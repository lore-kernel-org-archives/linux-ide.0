From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: ata_timing_compute() fixup
Date: Thu, 13 Oct 2011 15:17:32 +0200
Message-ID: <201110131517.33197.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: ata_timing_compute() fixup

XFER_SW_DMA_0 mode should be excluded from the extended cycle timing
computations.

Noticed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/libata-core.c
===================================================================
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3232,7 +3232,7 @@ int ata_timing_compute(struct ata_device
 	if (id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE drive */
 		memset(&p, 0, sizeof(p));
 
-		if (speed >= XFER_PIO_0 && speed <= XFER_SW_DMA_0) {
+		if (speed >= XFER_PIO_0 && speed < XFER_SW_DMA_0) {
 			if (speed <= XFER_PIO_2)
 				p.cycle = p.cyc8b = id[ATA_ID_EIDE_PIO];
 			else if ((speed <= XFER_PIO_4) ||
