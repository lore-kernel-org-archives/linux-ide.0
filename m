From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 28/64] alim15x3: remove superfluous locking from ali_set_pio_mode()
Date: Mon, 18 Jan 2010 18:17:59 +0100
Message-ID: <20100118171759.14623.53556.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754866Ab0ARRTz@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] alim15x3: remove superfluous locking from ali_set_pio_mode()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/alim15x3.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/ide/alim15x3.c
===================================================================
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -73,7 +73,6 @@ static void ali_set_pio_mode(ide_drive_t
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	unsigned long flags;
 	int bus_speed = ide_pci_clk ? ide_pci_clk : 33;
 	unsigned long T =  1000000 / bus_speed; /* PCI clock based */
 	int port = hwif->channel ? 0x5c : 0x58;
@@ -86,8 +85,6 @@ static void ali_set_pio_mode(ide_drive_t
 	t.active = clamp_val(t.active, 1, 8) & 7;
 	t.recover = clamp_val(t.recover, 1, 16) & 15;
 
-	local_irq_save(flags);
-
 	/* 
 	 * PIO mode => ATA FIFO on, ATAPI FIFO off
 	 */
@@ -96,8 +93,6 @@ static void ali_set_pio_mode(ide_drive_t
 	pci_write_config_byte(dev, port, t.setup);
 	pci_write_config_byte(dev, port + unit + 2,
 			      (t.active << 4) | t.recover);
-
-	local_irq_restore(flags);
 }
 
 /**
