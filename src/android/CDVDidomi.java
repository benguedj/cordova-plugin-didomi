package bguedj.cordova.plugin.didomi;

import android.util.Log;
import android.webkit.ValueCallback;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import io.didomi.sdk.Didomi;
import io.didomi.sdk.exceptions.DidomiNotReadyException;

/**
 * This class echoes a string called from JavaScript.
 */
public class CDVDidomi extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("injectConsent")) {
            this.injectConsent(callbackContext);
            return true;
        }
        return false;
    }

    private void injectConsent(CallbackContext callbackContext) {
      Didomi didomi = Didomi.getInstance();
      String jsCMP = "window.gdprAppliesGlobally = true; (function () {function a(e) {if (!window.frames[e]) {if (document.body && document.body.firstChild) { var t = document.body; var n = document.createElement(\"iframe\"); n.style.display = \"none\"; n.name = e; n.title = e; t.insertBefore(n, t.firstChild) }else { setTimeout(function () { a(e) }, 5) }}} function e(n, r, o, c, s) {function e(e, t, n, a) { if (typeof n !== \"function\") { return } if (!window[r]) { window[r] = [] } var i = false; if (s) { i = s(e, t, n) } if (!i) { window[r].push({ command: e, parameter: t, callback: n, version: a }) } } e.stub = true; function t(a) {if (!window[n] || window[n].stub !== true) { return } if (!a.data) { return }var i = typeof a.data === \"string\"; var e; try { e = i ? JSON.parse(a.data) : a.data } catch (t) { return } if (e[o]) { var r = e[o]; window[n](r.command, r.parameter, function (e, t) { var n = {}; n[c] = { returnValue: e, success: t, callId: r.callId }; a.source.postMessage(i ? JSON.stringify(n) : n, \"*\") }, r.version) }}if (typeof window[n] !== \"function\") { window[n] = e; if (window.addEventListener) { window.addEventListener(\"message\", t, false) } else { window.attachEvent(\"onmessage\", t) } }} e(\"__tcfapi\", \"__tcfapiBuffer\", \"__tcfapiCall\", \"__tcfapiReturn\"); a(\"__tcfapiLocator\"); (function (e, tgt) {var t = document.createElement(\"script\"); t.id = \"spcloader\"; t.type = \"text/javascript\"; t.async = true; t.src = \"https://sdk.privacy-center.org/\" + e + \"/loader.js?target_type=notice&target=\" + tgt; t.charset = \"utf-8\"; var n = document.getElementsByTagName(\"script\")[0]; n.parentNode.insertBefore(t, n)})(\"539b86a7-a602-4da6-a9a5-560546b3bc2b\", \"eR9naxVm\")})();";
      String jsDidomi = null;
      try {
        jsDidomi = didomi.getJavaScriptForWebView();
      } catch (DidomiNotReadyException e) {
        e.printStackTrace();
        callbackContext.error("e.printStackTrace();");
      }
      if (jsDidomi != null && jsDidomi.length() > 0) {
        Log.v("jsDidomi : ", jsDidomi);
        String jsToInject = jsCMP + " " + jsDidomi;
        this.webView.getEngine().evaluateJavascript(jsToInject, null);
        callbackContext.success("OK");
      } else {
        callbackContext.error("Expected one non-empty string argument.");
      }
    }
}
