From: Doug Maxey <dwm@austin.ibm.com>
Subject: simple use wcache from drive (was)Re: [RFC/PATCH 0/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 16:54:49 -0600
Message-ID: <200501282254.j0SMsnBu023405@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.131]:32954 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262808AbVA1Wyy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 17:54:54 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0SMsqCO493782
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 17:54:52 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0SMsq58439268
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 15:54:52 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0SMspti032424
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 15:54:51 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


On Fri, 28 Jan 2005 23:32:53 +0100, Bartlomiej Zolnierkiewicz wrote:
>> The datacenters/server folks that would be using these drives would
>> expect them to remain as set.  I have to check, but unless something
>> has changed very recently in the kernel, setting with hdparm does not
>> "stick" in the sense that the command succeeds to the disk, but no change
>> is made to the barrier.
>
>It is not a problem for IDE driver (flushes become no-ops)
>and this way you can later enable wcache and still use barries.

Well that certainly simplfies things.

How about this?
===== drivers/ide/ide-disk.c 1.115 vs edited =====
--- 1.115/drivers/ide/ide-disk.c	2005-01-04 11:39:25 -06:00
+++ edited/drivers/ide/ide-disk.c	2005-01-28 16:48:24 -06:00
@@ -1083,7 +1083,7 @@ static void idedisk_setup (ide_drive_t *
 	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
 		drive->wcache = 1;
 
-	write_cache(drive, 1);
+	write_cache(drive, drive->wcache);
 
 	/*
 	 * We must avoid issuing commands a drive does not understand


