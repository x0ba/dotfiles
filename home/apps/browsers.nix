{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isLinux isDarwin;
in
{
  config = lib.mkIf config.isGraphical {
    programs.chromium = {
      enable = isLinux;
      package = pkgs.ungoogled-chromium;
    };

    programs.firefox = {
      enable = true;
      # since I'm using firefox from brew on darwin, I need to build a dummy package
      # to still manage it via home-manager
      package = pkgs.lib.mkIf isDarwin (pkgs.writeScriptBin "__dummy-firefox" "");
      profiles.default = {
        search.default = "Google";
        search.force = true;
        extraConfig = ''
          /** GENERAL ***/
          user_pref("content.notify.interval", 100000);

          /** CSS ***/
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);


          /** GFX ***/
          user_pref("gfx.canvas.accelerated.cache-items", 4096);
          user_pref("gfx.canvas.accelerated.cache-size", 512);
          user_pref("gfx.content.skia-font-cache-size", 20);

          /** DISK CACHE ***/
          user_pref("browser.cache.jsbc_compression_level", 3);


          /** MEDIA CACHE ***/
          user_pref("media.memory_cache_max_size", 65536);
          user_pref("media.cache_readahead_limit", 7200);
          user_pref("media.cache_resume_threshold", 3600);

          /** IMAGE CACHE ***/
          user_pref("image.mem.decode_bytes_at_a_time", 32768);

          /** NETWORK ***/
          user_pref("network.http.max-connections", 1800);

          user_pref("network.http.max-persistent-connections-per-server", 10);
          user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
          user_pref("network.http.pacing.requests.enabled", false);
          user_pref("network.dnsCacheExpiration", 3600);

          user_pref("network.dns.max_high_priority_threads", 8);
          user_pref("network.ssl_tokens_cache_capacity", 10240);

          /** SPECULATIVE LOADING ***/
          user_pref("network.dns.disablePrefetch", true);
          user_pref("network.prefetch-next", false);
          user_pref("network.predictor.enabled", false);

          /** EXPERIMENTAL ***/
          user_pref("layout.css.grid-template-masonry-value.enabled", true);
          user_pref("dom.enable_web_task_scheduling", true);
          user_pref("layout.css.has-selector.enabled", true);
          user_pref("dom.security.sanitizer.enabled", true);

          /** TRACKING PROTECTION ***/
          user_pref("browser.contentblocking.category", "strict");
          user_pref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
          user_pref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
          user_pref("network.cookie.sameSite.noneRequiresSecure", true);
          user_pref("browser.download.start_downloads_in_tmp_dir", true);
          user_pref("browser.helperApps.deleteTempFileOnExit", true);
          user_pref("browser.uitour.enabled", false);
          user_pref("privacy.globalprivacycontrol.enabled", true);

          /** OCSP & CERTS / HPKP ***/
          user_pref("security.OCSP.enabled", 0);
          user_pref("security.remote_settings.crlite_filters.enabled", true);
          user_pref("security.pki.crlite_mode", 2);

          /** SSL / TLS ***/
          user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
          user_pref("browser.xul.error_pages.expert_bad_cert", true);
          user_pref("security.tls.enable_0rtt_data", false);

          /** DISK AVOIDANCE ***/
          user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
          user_pref("browser.sessionstore.interval", 60000);

          /** SHUTDOWN & SANITIZING ***/
          user_pref("privacy.history.custom", true);

          /** SEARCH / URL BAR ***/
          user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
          user_pref("browser.urlbar.update2.engineAliasRefresh", true);
          user_pref("browser.search.suggest.enabled", false);
          user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
          user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
          user_pref("browser.formfill.enable", false);
          user_pref("security.insecure_connection_text.enabled", true);
          user_pref("security.insecure_connection_text.pbmode.enabled", true);
          user_pref("network.IDN_show_punycode", true);


          /** HTTPS-FIRST POLICY ***/
          user_pref("dom.security.https_first", true);
          user_pref("dom.security.https_first_schemeless", true);

          /** PASSWORDS ***/
          user_pref("signon.formlessCapture.enabled", false);
          user_pref("signon.privateBrowsingCapture.enabled", false);
          user_pref("network.auth.subresource-http-auth-allow", 1);
          user_pref("editor.truncate_user_pastes", false);

          /** MIXED CONTENT + CROSS-SITE ***/
          user_pref("security.mixed_content.block_display_content", true);
          user_pref("security.mixed_content.upgrade_display_content", true);
          user_pref("security.mixed_content.upgrade_display_content.image", true);
          user_pref("pdfjs.enableScripting", false);
          user_pref("extensions.postDownloadThirdPartyPrompt", false);

          /** HEADERS / REFERERS ***/
          user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

          /** CONTAINERS ***/
          user_pref("privacy.userContext.ui.enabled", true);

          /** WEBRTC ***/
          user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
          user_pref("media.peerconnection.ice.default_address_only", true);

          /** SAFE BROWSING ***/
          user_pref("browser.safebrowsing.downloads.remote.enabled", false);

          /** MOZILLA ***/
          user_pref("permissions.default.desktop-notification", 2);
          user_pref("permissions.default.geo", 2);
          user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
          user_pref("permissions.manager.defaultsUrl", "");
          user_pref("webchannel.allowObject.urlWhitelist", "");

          /** TELEMETRY ***/
          user_pref("datareporting.policy.dataSubmissionEnabled", false);
          user_pref("datareporting.healthreport.uploadEnabled", false);
          user_pref("toolkit.telemetry.unified", false);
          user_pref("toolkit.telemetry.enabled", false);
          user_pref("toolkit.telemetry.server", "data:,");
          user_pref("toolkit.telemetry.archive.enabled", false);
          user_pref("toolkit.telemetry.newProfilePing.enabled", false);
          user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
          user_pref("toolkit.telemetry.updatePing.enabled", false);
          user_pref("toolkit.telemetry.bhrPing.enabled", false);
          user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
          user_pref("toolkit.telemetry.coverage.opt-out", true);
          user_pref("toolkit.coverage.opt-out", true);
          user_pref("toolkit.coverage.endpoint.base", "");
          user_pref("browser.ping-centre.telemetry", false);
          user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
          user_pref("browser.newtabpage.activity-stream.telemetry", false);

          /** EXPERIMENTS ***/
          user_pref("app.shield.optoutstudies.enabled", false);
          user_pref("app.normandy.enabled", false);
          user_pref("app.normandy.api_url", "");

          /** CRASH REPORTS ***/
          user_pref("breakpad.reportURL", "");
          user_pref("browser.tabs.crashReporting.sendReport", false);
          user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

          /** DETECTION ***/
          user_pref("captivedetect.canonicalURL", "");
          user_pref("network.captive-portal-service.enabled", false);
          user_pref("network.connectivity-service.enabled", false);

          /** MOZILLA UI ***/
          user_pref("browser.privatebrowsing.vpnpromourl", "");
          user_pref("extensions.getAddons.showPane", false);
          user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
          user_pref("browser.discovery.enabled", false);
          user_pref("browser.shell.checkDefaultBrowser", false);
          user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
          user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
          user_pref("browser.preferences.moreFromMozilla", false);
          user_pref("browser.tabs.tabmanager.enabled", false);
          user_pref("browser.aboutConfig.showWarning", false);
          user_pref("browser.aboutwelcome.enabled", false);

          /** THEME ADJUSTMENTS ***/
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("browser.compactmode.show", true);
          user_pref("browser.display.focus_ring_on_anything", true);
          user_pref("browser.display.focus_ring_style", 0);
          user_pref("browser.display.focus_ring_width", 0);
          user_pref("layout.css.prefers-color-scheme.content-override", 2);
          user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS

          /** COOKIE BANNER HANDLING ***/
          user_pref("cookiebanners.service.mode", 1);
          user_pref("cookiebanners.service.mode.privateBrowsing", 1);

          /** FULLSCREEN NOTICE ***/
          user_pref("full-screen-api.transition-duration.enter", "0 0");
          user_pref("full-screen-api.transition-duration.leave", "0 0");
          user_pref("full-screen-api.warning.delay", -1);
          user_pref("full-screen-api.warning.timeout", 0);

          /** URL BAR ***/
          user_pref("browser.urlbar.suggest.calculator", true);
          user_pref("browser.urlbar.unitConversion.enabled", true);
          user_pref("browser.urlbar.trending.featureGate", false);

          /** NEW TAB PAGE ***/
          user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
          user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

          /** POCKET ***/
          user_pref("extensions.pocket.enabled", false);

          /** DOWNLOADS ***/
          user_pref("browser.download.always_ask_before_handling_new_types", true);
          user_pref("browser.download.manager.addToRecentDocs", false);

          /** PDF ***/
          user_pref("browser.download.open_pdf_attachments_inline", true);

          /** TAB BEHAVIOR ***/
          user_pref("browser.bookmarks.openInTabClosesMenu", false);
          user_pref("browser.menu.showViewImageInfo", true);
          user_pref("findbar.highlightAll", true);
          user_pref("layout.word_select.eat_space_to_next_word", false);
        '';
        userChrome = ''
          #TabsToolbar {
            visibility: collapse;
          }
        '';
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          onepassword-password-manager
          tab-stash
          df-youtube
          languagetool
          multi-account-containers
          refined-github
          temporary-containers
          ublock-origin
          tridactyl
        ];
      };
    };

    home.packages = lib.mkIf isLinux [
      # pkgs.nur.repos.nekowinston.sizzy
      pkgs.mullvad-browser
    ];

    xdg.mimeApps.defaultApplications = {
      "text/html" = "chromium.desktop";
      "x-scheme-handler/http" = "chromium.desktop";
      "x-scheme-handler/https" = "chromium.desktop";
      "x-scheme-handler/about" = "chromium.desktop";
      "x-scheme-handler/unknown" = "chromium.desktop";
    };
  };
}
