From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: sata_sil24 corruption details
Date: Thu, 10 Nov 2005 15:34:33 -0500
Message-ID: <87f94c370511101234v7a20c0daic907c41ccc61482c@mail.gmail.com>
References: <20051110071736.23747.qmail@science.horizon.com>
	 <43730C55.7030808@gmail.com>
	 <87f94c370511100615u1eba1baai9d91df8ad2556510@mail.gmail.com>
	 <43735C19.4040402@gmail.com> <4373843E.2030308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:541 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932076AbVKJUee convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 15:34:34 -0500
Received: by zproxy.gmail.com with SMTP id k1so493741nzf
        for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 12:34:34 -0800 (PST)
In-Reply-To: <4373843E.2030308@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux@horizon.com, linux-ide@vger.kernel.org

On 11/10/05, Tejun Heo <htejun@gmail.com> wrote:
> Tejun Heo wrote:
> > Greg Freemyer wrote:
> >
> >> On 11/10/05, Tejun Heo <htejun@gmail.com> wrote:
> >>
> >>> linux@horizon.com wrote:
> >>>
> >>>> Three days ago, I wrote:
> >>>>
> >>>>
> >>>>> I finished "badblocks -b 4096 -c 65536 -s -v -w -t random" run on 350
> >>>>> G of one drive without seeing problems, and am working on the other 5.
> >>>>> (In parallel, just to stress the driver.)
> >>>>
> >>>>
> >>>>
> >>>> My parallel -p1 badblocks runs (I shrunk the chunk size to -c 16384)
> >>>> finished on 3 of the 5 drives, but after 69 hours and I don't know how
> >>>> many passes, it's still running on one pair of drives.  Interestingly,
> >>>> the pair (sdc4 & sdd4) is connected to a single controller.
> >>>>
> >>>> Thus, it might not be a multiple-controller issue (I don't know how
> >>>> many other people have 3 Sil3132s in a system), but perhaps an issue
> >>>> with simultaneous activity on the 2 ports of a single controller.
> >>>>
> >>>> Is there anything else I could do to help debug this problem?  Any
> >>>> additional
> >>>> debugging I can enable?
> >>>>
> >>>> It would take me a while to clean the backups off the system and move
> >>>> it outside the firewall to allow remote access if someone wants access
> >>>> to that particular hardware, but it's just an expensive bit bucket at
> >>>> the moment, so ask if it would help...
> >>>
> >>>
> >>> Hello, there.
> >>>
> >>> I'll soon try to tackle this one.  However, I currently have only one
> >>> 3124 controller and one harddisk to hook to that controller, so I cannot
> >>> reproduce your setup over here.  Here are things that I think might help
> >>> in diagnosing the problem.
> >>>
> >>> * Trying other drivers
> >>>        * Trying the original driver.  I'll port the original driver
> >>>          from sii to the current tree and post the patch.
> >>>        * Performing similar test under Windows.
> >>>
> >>> * Ruling out disk problem
> >>>        * Trying other harddisks.  All harddisk drives perform error
> >>>          detection/correction when data are read from the media, but
> >>>          ruling out the possibility would still be helpful.
> >>>
> >>> * If you have log of failed sectors, finding patterns will be helpful.
> >>>  If the errors occur at random places, it's likely that we have
> >>>  controller/driver issues.  If errors are localized over multiple runs,
> >>>  maybe the disk is at fault.
> >>>
> >>> --
> >>> tejun
> >>
> >>
> >>
> >> Tejun,
> >>
> >> I assume you saw my e-mail that with a 3112 and a single SATA drive we
> >> were seeing corruption as well.  That being the case I think you
> >> should first verify that corruption is not occuring in the single SATA
> >> drive case.
> >>
> >> Our test was to create a bunch of 2 GB files on a PATA drive.
> >>
> >> We simply used a drive with real data as the source of our test files.
> >> ie. IIRC: cd test_dir; dd if=/dev/hde conv=noerror,sync | split -b 2000m
> >>
> >> Then we calculated the md5 of all the 2 GB pieces.  All of this done
> >> in a pure PATA setup.
> >>
> >> Then we connected a SATA drive to a 3112 and simply copied the files
> >> from the PATA drive to the SATA drive and verified the md5 values.  We
> >> found corruption in 1 - 3% of the files copied.
> >>
> >> FYI: The above are all very common steps for a computer forensic
> >> examine, thus we found this issue in our attempts to qualify the 3112
> >> as part of our forensic equipment.  We have not tested since 2.6.11
> >> and that was with a SUSE kernel.
> >>
> >
> > Hi,
> >
> > I'll run single drive test on sil3112 tonight, but can you please try
> > 2.6.14?  IIRC, there have been some PCI FIFO setting change.  Hmmm..
> > oh.. it was the following commit.
> >
> > ---
> > $ git-cat-file commit e1dd23a0012c3929737798fda9fede0e783f4ff3
> > tree c7f808b6433ef1015f55418e7f11f432943bdefd
> > parent 5273a00d9c763108397658d440618f7ac3e40f83
> > author Jens Axboe <axboe@suse.de> 1118228545 +0200
> > committer Jeff Garzik <jgarzik@pobox.com> 1118300782 -0400
> >
> > [PATCH] sata_sil: Fix FIFO PCI Bus Arbitration kernel oops
> >
> > Correct this.
> > ---
> >
> > Jens, is it possible that above change fixes data corruption?
> >
>
> Greg, first pass of 'badblocks -t random -v -w' on 100G partion of 160G
> disk just finished without any error.  This is samsung hd160jj drive on
> sil3112 controller.  I'll let badblocks run thorough the night and
> perform file copy & md5sum test tomorrow.  But my hunch is that there is
> no common data corruption problem with sil3112.  It's just in too
> wide-spread use to have such data corruption problem with so few reportings.
>
> What exact controller/disk did you use?  Care to retest your setup with
> 2.6.14?
>
> --
> tejun
>
Tejun

The corruption I was seeing was on the order of a few bytes per 100
GB.  I'm not sure that most users would realize they were having
problems with that small of an error rate.

I'm not sure what the OPs error rate was, but maybe he can tell us.

I will attempt to retest with 2.6.14 vanilla.  Not sure if that will
be today or tomorrow.

I don't have the old disk any more, but I will report what I use this time.

I also have a CoolGear SATA to USB bridge, so if corruption is still
occuring I can retry the process with a USB connection to the
computer.  http://www.cooldrives.com/seatatousb20.html   If that works
it should rule out the Drive.

Thanks for taking the time.

Greg
--
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
