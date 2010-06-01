From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] tx493xide: use min_t() macro instead of min()
Date: Wed,  2 Jun 2010 00:28:38 +0900
Message-ID: <1275406118-14581-1-git-send-email-anemo@mba.ocn.ne.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from defer-dn02.ocn.ad.jp ([125.170.100.157]:48536 "EHLO
	defer-dn02.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab0FAP6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jun 2010 11:58:24 -0400
Received: from mv-drv-hcb003.ocn.ad.jp (mv-drv-hcb003.ocn.ad.jp [118.23.109.133])
	by defer-dn02.ocn.ad.jp (Postfix) with ESMTP id 2FE20B8FE9
	for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2010 00:30:13 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "David S. Miller" <davem@davemloft.net>

This fixes a warning ("comparison of distinct pointer types lacks a
cast") introduced by the commit
040f6b4f14adb2ca5babb84e9fb2ebc6661e0be2 ("tx493xide: use ->pio_mode
value to determine pair device speed").

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4938ide.c |    2 +-
 drivers/ide/tx4939ide.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 1d80f1f..7002765 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -64,7 +64,7 @@ static void tx4938ide_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 
 	pair = ide_get_pair_dev(drive);
 	if (pair)
-		safe = min(safe, pair->pio_mode - XFER_PIO_0);
+		safe = min_t(u8, safe, pair->pio_mode - XFER_PIO_0);
 	tx4938ide_tune_ebusc(pdata->ebus_ch, pdata->gbus_clock, safe);
 }
 
diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index 3c73677..bed3e39 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -114,7 +114,7 @@ static void tx4939ide_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 
 	pair = ide_get_pair_dev(drive);
 	if (pair)
-		safe = min(safe, pair->pio_mode - XFER_PIO_0);
+		safe = min_t(u8, safe, pair->pio_mode - XFER_PIO_0);
 	/*
 	 * Update Command Transfer Mode for master/slave and Data
 	 * Transfer Mode for this drive.
-- 
1.5.6.5

