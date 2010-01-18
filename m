From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 55/64] amd74xx: use ->pio_mode value to determine pair device speed
Date: Mon, 18 Jan 2010 18:21:33 +0100
Message-ID: <20100118172133.14623.99453.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:55501 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab0ARRWo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:22:44 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] amd74xx: use ->pio_mode value to determine pair device speed

Use the current PIO mode value instead of the current transfer speed
of the pair device on the port to determine PIO commmand timings used
for both devices on the port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/amd74xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/amd74xx.c
===================================================================
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -94,7 +94,7 @@ static void amd_set_drive(ide_hwif_t *hw
 	ide_timing_compute(drive, speed, &t, T, UT);
 
 	if (peer) {
-		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
+		ide_timing_compute(peer, peer->pio_mode, &p, T, UT);
 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
 
