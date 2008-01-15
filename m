From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: Keeps saying SATA link down (SStatus 0 SControl
	0)
Date: Tue, 15 Jan 2008 10:28:06 +0100
Message-ID: <18316.31910.973794.732242@harpo.it.uu.se>
References: <20080113234320.GA6225@roeckx.be>
	<18315.7567.747367.84127@harpo.it.uu.se>
	<20080115000953.GA2799@roeckx.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:49558 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbYAOJ2M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jan 2008 04:28:12 -0500
In-Reply-To: <20080115000953.GA2799@roeckx.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kurt Roeckx <kurt@roeckx.be>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Kurt Roeckx writes:
 > On Mon, Jan 14, 2008 at 09:30:07AM +0100, Mikael Pettersson wrote:
 > > 
 > > The chip repeatedly signals plug and unplug events on its second
 > > ATA port. This is not a common error.
 > > 
 > > I need a lot more information to debug this:
 > > - the output of /sbin/lspci
 > 
 > 00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
 > 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
 > 00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)
...
 > 00:08.0 0104: 105a:3376 (rev 02)

Let me guess, this is a Promise chip included on the mainboard
as a RAID controller, and not an add-on PCI card?

If it's a mainboard chip, please enter the BIOS and see if it
can be configured for non-RAID mode. If it can, please reconfigure
it and boot Linux. Does it still claim to be a 20376 or is it
now a 20378?

FWIW, my News server uses its mainboard's 20378 chip, and it
works beautifully with the latest kernels.

Unfortunately, the 20376, being a "FastTrak", is very poorly
documented in publicly available documents and driver sources.

I'll dig around for more info on the 20376. If I can't find
anything useful, then I'm afraid the only option is to add a
quirk to forcibly disable hotplugging on the 20376 as it
apparently doesn't work.

/Mikael
