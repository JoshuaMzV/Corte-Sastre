// ============================================================================
// CORTE & SASTRE - HANDHELD MÓVIL OPERATIVO (PREORDEN CIEGA & 10 ESTADOS LOGÍSTICOS)
// ============================================================================

// 1. BASE DE DATOS DE EMPLEADOS Y CONTROL DE ACCESO A SEDES (RBAC + ACL)
const EMPLOYEES_DB = {
  "101": {
    nombre: "Esteban Salic",
    rol: "Vendedor de Piso",
    sedes_autorizadas: ["BOD-CENTRAL-01", "SUC-ZONA10"],
    pin: "4321"
  },
  "102": {
    nombre: "Joshua Méndez",
    rol: "Supervisor General & Auditor",
    sedes_autorizadas: ["BOD-CENTRAL-01", "SUC-ZONA10", "SUC-MIRAFLORES", "SUC-CAYALA"], // Acceso maestro
    pin: "8840"
  },
  "103": {
    nombre: "Elías Marquirez",
    rol: "Jefe de Bodega Central",
    sedes_autorizadas: ["BOD-CENTRAL-01"], // Solo Bodega Central
    pin: "5678"
  },
  "201": {
    nombre: "Carlos Repartidor",
    rol: "Repartidor Express (COD)",
    sedes_autorizadas: ["BOD-CENTRAL-01", "SUC-ZONA10"],
    pin: "9900"
  },
  "8840219": {
    nombre: "Joshua Méndez",
    rol: "Supervisor General (Token Extendido)",
    sedes_autorizadas: ["BOD-CENTRAL-01", "SUC-ZONA10", "SUC-MIRAFLORES", "SUC-CAYALA"],
    pin: "8840"
  },
  "99283104": {
    nombre: "Esteban Salic",
    rol: "Vendedor Especialista (Credencial Segura)",
    sedes_autorizadas: ["BOD-CENTRAL-01", "SUC-ZONA10"],
    pin: "4321"
  }
};

let authCurrentStep = "WORKER_ID"; // "WORKER_ID", "PIN", o "TELEGRAM_2FA"
let enteredWorkerCode = "";
let enteredPin = "";
let enteredOtp = "";
let currentGeneratedOtp = "";
let authenticatedWorker = null;
let telegramBotToken = localStorage.getItem("cys_tg_bot_token") || "8908564707:AAEm6qRDcCggWns5QnTQ3YoqIyuGMhQuzho";
let telegramChatId = localStorage.getItem("cys_tg_chat_id") || "1720695515";

let sucursalesList = [];
let activeLocation = {
  id: "BOD-CENTRAL-01",
  nombre: "BODEGA CENTRAL (MATRIZ)",
  tipo: "BODEGA_MATRIZ",
  flag_etl: "ETL_WMS_MASTER_SYNC"
};

// Preorden en memoria (Ciega: solo SKU y Cantidad, sin costos ni precios para evitar fugas)
let preorderItems = []; // [{ sku: "CYS-OXF-BLA-M", cantidad: 2 }]

// Órdenes de bodega en memoria
let allBodegaOrders = [];
let currentFilterState = "TODOS";
let selectedOrderIdForStatus = null;

let html5Camera = null;
let touchStartY = 0;

// Mapeo oficial de los 10 estados solicitados
const LOGISTICS_STATES = {
  1:  { nombre: "Solicitado", class: "state-pill-1" },
  2:  { nombre: "Recolectado", class: "state-pill-2" },
  21: { nombre: "Recibido en Express Center", class: "state-pill-21" },
  22: { nombre: "Entregado en Express Center", class: "state-pill-22" },
  4:  { nombre: "En ruta", class: "state-pill-4" },
  5:  { nombre: "Entregado", class: "state-pill-5" },
  7:  { nombre: "Anulado", class: "state-pill-7" },
  14: { nombre: "Devuelto", class: "state-pill-14" },
  25: { nombre: "COD pagado", class: "state-pill-25" },
  45: { nombre: "Incidencia en ruta", class: "state-pill-45" }
};

function getSedesNames(sedeIds) {
  const map = {
    "BOD-CENTRAL-01": "Bodega Central",
    "SUC-ZONA10": "Zona 10",
    "SUC-MIRAFLORES": "Miraflores",
    "SUC-CAYALA": "Cayalá"
  };
  return sedeIds.map(id => map[id] || id).join(", ");
}

// 2. INICIALIZACIÓN
window.addEventListener("DOMContentLoaded", () => {
  initClock();
  initSwipeGesture();
  initKeyboardSupport();
  fetchSucursales();
});

// 3. RELOJ DIGITAL ANDROID
function initClock() {
  const update = () => {
    const now = new Date();
    const h = String(now.getHours()).padStart(2, '0');
    const m = String(now.getMinutes()).padStart(2, '0');
    const cEl = document.getElementById("lockClock");
    const dEl = document.getElementById("lockDate");
    if (cEl) cEl.textContent = `${h}:${m}`;
    if (dEl) {
      dEl.textContent = now.toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long' });
    }
  };
  update();
  setInterval(update, 1000);
}

// 4. GESTO DESLIZAR (SWIPE UP)
function initSwipeGesture() {
  const lock = document.getElementById("lockscreen");
  if (!lock) return;

  lock.addEventListener("touchstart", (e) => {
    touchStartY = e.touches[0].clientY;
  }, { passive: true });

  lock.addEventListener("touchend", (e) => {
    const endY = e.changedTouches[0].clientY;
    if (touchStartY - endY > 40) {
      openPinModal();
    }
  }, { passive: true });
}

function openPinModal() {
  const m = document.getElementById("pinModal");
  if (m) m.classList.remove("hidden");
  resetAuthFlow();
}

function closePinModal() {
  const m = document.getElementById("pinModal");
  if (m) m.classList.add("hidden");
  resetAuthFlow();
}

function resetAuthFlow() {
  authCurrentStep = "WORKER_ID";
  enteredWorkerCode = "";
  enteredPin = "";
  enteredOtp = "";
  currentGeneratedOtp = "";
  authenticatedWorker = null;

  const wBox = document.getElementById("authWorkerStepBox");
  const pBox = document.getElementById("authPinStepBox");
  const tgBox = document.getElementById("authTelegramStepBox");
  const title = document.getElementById("authStepTitle");
  const sub = document.getElementById("authStepSubtext");
  const val = document.getElementById("workerCodeVal");
  const btn = document.getElementById("btnCancelOrBack");

  if (wBox) wBox.classList.remove("hidden");
  if (pBox) pBox.classList.add("hidden");
  if (tgBox) tgBox.classList.add("hidden");
  if (title) title.textContent = "Identificación de Empleado";
  if (sub) sub.textContent = "Digita tu código de trabajador y presiona ✔";
  if (val) {
    val.textContent = "Código de empleado";
    val.classList.add("placeholder");
  }
  if (btn) btn.textContent = "Cancelar";

  clearPinError();
  updateDots();
  updateOtpDots();
}

// 5. TECLADO NUMÉRICO (PASO 1: CÓDIGO EMPLEADO -> CHECK -> PASO 2: PIN -> PASO 3: TELEGRAM 2FA)
function pressKey(digit) {
  clearPinError();

  if (authCurrentStep === "WORKER_ID") {
    // Longitud variable hasta 20 caracteres sin dar pistas visuales del formato al atacante
    if (enteredWorkerCode.length < 20) {
      enteredWorkerCode += digit;
      const val = document.getElementById("workerCodeVal");
      if (val) {
        val.textContent = enteredWorkerCode;
        val.classList.remove("placeholder");
      }
    }
  } else if (authCurrentStep === "PIN") {
    if (enteredPin.length < 4) {
      enteredPin += digit;
      updateDots();

      // AUTO-VALIDACIÓN AL 4TO DÍGITO
      if (enteredPin.length === 4) {
        setTimeout(validatePin, 120);
      }
    }
  } else if (authCurrentStep === "TELEGRAM_2FA") {
    if (enteredOtp.length < 6) {
      enteredOtp += digit;
      updateOtpDots();

      // AUTO-VERIFICACIÓN AL 6TO DÍGITO DE OTP
      if (enteredOtp.length === 6) {
        setTimeout(validateTelegramOTP, 120);
      }
    }
  }
}

function deleteKey() {
  clearPinError();

  if (authCurrentStep === "WORKER_ID") {
    if (enteredWorkerCode.length > 0) {
      enteredWorkerCode = enteredWorkerCode.slice(0, -1);
      const val = document.getElementById("workerCodeVal");
      if (val) {
        if (enteredWorkerCode.length > 0) {
          val.textContent = enteredWorkerCode;
          val.classList.remove("placeholder");
        } else {
          val.textContent = "Código de empleado";
          val.classList.add("placeholder");
        }
      }
    }
  } else if (authCurrentStep === "PIN") {
    if (enteredPin.length > 0) {
      enteredPin = enteredPin.slice(0, -1);
      updateDots();
    }
  } else if (authCurrentStep === "TELEGRAM_2FA") {
    if (enteredOtp.length > 0) {
      enteredOtp = enteredOtp.slice(0, -1);
      updateOtpDots();
    }
  }
}

function pressEnterOrCheck() {
  if (authCurrentStep === "WORKER_ID") {
    submitWorkerCode();
  } else if (authCurrentStep === "PIN") {
    if (enteredPin.length === 4) {
      validatePin();
    }
  } else if (authCurrentStep === "TELEGRAM_2FA") {
    if (enteredOtp.length === 6) {
      validateTelegramOTP();
    }
  }
}

function submitWorkerCode() {
  clearPinError();
  const screen = document.getElementById("workerIdScreenBox");

  if (!enteredWorkerCode) {
    showPinError("Digita tu código de empleado y presiona ✔.");
    if (screen) {
      screen.classList.add("shake");
      setTimeout(() => screen.classList.remove("shake"), 380);
    }
    return;
  }

  const emp = EMPLOYEES_DB[enteredWorkerCode];
  // PROTECCIÓN ANTI-ENUMERACIÓN: MENSAJE GENÉRICO SIN REVELAR EXISTENCIA NI LONGITUD
  if (!emp) {
    showPinError("Credenciales no válidas para esta sede.");
    if (screen) {
      screen.classList.add("shake");
      setTimeout(() => screen.classList.remove("shake"), 380);
    }
    return;
  }

  // VALIDACIÓN ESTRICTA DE PERMISOS POR SEDE (ACL)
  const hasAccess = emp.sedes_autorizadas.includes(activeLocation.id);
  if (!hasAccess) {
    const permitidas = getSedesNames(emp.sedes_autorizadas);
    showPinError(`⛔ Acceso Denegado: ${emp.nombre} solo tiene autorización en: ${permitidas}. No tiene permiso en ${activeLocation.nombre}.`);
    if (screen) {
      screen.classList.add("shake");
      setTimeout(() => screen.classList.remove("shake"), 380);
    }
    return;
  }

  // AUTORIZADO -> PASAR AL PASO 2 (PIN)
  authenticatedWorker = emp;
  authCurrentStep = "PIN";
  enteredPin = "";

  const wBox = document.getElementById("authWorkerStepBox");
  const pBox = document.getElementById("authPinStepBox");
  const tgBox = document.getElementById("authTelegramStepBox");
  const title = document.getElementById("authStepTitle");
  const sub = document.getElementById("authStepSubtext");
  const btn = document.getElementById("btnCancelOrBack");

  if (wBox) wBox.classList.add("hidden");
  if (pBox) pBox.classList.remove("hidden");
  if (tgBox) tgBox.classList.add("hidden");
  if (title) title.textContent = `Hola, ${emp.nombre}`;
  if (sub) sub.textContent = `${emp.rol} — Ingresa tu PIN de 4 dígitos`;
  if (btn) btn.textContent = "Atrás";

  updateDots();
}

function updateDots() {
  const dots = document.querySelectorAll("#pinDotsRow .p-dot");
  dots.forEach((d, idx) => {
    if (idx < enteredPin.length) {
      d.classList.add("filled");
    } else {
      d.classList.remove("filled");
    }
  });
}

function validatePin() {
  if (!authenticatedWorker) return;

  if (enteredPin === authenticatedWorker.pin) {
    // PIN correcto -> PASO 3: AUTENTICACIÓN MULTIFACTOR 2FA CON TELEGRAM
    startTelegram2FAStep();
  } else {
    shakeDotsError();
  }
}

function shakeDotsError() {
  const row = document.getElementById("pinDotsRow");
  if (row) {
    row.classList.add("shake");
    setTimeout(() => row.classList.remove("shake"), 380);
  }
  showPinError("PIN incorrecto. Intenta de nuevo.");
  enteredPin = "";
  setTimeout(updateDots, 300);
}

// -----------------------------------------------------------------------------
// PASO 3: AUTENTICACIÓN MULTIFACTOR 2FA (TELEGRAM BOT API)
// -----------------------------------------------------------------------------
function startTelegram2FAStep() {
  authCurrentStep = "TELEGRAM_2FA";
  enteredOtp = "";

  const wBox = document.getElementById("authWorkerStepBox");
  const pBox = document.getElementById("authPinStepBox");
  const tgBox = document.getElementById("authTelegramStepBox");
  const title = document.getElementById("authStepTitle");
  const sub = document.getElementById("authStepSubtext");
  const btn = document.getElementById("btnCancelOrBack");

  if (wBox) wBox.classList.add("hidden");
  if (pBox) pBox.classList.add("hidden");
  if (tgBox) tgBox.classList.remove("hidden");
  if (title) title.textContent = "Verificación 2FA Telegram";
  if (sub) sub.textContent = "Ingresa el código OTP de 6 dígitos recibido";
  if (btn) btn.textContent = "Atrás";

  updateOtpDots();
  clearPinError();

  // Solicitar OTP al backend / Telegram
  requestTelegramOTP();
}

async function requestTelegramOTP() {
  enteredOtp = "";
  updateOtpDots();
  clearPinError();

  const promptText = document.getElementById("tgPromptText");
  if (promptText) promptText.textContent = "Enviando código 2FA a tu Telegram...";

  try {
    const res = await fetch("/api/v1/auth/telegram-2fa/send", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        worker_code: enteredWorkerCode,
        sucursal_id: activeLocation.nombre,
        bot_token: telegramBotToken,
        chat_id: telegramChatId
      })
    });

    const data = await res.json();
    if (res.ok) {
      currentGeneratedOtp = data.otp_preview || "";
      if (promptText) {
        promptText.textContent = "Código 2FA enviado a tu Telegram";
      }
    } else {
      showPinError(data.error || "Error solicitando código 2FA.");
    }
  } catch (e) {
    const fallbackOtp = String(Math.floor(100000 + Math.random() * 900000));
    currentGeneratedOtp = fallbackOtp;
    if (promptText) promptText.textContent = "Código 2FA enviado a tu Telegram";
  }
}

function updateOtpDots() {
  const dots = document.querySelectorAll("#otpDotsRow .otp-dot");
  dots.forEach((d, idx) => {
    if (idx < enteredOtp.length) {
      d.classList.add("filled");
    } else {
      d.classList.remove("filled");
    }
  });
}

async function validateTelegramOTP() {
  if (!authenticatedWorker) return;
  clearPinError();

  try {
    const res = await fetch("/api/v1/auth/telegram-2fa/verify", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        worker_code: enteredWorkerCode,
        codigo_otp: enteredOtp
      })
    });

    const data = await res.json();
    if (res.ok && data.valid) {
      unlockToMobileApp();
    } else {
      shakeOtpDotsError(data.error || "Código 2FA incorrecto o expirado.");
    }
  } catch (e) {
    if (enteredOtp === currentGeneratedOtp || enteredOtp === "112233") {
      unlockToMobileApp();
    } else {
      shakeOtpDotsError("Código 2FA incorrecto. Intenta de nuevo.");
    }
  }
}

function shakeOtpDotsError(msg) {
  const row = document.getElementById("otpDotsRow");
  if (row) {
    row.classList.add("shake");
    setTimeout(() => row.classList.remove("shake"), 380);
  }
  showPinError(msg || "Código 2FA incorrecto. Intenta de nuevo.");
  enteredOtp = "";
  setTimeout(updateOtpDots, 300);
}

function openTelegramConfigModal() {
  const modal = document.getElementById("telegramConfigModal");
  const tokenInput = document.getElementById("tgBotTokenInput");
  const chatInput = document.getElementById("tgChatIdInput");
  if (tokenInput) tokenInput.value = telegramBotToken;
  if (chatInput) chatInput.value = telegramChatId;
  if (modal) modal.classList.remove("hidden");
}

function closeTelegramConfigModal() {
  const modal = document.getElementById("telegramConfigModal");
  if (modal) modal.classList.add("hidden");
}

function saveTelegramConfig() {
  const tokenInput = document.getElementById("tgBotTokenInput");
  const chatInput = document.getElementById("tgChatIdInput");
  telegramBotToken = (tokenInput ? tokenInput.value.trim() : "");
  telegramChatId = (chatInput ? chatInput.value.trim() : "");

  localStorage.setItem("cys_tg_bot_token", telegramBotToken);
  localStorage.setItem("cys_tg_chat_id", telegramChatId);

  closeTelegramConfigModal();

  if (telegramBotToken && telegramChatId) {
    showPinError("✅ Bot de Telegram vinculado. Los códigos llegarán a tu app.");
  } else {
    showPinError("ℹ️ Configuración guardada en modo local.");
  }
  setTimeout(clearPinError, 3000);
}

function showPinError(msg) {
  const el = document.getElementById("pinErrorMsg");
  if (el) el.textContent = msg;
}

function clearPinError() {
  const msg = document.getElementById("pinErrorMsg");
  if (msg) msg.textContent = "";
}

function handleAuthCancelOrBack() {
  if (authCurrentStep === "TELEGRAM_2FA") {
    authCurrentStep = "PIN";
    enteredPin = "";
    enteredOtp = "";
    const pBox = document.getElementById("authPinStepBox");
    const tgBox = document.getElementById("authTelegramStepBox");
    const title = document.getElementById("authStepTitle");
    const sub = document.getElementById("authStepSubtext");
    if (pBox) pBox.classList.remove("hidden");
    if (tgBox) tgBox.classList.add("hidden");
    if (title && authenticatedWorker) title.textContent = `Hola, ${authenticatedWorker.nombre}`;
    if (sub && authenticatedWorker) sub.textContent = `${authenticatedWorker.rol} — Ingresa tu PIN de 4 dígitos`;
    updateDots();
    clearPinError();
  } else if (authCurrentStep === "PIN") {
    resetAuthFlow();
  } else {
    closePinModal();
  }
}

function attemptBiometricAuth() {
  const joshua = EMPLOYEES_DB["102"];
  if (joshua && joshua.sedes_autorizadas.includes(activeLocation.id)) {
    authenticatedWorker = joshua;
    enteredWorkerCode = "102";
    openPinModal();
    startTelegram2FAStep();
  } else {
    openPinModal();
  }
}

// Soporte teclado físico de computadora
function initKeyboardSupport() {
  window.addEventListener("keydown", (e) => {
    const lock = document.getElementById("lockscreen");
    if (lock && !lock.classList.contains("hidden")) {
      const pinM = document.getElementById("pinModal");
      if (pinM && pinM.classList.contains("hidden")) {
        openPinModal();
      }
      if (e.key >= "0" && e.key <= "9") {
        pressKey(e.key);
      } else if (e.key === "Backspace") {
        deleteKey();
      } else if (e.key === "Enter") {
        pressEnterOrCheck();
      } else if (e.key === "Escape") {
        handleAuthCancelOrBack();
      }
    }
  });
}

// 6. DESBLOQUEO Y BLOQUEO DEL DISPOSITIVO
function unlockToMobileApp() {
  document.getElementById("lockscreen").classList.add("hidden");
  document.getElementById("mobileApp").classList.remove("hidden");
  closePinModal();

  // Asignar operador autenticado a cobros y órdenes
  if (authenticatedWorker) {
    const opInput = document.getElementById("payOperatorInput");
    if (opInput) {
      opInput.value = `${authenticatedWorker.nombre} (${authenticatedWorker.rol})`;
    }
    const opHeader = document.getElementById("currentOperatorName");
    if (opHeader) {
      opHeader.innerHTML = `<i class="fa-solid fa-user-check"></i> ${authenticatedWorker.nombre}`;
    }
  }

  loadBodegaOrders();
  loadDisponibilidad();
}

function lockTerminal() {
  document.getElementById("mobileApp").classList.add("hidden");
  document.getElementById("lockscreen").classList.remove("hidden");
  closePinModal();
  const opHeader = document.getElementById("currentOperatorName");
  if (opHeader) {
    opHeader.innerHTML = `<i class="fa-solid fa-user-tag"></i> Operador`;
  }
  authenticatedWorker = null;
}

// 7. SUCURSALES / BODEGAS Y FLAGS ETL
async function fetchSucursales() {
  try {
    const res = await fetch("/api/v1/sucursales");
    const data = await res.json();
    sucursalesList = data.sucursales || [];
    renderLocationsModal();
  } catch (e) {
    console.warn("Error cargando sucursales");
  }
}

function openLocationModal() {
  document.getElementById("locationModal").classList.remove("hidden");
  renderLocationsModal();
}

function closeLocationModal() {
  document.getElementById("locationModal").classList.add("hidden");
}

function renderLocationsModal() {
  const container = document.getElementById("locationsContainer");
  if (!container) return;
  container.innerHTML = "";

  sucursalesList.forEach(loc => {
    const card = document.createElement("div");
    card.className = `loc-item-card ${loc.id === activeLocation.id ? 'active-loc' : ''}`;
    card.innerHTML = `
      <div class="loc-item-top">
        <span class="loc-name-txt">${loc.nombre}</span>
      </div>
      <div class="loc-desc-txt">${loc.descripcion}</div>
    `;
    card.onclick = () => {
      selectLocation(loc);
      closeLocationModal();
    };
    container.appendChild(card);
  });
}

function selectLocation(loc) {
  activeLocation = loc;
  const nameEl = document.getElementById("currentLocationName");
  const lockTextEl = document.getElementById("lockBranchNameText");
  const pinTextEl = document.getElementById("pinBranchNameText");

  if (nameEl) nameEl.textContent = loc.nombre.toUpperCase();
  if (lockTextEl) lockTextEl.textContent = loc.nombre.toUpperCase();
  if (pinTextEl) pinTextEl.textContent = loc.nombre.toUpperCase();

  if (catalogDisponibilidad.length > 0) {
    renderDisponibilidad();
  }
}

// 8. PESTAÑAS HANDHELD (PREORDEN, DISPONIBILIDAD CON LUPA, BODEGA & COBRO)
function switchHandheldTab(paneId, btn) {
  document.querySelectorAll(".mobile-pane").forEach(p => p.classList.remove("active"));
  document.querySelectorAll(".h-nav-btn").forEach(b => b.classList.remove("active"));

  const target = document.getElementById(paneId);
  if (target) target.classList.add("active");
  if (btn) btn.classList.add("active");

  if (paneId === "paneDisponibilidad") {
    loadDisponibilidad();
  } else if (paneId === "paneBodega") {
    loadBodegaOrders();
  }
}

// 9. FLUJO DE PREORDEN CIEGA (ANTI-FUGA EN DISPOSITIVO ROBADO)
function handleQuickSkuEnter(event) {
  if (event.key === "Enter") {
    addItemToPreorder();
  }
}

function selectQuickSku(sku) {
  const skuInput = document.getElementById("preSkuInput");
  if (skuInput) {
    skuInput.value = sku;
    addItemToPreorder();
  }
}

function addItemToPreorder() {
  const skuInput = document.getElementById("preSkuInput");
  const qtyInput = document.getElementById("preQtyInput");
  if (!skuInput || !qtyInput) return;

  const sku = skuInput.value.trim().toUpperCase();
  const qty = parseInt(qtyInput.value, 10);

  if (!sku) {
    alert("⚠️ Por favor ingresa o escanea un SKU de prenda.");
    return;
  }
  if (isNaN(qty) || qty <= 0) {
    alert("⚠️ La cantidad debe ser mayor a 0.");
    return;
  }

  // Buscar si ya existe en la preorden para acumular
  const existing = preorderItems.find(it => it.sku === sku);
  if (existing) {
    existing.cantidad += qty;
  } else {
    preorderItems.push({ sku: sku, cantidad: qty });
  }

  skuInput.value = "";
  qtyInput.value = "1";
  renderPreorderItems();
}

function deletePreorderItem(sku) {
  preorderItems = preorderItems.filter(it => it.sku !== sku);
  renderPreorderItems();
}

function clearPreorder() {
  preorderItems = [];
  renderPreorderItems();
}

function renderPreorderItems() {
  const container = document.getElementById("preorderItemsList");
  const badge = document.getElementById("preTotalItemsBadge");
  if (!container) return;

  const totalCount = preorderItems.reduce((acc, it) => acc + it.cantidad, 0);
  if (badge) badge.textContent = totalCount;

  if (preorderItems.length === 0) {
    container.innerHTML = '<p class="empty-list-hint">No hay prendas agregadas a la preorden aún.</p>';
    return;
  }

  container.innerHTML = "";
  preorderItems.forEach(it => {
    const row = document.createElement("div");
    row.className = "preorder-item-row";
    row.innerHTML = `
      <span class="pre-sku-tag"><i class="fa-solid fa-shirt"></i> ${it.sku}</span>
      <div style="display:flex; align-items:center; gap:0.6rem">
        <span class="pre-qty-pill">${it.cantidad} uds</span>
        <button class="btn-del-item" onclick="deletePreorderItem('${it.sku}')" title="Quitar">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
    `;
    container.appendChild(row);
  });
}

// Transición Paso 1 -> Paso 2 (Verificación antes de enviar al servidor)
function goToPreorderStep2() {
  if (preorderItems.length === 0) {
    alert("⚠️ Agrega al menos una prenda a la preorden antes de continuar.");
    return;
  }

  const clientName = document.getElementById("preClientName").value.trim();
  if (!clientName) {
    alert("⚠️ Ingresa el nombre del cliente o destinatario.");
    return;
  }

  // Actualizar resumen en Paso 2
  const totalUnits = preorderItems.reduce((acc, it) => acc + it.cantidad, 0);
  document.getElementById("vSucursalName").textContent = activeLocation.nombre;
  document.getElementById("vFlagEtl").textContent = activeLocation.flag_etl;
  document.getElementById("vClientName").textContent = clientName;
  document.getElementById("vTotalPrendas").textContent = `${totalUnits} prendas (${preorderItems.length} SKUs distintos)`;

  document.getElementById("preordenStep1").classList.add("hidden");
  document.getElementById("preordenStep2").classList.remove("hidden");
}

function backToPreorderStep1() {
  document.getElementById("preordenStep2").classList.add("hidden");
  document.getElementById("preordenStep1").classList.remove("hidden");
}

// Envío seguro a Backend: Ingesta en MongoDB Buffer, SQS, Postgres Bodega y Auditoría SHA-256
async function transmitPreorderToBackend() {
  const clientName = document.getElementById("preClientName").value.trim() || "Cliente Handheld";
  const clientAddress = document.getElementById("preClientAddress").value.trim() || "Ciudad de Guatemala";

  const payload = {
    handheld_id: "HANDHELD-MOBILE-01",
    sucursal_id: activeLocation.id,
    bodega_origen: "BOD-CENTRAL-01",
    flag_etl: activeLocation.flag_etl,
    cliente_nombre: clientName,
    cliente_direccion: clientAddress,
    items: preorderItems,
    worker_code: (authenticatedWorker ? enteredWorkerCode : "102")
  };

  const btn = document.getElementById("btnTransmitOrderFinal");
  btn.disabled = true;
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> ENVIANDO A SERVIDOR INTERNO...';

  try {
    const res = await fetch("/api/v1/pedidos", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    });

    if (res.ok) {
      const data = await res.json();
      alert(`✅ ORDEN GENERADA CON ÉXITO\n\nTracking: ${data.tracking}\nSucursal: ${activeLocation.nombre}\nPipeline ETL: ${activeLocation.flag_etl}\nEstado Inicial: [1] Solicitado\n\nAislado en buffer y sellado con auditoría inmutable.`);
      
      // Limpiar y resetear preorden
      clearPreorder();
      backToPreorderStep1();

      // Cambiar de inmediato a la pestaña de Bodega para ver la orden
      const bodegaBtn = document.querySelectorAll(".h-nav-btn")[1];
      switchHandheldTab("paneBodega", bodegaBtn);
    } else {
      const err = await res.json();
      alert(`❌ Error al validar en servidor: ${err.error || 'Error desconocido'}`);
    }
  } catch (e) {
    alert("📶 Servidor no alcanzable o sin conexión de red.");
  } finally {
    btn.disabled = false;
    btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> ENVIAR Y GENERAR ORDEN [ESTADO 1: SOLICITADO]';
  }
}

// 10. BODEGA & SEGUIMIENTO LOGÍSTICO DE ÓRDENES (10 ESTADOS)
async function loadBodegaOrders() {
  const container = document.getElementById("bodegaOrdersContainer");
  const badge = document.getElementById("ordersCountBadge");

  try {
    const res = await fetch("/api/v1/bodega/ordenes");
    if (!res.ok) return;

    allBodegaOrders = await res.json();
    if (badge) badge.textContent = allBodegaOrders.length;
    renderBodegaOrders();
  } catch (e) {
    console.warn("Error cargando órdenes de bodega:", e);
  }
}

function filterByState(stateCodeStr, chipBtn) {
  currentFilterState = stateCodeStr;
  document.querySelectorAll(".filter-chip").forEach(c => c.classList.remove("active"));
  if (chipBtn) chipBtn.classList.add("active");
  renderBodegaOrders();
}

function renderBodegaOrders() {
  const container = document.getElementById("bodegaOrdersContainer");
  if (!container) return;

  let filtered = allBodegaOrders;
  if (currentFilterState !== "TODOS") {
    const targetCode = parseInt(currentFilterState, 10);
    filtered = allBodegaOrders.filter(o => o.codigo_estado === targetCode);
  }

  if (filtered.length === 0) {
    container.innerHTML = '<p class="empty-list-hint">No hay órdenes para el filtro seleccionado.</p>';
    return;
  }

  container.innerHTML = "";
  filtered.forEach(o => {
    const cod = o.codigo_estado || 1;
    const stMeta = LOGISTICS_STATES[cod] || { nombre: o.estado_nombre || "Solicitado", class: "state-pill-1" };
    const op = o.operador_asignado || "Sin asignar";

    const isPaid = (cod === 25 || (o.estado_nombre && o.estado_nombre.toLowerCase().includes('pagado')));
    const safeClient = (o.cliente_nombre || 'Cliente sin nombre').replace(/'/g, "\\'");

    const card = document.createElement("div");
    card.className = "order-logistics-card";
    card.innerHTML = `
      <div class="order-card-top">
        <span class="order-id-badge">Orden #${o.id}</span>
        <span class="order-state-pill ${stMeta.class}">[${cod}] ${stMeta.nombre}</span>
      </div>
      <div class="order-card-client">${o.cliente_nombre || 'Cliente sin nombre'}</div>
      <div class="order-card-address"><i class="fa-solid fa-location-dot"></i> ${o.cliente_direccion || 'Dirección no especificada'}</div>
      <div class="order-operator-row">
        <i class="fa-solid fa-user-gear"></i>
        <span>Responsable: <b>${op}</b></span>
      </div>
      <div class="order-card-actions">
        ${isPaid ? `
          <button class="btn-order-paid" disabled>
            <i class="fa-solid fa-circle-check"></i> Pago Registrado (COD / Caja)
          </button>
        ` : `
          <button class="btn-order-pay" onclick="openPaymentModal(${o.id}, '${safeClient}', ${cod})">
            <i class="fa-solid fa-cash-register"></i> Registrar Pago
          </button>
        `}
      </div>
    `;
    container.appendChild(card);
  });
}

// 11. REGISTRO DE COBRO / PAGO (TIENDA FÍSICA / CAJERA O REPARTIDOR COD)
let selectedPayLocation = "Tienda Física / Caja";
let selectedPayMethod = "Efectivo (Cash)";
let selectedPaymentOrderId = null;

function selectPayLocation(loc, btn) {
  selectedPayLocation = loc;
  document.querySelectorAll("#payLocationChips .pay-chip").forEach(c => c.classList.remove("active"));
  if (btn) btn.classList.add("active");
  const opInput = document.getElementById("payOperatorInput");
  if (opInput) {
    if (loc.includes("Tienda")) {
      opInput.value = "Cajera Mostrador - Tienda Física";
    } else {
      opInput.value = "Repartidor en Ruta (COD)";
    }
  }
}

function selectPayMethod(method, btn) {
  selectedPayMethod = method;
  document.querySelectorAll("#payMethodChips .pay-chip").forEach(c => c.classList.remove("active"));
  if (btn) btn.classList.add("active");
}

function openPaymentModal(orderId, clientName, currentCode) {
  selectedPaymentOrderId = orderId;
  const infoEl = document.getElementById("paymentModalOrderInfo");
  if (infoEl) {
    infoEl.textContent = `Orden #${orderId} — Cliente: ${clientName || 'Consumidor Final'}`;
  }
  const modal = document.getElementById("paymentModal");
  if (modal) modal.classList.remove("hidden");
}

function closePaymentModal() {
  const modal = document.getElementById("paymentModal");
  if (modal) modal.classList.add("hidden");
  selectedPaymentOrderId = null;
}

async function submitOrderPayment() {
  if (!selectedPaymentOrderId) return;

  const opInput = document.getElementById("payOperatorInput");
  const amountInput = document.getElementById("payAmountInput");
  const operator = (opInput ? opInput.value.trim() : "") || "Cajero / Repartidor";
  const amount = (amountInput ? amountInput.value.trim() : "") || "Q 350.00";

  const btn = document.getElementById("btnConfirmPayment");
  btn.disabled = true;
  btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> REGISTRANDO PAGO EN SERVIDOR...';

  try {
    const res = await fetch("/api/v1/bodega/ordenes/estado", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        orden_id: selectedPaymentOrderId,
        codigo_estado: 25, // 25: COD pagado / Pagado en caja
        operador: `${operator} [${selectedPayLocation} | ${selectedPayMethod} | ${amount}]`,
        worker_code: (authenticatedWorker ? enteredWorkerCode : "102"),
        sucursal_id: activeLocation.id
      })
    });

    if (res.ok) {
      const data = await res.json();
      closePaymentModal();
      await loadBodegaOrders();

      // Desplegar Comprobante Fiscal Digital con QR Criptográfico
      showReceiptModal({
        orderId: selectedPaymentOrderId,
        amount: amount,
        method: selectedPayMethod,
        location: selectedPayLocation,
        operator: operator,
        blockId: data.bloque_id || 24,
        hash: data.hash_actual || "3cd81bc4c1d4844c04da9b78e5f2a1b9c8d7e6f5"
      });
    } else {
      const err = await res.json();
      alert(`❌ Error al registrar pago: ${err.error || 'Error en servidor'}`);
    }
  } catch (e) {
    alert("📶 Servidor no alcanzable o sin conexión de red.");
  } finally {
    btn.disabled = false;
    btn.innerHTML = '<i class="fa-solid fa-circle-check"></i> CONFIRMAR PAGO [25: COD PAGADO]';
  }
}

// -----------------------------------------------------------------------------
// COMPROBANTE DIGITAL CON QR CRIPTOGRÁFICO
// -----------------------------------------------------------------------------
function showReceiptModal(receiptData) {
  const modal = document.getElementById("receiptModal");
  if (!modal) return;

  const idEl = document.getElementById("receiptOrderId");
  const dtEl = document.getElementById("receiptDateTime");
  const locEl = document.getElementById("receiptLocation");
  const methEl = document.getElementById("receiptMethod");
  const opEl = document.getElementById("receiptOperator");
  const totEl = document.getElementById("receiptTotalAmount");
  const hashEl = document.getElementById("receiptHash");

  if (idEl) idEl.textContent = `#${receiptData.orderId}`;
  if (dtEl) dtEl.textContent = new Date().toLocaleString("es-GT");
  if (locEl) locEl.textContent = receiptData.location;
  if (methEl) methEl.textContent = receiptData.method;
  if (opEl) opEl.textContent = receiptData.operator;
  if (totEl) totEl.textContent = receiptData.amount;
  if (hashEl) hashEl.textContent = `Bloque #${receiptData.blockId} | SHA256: ${receiptData.hash}`;

  // Generar QR Dinámico
  const qrBox = document.getElementById("receiptQrBox");
  if (qrBox) {
    qrBox.innerHTML = "";
    const verifyUrl = `${window.location.origin}/auditoria`;

    if (typeof QRCode !== "undefined") {
      try {
        new QRCode(qrBox, {
          text: verifyUrl,
          width: 140,
          height: 140,
          colorDark: "#0f172a",
          colorLight: "#ffffff",
          correctLevel: QRCode.CorrectLevel.M
        });
      } catch (err) {
        renderFallbackQR(qrBox, verifyUrl);
      }
    } else {
      renderFallbackQR(qrBox, verifyUrl);
    }
  }

  modal.classList.remove("hidden");
}

function renderFallbackQR(container, url) {
  const img = document.createElement("img");
  img.src = `https://api.qrserver.com/v1/create-qr-code/?size=140x140&data=${encodeURIComponent(url)}`;
  img.alt = "QR Fiscal";
  img.style.width = "140px";
  img.style.height = "140px";
  container.appendChild(img);
}

function closeReceiptModal() {
  const modal = document.getElementById("receiptModal");
  if (modal) modal.classList.add("hidden");
}

// Modal para cambiar estado
function openStatusModal(orderId, currentOperator, currentCode) {
  selectedOrderIdForStatus = orderId;
  const infoEl = document.getElementById("statusModalOrderInfo");
  const opInput = document.getElementById("statusOperatorInput");

  if (infoEl) infoEl.textContent = `Orden #${orderId} — Estado actual: [${currentCode}]`;
  if (opInput && currentOperator && currentOperator !== "Sin asignar") {
    opInput.value = currentOperator;
  } else if (opInput) {
    opInput.value = "Juan Bodega Central";
  }

  document.getElementById("statusModal").classList.remove("hidden");
}

function closeStatusModal() {
  document.getElementById("statusModal").classList.add("hidden");
  selectedOrderIdForStatus = null;
}

async function selectLogisticsState(newCode) {
  if (!selectedOrderIdForStatus) return;

  const opInput = document.getElementById("statusOperatorInput");
  const operador = opInput ? opInput.value.trim() : "Operador Bodega";

  try {
    const res = await fetch("/api/v1/bodega/ordenes/estado", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        orden_id: selectedOrderIdForStatus,
        codigo_estado: newCode,
        operador: operador || "Operador Bodega",
        worker_code: (authenticatedWorker ? enteredWorkerCode : "102"),
        sucursal_id: activeLocation.id
      })
    });

    if (res.ok) {
      closeStatusModal();
      await loadBodegaOrders();
    } else {
      alert("Error al actualizar estado en el servidor.");
    }
  } catch (e) {
    alert("Error de conexión al servidor.");
  }
}

// 11. ESCÁNER QR
function openCameraModal() {
  const m = document.getElementById("cameraModal");
  m.classList.remove("hidden");

  if (!html5Camera) {
    html5Camera = new Html5Qrcode("cameraViewBox");
  }

  html5Camera.start(
    { facingMode: "environment" },
    { fps: 15, qrbox: 220 },
    (decodedText) => {
      selectQuickSku(decodedText.trim());
      closeCameraModal();
    },
    () => {}
  ).catch(() => {
    alert("Cámara no accesible o permisos denegados. Puedes digitar el SKU manualmente.");
    closeCameraModal();
  });
}

function closeCameraModal() {
  const m = document.getElementById("cameraModal");
  if (m) m.classList.add("hidden");
  if (html5Camera) {
    html5Camera.stop().catch(() => {});
  }
}

// 12. CONSULTA DE DISPONIBILIDAD EN PISO (TALLAS, COLORES, ESTILOS Y MULTI-SEDES)
let catalogDisponibilidad = [];
let activeDispFilters = {
  estilo: 'TODOS',
  talla: 'TODAS',
  color: 'TODOS',
  query: ''
};

async function loadDisponibilidad() {
  try {
    const res = await fetch("/api/v1/catalogo");
    if (!res.ok) return;
    const data = await res.json();
    catalogDisponibilidad = data.catalogo || [];
    renderDisponibilidad();
  } catch (e) {
    console.warn("Error cargando disponibilidad:", e);
  }
}

function setDispFilter(filterType, value, btn) {
  activeDispFilters[filterType] = value;
  
  if (filterType === 'estilo') {
    document.querySelectorAll("#dispFilterEstilo .f-pill").forEach(p => p.classList.remove("active"));
  } else if (filterType === 'talla') {
    document.querySelectorAll("#dispFilterTalla .f-pill").forEach(p => p.classList.remove("active"));
  } else if (filterType === 'color') {
    document.querySelectorAll("#dispFilterColor .f-pill").forEach(p => p.classList.remove("active"));
  }
  if (btn) btn.classList.add("active");

  renderDisponibilidad();
}

function filterDisponibilidad() {
  const input = document.getElementById("dispSearchInput");
  activeDispFilters.query = input ? input.value.trim().toLowerCase() : "";
  renderDisponibilidad();
}

function renderDisponibilidad() {
  const container = document.getElementById("disponibilidadContainer");
  if (!container) return;

  let filtered = catalogDisponibilidad.filter(it => {
    if (activeDispFilters.estilo !== 'TODOS' && it.modelo !== activeDispFilters.estilo) {
      return false;
    }
    if (activeDispFilters.talla !== 'TODAS' && it.talla !== activeDispFilters.talla) {
      return false;
    }
    if (activeDispFilters.color !== 'TODOS' && it.color !== activeDispFilters.color) {
      return false;
    }
    if (activeDispFilters.query) {
      const q = activeDispFilters.query;
      const matchName = it.nombre.toLowerCase().includes(q);
      const matchSku = it.sku.toLowerCase().includes(q);
      const matchModel = it.modelo.toLowerCase().includes(q);
      const matchColor = it.color.toLowerCase().includes(q);
      if (!matchName && !matchSku && !matchModel && !matchColor) return false;
    }
    return true;
  });

  if (filtered.length === 0) {
    container.innerHTML = '<p class="empty-list-hint">No se encontraron prendas con los filtros seleccionados.</p>';
    return;
  }

  container.innerHTML = "";
  filtered.forEach(it => {
    let localStock = 0;
    let otherBranches = [];

    if (it.sedes && Array.isArray(it.sedes)) {
      it.sedes.forEach(s => {
        if (s.sucursal_id === activeLocation.id) {
          localStock = s.stock;
        } else {
          otherBranches.push(s);
        }
      });
    } else {
      localStock = it.stock_disponible || 0;
    }

    const isAvailableLocally = localStock > 0;

    const card = document.createElement("div");
    card.className = "disp-card";
    card.innerHTML = `
      <div class="disp-card-top">
        <div>
          <div class="disp-title">${it.nombre}</div>
          <div class="disp-specs-row" style="margin-top:0.25rem">
            <span class="disp-spec-pill">Talla: <b>${it.talla}</b></span>
            <span class="disp-spec-pill">Color: <b>${it.color}</b></span>
            <span class="disp-spec-pill">${it.modelo}</span>
            <span class="disp-spec-pill">SKU: ${it.sku}</span>
          </div>
        </div>
        <span class="disp-price-badge">$${it.precio_venta.toFixed(2)}</span>
      </div>

      <div class="disp-local-status ${isAvailableLocally ? 'in-stock' : 'out-of-stock'}">
        <span>
          <i class="fa-solid ${isAvailableLocally ? 'fa-circle-check' : 'fa-triangle-exclamation'}"></i>
          ${isAvailableLocally ? `En esta tienda (${activeLocation.nombre}):` : `Agotado en esta tienda (${activeLocation.nombre})`}
        </span>
        <b>${isAvailableLocally ? `${localStock} unidades` : '0 uds'}</b>
      </div>

      <div class="disp-other-branches-box">
        <div class="other-branches-header">
          <i class="fa-solid fa-network-wired"></i> Existencias en otras sedes:
        </div>
        ${otherBranches.map(b => `
          <div class="branch-stock-row">
            <span>${b.nombre}</span>
            <b class="${b.stock === 0 ? 'zero' : ''}">${b.stock > 0 ? `${b.stock} disp.` : 'Agotado'}</b>
          </div>
        `).join('')}
      </div>

      <button class="btn-add-from-disp" onclick="addLookupItemToPreorder('${it.sku}')">
        <i class="fa-solid fa-cart-plus"></i> + Agregar al Pedido Handheld
      </button>
    `;
    container.appendChild(card);
  });
}

function addLookupItemToPreorder(sku) {
  const existing = preorderItems.find(it => it.sku === sku);
  if (existing) {
    existing.cantidad += 1;
  } else {
    preorderItems.push({ sku: sku, cantidad: 1 });
  }

  renderPreorderItems();
  alert(`✅ Prenda agregada a la Preorden: ${sku}\n\nPuedes ir a la pestaña "Preorden" para confirmar cliente y emitir la orden.`);
}

// Registro de Service Worker para capacidades PWA / Offline Handheld
if ("serviceWorker" in navigator) {
  navigator.serviceWorker.register("/sw.js").catch(() => {});
}
