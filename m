From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 62/64] tx493xide: use ->pio_mode value to determine pair device speed
Date: Mon, 18 Jan 2010 18:22:23 +0100
Message-ID: <20100118172223.14623.60339.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:51627 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab0ARRXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:23:36 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] tx493xide: use ->pio_mode value to determine pair device speed

Use the current PIO mode value instead of the physical maximum one
of the pair device on the port to determine PIO commmand timings used
for both devices on the port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/tx4938ide.c |    2 +-
 drivers/ide/tx4939ide.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/tx4938ide.c
===================================================================
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -64,7 +64,7 @@ static void tx4938ide_set_pio_mode(ide_h
 
 	pair = ide_get_pair_dev(drive);
 	if (pair)
-		safe = min(safe, ide_get_best_pio_mode(pair, 255, 5));
+		safe = min(safe, pair->pio_mode - XFER_PIO_0);
 	tx4938ide_tune_ebusc(pdata->ebus_ch, pdata->gbus_clock, safe);
 }
 
Index: b/drivers/ide/tx4939ide.c
===================================================================
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -114,7 +114,7 @@ static void tx4939ide_set_pio_mode(ide_h
 
 	pair = ide_get_pair_dev(drive);
 	if (pair)
-		safe = min(safe, ide_get_best_pio_mode(pair, 255, 4));
+		safe = min(safe, pair->pio_mode - XFER_PIO_0);
 	/*
 	 * Update Command Transfer Mode for master/slave and Data
 	 * Transfer Mode for this drive.
