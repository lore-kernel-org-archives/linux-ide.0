From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Use ATAPI PIO mode for specific request buffer
 sizes
Date: Thu, 02 Dec 2004 06:21:08 -0500
Message-ID: <41AEFAA4.80907@pobox.com>
References: <00ce01c4d6b8$d222d080$bc604109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25035 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261584AbULBLVX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Dec 2004 06:21:23 -0500
In-Reply-To: <00ce01c4d6b8$d222d080$bc604109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Hi, Jeff:
> 
>   After some testing, it seems that some PATA host adapter (ex. pdc20275) cannot 
> work reliably with specific request buffer sizes under ATAPI DMA mode.
> 
> Detailed test result:
> 4096, 2048, 1024, 512, 256: OK
> 384, 257, 255, 128, 96, 64, 32:  failed (irq lost)
> 
>   It seems multiple of 256 bytes are the safe ATAPI DMA buffer sizes to use.
> 
> Attached please find the patch against libata-dev-2.6 for your review.
> Two changes:
> 1. Use ATAPI PIO mode for ATAPI REQUEST_SENSE
> 2. Use ATAPI PIO mode for specific SCSI commands issued to ATAPI device that
>     buffer_size % 256 != 0.
> 
>   Since for most commands, buffer_size % 256 is 0,  this patch
> won't introduce big impact to the performance of libata (hopefully).
>   
>   Tested OK on on my machine with pdc20275 and ASUS CD-RW drive.

hmmmmmmm.

Your change #1 makes perfect sense, and I agree it is the safer (and 
more simple) route.

I must ponder change #2 some more (after some sleep :)).  In particular, 
I am concerned that making change #2 across all controllers will hurt 
performance on the commands whose data length is not purely sector-sized 
chunks.

Would you mind splitting up change #1 and #2 into separate patches?

	Jeff


