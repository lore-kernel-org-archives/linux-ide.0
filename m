Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D27C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 20:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiBBU61 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 15:58:27 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:46808 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBBU61 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 15:58:27 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 5C77121F2172
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] libata: make ata_host_suspend() *void*
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Viresh Kumar <vireshk@kernel.org>
Organization: Open Mobile Platform
Message-ID: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
Date:   Wed, 2 Feb 2022 23:58:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_host_suspend() always returns 0, so the result checks in many drivers
look pointless.  Let's make this function return *void* instead of *int*.

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/ahci.c             |    3 ++-
 drivers/ata/ata_piix.c         |    5 +----
 drivers/ata/libahci_platform.c |    3 ++-
 drivers/ata/libata-core.c      |    8 ++------
 drivers/ata/pata_arasan_cf.c   |    3 ++-
 drivers/ata/pata_cs5520.c      |    5 +----
 drivers/ata/pata_imx.c         |   15 ++++++---------
 drivers/ata/pata_macio.c       |    6 +-----
 drivers/ata/pata_mpc52xx.c     |    3 ++-
 drivers/ata/pata_samsung_cf.c  |    3 ++-
 drivers/ata/pata_triflex.c     |    5 +----
 drivers/ata/sata_fsl.c         |    4 +++-
 drivers/ata/sata_highbank.c    |    3 ++-
 drivers/ata/sata_mv.c          |    6 +++---
 drivers/ata/sata_rcar.c        |   18 ++++++++----------
 include/linux/libata.h         |    2 +-
 16 files changed, 39 insertions(+), 53 deletions(-)

Index: libata/drivers/ata/ahci.c
===================================================================
--- libata.orig/drivers/ata/ahci.c
+++ libata/drivers/ata/ahci.c
@@ -891,7 +891,8 @@ static int ahci_pci_device_suspend(struc
 	}
 
 	ahci_pci_disable_interrupts(host);
-	return ata_host_suspend(host, PMSG_SUSPEND);
+	ata_host_suspend(host, PMSG_SUSPEND);
+	return 0;
 }
 
 static int ahci_pci_device_resume(struct device *dev)
Index: libata/drivers/ata/ata_piix.c
===================================================================
--- libata.orig/drivers/ata/ata_piix.c
+++ libata/drivers/ata/ata_piix.c
@@ -993,11 +993,8 @@ static int piix_pci_device_suspend(struc
 {
 	struct ata_host *host = pci_get_drvdata(pdev);
 	unsigned long flags;
-	int rc = 0;
 
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
+	ata_host_suspend(host, mesg);
 
 	/* Some braindamaged ACPI suspend implementations expect the
 	 * controller to be awake on entry; otherwise, it burns cpu
Index: libata/drivers/ata/libahci_platform.c
===================================================================
--- libata.orig/drivers/ata/libahci_platform.c
+++ libata/drivers/ata/libahci_platform.c
@@ -733,7 +733,8 @@ int ahci_platform_suspend_host(struct de
 	if (hpriv->flags & AHCI_HFLAG_SUSPEND_PHYS)
 		ahci_platform_disable_phys(hpriv);
 
-	return ata_host_suspend(host, PMSG_SUSPEND);
+	ata_host_suspend(host, PMSG_SUSPEND);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
 
Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -5170,10 +5170,9 @@ EXPORT_SYMBOL_GPL(ata_sas_port_resume);
  *
  *	Suspend @host.  Actual operation is performed by port suspend.
  */
-int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
+void ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 {
 	host->dev->power.power_state = mesg;
-	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_host_suspend);
 
@@ -6090,11 +6089,8 @@ EXPORT_SYMBOL_GPL(ata_pci_device_do_resu
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
 
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
+	ata_host_suspend(host, mesg);
 
 	ata_pci_device_do_suspend(pdev, mesg);
 
Index: libata/drivers/ata/pata_arasan_cf.c
===================================================================
--- libata.orig/drivers/ata/pata_arasan_cf.c
+++ libata/drivers/ata/pata_arasan_cf.c
@@ -937,7 +937,8 @@ static int arasan_cf_suspend(struct devi
 		dmaengine_terminate_all(acdev->dma_chan);
 
 	cf_exit(acdev);
-	return ata_host_suspend(host, PMSG_SUSPEND);
+	ata_host_suspend(host, PMSG_SUSPEND);
+	return 0;
 }
 
 static int arasan_cf_resume(struct device *dev)
Index: libata/drivers/ata/pata_cs5520.c
===================================================================
--- libata.orig/drivers/ata/pata_cs5520.c
+++ libata/drivers/ata/pata_cs5520.c
@@ -259,11 +259,8 @@ static int cs5520_reinit_one(struct pci_
 static int cs5520_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
 
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
+	ata_host_suspend(host, mesg);
 
 	pci_save_state(pdev);
 	return 0;
Index: libata/drivers/ata/pata_imx.c
===================================================================
--- libata.orig/drivers/ata/pata_imx.c
+++ libata/drivers/ata/pata_imx.c
@@ -223,17 +223,14 @@ static int pata_imx_suspend(struct devic
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct pata_imx_priv *priv = host->private_data;
-	int ret;
 
-	ret = ata_host_suspend(host, PMSG_SUSPEND);
-	if (!ret) {
-		__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
-		priv->ata_ctl =
-			__raw_readl(priv->host_regs + PATA_IMX_ATA_CONTROL);
-		clk_disable_unprepare(priv->clk);
-	}
+	ata_host_suspend(host, PMSG_SUSPEND);
 
-	return ret;
+	__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
+	priv->ata_ctl = __raw_readl(priv->host_regs + PATA_IMX_ATA_CONTROL);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
 }
 
 static int pata_imx_resume(struct device *dev)
Index: libata/drivers/ata/pata_macio.c
===================================================================
--- libata.orig/drivers/ata/pata_macio.c
+++ libata/drivers/ata/pata_macio.c
@@ -853,12 +853,8 @@ static int pata_macio_slave_config(struc
 #ifdef CONFIG_PM_SLEEP
 static int pata_macio_do_suspend(struct pata_macio_priv *priv, pm_message_t mesg)
 {
-	int rc;
-
 	/* First, core libata suspend to do most of the work */
-	rc = ata_host_suspend(priv->host, mesg);
-	if (rc)
-		return rc;
+	ata_host_suspend(priv->host, mesg);
 
 	/* Restore to default timings */
 	pata_macio_default_timings(priv);
Index: libata/drivers/ata/pata_mpc52xx.c
===================================================================
--- libata.orig/drivers/ata/pata_mpc52xx.c
+++ libata/drivers/ata/pata_mpc52xx.c
@@ -824,7 +824,8 @@ mpc52xx_ata_suspend(struct platform_devi
 {
 	struct ata_host *host = platform_get_drvdata(op);
 
-	return ata_host_suspend(host, state);
+	ata_host_suspend(host, state);
+	return 0;
 }
 
 static int
Index: libata/drivers/ata/pata_samsung_cf.c
===================================================================
--- libata.orig/drivers/ata/pata_samsung_cf.c
+++ libata/drivers/ata/pata_samsung_cf.c
@@ -608,7 +608,8 @@ static int pata_s3c_suspend(struct devic
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 
-	return ata_host_suspend(host, PMSG_SUSPEND);
+	ata_host_suspend(host, PMSG_SUSPEND);
+	return 0;
 }
 
 static int pata_s3c_resume(struct device *dev)
Index: libata/drivers/ata/pata_triflex.c
===================================================================
--- libata.orig/drivers/ata/pata_triflex.c
+++ libata/drivers/ata/pata_triflex.c
@@ -198,11 +198,8 @@ static const struct pci_device_id trifle
 static int triflex_ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
 
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
+	ata_host_suspend(host, mesg);
 
 	/*
 	 * We must not disable or powerdown the device.
Index: libata/drivers/ata/sata_fsl.c
===================================================================
--- libata.orig/drivers/ata/sata_fsl.c
+++ libata/drivers/ata/sata_fsl.c
@@ -1546,7 +1546,9 @@ static int sata_fsl_remove(struct platfo
 static int sata_fsl_suspend(struct platform_device *op, pm_message_t state)
 {
 	struct ata_host *host = platform_get_drvdata(op);
-	return ata_host_suspend(host, state);
+
+	ata_host_suspend(host, state);
+	return 0;
 }
 
 static int sata_fsl_resume(struct platform_device *op)
Index: libata/drivers/ata/sata_highbank.c
===================================================================
--- libata.orig/drivers/ata/sata_highbank.c
+++ libata/drivers/ata/sata_highbank.c
@@ -587,7 +587,8 @@ static int ahci_highbank_suspend(struct
 	writel(ctl, mmio + HOST_CTL);
 	readl(mmio + HOST_CTL); /* flush */
 
-	return ata_host_suspend(host, PMSG_SUSPEND);
+	ata_host_suspend(host, PMSG_SUSPEND);
+	return 0;
 }
 
 static int ahci_highbank_resume(struct device *dev)
Index: libata/drivers/ata/sata_mv.c
===================================================================
--- libata.orig/drivers/ata/sata_mv.c
+++ libata/drivers/ata/sata_mv.c
@@ -4235,10 +4235,10 @@ static int mv_platform_remove(struct pla
 static int mv_platform_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
+
 	if (host)
-		return ata_host_suspend(host, state);
-	else
-		return 0;
+		ata_host_suspend(host, state);
+	return 0;
 }
 
 static int mv_platform_resume(struct platform_device *pdev)
Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -945,19 +945,17 @@ static int sata_rcar_suspend(struct devi
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_rcar_priv *priv = host->private_data;
 	void __iomem *base = priv->base;
-	int ret;
 
-	ret = ata_host_suspend(host, PMSG_SUSPEND);
-	if (!ret) {
-		/* disable interrupts */
-		iowrite32(0, base + ATAPI_INT_ENABLE_REG);
-		/* mask */
-		iowrite32(priv->sataint_mask, base + SATAINTMASK_REG);
+	ata_host_suspend(host, PMSG_SUSPEND);
 
-		pm_runtime_put(dev);
-	}
+	/* disable interrupts */
+	iowrite32(0, base + ATAPI_INT_ENABLE_REG);
+	/* mask */
+	iowrite32(priv->sataint_mask, base + SATAINTMASK_REG);
 
-	return ret;
+	pm_runtime_put(dev);
+
+	return 0;
 }
 
 static int sata_rcar_resume(struct device *dev)
Index: libata/include/linux/libata.h
===================================================================
--- libata.orig/include/linux/libata.h
+++ libata/include/linux/libata.h
@@ -1080,7 +1080,7 @@ extern int ata_sas_scsi_ioctl(struct ata
 extern bool ata_link_online(struct ata_link *link);
 extern bool ata_link_offline(struct ata_link *link);
 #ifdef CONFIG_PM
-extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
+extern void ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
 extern void ata_sas_port_suspend(struct ata_port *ap);
 extern void ata_sas_port_resume(struct ata_port *ap);
