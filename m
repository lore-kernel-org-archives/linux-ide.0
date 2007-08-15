From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Still having problems with sata_promise on all late kernels
Date: Wed, 15 Aug 2007 17:39:17 +0200 (MEST)
Message-ID: <200708151539.l7FFdHic010433@alkaid.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:44068 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779AbXHOPj1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 11:39:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brad@wasp.net.au, htejun@gmail.com
Cc: linux-ide@vger.kernel.org, mikpe@it.uu.se

On Wed, 15 Aug 2007 16:54:52 +0900, Tejun Heo wrote:
>Brad Campbell wrote:
>> Tejun Heo wrote:
>> 
>>> ATA bus error is a strong indicator for hardware problem.  Please get a
>>> separate power supply (doesn't have to be an expensive one), power it up
>>> [1], and connect some of the drives to the power supply and see whether
>>> errors persist on those drives.
>>>
>> 
>> 2 separate tests with the 2 troublesome drives, each time with both
>> drives on a different power supply unit. Also tried new cables from a
>> different manufacturer.
>> 
>> It ain't the cables and it ain't the power.
>
>I see.  Thanks.  I'm pretty much out of ideas at this point.  Mikael?

The box was described as a KT600 chipset era machine
with 3 Promise SATA150TX4 cards, a SIL3112 card, and
an on-board VIA controller. According to the `lspci'
posted the box probably also has an AGP card and at
least one gigaether card (there's two, I guess one might
be built-in).

All in all, a rather heavily loaded (in terms of power,
cooling, and the PCI bus) box (for a desktop chipset).

I've never seen the SATA150-generation cards misbehave,
so at this point I have to assume that it's a system
limit issue, be it PCI, power, or cooling.

/Mikael
