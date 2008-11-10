From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with	unload
Date: Mon, 10 Nov 2008 18:00:18 +0900
Message-ID: <4917F822.5060204@kernel.org>
References: <491083CC.5050508@rtr.ca> <49108AA0.1080507@rtr.ca> <491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net> <4910A509.1030307@rtr.ca> <49116811.5000109@kernel.org> <873ai6cmio.fsf@denkblock.local> <4911A8EA.8030605@kernel.org> <87k5bhxerq.fsf@denkblock.local> <4913BF3D.3090704@kernel.org> <20081107074857.GA6461@dragonheart.kerker.die-welt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55955 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbYKJJAn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 04:00:43 -0500
In-Reply-To: <20081107074857.GA6461@dragonheart.kerker.die-welt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: Elias Oltmanns <eo@nebensachen.de>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Evgeni Golov wrote:
> On Fri, Nov 07, 2008 at 01:08:29PM +0900, Tejun Heo wrote:
>>> This suggests to me that hdparm --idle-unload does indeed trigger a phy
>>> event, but the interrupt handler clears SError. Issuing the unload
>>> command in EH, on the other hand, does not result in a phy event because
>>> event notification is disabled. That way, phyrdy and commwake don't get
>>> cleared in SError in will indicate a hotplug event next time SError is
>>> checked. Does that make sense? If so, what's to be done about it?
>> Hmmm... if ALPM is enabled, it could explain all.  Enabling ALPM does
>> inhibit event notifications but it doesn't prevent autopsy from
>> interpreting SError as if ALPM is not enabled.
>>
>> Evgeni, is ALPM enabled?
> 
> You mean Aggressive Link Power Management? As patches from here:
> http://www.kernel.org/pub/linux/kernel/people/kristen/patches/SATA/alpm/
> ?
> Unless they got merged into 2.6.27 and autoenabled, no, I dont use ALPM :)

Heh... I'm fresh out of ideas.  Somehow SError is being set on the
initial EH head unload.  In general, what EH is doing is harmless in
itself but EH reset can delay head unloading defeating the purpose of
unloading.

Is the phy event before or after head unloading?

Thanks.

-- 
tejun
