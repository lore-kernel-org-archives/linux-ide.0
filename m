From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_ali: cleanup ali_set_piomode()
Date: Thu, 13 Oct 2011 13:09:25 +0200
Message-ID: <201110131309.26032.bzolnier@gmail.com>
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
Subject: [PATCH] pata_ali: cleanup ali_set_piomode()

Merge ali_fifo_control() calls.

This changes behavior but there shouldn't be any problems with it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
earlier references:
https://lkml.org/lkml/2010/1/18/258

 drivers/ata/pata_ali.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_ali.c
===================================================================
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -222,12 +222,9 @@ static void ali_set_piomode(struct ata_p
 	}
 
 	/* PIO FIFO is only permitted on ATA disk */
-	if (adev->class != ATA_DEV_ATA)
-		ali_fifo_control(ap, adev, 0x00);
-	ali_program_modes(ap, adev, &t, 0);
-	if (adev->class == ATA_DEV_ATA)
-		ali_fifo_control(ap, adev, 0x05);
+	ali_fifo_control(ap, adev, (adev->class == ATA_DEV_ATA) ? 0x05 : 0x00);
 
+	ali_program_modes(ap, adev, &t, 0);
 }
 
 /**
