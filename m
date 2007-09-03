From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: port is slow to respond, reset failed
Date: Mon, 3 Sep 2007 10:11:12 +0200 (MEST)
Message-ID: <200709030811.l838BC9a026315@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:35550 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbXICILR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Sep 2007 04:11:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@how.dk, linux-ide@vger.kernel.org, mikpe@it.uu.se

On Mon, 03 Sep 2007 01:04:08 +0200, Peter Favrholdt wrote:
> Hi Mikael Pettersson wrote:
> > I'm easily able to reproduce this problem on my sata_promise test rig.
> > Using 2.6.23-rc5 to dd read a single Seagate disk on a SATA300 TX4 card
> > quickly fails as Peter described.
> > 
> > Applying the 1.5Gbps patch to the driver appears to make things stable.
> > 
> > Those SATAII chips really don't seem to like 3Gbps mode. Or else we're
> > missing some critical documentation on how to make them work.
> 
> The funny thing is: I have the exact same adapter and disks in a Dell 
> PE1800 server. This doesn't show any errors.
> 
> Only difference is the card is in a PCI-X slot and the server is running
> Linux 2.6.19.5.

I assume the PE1800 has some Intel chipset? Which one?
And the machine that does have problems, what chipset does it have?

I'm actually beginning to think there's some PCI compatibility breakage
somewhere, as I too see sata_promise working fine in some machines but
not in others. Alas, my knowledge of PCI tweakables is close to nil.

/Mikael
