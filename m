From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sat, 27 Mar 2004 19:49:12 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40662108.40705@pobox.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37814 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262035AbUC1At1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 19:49:27 -0500
In-Reply-To: <4066191E.4040702@yahoo.com.au>
List-Id: linux-ide@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Nick Piggin wrote:
> Aside, you should make 2 or 4 tags the default though: that
> still gives you the pipelining without sacrificing latency
> and usibility.

I would rather have a sane block layer default, that works without my 
intervention :)

Ditto the max_sectors issue, the driver for the hardware w/ a 256-depth 
queue should attempt to queue up to the hardware maximum.  The block 
layer can be smart and limit things further from there...

IIRC the AIC7xxx driver sets the queue depth to 200+ on one of my 
drives.  That may be 2.4, though...


> The only area (I think) where large queues outperform the IO
> scheduler are lots of parallel, scattered reads. I think this
> is because the drive can immediately return cached data even
> though it looks like a large seek to the IO scheduler.
> (This is from testing on my single, old SCSI disk though.)

Most ATA drives have their own internal disk schedulers, and all of the 
major vendors seem to have done something useful with TCQ.  Newer drives 
definitely take advantage of the additional knowledge gained via 
knowledge of the entire queue rather than just a single request.

The parallel-reads case you mention is definitely a winner with TCQ, but 
writes are also, for ATA-specific reasons (among others):  since ATA has 
been one-command-at-a-time for so long, write caching became necessary 
for decent performance.  So ATA disks needed a decent internal IO 
scheduler, just maintain a decent level of performance.

TCQ-on-write for ATA disks is yummy because you don't really know what 
the heck the ATA disk is writing at the present time.  By the time the 
Linux disk scheduler gets around to deciding it has a nicely merged and 
scheduled set of requests, it may be totally wrong for the disk's IO 
scheduler.  TCQ gives the disk a lot more power when the disk integrates 
writes into its internal IO scheduling.

	Jeff



