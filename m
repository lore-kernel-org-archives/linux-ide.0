From: Doug Maxey <dwm@austin.ibm.com>
Subject: [RFC/PATCH 2/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 12:16:17 -0600
Message-ID: <200501281816.j0SIGHnp021085@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.133]:46745 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262463AbVA1SQW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 13:16:22 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0SIGKZ7629264
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 13:16:20 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0SIGJqw318320
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:16:19 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0SIGJl2011601
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:16:19 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


    - add hook in ide-taskfile:ide_cmd_ioctl() to call the new
      function ide_write_cache().

 drivers/ide/ide-taskfile.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/drivers/ide/ide-taskfile.c lk-2.6.11-rc2-bk5.b/drivers/ide/ide-taskfile.c
--- lk-2.6.11-rc2-bk5.a/drivers/ide/ide-taskfile.c	2005-01-26 13:19:34.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/drivers/ide/ide-taskfile.c	2005-01-28 11:19:55.907361320 -0600
@@ -698,6 +698,16 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 	if (copy_from_user(args, (void __user *)arg, 4))
 		return -EFAULT;
 
+	if ((args[0] == WIN_SETFEATURES) &&
+	    ((args[2] == SETFEATURES_EN_WCACHE) ||
+	     (args[2] == SETFEATURES_DIS_WCACHE))) {
+		/*
+		 * Call the handler to support settings in the block layer.
+		 */
+		err = ide_write_cache (drive, (args[2] == SETFEATURES_EN_WCACHE));
+		return err;
+	}
+
 	memset(&tfargs, 0, sizeof(ide_task_t));
 	tfargs.tfRegister[IDE_FEATURE_OFFSET] = args[2];
 	tfargs.tfRegister[IDE_NSECTOR_OFFSET] = args[3];


