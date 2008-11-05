From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Wed, 05 Nov 2008 23:08:42 +0900
Message-ID: <4911A8EA.8030605@kernel.org>
References: <871vxrzssj.fsf@denkblock.local> <491026AB.1090704@kernel.org>	<20081104123211.A86321FD5A@chi.die-welt.net> <49108120.6000205@rtr.ca>	<491083CC.5050508@rtr.ca> <49108AA0.1080507@rtr.ca>	<491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net>	<4910A509.1030307@rtr.ca> <49116811.5000109@kernel.org> <873ai6cmio.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33048 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbYKEOJG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2008 09:09:06 -0500
In-Reply-To: <873ai6cmio.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Mark Lord <liml@rtr.ca>, Evgeni Golov <sargentd@die-welt.net>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Elias Oltmanns wrote:
>> -	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
>> +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> 
> After my embarrassing failure to parse a macro correctly a few days
> back, I've got to be careful ;-). But still, what good does that patch
> do? It doesn't really change anything, does it?

Hehheh, I suppose it's my turn for embarrassment.

> As a wild guess, I'm wondering whether ata_eh_revalidate_and_attach()
> has anything to do with it. Unless you have a better suggestion, perhaps
> the following debug patch would give some useful information.

I don't have much idea at this point.  To the drive, it shouldn't look
any different.  Ah... it's ata_piix, right?  ata_piix doesn't have PHY
event IRQ, so it could be that the command issued by hdparm did trigger
PHY event but didn't get noticed by EH while the condition triggered by
IDLE IMMEDIATE did.  One way to find out would be adding SCR print outs
on command completion.

Thanks.

-- 
tejun
