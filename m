From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: sata_sil24 corruption details
Date: Thu, 10 Nov 2005 09:15:32 -0500
Message-ID: <87f94c370511100615u1eba1baai9d91df8ad2556510@mail.gmail.com>
References: <20051110071736.23747.qmail@science.horizon.com>
	 <43730C55.7030808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:54232 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750914AbVKJOPd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 09:15:33 -0500
Received: by zproxy.gmail.com with SMTP id 40so386323nzk
        for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 06:15:33 -0800 (PST)
In-Reply-To: <43730C55.7030808@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux@horizon.com, linux-ide@vger.kernel.org

On 11/10/05, Tejun Heo <htejun@gmail.com> wrote:
> linux@horizon.com wrote:
> > Three days ago, I wrote:
> >
> >>I finished "badblocks -b 4096 -c 65536 -s -v -w -t random" run on 350
> >>G of one drive without seeing problems, and am working on the other 5.
> >>(In parallel, just to stress the driver.)
> >
> >
> > My parallel -p1 badblocks runs (I shrunk the chunk size to -c 16384)
> > finished on 3 of the 5 drives, but after 69 hours and I don't know how
> > many passes, it's still running on one pair of drives.  Interestingly,
> > the pair (sdc4 & sdd4) is connected to a single controller.
> >
> > Thus, it might not be a multiple-controller issue (I don't know how
> > many other people have 3 Sil3132s in a system), but perhaps an issue
> > with simultaneous activity on the 2 ports of a single controller.
> >
> > Is there anything else I could do to help debug this problem?  Any additional
> > debugging I can enable?
> >
> > It would take me a while to clean the backups off the system and move
> > it outside the firewall to allow remote access if someone wants access
> > to that particular hardware, but it's just an expensive bit bucket at
> > the moment, so ask if it would help...
>
> Hello, there.
>
> I'll soon try to tackle this one.  However, I currently have only one
> 3124 controller and one harddisk to hook to that controller, so I cannot
> reproduce your setup over here.  Here are things that I think might help
> in diagnosing the problem.
>
> * Trying other drivers
>         * Trying the original driver.  I'll port the original driver
>           from sii to the current tree and post the patch.
>         * Performing similar test under Windows.
>
> * Ruling out disk problem
>         * Trying other harddisks.  All harddisk drives perform error
>           detection/correction when data are read from the media, but
>           ruling out the possibility would still be helpful.
>
> * If you have log of failed sectors, finding patterns will be helpful.
>   If the errors occur at random places, it's likely that we have
>   controller/driver issues.  If errors are localized over multiple runs,
>   maybe the disk is at fault.
>
> --
> tejun

Tejun,

I assume you saw my e-mail that with a 3112 and a single SATA drive we
were seeing corruption as well.  That being the case I think you
should first verify that corruption is not occuring in the single SATA
drive case.

Our test was to create a bunch of 2 GB files on a PATA drive.

We simply used a drive with real data as the source of our test files.
ie. IIRC: cd test_dir; dd if=/dev/hde conv=noerror,sync | split -b 2000m

Then we calculated the md5 of all the 2 GB pieces.  All of this done
in a pure PATA setup.

Then we connected a SATA drive to a 3112 and simply copied the files
from the PATA drive to the SATA drive and verified the md5 values.  We
found corruption in 1 - 3% of the files copied.

FYI: The above are all very common steps for a computer forensic
examine, thus we found this issue in our attempts to qualify the 3112
as part of our forensic equipment.  We have not tested since 2.6.11
and that was with a SUSE kernel.

Greg
--
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
