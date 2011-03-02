From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: libata default FUA support
Date: Wed, 2 Mar 2011 18:29:40 +0100
Message-ID: <20110302172940.GA1644@gentoo.trippels.de>
References: <20110301203313.GA1656@gentoo.trippels.de>
 <4D6D952D.8030609@gmail.com>
 <4D6DF231.5090702@msgid.tls.msk.ru>
 <20110302085823.GI19669@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:48681 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340Ab1CBR3m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2011 12:29:42 -0500
Content-Disposition: inline
In-Reply-To: <20110302085823.GI19669@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2011.03.02 at 09:58 +0100, Tejun Heo wrote:
> On Wed, Mar 02, 2011 at 10:30:57AM +0300, Michael Tokarev wrote:
> > > I believe the way the block layer uses it, basically it only saves the
> > > overhead of one transaction to the drive. It might be significant on
> > > some workloads (especially on high IOPS drives like SSDs) but it's
> > > likely not a huge deal.
> > 
> > One transaction per what?  If it means extra, especially "large"
> > transaction (lile flush with a wait) per each fsync-like call,
> > that can be huge deal actually, especially on database-like
> > workloads (lots of small syncronous random writes).
> 
> The way flushes are used by filesystems is that FUA is usually only
> used right after another FLUSH.  ie. Using FUA replaces FLUSH + commit
> block write + FLUSH sequence to FLUSH + FUA commit block write.  Due
> to the preceding FLUSH, the cache is already empty, so the only
> difference between WRITE + FLUSH and FUA WRITE becomes the extra
> command issue overhead which is usually almost unnoticeable compared
> to the actual IO.
> 
> Another thing is that with the recent updates to block FLUSH handling,
> using FUA might even be less efficient.  The new implementation
> aggressively merges those commit writes and flushes.  IOW, depending
> on timing, multiple consecutive commit writes can be merged as,
> 
>  FLUSH + commit writes + FLUSH
> 
> or
> 
>  FLUSH + some commit writes + FLUSH + other commit writes + FLUSH
> 
> and so on,
> 
> These merges will happen with fsync heavy workloads where FLUSH
> performance actually matters and, in these scenarios, FUA writes is
> less effective because it puts extra ordering restrictions on each FUA
> write.  ie. With surrounding FLUSHes, the drive is free to reorder
> commit writes to maximize performance, with FUA, the disk has to jump
> around all over the place to execute each command in the exact issue
> order.
> 
> I personally think FUA is a misfeature.  It's a microoptimization with
> shallow benefits even when used properly while putting much heavier
> restriction on actual IO order, which usually is the slow part.

Thanks for the detailed information. Just to confirm your point here are
some benchmark results:

(Seagate ST1500DL003 1.5TB 5900rpm, xfs (delaylog), ffsb (
http://sourceforge.net/projects/ffsb/ ) pure random write benchmark:

1)
Total Results 30sec run, 1 thread, 104*35MB files

             Op Name   Transactions      Trans/sec      % Trans     % Op Weight    Throughput
             =======   ============      =========      =======     ===========    ==========
FUA:         write :   435456            1183.44        100.000%    100.000%       162MB/sec
no FUA:      write :   441600            1243.47        100.000%    100.000%       170MB/sec

System Call Latency statistics in millisecs

                Min             Avg             Max             Total Calls
                ========        ========        ========        ============
[  write]FUA    0.000000        0.070392        5444.638184           435456
[  write]no FUA 0.000000        0.069718        4715.519043           441600

2)
Total Results 240sec run, 2 threads, 104*35MB files
===============
             Op Name   Transactions      Trans/sec      % Trans     % Op Weight    Throughput
             =======   ============      =========      =======     ===========    ==========
FUA:         write :   594944            919.45         100.000%    100.000%       126MB/sec
no FUA:      write :   653824            1097.31        100.000%    100.000%       150MB/sec

System Call Latency statistics in millisecs

                Min             Avg             Max             Total Calls
                ========        ========        ========        ============
[  write]FUA    0.000000        0.812704        13467.903320          594944
[  write]no FUA 0.000000        0.727761        9695.806641           653824

-- 
Markus

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="random_writes.ffsb"

# Large file random writes.
# 104 files, 35MB per file.

time=240
alignio=1

[filesystem0]
	location=/var/tmp/fs_bench
	num_files=104
	min_filesize=36700160  # 35 MB
	max_filesize=36700160
	reuse=1
[end0]

[threadgroup0]
	num_threads=2

	write_random=1
	write_weight=1

	write_size=1048576  # 1 MB
	write_blocksize=4096

	[stats]
		enable_stats=1
		enable_range=1

		msec_range    0.00      0.01
		msec_range    0.01      0.02
		msec_range    0.02      0.05
		msec_range    0.05      0.10
		msec_range    0.10      0.20
		msec_range    0.20      0.50
		msec_range    0.50      1.00
		msec_range    1.00      2.00
		msec_range    2.00      5.00
		msec_range    5.00     10.00
		msec_range   10.00     20.00
		msec_range   20.00     50.00
		msec_range   50.00    100.00
		msec_range  100.00    200.00
		msec_range  200.00    500.00
		msec_range  500.00   1000.00
		msec_range 1000.00   2000.00
		msec_range 2000.00   5000.00
		msec_range 5000.00  10000.00
	[end]
[end0]

--KsGdsel6WgEHnImy--
