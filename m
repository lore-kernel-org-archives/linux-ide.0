From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] make Linux IDE more CELF-conforming ;)
Date: Thu, 20 May 2004 01:24:17 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405200124.17585.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59065 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264682AbUESXXt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 19:23:49 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hch@lst.de


I want to push it to Linus soon...

Noticed by Christoph Hellwig <hch@lst.de>.

Fix ide_delay_50ms() in ide.c to always sleep.

Probably somebody got the logic wrong while adding
#ifndef CONFIG_BLK_DEV_IDECS back in 2.4.0-test2.

 linux-2.6.6-bk3-bzolnier/drivers/ide/ide.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN drivers/ide/ide.c~ide_delay_50ms drivers/ide/ide.c
--- linux-2.6.6-bk3/drivers/ide/ide.c~ide_delay_50ms	2004-05-20 00:42:24.017922320 +0200
+++ linux-2.6.6-bk3-bzolnier/drivers/ide/ide.c	2004-05-20 00:42:38.945652960 +0200
@@ -1396,12 +1396,8 @@ void ide_add_generic_settings (ide_drive
  */
 void ide_delay_50ms (void)
 {
-#ifndef CONFIG_BLK_DEV_IDECS
-	mdelay(50);
-#else
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(1+HZ/20);
-#endif /* CONFIG_BLK_DEV_IDECS */
 }
 
 EXPORT_SYMBOL(ide_delay_50ms);

_

