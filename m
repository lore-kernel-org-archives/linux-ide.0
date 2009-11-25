From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 63/86] pata_radisys: fix UDMA handling
Date: Wed, 25 Nov 2009 18:09:55 +0100
Message-ID: <20091125170955.5446.92093.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759305AbZKYRKp@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_radisys: fix UDMA handling

Set correct bits to switch between UDMA2 and UDMA4.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_radisys.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_radisys.c
===================================================================
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -139,9 +139,9 @@ static void radisys_set_dmamode (struct 
 		pci_read_config_byte(dev, 0x4A, &udma_mode);
 
 		if (adev->xfer_mode == XFER_UDMA_2)
-			udma_mode &= ~ (1 << adev->devno);
+			udma_mode &= ~(2 << (adev->devno * 4));
 		else /* UDMA 4 */
-			udma_mode |= (1 << adev->devno);
+			udma_mode |= (2 << (adev->devno * 4));
 
 		pci_write_config_byte(dev, 0x4A, udma_mode);
 
