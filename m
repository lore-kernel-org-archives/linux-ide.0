From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: simple use wcache from drive
Date: Sun, 30 Jan 2005 01:41:00 +0100
Message-ID: <58cb370e050129164121693486@mail.gmail.com>
References: <58cb370e05012916051d3f465f@mail.gmail.com>
	 <200501300019.j0U0Jowx006319@falcon10.austin.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:34611 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261620AbVA3AlB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jan 2005 19:41:01 -0500
Received: by wproxy.gmail.com with SMTP id 67so416847wri
        for <linux-ide@vger.kernel.org>; Sat, 29 Jan 2005 16:41:01 -0800 (PST)
In-Reply-To: <200501300019.j0U0Jowx006319@falcon10.austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>

On Sat, 29 Jan 2005 18:19:50 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> 
> On Sun, 30 Jan 2005 01:05:03 +0100, Bartlomiej Zolnierkiewicz wrote:
> >On Sat, 29 Jan 2005 17:54:47 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> >>
> >> On Fri, 28 Jan 2005 23:59:18 +0100, Bartlomiej Zolnierkiewicz wrote:
> >> >On Fri, 28 Jan 2005 23:56:41 +0100, Bartlomiej Zolnierkiewicz
> >> ><bzolnier@gmail.com> wrote:
> >> >> On Fri, 28 Jan 2005 16:54:49 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> >> >> >
> >> >> > On Fri, 28 Jan 2005 23:32:53 +0100, Bartlomiej Zolnierkiewicz wrote:
> >> >> > >> The datacenters/server folks that would be using these drives would
> >> >> > >> expect them to remain as set.  I have to check, but unless something
> >> >> > >> has changed very recently in the kernel, setting with hdparm does not
> >> >> > >> "stick" in the sense that the command succeeds to the disk, but no change
> >> >> > >> is made to the barrier.
> >> >> > >
> >> >> > >It is not a problem for IDE driver (flushes become no-ops)
> >> >> > >and this way you can later enable wcache and still use barries.
> >> >> >
> >> >> > Well that certainly simplfies things.
> >> >> >
> >> >> > How about this?
> >> >>
> >> >> No go until 'drive->wcache' bug is fixed.
> >> >
> >> >And until user is informed about status of wcache (printk).
> >> >
> >>
> >> [PATCH] use IDE drive cache enabled setting by default.
> >>
> >>   Enable the default setting of the driver use of write cache to be
> >>   defined by the drive itself.
> >>
> >> Signed-off-by: Doug Maxey <dwm@austin.ibm.com>
> >>
> >> ===== drivers/ide/ide-disk.c 1.115 vs 1.116 =====
> >> --- 1.115/drivers/ide/ide-disk.c        2005-01-04 11:39:25 -06:00
> >> +++ 1.116/drivers/ide/ide-disk.c        2005-01-29 15:13:24 -06:00
> >> @@ -784,6 +784,7 @@ static int write_cache(ide_drive_t *driv
> >>         if (err)
> >>                 return err;
> >>
> >> +       printk(KERN_DEBUG "%s: %sabling write cache\n", drive->name, arg ? "en" : "dis");
> >>         drive->wcache = arg;
> >>         return 0;
> >>  }
> >> @@ -1080,10 +1081,10 @@ static void idedisk_setup (ide_drive_t *
> >>         drive->no_io_32bit = id->dword_io ? 1 : 0;
> >>
> >>         /* write cache enabled? */
> >> -       if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
> >> +       if ((id->csfo & 1) && (id->cfs_enable_1 & (1 << 5)))
> >>                 drive->wcache = 1;
> >
> >This bogus... I was thinking about bug related to hdparm...
> 
> Sorry, my crystal ball is foggy today.  Do you have a specific bug number or
> message-id?

>From private mail to you:
On Wed, 13 Oct 2004 21:06:32 +0200, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> the write cache handling is a bit more complicated, please look at
> write_cache():
> 
>         if (!ide_id_has_flush_cache(drive->id))
>                 return 1;
> 
> this means that the write cache will stay enabled for devices not supporting
> (or advertising) flush cache feature.  Anyway this is a minor issue,
> real problem is that hdparm doesn't use HDIO_SET_WCACHE ioctl but
> HDIO_DRIVE_CMD to [en,dis]able write cache.  Suppose the following scenario:
> 
> - disk supports write cache and cache flush
> - disk comes with write cache disabled by default
> - your patch disables write cache
> - user enables write cache with hdparm
> - driver is not aware that write cache has been enabled
>  (BAD)

> >
> >> -       write_cache(drive, 1);
> >> +       write_cache(drive, drive->wcache);
> >
> >You still didn't answer my question what is the practical reason for this...
> 
> Thought we had already cleared this up.  See above.

Nope, please see "[RFC/PATCH 0/7] enable honoring write cache setting
of IDE drive" thread.
