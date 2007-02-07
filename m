From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (pata-2.6 fix queue) cmd64x: remove broken SW/MW DMA support
Date: Thu, 8 Feb 2007 00:00:32 +0300
Message-ID: <200702080000.32852.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:36789 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422733AbXBGVAj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 16:00:39 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Remove the bogus code pretending to set SW/MW DMA timings -- I wonder whether
its author really thought that he could achieve that wrtiting to BMIDE status
registers?  Stop fiddling with the DMA capable bits in the speedproc() -- they
do not enable DMA, and are properly dealt with by the dma_host_{on,off} methods;
also, get rid of the duplicate reads/writes of UDIDETCRx registers, and do some
coding style and whitespace changes while at it...

Unfortunately, fixing the SW/MW DMA support would requre a major driver rewrite
along with some more fixing, so I'm putting it off...

Warning: this has been compile-tested only.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/cmd64x.c |   80 +++++++++++++++++++++--------------------------
 1 files changed, 36 insertions(+), 44 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,6 +1,6 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.41	Feb 3, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.42	Feb 6, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
@@ -381,61 +381,55 @@ static u8 cmd64x_ratemask (ide_drive_t *
 	return mode;
 }
 
-static int cmd64x_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int cmd64x_tune_chipset (ide_drive_t *drive, u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
+	u8 unit			= drive->dn & 0x01;
+	u8 regU = 0, pciU	= hwif->channel ? UDIDETCR1 : UDIDETCR0;
 
-	u8 unit			= (drive->select.b.unit & 0x01);
-	u8 regU = 0, pciU	= (hwif->channel) ? UDIDETCR1 : UDIDETCR0;
-	u8 regD = 0, pciD	= (hwif->channel) ? BMIDESR1 : BMIDESR0;
-
-	u8 speed	= ide_rate_filter(cmd64x_ratemask(drive), xferspeed);
+	speed = ide_rate_filter(cmd64x_ratemask(drive), speed);
 
 	if (speed >= XFER_SW_DMA_0) {
-		(void) pci_read_config_byte(dev, pciD, &regD);
-		(void) pci_read_config_byte(dev, pciU, &regU);
-		regD &= ~(unit ? 0x40 : 0x20);
+		(void) pci_read_config_byte (dev, pciU, &regU);
 		regU &= ~(unit ? 0xCA : 0x35);
-		(void) pci_write_config_byte(dev, pciD, regD);
-		(void) pci_write_config_byte(dev, pciU, regU);
-		(void) pci_read_config_byte(dev, pciD, &regD);
-		(void) pci_read_config_byte(dev, pciU, &regU);
 	}
 
 	switch(speed) {
-		case XFER_UDMA_5:	regU |= (unit ? 0x0A : 0x05); break;
-		case XFER_UDMA_4:	regU |= (unit ? 0x4A : 0x15); break;
-		case XFER_UDMA_3:	regU |= (unit ? 0x8A : 0x25); break;
-		case XFER_UDMA_2:	regU |= (unit ? 0x42 : 0x11); break;
-		case XFER_UDMA_1:	regU |= (unit ? 0x82 : 0x21); break;
-		case XFER_UDMA_0:	regU |= (unit ? 0xC2 : 0x31); break;
-		case XFER_MW_DMA_2:	regD |= (unit ? 0x40 : 0x10); break;
-		case XFER_MW_DMA_1:	regD |= (unit ? 0x80 : 0x20); break;
-		case XFER_MW_DMA_0:	regD |= (unit ? 0xC0 : 0x30); break;
-		case XFER_SW_DMA_2:	regD |= (unit ? 0x40 : 0x10); break;
-		case XFER_SW_DMA_1:	regD |= (unit ? 0x80 : 0x20); break;
-		case XFER_SW_DMA_0:	regD |= (unit ? 0xC0 : 0x30); break;
-		case XFER_PIO_5:
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			(void) cmd64x_tune_pio(drive, speed - XFER_PIO_0);
-			break;
-
-		default:
-			return 1;
+	case XFER_UDMA_5:
+		regU |= unit ? 0x0A : 0x05;
+		break;
+	case XFER_UDMA_4:
+		regU |= unit ? 0x4A : 0x15;
+		break;
+	case XFER_UDMA_3:
+		regU |= unit ? 0x8A : 0x25;
+		break;
+	case XFER_UDMA_2:
+		regU |= unit ? 0x42 : 0x11;
+		break;
+	case XFER_UDMA_1:
+		regU |= unit ? 0x82 : 0x21;
+		break;
+	case XFER_UDMA_0:
+		regU |= unit ? 0xC2 : 0x31;
+		break;
+	case XFER_PIO_5:
+	case XFER_PIO_4:
+	case XFER_PIO_3:
+	case XFER_PIO_2:
+	case XFER_PIO_1:
+	case XFER_PIO_0:
+		(void) cmd64x_tune_pio(drive, speed - XFER_PIO_0);
+		break;
+	default:
+		return 1;
 	}
 
-	if (speed >= XFER_SW_DMA_0) {
+	if (speed >= XFER_SW_DMA_0)
 		(void) pci_write_config_byte(dev, pciU, regU);
-		regD |= (unit ? 0x40 : 0x20);
-		(void) pci_write_config_byte(dev, pciD, regD);
-	}
 
-	return (ide_config_drive_speed(drive, speed));
+	return ide_config_drive_speed(drive, speed);
 }
 
 static int config_chipset_for_dma (ide_drive_t *drive)
@@ -684,8 +678,6 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->atapi_dma = 1;
 
 	hwif->ultra_mask = 0x3f;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 
 	if (dev->device == PCI_DEVICE_ID_CMD_643)
 		hwif->ultra_mask = 0x80;

