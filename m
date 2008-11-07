From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Fri, 07 Nov 2008 13:08:29 +0900
Message-ID: <4913BF3D.3090704@kernel.org>
References: <871vxrzssj.fsf@denkblock.local> <491026AB.1090704@kernel.org>	<20081104123211.A86321FD5A@chi.die-welt.net> <49108120.6000205@rtr.ca>	<491083CC.5050508@rtr.ca> <49108AA0.1080507@rtr.ca>	<491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net>	<4910A509.1030307@rtr.ca> <49116811.5000109@kernel.org>	<873ai6cmio.fsf@denkblock.local> <4911A8EA.8030605@kernel.org> <87k5bhxerq.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39602 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbYKGEI5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Nov 2008 23:08:57 -0500
In-Reply-To: <87k5bhxerq.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Mark Lord <liml@rtr.ca>, Evgeni Golov <sargentd@die-welt.net>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Elias Oltmanns wrote:
> Tejun Heo <tj@kernel.org> wrote:
>> Elias Oltmanns wrote:
> [...]
>>> As a wild guess, I'm wondering whether ata_eh_revalidate_and_attach()
>>> has anything to do with it. Unless you have a better suggestion, perhaps
>>> the following debug patch would give some useful information.
>> I don't have much idea at this point.  To the drive, it shouldn't look
>> any different.  Ah... it's ata_piix, right?  ata_piix doesn't have PHY
>> event IRQ, so it could be that the command issued by hdparm did trigger
>> PHY event but didn't get noticed by EH while the condition triggered by
>> IDLE IMMEDIATE did.  One way to find out would be adding SCR print outs
>> on command completion.
> 
> Actually, event notification is turned off during error recovery for
> ahci as well.

Yeap, but SError is checked and cleared after event notification is
turned back on, so events shouldn't leak.

> Additionally, we have the following in the interrupt
> handler of ahci.c:
> 
> 	/* If we are getting PhyRdy, this is
>  	 * just a power state change, we should
>  	 * clear out this, plus the PhyRdy/Comm
>  	 * Wake bits from Serror
>  	 */
> 	if ((hpriv->flags & AHCI_HFLAG_NO_HOTPLUG) &&
> 		(status & PORT_IRQ_PHYRDY)) {
> 		status &= ~PORT_IRQ_PHYRDY;
> 		ahci_scr_write(&ap->link, SCR_ERROR, ((1 << 16) | (1 << 18)));
> 	}
> 
> This suggests to me that hdparm --idle-unload does indeed trigger a phy
> event, but the interrupt handler clears SError. Issuing the unload
> command in EH, on the other hand, does not result in a phy event because
> event notification is disabled. That way, phyrdy and commwake don't get
> cleared in SError in will indicate a hotplug event next time SError is
> checked. Does that make sense? If so, what's to be done about it?

Hmmm... if ALPM is enabled, it could explain all.  Enabling ALPM does
inhibit event notifications but it doesn't prevent autopsy from
interpreting SError as if ALPM is not enabled.

Evgeni, is ALPM enabled?

Thanks.

-- 
tejun
