From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 45/63] ide-cd: remove BUG_ON() from cdrom_newpc_intr()
Date: Thu, 20 Dec 2007 02:27:07 +0100
Message-ID: <200712200227.07552.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:11604 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758901AbXLTBet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389244ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


There is no need for it anylonger and ide_set_handler() complains
if ->handler is not NULL anyway.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1368,8 +1368,6 @@ static ide_startstop_t cdrom_newpc_intr(
 	if (len > 0)
 		ide_cd_pad_transfer(drive, xferfunc, len);
 
-	BUG_ON(HWGROUP(drive)->handler != NULL);
-
 	ide_set_handler(drive, cdrom_newpc_intr, rq->timeout, NULL);
 	return ide_started;
 
