From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 14:45:52 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40687CF0.3040206@pobox.com>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24204 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263107AbUC2TqK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Mar 2004 14:46:10 -0500
In-Reply-To: <20040329130410.GH3039@dualathlon.random>
List-Id: linux-ide@vger.kernel.org
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Andrea Arcangeli wrote:
> Once you change the API too, then you can set the hardwre limit in your
> driver and relay on the highlevel blkdev code to find the optimal runtime
> dma size for bulk I/O, but today it's your driver that is enforcing a
> runtime bulk dma size, not the maximim limit of the controller, and so
> you should code your patch accordingly.

This magic 512k or 1M limit has nothing to do with SATA.  It's a magic 
number whose definition is "we don't want PATA or SATA or SCSI disks 
doing larger requests than this for latency, VM, and similar reasons."

That definition belongs outside the low-level SATA driver.

This 512k/1M value is sure to change over time, which involves 
needlessly plugging the same value into multiple places.  And when such 
changes occurs, you must be careful not to exceed hardware- and 
errata-based limits -- of which there is no distinction in the code.

I think the length of this discussion alone clearly implies that the 
low-level driver should not be responsible for selecting this value, if 
nothing else ;-)

	Jeff



