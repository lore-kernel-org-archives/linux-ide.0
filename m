From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_legacy: Restructure and revamp
Date: Wed, 12 Dec 2007 16:00:04 +0000
Message-ID: <20071212160004.57735b9c@the-village.bc.nu>
References: <20071208155506.77642115@the-village.bc.nu>
	<20071211212326.0223589c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35880 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751848AbXLLQGL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 11:06:11 -0500
In-Reply-To: <20071211212326.0223589c.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> Is this patch going to screw my kernel up?

I hope not. I've been testing it both on systems with PCI bus and with
just ISA/VLB. I've also done all=1 testing on various PCI systems which
then correctly work with legacy IDE although performance of course sucks
rocks.

On most boxes the code path executed is

	have we got PCI ata
	yes
	exit

> 
> > +static __init void probe_opti_vlb(void)
> > +{
> > +	/* If an OPTI 82C46X is present find out where the channels are */
> > +	static const char *optis[4] = {
> > +		"3/463MV", "5MV",
> > +		"5MVA", "5MVB"
> > +	};
> > +	u8 chans = 1;
> > +	u8 ctrl = (opti_syscfg(0x30) & 0xC0) >> 6;
> > +
> > +	opti82c46x = 3;	/* Assume master and slave first */
> > +	printk(KERN_INFO DRV_NAME ": Opti 82C46%s chipset support.\n",
> > +								optis[ctrl]);
> > +	if (ctrl == 3)
> > +		chans = (opti_syscfg(0x3F) & 0x20) ? 2 : 1;
> 
> this could be
> 
> 	if (ctrl == 3 && (opti_syscfg(0x3F) & 0x20))
> 		chans = 2;
> 
> if that's any clearer...

Agreed - that is clearer.

Alan
