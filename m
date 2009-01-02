From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ata_piix: save, use saved and restore IOCFG
Date: Fri, 02 Jan 2009 12:04:48 +0900
Message-ID: <495D8450.6070505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34937 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbZABDFY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jan 2009 22:05:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andreas Mohr <andi@lisas.de>

Certain ACPI implementations mess up IOCFG on _STM making libata
detect cable type incorrectly after a suspend/resume cycle.  This
patch makes ata_piix save IOCFG on attach, use the saved value for
things which aren't dynamic and restore it on detach so that the next
driver also gets the BIOS initialized value.

This patch contains the following changes.

* makes ich_pata_cable_detect() use saved_iocfg.

* make piix_iocfg_bit18_quirk() take @host and use saved_iocfg.

* hpriv allocation moved upwards to save iocfg before doing anything
  else.

This fixes bz#11879.  Andreas Mohr reported and diagnosed the problem.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andreas Mohr <andi@lisas.de>
---
 drivers/ata/ata_piix.c |   49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index c11936e..be4d4bd 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -154,11 +154,13 @@ struct piix_map_db {
 
 struct piix_host_priv {
 	const int *map;
+	u32 saved_iocfg;
 	void __iomem *sidpr;
 };
 
 static int piix_init_one(struct pci_dev *pdev,
 			 const struct pci_device_id *ent);
+static void piix_remove_one(struct pci_dev *pdev);
 static int piix_pata_prereset(struct ata_link *link, unsigned long deadline);
 static void piix_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode(struct ata_port *ap, struct ata_device *adev);
@@ -296,7 +298,7 @@ static struct pci_driver piix_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= piix_pci_tbl,
 	.probe			= piix_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= piix_remove_one,
 #ifdef CONFIG_PM
 	.suspend		= piix_pci_device_suspend,
 	.resume			= piix_pci_device_resume,
@@ -610,8 +612,9 @@ static const struct ich_laptop ich_laptop[] = {
 static int ich_pata_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	struct piix_host_priv *hpriv = ap->host->private_data;
 	const struct ich_laptop *lap = &ich_laptop[0];
-	u8 tmp, mask;
+	u8 mask;
 
 	/* Check for specials - Acer Aspire 5602WLMi */
 	while (lap->device) {
@@ -625,8 +628,7 @@ static int ich_pata_cable_detect(struct ata_port *ap)
 
 	/* check BIOS cable detect results */
 	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
-	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
-	if ((tmp & mask) == 0)
+	if ((hpriv->saved_iocfg & mask) == 0)
 		return ATA_CBL_PATA40;
 	return ATA_CBL_PATA80;
 }
@@ -1357,7 +1359,7 @@ static int __devinit piix_init_sidpr(struct ata_host *host)
 	return 0;
 }
 
-static void piix_iocfg_bit18_quirk(struct pci_dev *pdev)
+static void piix_iocfg_bit18_quirk(struct ata_host *host)
 {
 	static const struct dmi_system_id sysids[] = {
 		{
@@ -1374,7 +1376,8 @@ static void piix_iocfg_bit18_quirk(struct pci_dev *pdev)
 
 		{ }	/* terminate list */
 	};
-	u32 iocfg;
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	struct piix_host_priv *hpriv = host->private_data;
 
 	if (!dmi_check_system(sysids))
 		return;
@@ -1383,12 +1386,11 @@ static void piix_iocfg_bit18_quirk(struct pci_dev *pdev)
 	 * seem to use it to disable a channel.  Clear the bit on the
 	 * affected systems.
 	 */
-	pci_read_config_dword(pdev, PIIX_IOCFG, &iocfg);
-	if (iocfg & (1 << 18)) {
+	if (hpriv->saved_iocfg & (1 << 18)) {
 		dev_printk(KERN_INFO, &pdev->dev,
 			   "applying IOCFG bit18 quirk\n");
-		iocfg &= ~(1 << 18);
-		pci_write_config_dword(pdev, PIIX_IOCFG, iocfg);
+		pci_write_config_dword(pdev, PIIX_IOCFG,
+				       hpriv->saved_iocfg & ~(1 << 18));
 	}
 }
 
@@ -1437,6 +1439,17 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
+	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
+
+	/* Save IOCFG, this will be used for cable detection, quirk
+	 * detection and restoration on detach.  This is necessary
+	 * because some ACPI implementations mess up cable related
+	 * bits on _STM.  Reported on kernel bz#11879.
+	 */
+	pci_read_config_dword(pdev, PIIX_IOCFG, &hpriv->saved_iocfg);
+
 	/* ICH6R may be driven by either ata_piix or ahci driver
 	 * regardless of BIOS configuration.  Make sure AHCI mode is
 	 * off.
@@ -1448,10 +1461,6 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	}
 
 	/* SATA map init can change port_info, do it before prepping host */
-	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv)
-		return -ENOMEM;
-
 	if (port_flags & ATA_FLAG_SATA)
 		hpriv->map = piix_init_sata_map(pdev, port_info,
 					piix_map_db_table[ent->driver_data]);
@@ -1470,7 +1479,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	}
 
 	/* apply IOCFG bit18 quirk */
-	piix_iocfg_bit18_quirk(pdev);
+	piix_iocfg_bit18_quirk(host);
 
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
@@ -1495,6 +1504,16 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &piix_sht);
 }
 
+static void piix_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct piix_host_priv *hpriv = host->private_data;
+
+	pci_write_config_dword(pdev, PIIX_IOCFG, hpriv->saved_iocfg);
+
+	ata_pci_remove_one(pdev);
+}
+
 static int __init piix_init(void)
 {
 	int rc;
