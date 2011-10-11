From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cy82c693: fix PCI device selection
Date: Tue, 11 Oct 2011 19:37:32 +0200
Message-ID: <201110111937.32501.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cy82c693: fix PCI device selection

Wrong PCI device may be selected by cy82c693_set_pio_mode() if modular
IDE host drivers are used and there are additional IDE PCI devices
installed in the system.  Fix it.

While at it remove redundant pci_get_slot() call as cy82c693_init_one()
already takes care of keeping the reference on the second port's PCI
device.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/cy82c693.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

Index: b/drivers/ide/cy82c693.c
===================================================================
--- a/drivers/ide/cy82c693.c
+++ b/drivers/ide/cy82c693.c
@@ -82,24 +82,13 @@ static void cy82c693_set_dma_mode(ide_hw
 
 static void cy82c693_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
+	struct pci_dev *dev = to_pci_dev(hwif->host->dev[drive->dn / 2]);
 	int bus_speed = ide_pci_clk ? ide_pci_clk : 33;
 	const unsigned long T = 1000000 / bus_speed;
 	unsigned int addrCtrl;
 	struct ide_timing t;
 	u8 time_16, time_8;
 
-	/* select primary or secondary channel */
-	if (hwif->index > 0) {  /* drive is on the secondary channel */
-		dev = pci_get_slot(dev->bus, dev->devfn+1);
-		if (!dev) {
-			printk(KERN_ERR "%s: tune_drive: "
-				"Cannot find secondary interface!\n",
-				drive->name);
-			return;
-		}
-	}
-
 	ide_timing_compute(drive, drive->pio_mode, &t, T, 1);
 
 	time_16 = clamp_val(t.recover - 1, 0, 15) |
@@ -141,8 +130,6 @@ static void cy82c693_set_pio_mode(ide_hw
 		pci_write_config_byte(dev, CY82_IDE_SLAVE_IOW, time_16);
 		pci_write_config_byte(dev, CY82_IDE_SLAVE_8BIT, time_8);
 	}
-	if (hwif->index > 0)
-		pci_dev_put(dev);
 }
 
 static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
