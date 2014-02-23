From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] ahci_sunxi: Use msleep instead of mdelay
Date: Sun, 23 Feb 2014 12:52:41 +0100
Message-ID: <1393156361-18414-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBEGCU6MAKGQEFHT53JY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

ahci_sunxi_phy_init is called from the probe and resume code paths, and
sleeping is safe in both, so use msleep instead of mdelay.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_sunxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 001f7dfc..d1bf3f7 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -90,7 +90,7 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 
 	/* This magic is from the original code */
 	writel(0, reg_base + AHCI_RWCR);
-	mdelay(5);
+	msleep(5);
 
 	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
 	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
@@ -105,7 +105,7 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 			 (0x7 << 20), (0x3 << 20));
 	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
 			 (0x1f << 5), (0x19 << 5));
-	mdelay(5);
+	msleep(5);
 
 	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
 
@@ -137,7 +137,7 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 		udelay(1);
 	} while (1);
 
-	mdelay(15);
+	msleep(15);
 
 	writel(0x7, reg_base + AHCI_RWCR);
 
-- 
1.9.0
