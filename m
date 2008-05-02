From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 03/12] sata_mv wait for empty+idle
Date: Fri, 02 May 2008 13:45:24 -0400
Message-ID: <481B5334.7030200@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>	 <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <da824cf30805020942q27466cbbk5c7877d6caa6c3d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1281 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756957AbYEBRpZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 13:45:25 -0400
In-Reply-To: <da824cf30805020942q27466cbbk5c7877d6caa6c3d1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Grant Grundler wrote:
> On Thu, May 1, 2008 at 11:09 PM, Mark Lord <liml@rtr.ca> wrote:
>> When performing EH, it is recommended to wait for the EDMA engine
>>  to empty out requests-in-progress before disabling EDMA.
>>
>>  Introduce code to poll the EDMA_STATUS register for idle/empty bits
>>  before disabling EDMA.  For non-EH operation, this will normally exit
>>  without delay, other than the register read.
..
>>  +static void mv_wait_for_edma_empty_idle(struct ata_port *ap)
>>  +{
>>  +       void __iomem *port_mmio = mv_ap_base(ap);
>>  +       const u32 empty_idle = (EDMA_STATUS_CACHE_EMPTY |
>> EDMA_STATUS_IDLE);
>>  +       const int per_loop = 5, timeout = (15 * 1000 / per_loop);
> 
> I reccomend setting per_loop to 10 or 20 at least. 5us is not very long.
> It takes about 1us to do an MMIO read. Each additional MMIO read will exacerbate
> the problem of DMA not finishing since MMIO reads interfere with DMA streams.
> 
> Also can you add a comment why 15ms is right amount of time to wait?
..

I would, if I knew.  That's just a random number.
My own timings with a handful of drives here indicated
that it takes a few hundred microseconds worst case,
so I just picked a bigger number to start with.

No rationale == no comment in the original.
But if you have a good theory for what that number ought to be,
then go for it -- just patch it and stick an explanation in.

Thanks.

> BTW, I have no idea when EDMA stops on it's own or if we could
> safely get EDMA to stop "prematurely" (e.g. disable PCI Bus Master).
..

I don't know what you're talking about there.

???
