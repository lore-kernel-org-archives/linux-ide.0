From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_mv 7042 support and port multipliers
Date: Mon, 06 Nov 2006 01:22:24 -0500
Message-ID: <454ED4A0.2090408@pobox.com>
References: <20061106043114.GO15897@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37101 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932640AbWKFGW2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Nov 2006 01:22:28 -0500
In-Reply-To: <20061106043114.GO15897@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Robin H. Johnson wrote:
> Hi,
> 
> I recently picked up a new eSATA controller
> (http://www.sonnettech.com/product/tempo_sata_e4p.html), along with a
> port-multiplier enclosure (Fusion 500P from the same company) and a
> bunch of disks, since I was running out of space.
> 
> I added this to the table mv_pci_tbl[]:
> { PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
> 
> However, I see it doesn't quite work. 7042 support doesn't seem to have
> been touched or even mentioned since Jeff posted the 6042 changes in
> January.
> 
> The card reports as revision 2, which is not in the code either.
> 
> I've got the hardware, so I'm willing to do heavy lifting of code (NCQ,
> Hotplug, PMP) if it hasn't been done yet, if somebody point me to some
> docs on the matter.  I've seen the mvSata-3.6.1 driver, and it appears
> to have most of the stuff on revision 1, but nothing on hardware
> revision 2 either.
> 
> Jeff: you mentioned back in September about Marvell being a bit more
> generous with docs? Were 7042 docs amongst them or do I have to slog
> through the messy mvSata driver to find everything?


That's what I had to do.  I have the docs, which cover the programming 
interface, but it doesn't cover a lot of the associated errata.  I had 
to dig that out of the mvSata driver myself.

I had thought that Mark Lord was working on improving sata_mv, but 
outside of a locking bugfixes, I haven't seen anything since mid-May.

So I guess sata_mv is in limbo again...

	Jeff



