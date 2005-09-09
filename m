From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: [PATCH 2.6.13] ide: fix null request pointer for taskfile ioctl
Date: Fri, 9 Sep 2005 14:41:49 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BDC7@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:23893 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1030377AbVIIVmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2005 17:42:06 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE Mailing List <linux-ide@vger.kernel.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>

When doing ioctl HDIO_DRIVE_TASKFILE, the ide_task_t's
request pointer is never set, but flagged_taskfile and
do_rw_taskfile pass it as a parameter to the prehandler.
The kernel will oops taskfile pio-out commands because of this
(taskfile pio-in doesn't use a prehandler).  This fix sets the
request pointer at the time the request is created to stop this
oops.

Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>

--- linux-2.6.13.orig/drivers/ide/ide-taskfile.c	2005-08-28
16:41:01.000000000 -0700
+++ linux-2.6.13/drivers/ide/ide-taskfile.c	2005-09-09
13:47:41.000000000 -0700
@@ -500,6 +500,7 @@ static int ide_diag_taskfile(ide_drive_t
 	}
 
 	rq.special = args;
+	args->rq = &rq;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
