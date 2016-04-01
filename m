From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 1/3] libahci: save port map for forced port map
Date: Fri,  1 Apr 2016 08:52:56 +0100
Message-ID: <1459497178-31090-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459497178-31090-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jmaggard10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

In usecases where force_port_map is used saved_port_map is never set,
resulting in not programming the PORTS_IMPL register as part of initial
config. This patch fixes this by setting it to port_map even in case
where force_port_map is used, making it more inline with other parts of
the code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/ata/libahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3982054..a5d7c1c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -507,6 +507,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
 			 port_map, hpriv->force_port_map);
 		port_map = hpriv->force_port_map;
+		hpriv->saved_port_map = port_map;
 	}
 
 	if (hpriv->mask_port_map) {
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
