// macOS Sonoma Launcher for Android Client Logic
let INSTALLED_APPS = [];

const MOCK_FALLBACK_APPS = [
  { name: 'Safari', packageName: 'com.android.chrome', icon: '🌐' },
  { name: 'Termux', packageName: 'com.termux', icon: '⚡' },
  { name: 'System Settings', packageName: 'com.android.settings', icon: '⚙️' },
  { name: 'Camera', packageName: 'com.android.camera', icon: '📷' },
  { name: 'Finder', packageName: 'com.google.android.documentsui', icon: '📁' },
  { name: 'Messages', packageName: 'com.whatsapp', icon: '💬' },
  { name: 'YouTube', packageName: 'com.google.android.youtube', icon: '▶️' },
  { name: 'GitHub', packageName: 'com.github.android', icon: '🐙' }
];

document.addEventListener('DOMContentLoaded', () => {
  updateMenuClock();
  setInterval(updateMenuClock, 1000);

  loadRealInstalledApps();

  window.onHomePressed = () => {
    closeLaunchpad();
    closeAppleMenu();
    closeControlCenter();
    closeAppModal();
    triggerHaptic();
  };

  const lpInput = document.getElementById('launchpad-search-input');
  if (lpInput) {
    lpInput.addEventListener('input', () => {
      const q = lpInput.value.toLowerCase().trim();
      filterLaunchpadApps(q);
    });

    lpInput.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        triggerHaptic();
        const q = lpInput.value.trim();
        if (q) {
          const match = INSTALLED_APPS.find(a => a.name.toLowerCase() === q.toLowerCase());
          if (match) {
            triggerAppLaunch(match);
          } else {
            searchWeb(q);
          }
          closeLaunchpad();
        }
      }
    });
  }
});

function triggerHaptic() {
  if (window.AndroidLauncher && window.AndroidLauncher.performHaptics) {
    try { window.AndroidLauncher.performHaptics(); } catch (e) {}
  }
}

function loadRealInstalledApps() {
  if (window.AndroidLauncher && window.AndroidLauncher.getInstalledApps) {
    try {
      const jsonStr = window.AndroidLauncher.getInstalledApps();
      const rawList = JSON.parse(jsonStr);

      if (rawList && rawList.length > 0) {
        INSTALLED_APPS = rawList.map(item => ({
          name: item.name,
          packageName: item.packageName,
          iconUrl: item.icon
        }));
        
        INSTALLED_APPS.sort((a, b) => a.name.localeCompare(b.name));
        renderDesktopGrid(INSTALLED_APPS);
        renderLaunchpadGrid(INSTALLED_APPS);
        return;
      }
    } catch (err) {
      console.error("Native apps load error:", err);
    }
  }

  INSTALLED_APPS = MOCK_FALLBACK_APPS;
  renderDesktopGrid(INSTALLED_APPS);
  renderLaunchpadGrid(INSTALLED_APPS);
}

function renderDesktopGrid(appList) {
  const container = document.getElementById('desktop-files-grid');
  if (!container) return;
  container.innerHTML = '';

  appList.slice(0, 12).forEach(app => {
    const item = document.createElement('div');
    item.className = 'mac-desktop-item';
    item.onclick = () => {
      triggerHaptic();
      document.getElementById('menu-active-app').innerText = app.name;
      triggerAppLaunch(app);
    };

    let pressTimer;
    item.addEventListener('touchstart', () => {
      pressTimer = setTimeout(() => {
        triggerHaptic();
        openAppModal(app);
      }, 550);
    });
    item.addEventListener('touchend', () => clearTimeout(pressTimer));
    item.addEventListener('contextmenu', (e) => {
      e.preventDefault();
      triggerHaptic();
      openAppModal(app);
    });

    const iconHtml = app.iconUrl 
      ? `<img src="${app.iconUrl}" style="width:100%; height:100%; object-fit:contain;" />`
      : app.icon || '📱';

    item.innerHTML = `
      <div class="mac-desktop-icon">${iconHtml}</div>
      <div class="mac-desktop-label" title="${app.name}">${app.name}</div>
    `;
    container.appendChild(item);
  });
}

function renderLaunchpadGrid(appList) {
  const container = document.getElementById('launchpad-grid');
  if (!container) return;
  container.innerHTML = '';

  appList.forEach(app => {
    const item = document.createElement('div');
    item.className = 'mac-desktop-item';
    item.onclick = () => {
      triggerHaptic();
      closeLaunchpad();
      document.getElementById('menu-active-app').innerText = app.name;
      triggerAppLaunch(app);
    };

    let pressTimer;
    item.addEventListener('touchstart', () => {
      pressTimer = setTimeout(() => {
        triggerHaptic();
        openAppModal(app);
      }, 550);
    });
    item.addEventListener('touchend', () => clearTimeout(pressTimer));
    item.addEventListener('contextmenu', (e) => {
      e.preventDefault();
      triggerHaptic();
      openAppModal(app);
    });

    const iconHtml = app.iconUrl 
      ? `<img src="${app.iconUrl}" style="width:100%; height:100%; object-fit:contain;" />`
      : app.icon || '📱';

    item.innerHTML = `
      <div class="mac-desktop-icon">${iconHtml}</div>
      <div class="mac-desktop-label" title="${app.name}">${app.name}</div>
    `;
    container.appendChild(item);
  });
}

function filterLaunchpadApps(query) {
  const q = query.toLowerCase().trim();
  if (!q) {
    renderLaunchpadGrid(INSTALLED_APPS);
  } else {
    const filtered = INSTALLED_APPS.filter(a => a.name.toLowerCase().includes(q));
    renderLaunchpadGrid(filtered);
  }
}

function toggleLaunchpad() {
  triggerHaptic();
  closeAppleMenu();
  const lp = document.getElementById('launchpad-modal');
  lp.classList.toggle('active');
  if (lp.classList.contains('active')) {
    setTimeout(() => {
      document.getElementById('launchpad-search-input').focus();
    }, 200);
  }
}

function closeLaunchpad() {
  const lp = document.getElementById('launchpad-modal');
  if (lp) lp.classList.remove('active');
}

function toggleAppleMenu() {
  triggerHaptic();
  const menu = document.getElementById('apple-menu');
  menu.classList.toggle('active');
}

function closeAppleMenu() {
  const menu = document.getElementById('apple-menu');
  if (menu) menu.classList.remove('active');
}

function toggleControlCenter() {
  triggerHaptic();
  const cc = document.getElementById('control-center');
  cc.classList.toggle('active');
}

function closeControlCenter() {
  const cc = document.getElementById('control-center');
  if (cc) cc.classList.remove('active');
}

function triggerAppLaunch(app) {
  if (app.packageName && window.AndroidLauncher && window.AndroidLauncher.launchApp) {
    const launched = window.AndroidLauncher.launchApp(app.packageName);
    if (!launched) {
      alert(`Unable to launch ${app.name}`);
    }
  } else {
    alert(`🚀 Launching ${app.name}...`);
  }
}

function searchWeb(query) {
  const url = `https://www.google.com/search?q=${encodeURIComponent(query)}`;
  if (window.AndroidLauncher && window.AndroidLauncher.launchApp) {
    window.AndroidLauncher.launchApp('com.android.chrome');
  } else {
    window.open(url, '_blank');
  }
}

function updateMenuClock() {
  const now = new Date();
  let hours = now.getHours();
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const ampm = hours >= 12 ? 'PM' : 'AM';
  hours = hours % 12 || 12;

  const clockElem = document.getElementById('menu-clock');
  if (clockElem) clockElem.innerText = `${hours}:${minutes} ${ampm}`;
}

function setDefaultHomeLauncher() {
  triggerHaptic();
  closeAppleMenu();
  if (window.AndroidLauncher && window.AndroidLauncher.setAsDefaultHome) {
    window.AndroidLauncher.setAsDefaultHome();
  } else {
    alert('📱 Select macOS Sonoma Launcher as your Home app in Android Settings!');
  }
}

function openSystemSettings() {
  triggerHaptic();
  closeAppleMenu();
  if (window.AndroidLauncher && window.AndroidLauncher.openSettings) {
    window.AndroidLauncher.openSettings();
  } else {
    alert('⚙️ Opening Android Settings...');
  }
}

function openWallpaperPicker() {
  triggerHaptic();
  closeAppleMenu();
  if (window.AndroidLauncher && window.AndroidLauncher.openWallpaperPicker) {
    window.AndroidLauncher.openWallpaperPicker();
  } else {
    alert('🖼️ Select Wallpaper from Device Gallery');
  }
}

function launchChrome() {
  triggerHaptic();
  if (window.AndroidLauncher && window.AndroidLauncher.launchApp) {
    window.AndroidLauncher.launchApp('com.android.chrome');
  } else {
    alert('🌐 Opening Safari / Chrome...');
  }
}

function launchTermux() {
  triggerHaptic();
  if (window.AndroidLauncher && window.AndroidLauncher.launchApp) {
    window.AndroidLauncher.launchApp('com.termux');
  } else {
    alert('⚡ Opening Terminal / Termux...');
  }
}

function openAppModal(app) {
  CURRENT_APP_SELECTED = app;
  document.getElementById('app-modal-title').innerText = app.name;
  document.getElementById('app-modal-pkg').innerText = app.packageName || 'com.example.app';

  const iconContainer = document.getElementById('app-modal-icon');
  if (app.iconUrl) {
    iconContainer.innerHTML = `<img src="${app.iconUrl}" style="width:44px; height:44px; object-fit:contain;" />`;
  } else {
    iconContainer.innerHTML = app.icon || '📱';
  }

  document.getElementById('btn-launch-modal').onclick = () => {
    triggerHaptic();
    closeAppModal();
    triggerAppLaunch(app);
  };

  document.getElementById('btn-info-modal').onclick = () => {
    triggerHaptic();
    closeAppModal();
    if (app.packageName && window.AndroidLauncher && window.AndroidLauncher.openAppDetails) {
      window.AndroidLauncher.openAppDetails(app.packageName);
    } else {
      alert(`App Info: ${app.packageName}`);
    }
  };

  document.getElementById('btn-uninstall-modal').onclick = () => {
    triggerHaptic();
    closeAppModal();
    if (app.packageName && window.AndroidLauncher && window.AndroidLauncher.uninstallApp) {
      window.AndroidLauncher.uninstallApp(app.packageName);
    } else {
      alert(`Uninstall: ${app.packageName}`);
    }
  };

  document.getElementById('app-modal').classList.add('active');
}

function closeAppModal() {
  document.getElementById('app-modal').classList.remove('active');
}
