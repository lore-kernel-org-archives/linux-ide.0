From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/64] pata_cmd64x: cmd648_bmdma_stop() fix
Date: Mon, 18 Jan 2010 18:15:11 +0100
Message-ID: <20100118171511.14623.43642.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754578Ab0ARRQj@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cmd64x: cmd648_bmdma_stop() fix

Clear the primary channel pending interrupt bit
instead of the reserved one.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cmd64x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_cmd64x.c
===================================================================
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -40,7 +40,7 @@
 
 enum {
 	CFR 		= 0x50,
-		CFR_INTR_CH0  = 0x02,
+		CFR_INTR_CH0  = 0x04,
 	CNTRL 		= 0x51,
 		CNTRL_DIS_RA0 = 0x40,
 		CNTRL_DIS_RA1 = 0x80,
