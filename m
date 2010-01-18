From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 32/64] cmd64x: remove superfluous checks from cmd64x_set_dma_mode()
Date: Mon, 18 Jan 2010 18:18:38 +0100
Message-ID: <20100118171838.14623.62499.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755292Ab0ARR2y@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cmd64x: remove superfluous checks from cmd64x_set_dma_mode()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cmd64x.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: b/drivers/ide/cmd64x.c
===================================================================
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -172,10 +172,8 @@ static void cmd64x_set_dma_mode(ide_driv
 	u8 unit			= drive->dn & 0x01;
 	u8 regU = 0, pciU	= hwif->channel ? UDIDETCR1 : UDIDETCR0;
 
-	if (speed >= XFER_SW_DMA_0) {
-		(void) pci_read_config_byte(dev, pciU, &regU);
-		regU &= ~(unit ? 0xCA : 0x35);
-	}
+	pci_read_config_byte(dev, pciU, &regU);
+	regU &= ~(unit ? 0xCA : 0x35);
 
 	switch(speed) {
 	case XFER_UDMA_5:
@@ -207,8 +205,7 @@ static void cmd64x_set_dma_mode(ide_driv
 		break;
 	}
 
-	if (speed >= XFER_SW_DMA_0)
-		(void) pci_write_config_byte(dev, pciU, regU);
+	pci_write_config_byte(dev, pciU, regU);
 }
 
 static void cmd648_clear_irq(ide_drive_t *drive)
