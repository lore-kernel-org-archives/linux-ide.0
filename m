From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 15:43:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281531550.4244@woody.osdl.org>
References: <456CB72A.3010004@local.se> <Pine.LNX.4.64.0611281444330.4244@woody.osdl.org>
 <456CC4C5.6090003@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:6859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756906AbWK1Xn1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 18:43:27 -0500
In-Reply-To: <456CC4C5.6090003@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jonas Lundgren <jonas@local.se>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Tue, 28 Nov 2006, Jeff Garzik wrote:
> 
> I was sorta wondering in that direction too.  If its in legacy mode (PATA and
> SATA smushed together), that's a possibility.  But native or AHCI modes, the
> channels are pretty independent (which is the nature of SATA).

Well, what I was more wondering about is whether perhaps the legacy mode 
emulation - even when it isn't actually used - means that there is simply 
some shared state (read: chipset bug that nobody noticed).

> Historical note:  ata_piix is IMO more complicated than ahci, because the
> silicon is emulating the PATA interface using an internal (probably huge)
> state machine, converting PATA behavior to sending/receiving SATA packets.

Well, there's bound to be the same big state machine working the other 
way, and maybe the chip simply internally gets confused. Or, as you say, 
simply because the emulation state machinery has to be taken into account, 
and _that_ ends up beign shared between the two otherwise independent 
channels..

How hard would it be to just force a shared spinlock between two sata 
channels on the same "controller"? It sounds like Jonas has a very 
repeatable setup, so even if I can't repeat my problem, if the performance 
degradation on writes is related, he can check his thing..

		Linus
