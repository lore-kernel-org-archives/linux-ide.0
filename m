From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 13:59:51 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406720A7.1050501@pobox.com>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262374AbUC1TAG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 14:00:06 -0500
In-Reply-To: <200403282045.07246.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 28 of March 2004 20:30, Jens Axboe wrote:
>>Making something user tunable is usually not the best idea, if you can
>>deduct these things automagically instead. So whether this is the best
>>idea, depends on which way you want to go.
> 
> 
> I think it's the best idea for now, long-term we are better with automagic.


Mostly agreed:

Like I mentioned in the last message, the IO scheduler and the VM should 
really just figure out request size and queue depth and such based on 
observation of device throughput and latency.  So I agree w/ automagic.

But the sysadmin should also be allowed to say "I don't care about 
latency" if he has gobs and gobs of memory and knows his configuration well.

I like generic tunables such as "laptop mode" or "low latency" or "high 
throughput".  These sorts of tunables should affect the "automagic" 
calculations.

	Jeff



