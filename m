From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: simple use wcache from drive (was)Re: [RFC/PATCH 0/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 23:59:18 +0100
Message-ID: <58cb370e05012814592266d81f@mail.gmail.com>
References: <200501282254.j0SMsnBu023405@falcon10.austin.ibm.com>
	 <58cb370e05012814566dce888a@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.192]:8399 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262814AbVA1W7U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2005 17:59:20 -0500
Received: by wproxy.gmail.com with SMTP id 67so326967wri
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 14:59:19 -0800 (PST)
In-Reply-To: <58cb370e05012814566dce888a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>

On Fri, 28 Jan 2005 23:56:41 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Fri, 28 Jan 2005 16:54:49 -0600, Doug Maxey <dwm@austin.ibm.com> wrote:
> >
> > On Fri, 28 Jan 2005 23:32:53 +0100, Bartlomiej Zolnierkiewicz wrote:
> > >> The datacenters/server folks that would be using these drives would
> > >> expect them to remain as set.  I have to check, but unless something
> > >> has changed very recently in the kernel, setting with hdparm does not
> > >> "stick" in the sense that the command succeeds to the disk, but no change
> > >> is made to the barrier.
> > >
> > >It is not a problem for IDE driver (flushes become no-ops)
> > >and this way you can later enable wcache and still use barries.
> >
> > Well that certainly simplfies things.
> >
> > How about this?
> 
> No go until 'drive->wcache' bug is fixed.

And until user is informed about status of wcache (printk).

> > ===== drivers/ide/ide-disk.c 1.115 vs edited =====
> > --- 1.115/drivers/ide/ide-disk.c        2005-01-04 11:39:25 -06:00
> > +++ edited/drivers/ide/ide-disk.c       2005-01-28 16:48:24 -06:00
> > @@ -1083,7 +1083,7 @@ static void idedisk_setup (ide_drive_t *
> >         if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
> >                 drive->wcache = 1;
> >
> > -       write_cache(drive, 1);
> > +       write_cache(drive, drive->wcache);
> >
> >         /*
> >          * We must avoid issuing commands a drive does not understand
> >
>
