From: Doug Maxey <dwm@austin.ibm.com>
Subject: [RFC/PATCH 4/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 12:16:43 -0600
Message-ID: <200501281816.j0SIGhBV021106@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.133]:26010 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262727AbVA1SQq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 13:16:46 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0SIGjZ7625606
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 13:16:45 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0SIGjqw322782
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:16:45 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0SIGiUO012782
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:16:45 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


    - use new config variable BLK_DEV_HDWC in idedisk_setup code.

 include/linux/ide.h    |    5 +++++
 drivers/ide/ide-disk.c |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/include/linux/ide.h lk-2.6.11-rc2-bk5.b/include/linux/ide.h
--- lk-2.6.11-rc2-bk5.a/include/linux/ide.h	2005-01-28 09:47:00.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/include/linux/ide.h	2005-01-28 11:31:50.671700624 -0600
@@ -1548,5 +1548,10 @@ extern struct bus_type ide_bus_type;
 
 /* common write_cache setting. */
 int ide_write_cache(ide_drive_t *, int);
+#ifdef CONFIG_BLK_DEV_HDWC
+#define BLK_DEV_HDWC 1
+#else
+#define BLK_DEV_HDWC 0
+#endif /* CONFIG_BLK_DEV_HDWC */
 
 #endif /* _IDE_H */
diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/drivers/ide/ide-disk.c lk-2.6.11-rc2-bk5.b/drivers/ide/ide-disk.c
--- lk-2.6.11-rc2-bk5.a/drivers/ide/ide-disk.c	2005-01-26 13:19:34.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/drivers/ide/ide-disk.c	2005-01-28 11:27:46.417832856 -0600
@@ -1083,7 +1083,7 @@ static void idedisk_setup (ide_drive_t *
 	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
 		drive->wcache = 1;
 
-	write_cache(drive, 1);
+	write_cache(drive, (BLK_DEV_HDWC ? drive->wcache : 1));
 
 	/*
 	 * We must avoid issuing commands a drive does not understand
@@ -1093,7 +1093,7 @@ static void idedisk_setup (ide_drive_t *
 	 * LBA48 is not available so we don't need to recheck that.
 	 */
 	barrier = 0;
-	if (ide_id_has_flush_cache(id))
+	if (ide_id_has_flush_cache(id) && drive->wcache)
 		barrier = 1;
 	if (drive->addressing == 1) {
 		/* Can't issue the correct flush ? */


