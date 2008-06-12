From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 05/18] ide-cd: ide_do_rw_cdrom: add the catch-all bad request case to the if-else block
Date: Thu, 12 Jun 2008 08:40:57 +0200
Message-ID: <1213252870-20474-6-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:8640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbYFLGlH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:41:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2381813fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:41:05 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index e63eea2..21c4510 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1249,11 +1249,11 @@ static ide_startstop_t ide_do_rw_cdrom(ide_drive_t *drive, struct request *rq,
 		/* right now this can only be a reset... */
 		cdrom_end_request(drive, 1);
 		return ide_stopped;
+	} else {
+		blk_dump_rq_flags(rq, "ide-cd bad flags");
+		cdrom_end_request(drive, 0);
+		return ide_stopped;
 	}
-
-	blk_dump_rq_flags(rq, "ide-cd bad flags");
-	cdrom_end_request(drive, 0);
-	return ide_stopped;
 }
 
 
-- 
1.5.5.1

