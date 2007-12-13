From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 0/2] [libata] sata_mv: Add support for Marvell's integrated
 SATA controller
Date: Thu, 13 Dec 2007 11:30:58 -0500
Message-ID: <47615E42.2050600@rtr.ca>
References: <11966092121262-git-send-email-saeed.bishara@gmail.com>	 <c70ff3ad0712130613j4b856533idb3dacdf36cee256@mail.gmail.com>	 <47614EC6.2090004@rtr.ca> <c70ff3ad0712130804h6634612ct3e1c5415f01852de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3002 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758848AbXLMQbA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Dec 2007 11:31:00 -0500
In-Reply-To: <c70ff3ad0712130804h6634612ct3e1c5415f01852de@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Saeed Bishara <saeed@marvell.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

saeed bishara wrote:
>> I really think that a lot of the new variable/macro/enum names are overly long,
>> making the code a bit harder to read.
>> The patch is all about "System On Chip (SOC)" support,
>> yet the names all say "INTEGRATED".
> well, many socs have SATA or Ethernet controllers as pci controller,
> but in this case, the sata controller has been integrated into the soc
> by cutting the pci interface and connecting the sata core directly to
> the soc's bus. so I though that the "integrated" well show this fact.
> 
>> How about changing "INTEGRATED" to "SOC", and "integrated" to "soc" everywhere ?
>>
>> The mv_integrated_reset_hc_port() (or mv_soc_reset_hc_port()) function
>> seems to be a duplicate of the existing mv5_reset_hc_port() function.
> except the line that writes to the EDMA_CFG_OFS register (101f vs
> 11f). also , I think that in the future the the integrated/soc variant
> will have more register that does not exist in mv5 to reset.
..

The names are too long as-is.

> BTW, the mv5_sht and mv6_sht are identical, are there any plans to
> modify any or them?
..

Good idea.  Please send a separate patch for that one, thanks.

>> The new fields in the mv_host_priv struct are __iomem pointers
>> rather than offsets as was done for similar fields in the past
>> (offsets take up less space on 64-bit machines).
>> We should be consistent there, one way or the other.
> well, as those registers get access in the main flow (data commands),
> preparing the final address will save some runtime calculations. so,
> it's the speed vs memory tradeoff. I think speed should be preferred.
> agree?
..

Yes, speed is important.  Memory is considerably slower than CPUs,
so change them to offsets.

Cheers
