From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 47/86] pata_legacy: fix access to control register for QDI6580
Date: Wed, 25 Nov 2009 18:07:55 +0100
Message-ID: <20091125170755.5446.40963.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933038AbZKYRIj@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_legacy: fix access to control register for QDI6580

We need to mask out the port offset from the port number
cached in ld_qdi->timing.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_legacy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_legacy.c
===================================================================
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -672,7 +672,7 @@ static void qdi6580dp_set_piomode(struct
 	outb(timing, ld_qdi->timing + 2 * ap->port_no);
 	/* Clear the FIFO */
 	if (adev->class != ATA_DEV_ATA)
-		outb(0x5F, ld_qdi->timing + 3);
+		outb(0x5F, (ld_qdi->timing & 0xFFF0) + 3);
 }
 
 /**
@@ -707,7 +707,7 @@ static void qdi6580_set_piomode(struct a
 	outb(timing, ld_qdi->timing + 2 * adev->devno);
 	/* Clear the FIFO */
 	if (adev->class != ATA_DEV_ATA)
-		outb(0x5F, ld_qdi->timing + 3);
+		outb(0x5F, (ld_qdi->timing & 0xFFF0) + 3);
 }
 
 /**
