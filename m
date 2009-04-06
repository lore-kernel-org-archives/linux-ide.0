From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 06/07] sata_mv: cosmetic renames
Date: Mon, 06 Apr 2009 16:12:01 -0400
Message-ID: <49DA6211.203@rtr.ca>
References: <49DA2DFD.4010402@rtr.ca> <49DA2E33.4050704@rtr.ca> <49DA2E76.7000800@rtr.ca> <49DA566D.9040501@rtr.ca> <49DA56DE.3000200@rtr.ca> <49DA5709.7060005@rtr.ca> <49DA5733.3050206@rtr.ca> <49DA5D30.4000704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:45442 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594AbZDFUME (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 16:12:04 -0400
In-Reply-To: <49DA5D30.4000704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Add _OFS suffix to more of the register offset names,
>> for consistency with the rest of the driver.
>>
>> Also tag the defines for LTMODE and PHY_MODE4 to note
>> that read-after-write is necessary when updating those regs.
>>
>> No code changes here.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>> --- old/drivers/ata/sata_mv.c    2009-04-06 14:20:53.000000000 -0400
>> +++ new/drivers/ata/sata_mv.c    2009-04-06 15:00:16.000000000 -0400
>> @@ -272,17 +272,17 @@
>>     SATA_FIS_IRQ_CAUSE_OFS    = 0x364,
>>     SATA_FIS_IRQ_AN        = (1 << 9),    /* async notification */
>>
>> -    LTMODE_OFS        = 0x30c,
>> +    LTMODE_OFS        = 0x30c,    /* requires read-after-write */
>>     LTMODE_BIT8        = (1 << 8),    /* unknown, but necessary */
>>
>> -    PHY_MODE3        = 0x310,
>> -    PHY_MODE4        = 0x314,
>> +    PHY_MODE2_OFS        = 0x330,
>> +    PHY_MODE3_OFS        = 0x310,
>> +    PHY_MODE4_OFS        = 0x314,    /* requires read-after-write */
>>     PHY_MODE4_CFG_MASK    = 0x00000003,    /* phy internal config 
>> field */
>>     PHY_MODE4_CFG_VALUE    = 0x00000001,    /* phy internal config 
>> field */
>>     PHY_MODE4_RSVD_ZEROS    = 0x5de3fffa,    /* Gen2e always write 
>> zeros */
>>     PHY_MODE4_RSVD_ONES    = 0x00000005,    /* Gen2e always write ones */
> 
> _OFS suffix is redundant, and not often used in other Linux drivers.
..

Yeah, I agree it's kinda fugly, too.
But that's what was there from the earlier maintainers
(Brett and yourself, I guess), so for now I'm just keeping it consistent.

I might now try patch 08 follow-up to rename all of that stuff,
if you're happy with the series thus far.  Plan is to drop the _OFS stuff,
and also make a bunch of the register prefixes more consistent as well.

Currenly, some regs use MV_ whereas others don't, and some have SATA_
at the start but related registers don't.

Any preferences there?  It's all the same to me.

Cheers
