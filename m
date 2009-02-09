From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] ide: make ide_special_rq() BUG() on unknown requests
Date: Mon, 09 Feb 2009 21:00:49 +0100
Message-ID: <20090209200049.7985.36481.sendpatchset@localhost.localdomain>
References: <20090209200042.7985.94247.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51118 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068AbZBIT7j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 14:59:39 -0500
In-Reply-To: <20090209200042.7985.94247.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: make ide_special_rq() BUG() on unknown requests

If unknown request reaches this function something is _seriously_ wrong.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -353,9 +353,7 @@ static ide_startstop_t ide_special_rq(id
 	case REQ_DRIVE_RESET:
 		return ide_do_reset(drive);
 	default:
-		blk_dump_rq_flags(rq, "ide_special_rq - bad request");
-		ide_end_request(drive, 0, 0);
-		return ide_stopped;
+		BUG();
 	}
 }
 
