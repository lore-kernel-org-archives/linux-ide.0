From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 61/64] siimage: use ->pio_mode value to determine pair device speed
Date: Mon, 18 Jan 2010 18:22:16 +0100
Message-ID: <20100118172216.14623.20590.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755510Ab0ARRXi@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] siimage: use ->pio_mode value to determine pair device speed

Use the current PIO mode value instead of the physical maximum one
of the pair device on the port to determine PIO commmand timings used
for both devices on the port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/siimage.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/siimage.c
===================================================================
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -258,7 +258,7 @@ static void sil_set_pio_mode(ide_hwif_t
 
 	/* trim *taskfile* PIO to the slowest of the master/slave */
 	if (pair) {
-		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4);
+		u8 pair_pio = pair->pio_mode - XFER_PIO_0;
 
 		if (pair_pio < tf_pio)
 			tf_pio = pair_pio;
