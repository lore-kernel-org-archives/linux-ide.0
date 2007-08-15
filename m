From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Still having problems with sata_promise on all late kernels
Date: Wed, 15 Aug 2007 20:36:37 +0400
Message-ID: <46C32B95.4030604@wasp.net.au>
References: <200708151539.l7FFdHic010433@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:47449 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765821AbXHOQgo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 12:36:44 -0400
In-Reply-To: <200708151539.l7FFdHic010433@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:

> The box was described as a KT600 chipset era machine
> with 3 Promise SATA150TX4 cards, a SIL3112 card, and
> an on-board VIA controller. According to the `lspci'
> posted the box probably also has an AGP card and at
> least one gigaether card (there's two, I guess one might
> be built-in).

One PCI and one on-board. Otherwise quite an accurate assessment.

> All in all, a rather heavily loaded (in terms of power,
> cooling, and the PCI bus) box (for a desktop chipset).

Yes, cooling is not an issue. The motherboard reports 28-29C, the processor is 32-34C and the drives 
all report between 32-38C. The machine has an excessive number of fans in it and the drives live in 
Supermicro hotswap bays with 90mm high speed noise makers strapped to the back. The machines live in 
a separate air conditioned and UPS'd environment which is regulated at 20C. I've put a thermocouple 
in the machine and I never see temperatures on any of the hardware exceeding 40C (Graphics card 
heatsink)

The PSU is a 4 x 12v rail Thermaltake 600W jobbie with the 12v rails re-wired to feed mainly the 
drives (as one 18A rail would not do 15 drives all spinning up together). The PSU is now identical 
to the one fitted to its sister box. I've measured the voltages all within tolerance and the fully 
loaded ripple is less than 50mv on +5 and all +12 rails. That looks pretty good to me.

This is the second PSU the box has seen as I just upgraded it from the old 420W that was in there.

I have tried splitting the drives over 2 PSU's (several different combinations of drives and PSU's) 
and the problem still exists.

> I've never seen the SATA150-generation cards misbehave,
> so at this point I have to assume that it's a system
> limit issue, be it PCI, power, or cooling.

It may well be a PCI bus issue however it's sister box which is exactly the same mainboard has 15 
drives on 4 SATA150 cards and it has never had such a problem. It just locks up on shutdown :)

I will note that this machine has run (except for the lower wattage PSU) in this configuration since 
about 2.6.9 and sat perfectly happy with 2.6.16 until I needed to upgrade for some reason around 
2.6.21-rc (which is when the bus errors started).

I'll try some more conservative PCI settings in the BIOS and see what happens.

Thanks for the pointers anyway.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
