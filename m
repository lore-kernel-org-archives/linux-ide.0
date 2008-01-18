From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] ata_piix: convert to prepare - activate initialization
Date: Fri, 18 Jan 2008 18:36:29 +0900
Message-ID: <1200648990900-git-send-email-htejun@gmail.com>
References: <12006489901911-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:36351 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbYARJgl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 04:36:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so835837rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 01:36:36 -0800 (PST)
In-Reply-To: <12006489901911-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_piix requires more configuration during initialization than most
other SFF compliant controllers and one-go initialzation with
ata_pci_one() is too rigid.

This patch converts ata_piix to use two step prepare - activate
initialization used by other more advanced controllers.  This
conversion brings the happy side effect of enabling PCI device before
accessing PCI configuration registers.  Other than that, there
shouldn't be any behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |   79 ++++++++++++++++++++++-------------------------
 1 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ba10520..58b9c89 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -316,7 +316,6 @@ static const struct ata_port_operations piix_pata_ops = {
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
@@ -348,7 +347,6 @@ static const struct ata_port_operations ich_pata_ops = {
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ich_pata_cable_detect,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
@@ -375,7 +373,6 @@ static const struct ata_port_operations piix_sata_ops = {
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
@@ -521,7 +518,6 @@ static const struct piix_map_db *piix_map_db_table[] = {
 static struct ata_port_info piix_port_info[] = {
 	[piix_pata_mwdma] = 	/* PIIX3 MWDMA only */
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
@@ -530,7 +526,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[piix_pata_33] =	/* PIIX4 at 33MHz */
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
@@ -540,7 +535,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich_pata_33] = 	/* ICH0 - ICH at 33Mhz*/
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* Check: maybe 0x07  */
@@ -550,7 +544,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich_pata_66] = 	/* ICH controllers up to 66MHz */
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* MWDMA0 is broken on chip */
@@ -560,7 +553,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich_pata_100] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
@@ -570,7 +562,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich5_sata] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -580,7 +571,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich6_sata] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -590,7 +580,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich6_sata_ahci] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -600,7 +589,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich6m_sata_ahci] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -610,7 +598,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich8_sata_ahci] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -620,7 +607,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich8_2port_sata] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -630,7 +616,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[tolapai_sata_ahci] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -640,7 +625,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich8m_apple_sata_ahci] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -1242,10 +1226,10 @@ static int __devinit piix_check_450nx_errata(struct pci_dev *ata_dev)
 	return no_piix_dma;
 }
 
-static void __devinit piix_init_pcs(struct pci_dev *pdev,
-				    struct ata_port_info *pinfo,
+static void __devinit piix_init_pcs(struct ata_host *host,
 				    const struct piix_map_db *map_db)
 {
+	struct pci_dev *pdev = to_pci_dev(host->dev);
 	u16 pcs, new_pcs;
 
 	pci_read_config_word(pdev, ICH5_PCS, &pcs);
@@ -1259,11 +1243,10 @@ static void __devinit piix_init_pcs(struct pci_dev *pdev,
 	}
 }
 
-static void __devinit piix_init_sata_map(struct pci_dev *pdev,
-					 struct ata_port_info *pinfo,
-					 const struct piix_map_db *map_db)
+static const int *__devinit piix_init_sata_map(struct pci_dev *pdev,
+					       struct ata_port_info *pinfo,
+					       const struct piix_map_db *map_db)
 {
-	struct piix_host_priv *hpriv = pinfo[0].private_data;
 	const int *map;
 	int i, invalid_map = 0;
 	u8 map_value;
@@ -1287,7 +1270,6 @@ static void __devinit piix_init_sata_map(struct pci_dev *pdev,
 		case IDE:
 			WARN_ON((i & 1) || map[i + 1] != IDE);
 			pinfo[i / 2] = piix_port_info[ich_pata_100];
-			pinfo[i / 2].private_data = hpriv;
 			i++;
 			printk(" IDE IDE");
 			break;
@@ -1305,7 +1287,7 @@ static void __devinit piix_init_sata_map(struct pci_dev *pdev,
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "invalid MAP value %u\n", map_value);
 
-	hpriv->map = map;
+	return map;
 }
 
 static void piix_iocfg_bit18_quirk(struct pci_dev *pdev)
@@ -1364,8 +1346,10 @@ static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct device *dev = &pdev->dev;
 	struct ata_port_info port_info[2];
 	const struct ata_port_info *ppi[] = { &port_info[0], &port_info[1] };
-	struct piix_host_priv *hpriv;
 	unsigned long port_flags;
+	struct ata_host *host;
+	struct piix_host_priv *hpriv;
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
@@ -1375,17 +1359,31 @@ static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!in_module_init)
 		return -ENODEV;
 
+	port_info[0] = piix_port_info[ent->driver_data];
+	port_info[1] = piix_port_info[ent->driver_data];
+
+	port_flags = port_info[0].flags;
+
+	/* enable device and prepare host */
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	/* SATA map init can change port_info, do it before prepping host */
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
 
-	port_info[0] = piix_port_info[ent->driver_data];
-	port_info[1] = piix_port_info[ent->driver_data];
-	port_info[0].private_data = hpriv;
-	port_info[1].private_data = hpriv;
+	if (port_flags & ATA_FLAG_SATA)
+		hpriv->map = piix_init_sata_map(pdev, port_info,
+					piix_map_db_table[ent->driver_data]);
 
-	port_flags = port_info[0].flags;
+	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	if (rc)
+		return rc;
+	host->private_data = hpriv;
 
+	/* initialize controller */
 	if (port_flags & PIIX_FLAG_AHCI) {
 		u8 tmp;
 		pci_read_config_byte(pdev, PIIX_SCC, &tmp);
@@ -1396,13 +1394,8 @@ static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	/* Initialize SATA map */
-	if (port_flags & ATA_FLAG_SATA) {
-		piix_init_sata_map(pdev, port_info,
-				   piix_map_db_table[ent->driver_data]);
-		piix_init_pcs(pdev, port_info,
-			      piix_map_db_table[ent->driver_data]);
-	}
+	if (port_flags & ATA_FLAG_SATA)
+		piix_init_pcs(host, piix_map_db_table[ent->driver_data]);
 
 	/* apply IOCFG bit18 quirk */
 	piix_iocfg_bit18_quirk(pdev);
@@ -1420,12 +1413,14 @@ static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* This writes into the master table but it does not
 		   really matter for this errata as we will apply it to
 		   all the PIIX devices on the board */
-		port_info[0].mwdma_mask = 0;
-		port_info[0].udma_mask = 0;
-		port_info[1].mwdma_mask = 0;
-		port_info[1].udma_mask = 0;
+		host->ports[0]->mwdma_mask = 0;
+		host->ports[0]->udma_mask = 0;
+		host->ports[1]->mwdma_mask = 0;
+		host->ports[1]->udma_mask = 0;
 	}
-	return ata_pci_init_one(pdev, ppi);
+
+	pci_set_master(pdev);
+	return ata_pci_activate_sff_host(host, ata_interrupt, &piix_sht);
 }
 
 static int __init piix_init(void)
-- 
1.5.2.4

