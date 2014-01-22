From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 12/14] ahci-imx: Fix link not coming back up
 after suspend / resume
Date: Wed, 22 Jan 2014 20:04:47 +0100
Message-ID: <1390417489-5354-13-git-send-email-hdegoede@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB7VMQCLQKGQEUOXI3TY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390417489-5354-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

The phy needs to be re-initialized on resume for the link to properly come
back up.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_imx.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index e58e062..68d89fa 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -265,27 +265,11 @@ static int imx_ahci_resume(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 	int ret;
 
-	if (hpriv->target_pwr) {
-		ret = regulator_enable(hpriv->target_pwr);
-		if (ret)
-			return ret;
-	}
-
-	if (!imxpriv->no_device) {
-		ret = ahci_platform_enable_clks(hpriv);
-		if (ret < 0) {
-			dev_err(dev, "pre-enable sata_ref clock err:%d\n", ret);
-			return ret;
-		}
-
-		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
-				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
-				IMX6Q_GPR13_SATA_MPLL_CLK_EN);
-		usleep_range(1000, 2000);
-	}
+	ret = imx_ahci_phy_init(hpriv);
+	if (ret)
+		return ret;
 
 	return ahci_platform_resume_host(dev);
 }
-- 
1.8.5.3
