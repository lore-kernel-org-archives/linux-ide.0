From: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: [RFC/PATCH 0/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 15:43:52 -0600
Message-ID: <200501282143.j0SLhqlr022481@falcon10.austin.ibm.com>
References: <58cb370e05012813357d42da46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.133]:31873 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262776AbVA1VoM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 16:44:12 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0SLhtZ7140252
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 16:43:57 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0SLht58460146
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 14:43:55 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0SLhs4m004324
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 14:43:55 -0700
In-reply-to: <58cb370e05012813357d42da46@mail.gmail.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


On Fri, 28 Jan 2005 22:35:17 +0100, Bartlomiej Zolnierkiewicz wrote:
>On Fri, 28 Jan 2005 15:06:22 -0600, Doug Maxey <dwm@maxeymade.com> wrote:
>> 
>> On Fri, 28 Jan 2005 20:11:37 +0100, Bartlomiej Zolnierkiewicz wrote:
>> >On Fri, 28 Jan 2005 12:16:01 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
>> >
>> >We have too many config options already.
>> >
>> >Behavior should be simple:
>> >* no cache flushes - wcache off by default
>> >* cache flushes - wcache on by default
>> >* inform user about the wcache status
>> >* allow changing of wcache by user
>> 
>> My interpretation of what you are saying here is the selection of
>> "cache flush" drives the setting of wcache.  Are you saying that
>> "barrier=off" on the boot line the currently (only and will remain)
>> supported method controlling flushes?
>
>No, I am saying that cache flush is a property of disk not fs.
>On the contrary barrier is a property of filesystem.

Ok.  We are talking apples and oranges here.  The disk DOES have FLUSH CACHE, 
which is the main reason these drives work in the later kernels.  You can 
switch wcache back and forth, provided that the correct flushing is done.

Write cache, on the otherhand, which is disabled on the drive by default,
is not honored.

>
>> AFAICS, "barrier=off" just tells the FS (only ext2 and reiser) to not
>> flush writes.  I may be misunderstanding how that controls the
>> behavior of the drive at the ll_blk layer.  Is that what you want to
>> see a patch to, pick this out of the FS?
>
>No, why?
>
>> >>
>> >> 1) move the cache_write code to ide-io, where it will be callable from
>> >>    kernels built without ide-disk.
>> >
>> >I've already pointed this out - this is not needed, you should add
>> >check similar to this for 'xfer_set'.  Another reason not to do this
>> >is that write_cache() uses REQ_DRIVE_TASKFILE internally.
>> 
>> Is taskfile going away?
>
>Quite the opposite but if you want to use taskfile, map whole
>ide_cmd_ioctl() to it not CACHE_FLUSH_{EXT} command only
>and don't intermix bugfixes with potentially risky changes.
>

Well, if you turn off write cache, then you must not, at least on these 
drives, use FLUSH.  All write commands are errored.



