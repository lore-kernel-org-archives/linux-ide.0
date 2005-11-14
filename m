From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: sata_sil24 corruption details
Date: Mon, 14 Nov 2005 18:30:48 -0500
Message-ID: <87f94c370511141530h1c2d64e6kdb512f54c3c7b981@mail.gmail.com>
References: <20051110071736.23747.qmail@science.horizon.com>
	 <43730C55.7030808@gmail.com>
	 <87f94c370511100615u1eba1baai9d91df8ad2556510@mail.gmail.com>
	 <43735C19.4040402@gmail.com> <4373843E.2030308@gmail.com>
	 <87f94c370511101234v7a20c0daic907c41ccc61482c@mail.gmail.com>
	 <87f94c370511111649j41d1832dhe7820376f96059a1@mail.gmail.com>
	 <43755A78.3040005@gmail.com> <43771338.6010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:40595 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751321AbVKNXau convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Nov 2005 18:30:50 -0500
Received: by zproxy.gmail.com with SMTP id 40so1232102nzk
        for <linux-ide@vger.kernel.org>; Mon, 14 Nov 2005 15:30:49 -0800 (PST)
In-Reply-To: <43771338.6010000@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux@horizon.com, linux-ide@vger.kernel.org

On 11/13/05, Tejun Heo <htejun@gmail.com> wrote:
> Tejun Heo wrote:
> > Greg Freemyer wrote:
> >>
> >> Tejun,
> >>
> >> Success report:
> >>
> >> I did a 80 GB test copy with 2.6.14.1 and a Maxtor 80GB SATA drive and
> >> a 3112A.  I had 3 drives connected to my server, one PATA for booting,
> >> one PATA for to hold the source data, and the SATA drive.  Let me know
> >> if you want want details about the setup.
> >>
> >> I found no corruption.  Given that my error rate was very low it is
> >> possible that the corruption simply did not happen, but for now I'm
> >> assuming my earlier issues were either a disk problem or a kernel
> >> issue that was resolved by the latest kernel.
> >>
> >> I'm going to continue to test this setup.  I'll report any problems I
> >> find.
> >>
> >
> > Hi, Greg.
> >
> > I also have been continuing corruption test on 3112 during last two
> > days.  It's being performed on 100GB partition of a 160GB harddisk
> > (samsung hd160jj).  Nine passes of 'badblocks -t random -v -w /dev/sdb2'
> > succeeded without any problem.  To replicate your test, I created a 4GB
> > random file by dd'ing from /dev/urandom in a separate IDE disk and
> > copied it to the partition 24times (24 different files of course), then
> > I md5sum'd all copied files twice.  This test succeeded five times
> > without any problem, and it's in the sixth run now.
> >
> > Above badblocks and file copy tests amount to about 1.4TB of writes and
> > 1.9TB of reads without any data corruption.
> >
> > Let me know how your test turns out.
> >
>
> The 4G file test has been running through last two days and it finished
> thirteen more runs without any hickup.  So, my 3112 + hd160jj
> combination finshed 9 runs of 'badblocks -t random -v -w' and 22 runs of
> 4G file copy & verify twice test.  That's > 3TB of writes and > 5TB of
> reads without any error.
>
> I guess my setup doesn't have the problem you used to experience.  How's
> your testing going?
>
> --
> tejun
>

Tejun,

We still have not experienced any problems with 2.6.14.1.  I'm going
to put the 3112 into limited production use for drives over 200GB.  We
verify md5's as part of our standard protocol, so if anything is out
of whack we should find it.  Unfortunately we don't process a lot of
200+ GB drives, but enough that we will likely exercise it a couple
times a month.

Greg
--
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
