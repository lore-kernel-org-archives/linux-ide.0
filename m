From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC/PATCH 0/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 22:49:08 +0100
Message-ID: <58cb370e0501281349543d0d14@mail.gmail.com>
References: <58cb370e05012813357d42da46@mail.gmail.com>
	 <200501282143.j0SLhqlr022481@falcon10.austin.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:4186 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262781AbVA1VtT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2005 16:49:19 -0500
Received: by wproxy.gmail.com with SMTP id 67so319518wri
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 13:49:17 -0800 (PST)
In-Reply-To: <200501282143.j0SLhqlr022481@falcon10.austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>

On Fri, 28 Jan 2005 15:43:52 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> 
> On Fri, 28 Jan 2005 22:35:17 +0100, Bartlomiej Zolnierkiewicz wrote:
> >On Fri, 28 Jan 2005 15:06:22 -0600, Doug Maxey <dwm@maxeymade.com> wrote:
> >>
> >> On Fri, 28 Jan 2005 20:11:37 +0100, Bartlomiej Zolnierkiewicz wrote:
> >> >On Fri, 28 Jan 2005 12:16:01 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> >> >
> >> >We have too many config options already.
> >> >
> >> >Behavior should be simple:
> >> >* no cache flushes - wcache off by default
> >> >* cache flushes - wcache on by default
> >> >* inform user about the wcache status
> >> >* allow changing of wcache by user
> >>
> >> My interpretation of what you are saying here is the selection of
> >> "cache flush" drives the setting of wcache.  Are you saying that
> >> "barrier=off" on the boot line the currently (only and will remain)
> >> supported method controlling flushes?
> >
> >No, I am saying that cache flush is a property of disk not fs.
> >On the contrary barrier is a property of filesystem.
> 
> Ok.  We are talking apples and oranges here.  The disk DOES have FLUSH CACHE,
> which is the main reason these drives work in the later kernels.  You can
> switch wcache back and forth, provided that the correct flushing is done.
> 
> Write cache, on the otherhand, which is disabled on the drive by default,
> is not honored.

What is the practical reason to honor it?

> >
> >> AFAICS, "barrier=off" just tells the FS (only ext2 and reiser) to not
> >> flush writes.  I may be misunderstanding how that controls the
> >> behavior of the drive at the ll_blk layer.  Is that what you want to
> >> see a patch to, pick this out of the FS?
> >
> >No, why?
> >
> >> >>
> >> >> 1) move the cache_write code to ide-io, where it will be callable from
> >> >>    kernels built without ide-disk.
> >> >
> >> >I've already pointed this out - this is not needed, you should add
> >> >check similar to this for 'xfer_set'.  Another reason not to do this
> >> >is that write_cache() uses REQ_DRIVE_TASKFILE internally.
> >>
> >> Is taskfile going away?
> >
> >Quite the opposite but if you want to use taskfile, map whole
> >ide_cmd_ioctl() to it not CACHE_FLUSH_{EXT} command only
> >and don't intermix bugfixes with potentially risky changes.
> >
> 
> Well, if you turn off write cache, then you must not, at least on these
> drives, use FLUSH.  All write commands are errored.

With the 'drive->wcache' bugfix this shouldn't be a problem
as FLUSH commands wouldn't be sent to a drive.
