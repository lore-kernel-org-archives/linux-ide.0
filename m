From: "Grant Grundler" <grundler@google.com>
Subject: Re: sata_mv performance; impact of NCQ
Date: Fri, 25 Apr 2008 20:13:16 -0700
Message-ID: <da824cf30804252013l3a62166bk5ef03fb034fd47d5@mail.gmail.com>
References: <20080426001657.GD17369@modernduck.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:30267 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbYDZDNX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2008 23:13:23 -0400
Received: from spaceape23.eur.corp.google.com (spaceape23.eur.corp.google.com [172.28.16.75])
	by smtp-out.google.com with ESMTP id m3Q3DH7O031553
	for <linux-ide@vger.kernel.org>; Sat, 26 Apr 2008 04:13:17 +0100
Received: from wf-out-1314.google.com (wfc25.prod.google.com [10.142.3.25])
	by spaceape23.eur.corp.google.com with ESMTP id m3Q3DGD6019636
	for <linux-ide@vger.kernel.org>; Sat, 26 Apr 2008 04:13:17 +0100
Received: by wf-out-1314.google.com with SMTP id 25so3191291wfc.27
        for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 20:13:16 -0700 (PDT)
In-Reply-To: <20080426001657.GD17369@modernduck.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jody McIntyre <scjody@sun.com>
Cc: linux-ide@vger.kernel.org

On Fri, Apr 25, 2008 at 5:16 PM, Jody McIntyre <scjody@sun.com> wrote:
> I have completed several performance tests of the Marvell SATA
>  controllers (6x MV88SX6081) in a Sun x4500 (Thumper) system.  The
>  complete results are available from:
>  http://downloads.lustre.org/people/scjody/thumper-kernel-comparison-01.ods
>
>  My ultimate goal is to replace mv_sata (the out-of-tree vendor driver)
>  on RHEL 4 with sata_mv on a modern kernel, and to do this I need
>  equivalent or better performance, especially on large (1MB) IOs.
>
>  I note the recent changes to enable NCQ result in a net performance gain
>  for 64K and 128K IOs, but due to a chipset limitation in the 6xxx series
>  (according to commit f273827e2aadcf2f74a7bdc9ad715a1b20ea7dda),
>  max_sectors is now limited which means we can no longer perform IOs
>  greater than 128K (ENOMEM is returned from an sg write.)  Therefore
>  large IO performance suffers

I would not jump to that conclusion. 4-5 years ago I measured CPU
overhead and throughput vs block size for u320 SCSI and the
difference was minimal once block size exceeded 64K. By minimal
I mean low single digit differences. I haven't measured large block IO
recently for SCSI (or SATA) where it might be different.

Recently I measured sequential 4K IOs performance (goal was to
determine CPU overhead in the device drivers) and was surprised
to find that performance peaked at 4 threads per disk.  8 threads per
disk got about the same throughput as 1 thread.

For sequential reads the disk device firmware should recognize the
"stream" and read ahead to maintain media rate. My guess is more
threads will confuse this strategy and performance will suffer.  This
behavior depends on drive firmware which will vary depending
on the IO request size and on how the disk firmware segments read
buffers. And in this case, the firmware is known to have some
"OS specific optimizations" (not linux) so I'm not sure if that made
a difference as well.

For sequential writes, I'd be very surprised if the same is true since all
the SATA drives I've seen have WCE turned on by default. Thus, the
actual write to media is disconnected from the write request by the
on-disk write buffering. The drives don't have to guess what needs to
be written and the original request size might affect how buffers are
managed in the device and how much RAM the disk controller has
(I expect  8 MB - 32MB for SATA drives these days).
Again, YMMV depending on disk firmware.

>- for example, the performance of 2.6.25
>  with NCQ support removed on 1MB IOs is better than anything possible
>  with stock 2.6.25 for many workloads.
>
>  Would it be worth re-enabling large IOs on this hardware when NCQ is
>  disabled (using the queue_depth /proc variable)?  If so I'll come up
>  with a patch.

I think it depends on the difference in performance, how much the performance
depends on diskfirmware (can someone else reproduce those results with
a different drive?)  and how much uglier it makes the code.

I'm not openoffice enabled at the moment thus haven't been able to look
at the spreadsheet you provided. (Odd that OpenOffice isn't installed on
this google-issued Mac laptop by default...I'll get that installed though and
make sure to look at the spreadsheet.)

hth,
grant

>  Does anyone know what mv_sata does about NCQ?  I see references to NCQ
>  throughout the code but I don't yet understand it enough to determine
>  what's going on.  mv_sata _does_ support IOs greater than 128K, which
>  suggests that it does not use NCQ on this hardware at least.
>
>  Any advice on areas to explore to improve sata_mv's performance?  I
>  imagine I need to understand what mv_sata does differently, and plan on
>  spending some time reading that code, but I'd appreciate more specific
>  ideas if anyone has them.
>
>  Details on the tests I performed:
>
>  I used the sgpdd-survey tool, a low level performance test from the
>  Lustre iokit.  It can be downloaded from:
>  http://downloads.lustre.org/public/tools/lustre-iokit/ .  The tool
>  performs timed sgp_dd commands using various IO sizes, region counts,
>  and thread counts and reports aggregate bandwidth.  These results were
>  then graphed using a spreadsheet.
>
>  Note that the largest thread count measured is not the same on all
>  graphs.  For some reason, write() to the sg device returns ENOMEM to
>  some sgp_dd threads when large numbers of threads are run on recent
>  kernels.  The problem does not exist with the RHEL 4 kernel.  I have not
>  yet investigated why this happens.
>
>  Cheers,
>  Jody
>
>  --
>  Jody McIntyre - Linux Kernel Engineer, Sun HPC
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
