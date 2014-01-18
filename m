From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 03/13] ahci-platform: Fix clk enable/disable
 unbalance on suspend/resume
Date: Sun, 19 Jan 2014 00:48:45 +0100
Message-ID: <1390088935-7193-4-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB5VF5SLAKGQE7PMJXXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

For devices where ahci_platform_data provides suspend() there is an unbalance
in clk enable/disable calls. The suspend path does not disable the clk, but
the resume path enables it. This commit fixes it by always disabling the clk
in the suspend path independent of there being an ahci_platform_data suspend
method.

On all drivers currently using a suspend method, the suspend method always
succeeds, so change its return type to void, to avoid having the introduce
somewhat complex error handling paths.

The disabling of the clock on suspend is a functional change, to ensure this
is ok I've audited all drivers using ahci_platform_data:

arch/arm/mach-davinci/devices-da8xx.c: Does not use a suspend method
arch/arm/mach-spear/spear1340.c: Does not use the clock framework
drivers/ata/ahci_imx.c: Does have suspend and resume pdata methods, these
disable / enable another clock, so likely it is ok to disable / enable the
clock at of-node index 0 as well, I've ordered a wandboard to be able to
test these changes.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-spear/spear1340.c | 6 ++----
 drivers/ata/ahci_imx.c          | 4 +---
 drivers/ata/ahci_platform.c     | 2 +-
 include/linux/ahci_platform.h   | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 3fb6834..c4cbbd2 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -107,14 +107,12 @@ void sata_miphy_exit(struct device *dev)
 	msleep(20);
 }
 
-int sata_suspend(struct device *dev)
+void sata_suspend(struct device *dev)
 {
 	if (dev->power.power_state.event == PM_EVENT_FREEZE)
-		return 0;
+		return;
 
 	sata_miphy_exit(dev);
-
-	return 0;
 }
 
 int sata_resume(struct device *dev)
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3e23e99..30568d3 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -171,7 +171,7 @@ static void imx6q_sata_exit(struct device *dev)
 	clk_disable_unprepare(imxpriv->sata_ref_clk);
 }
 
-static int imx_ahci_suspend(struct device *dev)
+static void imx_ahci_suspend(struct device *dev)
 {
 	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
 
@@ -185,8 +185,6 @@ static int imx_ahci_suspend(struct device *dev)
 				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
 		clk_disable_unprepare(imxpriv->sata_ref_clk);
 	}
-
-	return 0;
 }
 
 static int imx_ahci_resume(struct device *dev)
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 4b231ba..dc1ef73 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -275,7 +275,7 @@ static int ahci_suspend(struct device *dev)
 		return rc;
 
 	if (pdata && pdata->suspend)
-		return pdata->suspend(dev);
+		pdata->suspend(dev);
 
 	if (!IS_ERR(hpriv->clk))
 		clk_disable_unprepare(hpriv->clk);
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 73a2500..a641cb6 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -23,7 +23,7 @@ struct ata_port_info;
 struct ahci_platform_data {
 	int (*init)(struct device *dev, void __iomem *addr);
 	void (*exit)(struct device *dev);
-	int (*suspend)(struct device *dev);
+	void (*suspend)(struct device *dev);
 	int (*resume)(struct device *dev);
 	const struct ata_port_info *ata_port_info;
 	unsigned int force_port_map;
-- 
1.8.4.2
