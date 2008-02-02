From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/5] ide: remove redundant BUG_ON() from [atapi_]reset_pollfunc()
Date: Sat, 2 Feb 2008 01:46:30 +0100
Message-ID: <200802020146.30385.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:35263 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762446AbYBBAgy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 19:36:54 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1309468fkz.5
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 16:36:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Same BUG_ON() is present inside ide_set_handler().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -860,7 +860,6 @@ static ide_startstop_t atapi_reset_pollf
 		printk("%s: ATAPI reset complete\n", drive->name);
 	} else {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
-			BUG_ON(HWGROUP(drive)->handler != NULL);
 			ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);
 			/* continue polling */
 			return ide_started;
@@ -900,7 +899,6 @@ static ide_startstop_t reset_pollfunc (i
 
 	if (!OK_STAT(tmp = hwif->INB(IDE_STATUS_REG), 0, BUSY_STAT)) {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
-			BUG_ON(HWGROUP(drive)->handler != NULL);
 			ide_set_handler(drive, &reset_pollfunc, HZ/20, NULL);
 			/* continue polling */
 			return ide_started;
