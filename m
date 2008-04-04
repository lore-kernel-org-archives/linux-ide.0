From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 5/5] sata_mv remove mv_phy_reset and mv_postreset
Date: Fri, 04 Apr 2008 10:25:07 -0400
Message-ID: <47F63A43.1030300@rtr.ca>
References: <47F1736F.8020104@rtr.ca> <47F17592.8070002@rtr.ca> <47F5E078.6040703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3479 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860AbYDDOZJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 10:25:09 -0400
In-Reply-To: <47F5E078.6040703@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Remove the now unused mv_phy_reset() code,
>> as well as the unnecessary mv_postreset() function.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> ACK patches 4-5
> 
> However, I would prefer to finish merging Tejun's honkin' huge 
> modularize patchsets, and then request that you rediff&resend sata_mv 
> patches 4 and 5
> 
> Having already ack'd it, I'll push Tejun's resync as soon as I receive it.
..

Perfect!  Thanks, Jeff.

I have sata_mv PMP patches yet to come.
Plus fixes for the interrupt/error handling in sata_mv,
a side-effect of which is that hot plug should begin working.

Smaller errata fixes will follow, as I get to them.

Cheers
