From: Doug Maxey <dwm@maxeymade.com>
Subject: Re: [RFC/PATCH 0/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 15:06:22 -0600
Message-ID: <200501282106.j0SL6M0Z026655@falcon30.maxeymade.com>
References: <58cb370e05012811112c3c0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:30923 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S262800AbVA1VGj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 16:06:39 -0500
In-reply-to: <58cb370e05012811112c3c0b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Doug Maxey <dwm@austin.ibm.com>, Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


On Fri, 28 Jan 2005 20:11:37 +0100, Bartlomiej Zolnierkiewicz wrote:
>On Fri, 28 Jan 2005 12:16:01 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
>
>We have too many config options already.
>
>Behavior should be simple:
>* no cache flushes - wcache off by default
>* cache flushes - wcache on by default
>* inform user about the wcache status
>* allow changing of wcache by user

My interpretation of what you are saying here is the selection of
"cache flush" drives the setting of wcache.  Are you saying that
"barrier=off" on the boot line the currently (only and will remain)
supported method controlling flushes?

AFAICS, "barrier=off" just tells the FS (only ext2 and reiser) to not
flush writes.  I may be misunderstanding how that controls the
behavior of the drive at the ll_blk layer.  Is that what you want to
see a patch to, pick this out of the FS?

>>
>> 1) move the cache_write code to ide-io, where it will be callable from
>>    kernels built without ide-disk.
>
>I've already pointed this out - this is not needed, you should add
>check similar to this for 'xfer_set'.  Another reason not to do this
>is that write_cache() uses REQ_DRIVE_TASKFILE internally.

Is taskfile going away?

>
>> 2) allow the drive to define the default setting of the cache when
>>    BLK_DEV_HDWC is set.
>>
>> 3) correctly handle the change of write cache setting from hdparm.
>>    This means that the call also changes the blk_queue_ordered()
>>    visible variable.
>
>I've asked you many times to separate this two changes.
>No luck so far.
>

Split patch does not count? :)


