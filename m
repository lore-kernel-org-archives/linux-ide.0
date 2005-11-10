From: Jens Axboe <axboe@suse.de>
Subject: Re: sata_sil24 corruption details
Date: Thu, 10 Nov 2005 18:39:25 +0100
Message-ID: <20051110173924.GH3699@suse.de>
References: <20051110071736.23747.qmail@science.horizon.com> <43730C55.7030808@gmail.com> <87f94c370511100615u1eba1baai9d91df8ad2556510@mail.gmail.com> <43735C19.4040402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:57654 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751179AbVKJRim (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2005 12:38:42 -0500
Content-Disposition: inline
In-Reply-To: <43735C19.4040402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, linux@horizon.com, linux-ide@vger.kernel.org

On Thu, Nov 10 2005, Tejun Heo wrote:
> Greg Freemyer wrote:
> >On 11/10/05, Tejun Heo <htejun@gmail.com> wrote:
> >
> >>linux@horizon.com wrote:
> >>
> >>>Three days ago, I wrote:
> >>>
> >>>
> >>>>I finished "badblocks -b 4096 -c 65536 -s -v -w -t random" run on 350
> >>>>G of one drive without seeing problems, and am working on the other 5.
> >>>>(In parallel, just to stress the driver.)
> >>>
> >>>
> >>>My parallel -p1 badblocks runs (I shrunk the chunk size to -c 16384)
> >>>finished on 3 of the 5 drives, but after 69 hours and I don't know how
> >>>many passes, it's still running on one pair of drives.  Interestingly,
> >>>the pair (sdc4 & sdd4) is connected to a single controller.
> >>>
> >>>Thus, it might not be a multiple-controller issue (I don't know how
> >>>many other people have 3 Sil3132s in a system), but perhaps an issue
> >>>with simultaneous activity on the 2 ports of a single controller.
> >>>
> >>>Is there anything else I could do to help debug this problem?  Any 
> >>>additional
> >>>debugging I can enable?
> >>>
> >>>It would take me a while to clean the backups off the system and move
> >>>it outside the firewall to allow remote access if someone wants access
> >>>to that particular hardware, but it's just an expensive bit bucket at
> >>>the moment, so ask if it would help...
> >>
> >>Hello, there.
> >>
> >>I'll soon try to tackle this one.  However, I currently have only one
> >>3124 controller and one harddisk to hook to that controller, so I cannot
> >>reproduce your setup over here.  Here are things that I think might help
> >>in diagnosing the problem.
> >>
> >>* Trying other drivers
> >>       * Trying the original driver.  I'll port the original driver
> >>         from sii to the current tree and post the patch.
> >>       * Performing similar test under Windows.
> >>
> >>* Ruling out disk problem
> >>       * Trying other harddisks.  All harddisk drives perform error
> >>         detection/correction when data are read from the media, but
> >>         ruling out the possibility would still be helpful.
> >>
> >>* If you have log of failed sectors, finding patterns will be helpful.
> >> If the errors occur at random places, it's likely that we have
> >> controller/driver issues.  If errors are localized over multiple runs,
> >> maybe the disk is at fault.
> >>
> >>--
> >>tejun
> >
> >
> >Tejun,
> >
> >I assume you saw my e-mail that with a 3112 and a single SATA drive we
> >were seeing corruption as well.  That being the case I think you
> >should first verify that corruption is not occuring in the single SATA
> >drive case.
> >
> >Our test was to create a bunch of 2 GB files on a PATA drive.
> >
> >We simply used a drive with real data as the source of our test files.
> >ie. IIRC: cd test_dir; dd if=/dev/hde conv=noerror,sync | split -b 2000m
> >
> >Then we calculated the md5 of all the 2 GB pieces.  All of this done
> >in a pure PATA setup.
> >
> >Then we connected a SATA drive to a 3112 and simply copied the files
> >from the PATA drive to the SATA drive and verified the md5 values.  We
> >found corruption in 1 - 3% of the files copied.
> >
> >FYI: The above are all very common steps for a computer forensic
> >examine, thus we found this issue in our attempts to qualify the 3112
> >as part of our forensic equipment.  We have not tested since 2.6.11
> >and that was with a SUSE kernel.
> >
> 
> Hi,
> 
> I'll run single drive test on sil3112 tonight, but can you please try 
> 2.6.14?  IIRC, there have been some PCI FIFO setting change.  Hmmm.. 
> oh.. it was the following commit.
> 
> ---
> $ git-cat-file commit e1dd23a0012c3929737798fda9fede0e783f4ff3
> tree c7f808b6433ef1015f55418e7f11f432943bdefd
> parent 5273a00d9c763108397658d440618f7ac3e40f83
> author Jens Axboe <axboe@suse.de> 1118228545 +0200
> committer Jeff Garzik <jgarzik@pobox.com> 1118300782 -0400
> 
> [PATCH] sata_sil: Fix FIFO PCI Bus Arbitration kernel oops
> 
> Correct this.
> ---
> 
> Jens, is it possible that above change fixes data corruption?

It could, but only on the 3114 (where it would oops before). The 3112
data corruption cache line fix predates it, so it probably isn't this
one.

-- 
Jens Axboe

