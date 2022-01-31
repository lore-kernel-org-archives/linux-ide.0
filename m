Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B56C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jan 2022 19:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiAaT54 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jan 2022 14:57:56 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:40226 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377744AbiAaT5g (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jan 2022 14:57:36 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru B1EA220C095E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] libata: ata_host_suspend() always returns 0
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>
Organization: Open Mobile Platform
Message-ID: <b690e385-0e2b-d476-2590-01b2abf4811f@omp.ru>
Date:   Mon, 31 Jan 2022 22:57:31 +0300
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

ata_host_suspend() always returns 0, so the result checks in the drivers
are pointless.  However I chose not to change ata_host_suspend() to *void*
not to have to change

	return ata_host_suspend(...);
to
	ata_host_suspend(...);
	return 0;

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/ata_piix.c     |    5 +----
 drivers/ata/libata-core.c  |    7 +++----
 drivers/ata/pata_cs5520.c  |    5 +----
 drivers/ata/pata_imx.c     |   15 ++++++---------
 drivers/ata/pata_macio.c   |    6 +-----
 drivers/ata/pata_triflex.c |    5 +----
 drivers/ata/sata_mv.c      |    6 +++---
 drivers/ata/sata_rcar.c    |   18 ++++++++----------
 8 files changed, 24 insertions(+), 43 deletions(-)

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
Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -5168,6 +5168,8 @@ EXPORT_SYMBOL_GPL(ata_sas_port_resume);
  *	@host: host to suspend
  *	@mesg: PM message
  *
+ *	Return: always 0
+ *
  *	Suspend @host.  Actual operation is performed by port suspend.
  */
 int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
@@ -6090,11 +6092,8 @@ EXPORT_SYMBOL_GPL(ata_pci_device_do_resu
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
 
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
+	ata_host_suspend(host, mesg);
 
 	ata_pci_device_do_suspend(pdev, mesg);
 
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
