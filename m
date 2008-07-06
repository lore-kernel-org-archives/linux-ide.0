From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/50] aec62xx: convert to use ->host_priv
Date: Sun, 06 Jul 2008 19:20:18 +0200
Message-ID: <48710236.1ade660a.3458.6279@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:7197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbYGFRes (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:48 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985609ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:47 -0700 (PDT)
Content-Disposition: inline; filename=aec62xx-convert-to-use-host_priv.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -59,10 +59,6 @@ static const struct chipset_bus_clock_li
 	{	0,		0x00,	0x00	}
 };
 
-#define BUSCLOCK(D)	\
-	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))
-
-
 /*
  * TO DO: active tuning and correction of cards without a bios.
  */
@@ -88,6 +84,8 @@ static void aec6210_set_mode(ide_drive_t
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	struct ide_host *host	= pci_get_drvdata(dev);
+	struct chipset_bus_clock_list_entry *bus_clock = host->host_priv;
 	u16 d_conf		= 0;
 	u8 ultra = 0, ultra_conf = 0;
 	u8 tmp0 = 0, tmp1 = 0, tmp2 = 0;
@@ -96,7 +94,7 @@ static void aec6210_set_mode(ide_drive_t
 	local_irq_save(flags);
 	/* 0x40|(2*drive->dn): Active, 0x41|(2*drive->dn): Recovery */
 	pci_read_config_word(dev, 0x40|(2*drive->dn), &d_conf);
-	tmp0 = pci_bus_clock_list(speed, BUSCLOCK(dev));
+	tmp0 = pci_bus_clock_list(speed, bus_clock);
 	d_conf = ((tmp0 & 0xf0) << 4) | (tmp0 & 0xf);
 	pci_write_config_word(dev, 0x40|(2*drive->dn), d_conf);
 
@@ -104,7 +102,7 @@ static void aec6210_set_mode(ide_drive_t
 	tmp2 = 0x00;
 	pci_read_config_byte(dev, 0x54, &ultra);
 	tmp1 = ((0x00 << (2*drive->dn)) | (ultra & ~(3 << (2*drive->dn))));
-	ultra_conf = pci_bus_clock_list_ultra(speed, BUSCLOCK(dev));
+	ultra_conf = pci_bus_clock_list_ultra(speed, bus_clock);
 	tmp2 = ((ultra_conf << (2*drive->dn)) | (tmp1 & ~(3 << (2*drive->dn))));
 	pci_write_config_byte(dev, 0x54, tmp2);
 	local_irq_restore(flags);
@@ -114,6 +112,8 @@ static void aec6260_set_mode(ide_drive_t
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	struct ide_host *host	= pci_get_drvdata(dev);
+	struct chipset_bus_clock_list_entry *bus_clock = host->host_priv;
 	u8 unit		= (drive->select.b.unit & 0x01);
 	u8 tmp1 = 0, tmp2 = 0;
 	u8 ultra = 0, drive_conf = 0, ultra_conf = 0;
@@ -122,12 +122,12 @@ static void aec6260_set_mode(ide_drive_t
 	local_irq_save(flags);
 	/* high 4-bits: Active, low 4-bits: Recovery */
 	pci_read_config_byte(dev, 0x40|drive->dn, &drive_conf);
-	drive_conf = pci_bus_clock_list(speed, BUSCLOCK(dev));
+	drive_conf = pci_bus_clock_list(speed, bus_clock);
 	pci_write_config_byte(dev, 0x40|drive->dn, drive_conf);
 
 	pci_read_config_byte(dev, (0x44|hwif->channel), &ultra);
 	tmp1 = ((0x00 << (4*unit)) | (ultra & ~(7 << (4*unit))));
-	ultra_conf = pci_bus_clock_list_ultra(speed, BUSCLOCK(dev));
+	ultra_conf = pci_bus_clock_list_ultra(speed, bus_clock);
 	tmp2 = ((ultra_conf << (4*unit)) | (tmp1 & ~(7 << (4*unit))));
 	pci_write_config_byte(dev, (0x44|hwif->channel), tmp2);
 	local_irq_restore(flags);
@@ -140,13 +140,6 @@ static void aec_set_pio_mode(ide_drive_t
 
 static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
 {
-	int bus_speed = ide_pci_clk ? ide_pci_clk : 33;
-
-	if (bus_speed <= 33)
-		pci_set_drvdata(dev, (void *) aec6xxx_33_base);
-	else
-		pci_set_drvdata(dev, (void *) aec6xxx_34_base);
-
 	/* These are necessary to get AEC6280 Macintosh cards to work */
 	if ((dev->device == PCI_DEVICE_ID_ARTOP_ATP865) ||
 	    (dev->device == PCI_DEVICE_ID_ARTOP_ATP865R)) {
@@ -254,10 +247,17 @@ static const struct ide_port_info aec62x
 
 static int __devinit aec62xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	const struct chipset_bus_clock_list_entry *bus_clock;
 	struct ide_port_info d;
 	u8 idx = id->driver_data;
+	int bus_speed = ide_pci_clk ? ide_pci_clk : 33;
 	int err;
 
+	if (bus_speed <= 33)
+		bus_clock = aec6xxx_33_base;
+	else
+		bus_clock = aec6xxx_34_base;
+
 	err = pci_enable_device(dev);
 	if (err)
 		return err;
@@ -273,7 +273,7 @@ static int __devinit aec62xx_init_one(st
 		}
 	}
 
-	err = ide_pci_init_one(dev, &d, NULL);
+	err = ide_pci_init_one(dev, &d, (void *)bus_clock);
 	if (err)
 		pci_disable_device(dev);
 

-- 

