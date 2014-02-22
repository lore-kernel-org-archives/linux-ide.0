From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 3/3] ahci_platform: Drop unused ahci_platform_data members
Date: Sat, 22 Feb 2014 17:22:55 +0100
Message-ID: <1393086175-6383-4-git-send-email-hdegoede@redhat.com>
References: <1393086175-6383-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB445UOMAKGQEZ263KBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1393086175-6383-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

These members are not used anywhere, and in the future we want
ahci_platform_data to go away entirely so there is no reason to keep these
around.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_platform.c   | 10 +---------
 include/linux/ahci_platform.h |  3 ---
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index d48ca8a..c04e1a9 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -404,7 +404,6 @@ static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
-	const struct ata_port_info *pi_template;
 	struct ahci_host_priv *hpriv;
 	int rc;
 
@@ -428,14 +427,7 @@ static int ahci_probe(struct platform_device *pdev)
 			goto disable_resources;
 	}
 
-	if (pdata && pdata->ata_port_info)
-		pi_template = pdata->ata_port_info;
-	else
-		pi_template = &ahci_port_info;
-
-	rc = ahci_platform_init_host(pdev, hpriv, pi_template,
-				     pdata ? pdata->force_port_map : 0,
-				     pdata ? pdata->mask_port_map  : 0);
+	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info, 0, 0);
 	if (rc)
 		goto pdata_exit;
 
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 542f268..1f16d50 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -33,9 +33,6 @@ struct ahci_platform_data {
 	void (*exit)(struct device *dev);
 	int (*suspend)(struct device *dev);
 	int (*resume)(struct device *dev);
-	const struct ata_port_info *ata_port_info;
-	unsigned int force_port_map;
-	unsigned int mask_port_map;
 };
 
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
-- 
1.9.0
