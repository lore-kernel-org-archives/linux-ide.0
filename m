From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Fw: [Bug 5880] Transcend CF pcmcia card no longer works
Date: Mon, 16 Jan 2006 10:55:42 +0100
Message-ID: <58cb370e0601160155i68538f2ftd3a46cd22ababeb2@mail.gmail.com>
References: <20060113113922.23ce6d78.akpm@osdl.org> <43C87CF2.30402@gmail.com>
	 <43C88509.7090009@yahoo.com.au> <43C88FBB.3000607@gmail.com>
	 <20060113215218.68a68f4e.akpm@osdl.org>
	 <43C896F0.1080005@yahoo.com.au> <43CB5D43.8080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.202]:18788 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932304AbWAPJzo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jan 2006 04:55:44 -0500
Received: by uproxy.gmail.com with SMTP id s2so580974uge
        for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2006 01:55:42 -0800 (PST)
In-Reply-To: <43CB5D43.8080301@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>, axboe@suse.de, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>, Linux-ide <linux-ide@vger.kernel.org>

On 1/16/06, Tejun Heo <htejun@gmail.com> wrote:
> Nick Piggin wrote:
> > Andrew Morton wrote:
> >
> >> (Adding bugzilla back to cc)
> >>
> >> Tejun Heo <htejun@gmail.com> wrote:
> >>
> >
> >>>> I'm not sure that it has been deallocated, rather something has
> >>>> overwritten
> >>>> it, no?
> >>>
> >>>
> >>> The ldm validation or failure seems irrelevant.  From the original
> >>> bug report.
> >>>
> >
> > Looks like you're right.
> >
> > It was just odd that the ldm check worked and the msdos one
> > oopsed; both attempt to read the same block in the same manner.
> >
> > Perhaps it may be that the queue was freed long before then, and
> > only just gets reused for something else and overwritten at this
> > point.
> >
> > slab debugging might help?
> >
>
> [CC'ing Bartlomiej and linux-ide]
>
> Hello, Bartlomiej.
>
> This thread started by Andrew forwarding bugzilla #5880 to as-iosched
> related people as the machine oopsed in anticipatory scheduler.  After
> diagnosis, it seems to be premature device release problem of IDE
> driver.  The original bug entry is
>
> http://bugzilla.kernel.org/show_bug.cgi?id=5880
>
> The original bug is about CF device unuseable.  The oops occurs after
> yanking out the CF device during partition check is in progress (all are
> failing due to IO error).
>
> I've glanced through the IDE code and the problem seems to be in
> ide_disk_get().  This function doesn't get the IDE generic device
> (ide_drive_t->gendev) and so if a device is yanked out while it's still
> open, the gendev doesn't wait for the open fd's to be closed.  This
> results in dangling open block device and thus above oops.  I'm not very
> sure about this analysis and currently don't have access to
> hot-unpluggable IDE devices.
>
> Can you please confirm this?

Hi Tejun,

Confirmed, we need to get/put generic device in ide_disk_{get,put}()
similarly like drivers/scsi/sd.c driver does it (the same also applies to
ide-{cd,floppy,tape,scsi} drivers).

I would happily apply a patch fixing it (*hint*, *hint*).


Now back to the original problem ("ghost" slave device):

Pavel, is there any way to recognize this PCMCIA IDE controller
in ide-cs driver so we could tell IDE subsystem not to probe slave
devices?

Thanks,
Bartlomiej
