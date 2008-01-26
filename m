From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 13/14] sata_mv No soft resets
Date: Sat, 26 Jan 2008 10:21:55 -0500
Message-ID: <479B5013.10500@rtr.ca>
References: <4798FB68.70400@rtr.ca> <4798FD3F.2050807@rtr.ca> <479AB6DE.1020304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4436 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYAZPV4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 10:21:56 -0500
In-Reply-To: <479AB6DE.1020304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> sata_mv No soft resets.
>>
>> Soft resets rarely have significant effect with these chips,
>> so always do a hard reset instead.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>> --- old/drivers/ata/sata_mv.c    2008-01-24 14:49:28.000000000 -0500
>> +++ new/drivers/ata/sata_mv.c    2008-01-24 14:51:53.000000000 -0500
>> @@ -2414,8 +2414,7 @@
>>
>> static void mv_error_handler(struct ata_port *ap)
>> {
>> -    ata_do_eh(ap, mv_prereset, ata_std_softreset,
>> -          mv_hardreset, mv_postreset);
>> +    ata_do_eh(ap, mv_prereset, NULL, mv_hardreset, mv_postreset);
>> }
> 
> Can you give a bit more explanation?
..

When I hit the existing EH, the system locks up.

When I remove the ata_std_softreset from that line,
it no longer locks up.

It still does have other issues, though, so you could drop
that patch for now, and I'll reissue it when I get round to
fixing that particularly horribly broken part of the driver later.

Cheers
