From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC/PATCH 0/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 20:11:37 +0100
Message-ID: <58cb370e05012811112c3c0b@mail.gmail.com>
References: <200501281816.j0SIG1mP021074@falcon10.austin.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:35501 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262698AbVA1TLn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2005 14:11:43 -0500
Received: by wproxy.gmail.com with SMTP id 67so298790wri
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:11:40 -0800 (PST)
In-Reply-To: <200501281816.j0SIG1mP021074@falcon10.austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>

On Fri, 28 Jan 2005 12:16:01 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> Howdy!

Hi,
 
> Some IDE drives destined for use in server class or datacenter
> machines will come with "write cache" disabled.  With the current
> code, the setting of the drive is effectively ignored, and the cache
> is always enabled if the drive has cache.
> 
> It is hard to define or enable certain behaviors that will keep
> everyone happy, but hey, this is my (and a certain vendor's) take on
> this.  If you are happy with the status quo, no behavior change.  If
> the user desires to have write cache disabled by default (per the
> drive), she can enable a more server friendly behavior.
>
> These patches are against BK5.  No attempt has been made to integrate
> with Jens' latest "scsi/sata write barrier" patches, but will look
> into that when the dust has settled for both.
> 
> With BLK_DEV_HDWC at the default of 0, the current driver behavior is
> maintained, i.e., the drive will always use the write cache per the
> current code.  With the setting enabled, the driver will use the
> default value of the drive write cache.

We have too many config options already.

Behavior should be simple:
* no cache flushes - wcache off by default
* cache flushes - wcache on by default
* inform user about the wcache status 
* allow changing of wcache by user

> One area this does not touch on is locking.  There does appear to be
> some issues in changing the setting on the fly, but this is ignored in
> the existing code.  Bart has been making some effort.
>
> This set of patches changes the way the write cache setting of IDE
> drives is handled to:
> 
> 1) move the cache_write code to ide-io, where it will be callable from
>    kernels built without ide-disk.

I've already pointed this out - this is not needed, you should add
check similar to this for 'xfer_set'.  Another reason not to do this
is that write_cache() uses REQ_DRIVE_TASKFILE internally.

> 2) allow the drive to define the default setting of the cache when
>    BLK_DEV_HDWC is set.
> 
> 3) correctly handle the change of write cache setting from hdparm.
>    This means that the call also changes the blk_queue_ordered()
>    visible variable.

I've asked you many times to separate this two changes.
No luck so far.

> 1/7 - add ide_write_cache() to ide-io.c.  This is in preparation for
>       the following patches that remove the current write_cache() from
>       ide-disk.c.  Moving to ide-io is allow ide_write_cache() to
>       handle calls (no-op) on systems without ide disks (IDE may not
>       have been built for disks).
> 
> 2/7 - add hook in ide-taskfile:ide_cmd_ioctl() to call the new
>       function ide_write_cache().
> 
> 3/7 - Add documentation for the use of the Kbuild variable
>       BLK_DEV_HDWC.
> 
> 4/7 - use new config variable BLK_DEV_HDWC in idedisk_setup code.
> 
> 5/7 - remove (now obsolete) write_cache() from ide-disk.c.  replace calls in
>       ide-disk.c with calls to ide_write_cache().
> 
> 6/7 - change the way that ide_write_cache controls the use of flushing
>       via blk_queue_ordered() to match the setting of the drive's
>       write cache setting.  This patch leaves the idedisk_issue_flush
>       in ide-disk.c, but the func could be moved to ide-io to complete
>       the break of the dependency between ide-io and ide-disk.
> 
> 7/7 - move idedisk_issue_flush to ide-io.c supporting
>       ide_write_cache()
