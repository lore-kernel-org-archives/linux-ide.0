From: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: simple use wcache from drive
Date: Sat, 29 Jan 2005 17:54:47 -0600
Message-ID: <200501292354.j0TNslrq006083@falcon10.austin.ibm.com>
References: <58cb370e05012814592266d81f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.132]:43228 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261610AbVA2Xyu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Jan 2005 18:54:50 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0TNsnaQ517062
	for <linux-ide@vger.kernel.org>; Sat, 29 Jan 2005 18:54:49 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0TNsnaE123912
	for <linux-ide@vger.kernel.org>; Sat, 29 Jan 2005 16:54:49 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0TNsm2w000419
	for <linux-ide@vger.kernel.org>; Sat, 29 Jan 2005 16:54:48 -0700
In-reply-to: <58cb370e05012814592266d81f@mail.gmail.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


On Fri, 28 Jan 2005 23:59:18 +0100, Bartlomiej Zolnierkiewicz wrote:
>On Fri, 28 Jan 2005 23:56:41 +0100, Bartlomiej Zolnierkiewicz
><bzolnier@gmail.com> wrote:
>> On Fri, 28 Jan 2005 16:54:49 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
>> >
>> > On Fri, 28 Jan 2005 23:32:53 +0100, Bartlomiej Zolnierkiewicz wrote:
>> > >> The datacenters/server folks that would be using these drives would
>> > >> expect them to remain as set.  I have to check, but unless something
>> > >> has changed very recently in the kernel, setting with hdparm does not
>> > >> "stick" in the sense that the command succeeds to the disk, but no change
>> > >> is made to the barrier.
>> > >
>> > >It is not a problem for IDE driver (flushes become no-ops)
>> > >and this way you can later enable wcache and still use barries.
>> >
>> > Well that certainly simplfies things.
>> >
>> > How about this?
>> 
>> No go until 'drive->wcache' bug is fixed.
>
>And until user is informed about status of wcache (printk).
>

[PATCH] use IDE drive cache enabled setting by default.

  Enable the default setting of the driver use of write cache to be
  defined by the drive itself.

Signed-off-by: Doug Maxey <dwm@austin.ibm.com>

===== drivers/ide/ide-disk.c 1.115 vs 1.116 =====
--- 1.115/drivers/ide/ide-disk.c	2005-01-04 11:39:25 -06:00
+++ 1.116/drivers/ide/ide-disk.c	2005-01-29 15:13:24 -06:00
@@ -784,6 +784,7 @@ static int write_cache(ide_drive_t *driv
 	if (err)
 		return err;
 
+	printk(KERN_DEBUG "%s: %sabling write cache\n", drive->name, arg ? "en" : "dis");
 	drive->wcache = arg;
 	return 0;
 }
@@ -1080,10 +1081,10 @@ static void idedisk_setup (ide_drive_t *
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
 
 	/* write cache enabled? */
-	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
+	if ((id->csfo & 1) && (id->cfs_enable_1 & (1 << 5)))
 		drive->wcache = 1;
 
-	write_cache(drive, 1);
+	write_cache(drive, drive->wcache);
 
 	/*
 	 * We must avoid issuing commands a drive does not understand


