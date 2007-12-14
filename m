From: Tejun Heo <htejun@gmail.com>
Subject: Re: Best way to segments/requests
Date: Sat, 15 Dec 2007 00:05:03 +0900
Message-ID: <47629B9F.90108@gmail.com>
References: <8b67d60712131459q35c3ef0dpe1347028112343fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:38363 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbXLNPFJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 10:05:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1797613wah.23
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 07:05:09 -0800 (PST)
In-Reply-To: <8b67d60712131459q35c3ef0dpe1347028112343fd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Hello,

Adrian McMenamin wrote:
> I am working on a driver for the CD Rom drive on the Sega Dreamcast
> (the so-called "GD Rom" drive). This device is electorically
> compatible with IDE-3 devices and has a pretty good match in terms of
> the control block registers but it implements its own packet command
> interface.
> 
> I now have a working driver but the performance is lousy.
> 
> The driver reads data off the disk using DMA and the target for the
> DMA has to be a contiguous. Therefore I have set:
> 
> 	/* using DMA so memory will need to be contiguous */
> 	blk_queue_max_hw_segments(gd.gdrom_rq, 1);
> 	/* set a large max size to get most from DMA */
> 	blk_queue_max_segment_size(gd.gdrom_rq, 0x40000);

Ah...

> ie only one segment per request but a big (for a small device) maximum
> size for the segment.
> 
> A priori I can see no performance advantage in allowing each request
> to include multiple segments because then I'd only have to reshake
> them so they went in one at a time. But from the looks of it if I do
> set the maximum number of segments to 1 then each request is limited
> to the smallest size - ie what I set in blk_queue_hardsect_size.

There just isn't much room for maneuver w/ just one segment.  Large
contiguous memory region isn't too common these days.  That said, there
was a bug recently spotted by Mark Lord which made contiguous memory
regions even rarer.  Which kernel version are you using?

> Is that right? What is the best way to go here?

If you can spare some memory and cpu cycles, preparing a contiguous
buffer and staging data there might help.  It will eat up some cpu
cycles but it won't be too much compared to PIO cycles.

-- 
tejun
