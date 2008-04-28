From: Jody McIntyre <scjody@sun.com>
Subject: Re: sata_mv performance; impact of NCQ
Date: Mon, 28 Apr 2008 13:14:49 -0400
Message-ID: <20080428171449.GI17369@modernduck.com>
References: <20080426001657.GD17369@modernduck.com>
 <da824cf30804252013l3a62166bk5ef03fb034fd47d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:44975 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933789AbYD1RPP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 13:15:15 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3SHFBSu000221
	for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 10:15:12 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0K0100C01NYY9800@fe-sfbay-10.sun.com> (original mail from scjody@sun.com)
 for linux-ide@vger.kernel.org; Mon, 28 Apr 2008 10:15:11 -0700 (PDT)
In-reply-to: <da824cf30804252013l3a62166bk5ef03fb034fd47d5@mail.gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

On Fri, Apr 25, 2008 at 08:13:16PM -0700, Grant Grundler wrote:
> >  max_sectors is now limited which means we can no longer perform IOs
> >  greater than 128K (ENOMEM is returned from an sg write.)  Therefore
> >  large IO performance suffers
> 
> I would not jump to that conclusion. 4-5 years ago I measured CPU
> overhead and throughput vs block size for u320 SCSI and the
> difference was minimal once block size exceeded 64K. By minimal
> I mean low single digit differences. I haven't measured large block IO
> recently for SCSI (or SATA) where it might be different.

The conclusion is supported by the graphs - comparing 128K IOs on stock
2.6.25 with 1024K IOs on 2.6.25 with NCQ removed shows lower performance
at high thread counts.  It's not dramatically lower but it's
measureable.  Also the results for small IOs are less consistent -
performance goes up and down as thread count increases.

> Recently I measured sequential 4K IOs performance (goal was to
> determine CPU overhead in the device drivers) and was surprised
> to find that performance peaked at 4 threads per disk.  8 threads per
> disk got about the same throughput as 1 thread.
> 
> For sequential reads the disk device firmware should recognize the
> "stream" and read ahead to maintain media rate. My guess is more
> threads will confuse this strategy and performance will suffer.  This
> behavior depends on drive firmware which will vary depending
> on the IO request size and on how the disk firmware segments read
> buffers. And in this case, the firmware is known to have some
> "OS specific optimizations" (not linux) so I'm not sure if that made
> a difference as well.

Indeed - and since (at the higher end of the scale) the thread count is
larger than the NCQ queue size, the drive firmware has no chance of
being able to reorder everything optimally.

> For sequential writes, I'd be very surprised if the same is true since all
> the SATA drives I've seen have WCE turned on by default. Thus, the
> actual write to media is disconnected from the write request by the
> on-disk write buffering. The drives don't have to guess what needs to
> be written and the original request size might affect how buffers are
> managed in the device and how much RAM the disk controller has
> (I expect  8 MB - 32MB for SATA drives these days).
> Again, YMMV depending on disk firmware.

We turn write caching off for data integrity reasons (write reordering
does bad things to journalling file systems if power is interrupted -
and at the scale of many Lustre deployments, it happens often enough to
be a concern.)  I'm also concerned about the effects of NCQ in this area
so we'll probably turn it off anyway.

> >  Would it be worth re-enabling large IOs on this hardware when NCQ is
> >  disabled (using the queue_depth /proc variable)?  If so I'll come up
> >  with a patch.
> 
> I think it depends on the difference in performance, how much the performance
> depends on diskfirmware (can someone else reproduce those results with
> a different drive?)  and how much uglier it makes the code.

Yes - sounds like it's worth a try anyway, especially if we end up
disabling NCQ for integrity reasons (no NCQ _and_ small IOs really sucks
according to my tests.)

Cheers,
Jody

> I'm not openoffice enabled at the moment thus haven't been able to look
> at the spreadsheet you provided. (Odd that OpenOffice isn't installed on
> this google-issued Mac laptop by default...I'll get that installed though and
> make sure to look at the spreadsheet.)
> 
> hth,
> grant
> 
> >  Does anyone know what mv_sata does about NCQ?  I see references to NCQ
> >  throughout the code but I don't yet understand it enough to determine
> >  what's going on.  mv_sata _does_ support IOs greater than 128K, which
> >  suggests that it does not use NCQ on this hardware at least.
> >
> >  Any advice on areas to explore to improve sata_mv's performance?  I
> >  imagine I need to understand what mv_sata does differently, and plan on
> >  spending some time reading that code, but I'd appreciate more specific
> >  ideas if anyone has them.
> >
> >  Details on the tests I performed:
> >
> >  I used the sgpdd-survey tool, a low level performance test from the
> >  Lustre iokit.  It can be downloaded from:
> >  http://downloads.lustre.org/public/tools/lustre-iokit/ .  The tool
> >  performs timed sgp_dd commands using various IO sizes, region counts,
> >  and thread counts and reports aggregate bandwidth.  These results were
> >  then graphed using a spreadsheet.
> >
> >  Note that the largest thread count measured is not the same on all
> >  graphs.  For some reason, write() to the sg device returns ENOMEM to
> >  some sgp_dd threads when large numbers of threads are run on recent
> >  kernels.  The problem does not exist with the RHEL 4 kernel.  I have not
> >  yet investigated why this happens.
> >
> >  Cheers,
> >  Jody
> >
> >  --
> >  Jody McIntyre - Linux Kernel Engineer, Sun HPC
> >  --
> >  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> >  the body of a message to majordomo@vger.kernel.org
> >  More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

-- 
Jody McIntyre - Linux Kernel Engineer, Sun HPC
