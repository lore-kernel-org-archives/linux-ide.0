From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] IDE update for 2.6.3 (6/9)
Date: Thu, 19 Feb 2004 15:58:35 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402191558.35086.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267301AbUBSOzk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2004 09:55:40 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


[IDE] remove bogus comment and code from ide_unregister_driver()

When ide_remove_proc_entries() is called, driver specific /proc/ide/hdx/
entries have been already removed by ->cleanup()->ide_unregister_subdriver().

 linux-2.6.3-root/drivers/ide/ide.c |    6 ------
 1 files changed, 6 deletions(-)

diff -puN drivers/ide/ide.c~ide_bogus_oops drivers/ide/ide.c
--- linux-2.6.3/drivers/ide/ide.c~ide_bogus_oops	2004-02-19 02:10:43.183892192 +0100
+++ linux-2.6.3-root/drivers/ide/ide.c	2004-02-19 02:10:43.187891584 +0100
@@ -2364,12 +2364,6 @@ void ide_unregister_driver(ide_driver_t 
 			printk(KERN_ERR "%s: cleanup_module() called while still busy\n", drive->name);
 			BUG();
 		}
-		/* We must remove proc entries defined in this module.
-		   Otherwise we oops while accessing these entries */
-#ifdef CONFIG_PROC_FS
-		if (drive->proc)
-			ide_remove_proc_entries(drive->proc, driver->proc);
-#endif
 		ata_attach(drive);
 	}
 }

_

