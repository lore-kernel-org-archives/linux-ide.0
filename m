From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 14/18] ata: ahci_platform: Add 'struct
 device' argument to ahci_platform_put_resources()
Date: Wed, 19 Feb 2014 13:01:56 +0100
Message-ID: <1392811320-3132-15-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBDN3SKMAKGQECIK7QBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

There is no easy way to access 'struct device' from 'struct ahci_host_priv'
so add an explicit argument for 'struct device'. We will need it
to call Runtime PM APIs.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_imx.c        | 5 +++--
 drivers/ata/ahci_platform.c   | 7 ++++---
 drivers/ata/ahci_sunxi.c      | 2 +-
 include/linux/ahci_platform.h | 3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 7d51ee2..5cdaf0b 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -276,16 +276,17 @@ static int imx_ahci_probe(struct platform_device *pdev)
 disable:
 	imx_sata_disable(hpriv);
 put_resources:
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 	return ret;
 }
 
 static void ahci_imx_host_stop(struct ata_host *host)
 {
+	struct device *dev = host->dev;
 	struct ahci_host_priv *hpriv = host->private_data;
 
 	imx_sata_disable(hpriv);
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 }
 
 static int imx_ahci_suspend(struct device *dev)
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 073931a..f8ef780 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -243,7 +243,8 @@ free_clk:
 }
 EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
 
-void ahci_platform_put_resources(struct ahci_host_priv *hpriv)
+void ahci_platform_put_resources(struct device *dev,
+				 struct ahci_host_priv *hpriv)
 {
 	int c;
 
@@ -375,7 +376,7 @@ pdata_exit:
 disable_resources:
 	ahci_platform_disable_resources(hpriv);
 put_resources:
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 	return rc;
 }
 
@@ -389,7 +390,7 @@ static void ahci_host_stop(struct ata_host *host)
 		pdata->exit(dev);
 
 	ahci_platform_disable_resources(hpriv);
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 568a211..219d77f 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -194,7 +194,7 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 disable_resources:
 	ahci_platform_disable_resources(hpriv);
 put_resources:
-	ahci_platform_put_resources(hpriv);
+	ahci_platform_put_resources(dev, hpriv);
 	return rc;
 }
 
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 7c683c7..719678c 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -43,7 +43,8 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
 struct ahci_host_priv *ahci_platform_get_resources(
 	struct platform_device *pdev);
-void ahci_platform_put_resources(struct ahci_host_priv *hpriv);
+void ahci_platform_put_resources(struct device *dev,
+				 struct ahci_host_priv *hpriv);
 int ahci_platform_init_host(struct platform_device *pdev,
 			    struct ahci_host_priv *hpriv,
 			    const struct ata_port_info *pi_template,
-- 
1.8.5.3
