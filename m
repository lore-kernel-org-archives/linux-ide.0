From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: something is dramatically wrong with buffered read performance in
 2.6.32.9
Date: Wed, 17 Mar 2010 17:33:49 -0500
Message-ID: <4BA158CD.6060402@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:53189 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125Ab0CQWdu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 18:33:50 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 9DBC86C3DC
	for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2010 17:33:49 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I recently upgraded from kernel 2.6.31.1 to 2.6.32.9.  Upon kicking the
tires on the new kernel I discovered that my two data partitions are
suffering a ~30MB/s performance loss compared to my root partition.  That's
a loss of nearly half the performance of my disk.

The root partition is a primary, formatted with EXT2.  The two data
partitions are logicals within an extended partition, both formatted with
XFS.  hdparm O_DIRECT tests show identical throughput for all 3 partitions.
 Going through the buffer cache, however, shows a huge performance drop for
the two logical partitions.  Throughput is nearly cut in half through the
buffer cache:

/dev/sda2:
 Timing O_DIRECT disk reads:  238 MB in  3.02 seconds =  78.79 MB/sec
/dev/sda2:
 Timing buffered disk reads:  208 MB in  3.00 seconds =  69.26 MB/sec

/dev/sda6:
 Timing O_DIRECT disk reads:  236 MB in  3.02 seconds =  78.14 MB/sec
/dev/sda6:
 Timing buffered disk reads:  126 MB in  3.01 seconds =  41.79 MB/sec

/dev/sda7:
 Timing O_DIRECT disk reads:  238 MB in  3.00 seconds =  79.27 MB/sec
/dev/sda7:
 Timing buffered disk reads:  126 MB in  3.03 seconds =  41.65 MB/sec

Any ideas what I'm running into here?  Did I somehow fubar something in
menuconfig?

I get the same results with dd copy tests through the buffer cache to
/dev/null.  Any idea what's wrong?  Is this a known bug?

-- 
Stan
