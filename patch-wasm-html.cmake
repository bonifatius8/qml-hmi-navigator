file(READ "${HTML_FILE}" content)

# viewport: device-width で通常のモバイルレイアウト
# Qt の canvas サイズは #screen.clientWidth (= 800px, CSS transform の影響を受けない) で決まる
string(REPLACE
"<meta name=\"viewport\" content=\"width=device-width, height=device-height, user-scalable=0\"/>"
"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, user-scalable=no\"/>"
content "${content}")

# #screen を 800×480 絶対固定。transform-origin: 0 0 で左上基点スケール
# clientWidth/clientHeight は transform 非依存 → ResizeObserver が Qt に渡す値は常に 800×480
string(REPLACE "</style>"
"      html, body { margin: 0; padding: 0; width: 100vw; height: 100vh; overflow: hidden; background: #1a1a1a; position: relative; }
      #screen { position: absolute; width: 800px; height: 480px; transform-origin: 0 0; }
    </style>" content "${content}")

# CSS transform でスケール適用。#screen のレイアウトサイズは変わらないため
# Qt の ResizeObserver は 800×480 を検知し続け、キャンバスリサイズが発生しない
string(REPLACE "<script src=\"${APP_NAME}.js\">"
"<script src=\"coi-serviceworker.js\"></script>
    <script>
      (function() {
        function applyScale() {
          var vw = window.innerWidth;
          var vh = window.innerHeight;
          var s  = Math.min(vw / 800, vh / 480);
          var el = document.getElementById('screen');
          if (!el) return;
          el.style.left      = ((vw - 800 * s) / 2) + 'px';
          el.style.top       = ((vh - 480 * s) / 2) + 'px';
          el.style.transform = 'scale(' + s + ')';
        }
        window.addEventListener('resize', applyScale);
        window.addEventListener('orientationchange', function() { setTimeout(applyScale, 150); });
        applyScale();
      })();
    </script>
    <script src=\"${APP_NAME}.js\">"
content "${content}")

file(WRITE "${HTML_FILE}" "${content}")
message(STATUS "Patched ${HTML_FILE}")
