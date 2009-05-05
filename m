From: Karl Hiramoto <karl@hiramoto.org>
Subject: [RFC]hpt366/ide-probe  reset drive on probe error.
Date: Tue, 05 May 2009 16:53:31 +0200
Message-ID: <4A0052EB.6040502@hiramoto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:51330 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192AbZEEOym (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2009 10:54:42 -0400
Received: from spunkymail-a20.g.dreamhost.com (caiajhbdccac.dreamhost.com [208.97.132.202])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 084AA18578E
	for <linux-ide@vger.kernel.org>; Tue,  5 May 2009 07:54:43 -0700 (PDT)
Received: from [192.168.10.51] (81.Red-83-44-145.dynamicIP.rima-tde.net [83.44.145.81])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a20.g.dreamhost.com (Postfix) with ESMTP id 41A16E252F
	for <linux-ide@vger.kernel.org>; Tue,  5 May 2009 07:53:36 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Part of this patch (htp366.c) is commented in an #if 0   in older 
kernels.   2.6.11 for sure.

I have an ARM IXP4xx based board with CompactFlash slot that this patch 
fixes some issues for.    I think the case, is only with a warm boot, 
where the drive was busy before the board was reset.   There is  no 
BIOS, only the redboot loader which loads the kernel.


A few questions:

1.  Would this be considerd to be brought into mainline?

2.  How would you port something like this to using the SATA layer?

Would it go to the ata_port_operations.prereset,  softreset or hardreset?

--
Karl

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 3377766..ba4b802 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -1280,6 +1280,31 @@ static u8 hpt3xx_cable_detect(ide_hwif_t *hwif)
 	return (scr1 & ata66) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 }
 
+/** routine to reset disk
+ *
+ * Since SUN Cobalt is attempting to do this operation, I should disclose
+ * this has been a long time ago Thu Jul 27 16:40:57 2000 was the patch date
+ * HOTSWAP ATA Infrastructure.
+ */
+
+static void hpt3xx_reset (ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct pci_dev *dev = to_pci_dev(hwif->dev);
+	unsigned long high_16;
+	u8 reset;
+	u8 reg59h = 0;
+
+	printk(KERN_INFO "%s reset drive channel %d\n", __func__, hwif->channel);
+	high_16 = pci_resource_start(dev, 4);
+
+	reset = hwif->channel ? 0x80 : 0x40;
+
+	pci_read_config_byte(dev, 0x59, &reg59h);
+	pci_write_config_byte(dev, 0x59, reg59h|reset);
+	pci_write_config_byte(dev, 0x59, reg59h);
+}
+
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
@@ -1406,6 +1431,7 @@ static const struct ide_port_ops hpt3xx_port_ops = {
 	.set_pio_mode		= hpt3xx_set_pio_mode,
 	.set_dma_mode		= hpt3xx_set_mode,
 	.quirkproc		= hpt3xx_quirkproc,
+	.resetproc		= hpt3xx_reset,
 	.maskproc		= hpt3xx_maskproc,
 	.mdma_filter		= hpt3xx_mdma_filter,
 	.udma_filter		= hpt3xx_udma_filter,
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 7f264ed..09295b4 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -367,6 +367,7 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
+	const struct ide_port_ops *port_ops = hwif->port_ops;
 	u16 *id = drive->id;
 	int rc;
 	u8 present = !!(drive->dev_flags & IDE_DFLAG_PRESENT), stat;
@@ -427,9 +428,20 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
 		/* ensure drive IRQ is clear */
 		stat = tp_ops->read_status(hwif);
 
-		if (rc == 1)
+		if (rc == 1) {
 			printk(KERN_ERR "%s: no response (status = 0x%02x)\n",
 					drive->name, stat);
+
+			if (port_ops->resetproc) {
+				port_ops->resetproc(drive);
+				msleep(50);
+			}
+			tp_ops->dev_select(drive);
+			msleep(50);
+			tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
+			(void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
+			rc = ide_dev_read_id(drive, cmd, id);
+		}
 	} else {
 		/* not present or maybe ATAPI */
 		rc = 3;


