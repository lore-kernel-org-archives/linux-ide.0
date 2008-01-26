From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 10/14] sata_mv Use DMA memory pools for hardware memory
 tables
Date: Sat, 26 Jan 2008 10:18:45 -0500
Message-ID: <479B4F55.8050105@rtr.ca>
References: <4798FB68.70400@rtr.ca> <4798FCE1.30702@rtr.ca> <479AB639.5020108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4407 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754127AbYAZPSq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 10:18:46 -0500
In-Reply-To: <479AB639.5020108@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
..
>> static int __init mv_init(void)
>> {
>> +    /* Ideally, a device (second parameter) would "own" these pools.
>> +     * But for maximum memory efficiency, we really need one global
>> +     * set of each, shared among all like devices.  As below.
>> +     */
>> +    mv_crqb_pool = dma_pool_create("mv_crqb_q", NULL, MV_CRQB_Q_SZ,
>> +                    MV_CRQB_Q_SZ, 0);
>> +    mv_crpb_pool = dma_pool_create("mv_crpb_q", NULL, MV_CRPB_Q_SZ,
>> +                    MV_CRPB_Q_SZ, 0);
>> +    mv_sg_tbl_pool = dma_pool_create("mv_sg_tbl", NULL, MV_SG_TBL_SZ,
>> +                      MV_SG_TBL_SZ, 0);
> 
> Sorry, I would far rather waste a tiny bit of memory than this.
..

The waste amounts to perhaps half a page, per port.
The chips have either 4 or 8 ports.

But whatever.  I think libata should actually provide the pools anyway,
since most drivers need hardware aligned DMA memory of very similar requirements.

The pre-existing scheme in the driver is insufficient,
as it does not guarantee correct alignment.  Right now it does
appear to work by accident, but there's no alignment guarantee
in the interface unless pools are used.

When we allocate 32 SG tables *per port*, this becomes much more of
a bother, so pools are needed there to avoid waste.

Having the pools per-port rather than per-chip multiplies any waste
by factors of 4 or 8.  I prefer not wasting memory, myself.

Cheers
