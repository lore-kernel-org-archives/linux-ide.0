From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sata_nv + ADMA + Samsung disk problem
Date: Fri, 04 Jan 2008 16:51:38 +1100
Message-ID: <1199425898.7291.30.camel@pasglop>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu>
	 <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com>
	 <477B0CFD.1030603@shaw.ca>
	 <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com>
	 <477BDEA5.8040701@garzik.org>
	 <F72FA20C31DD4F4C997B91C5B3690A0950557D@hqemmail07.nvidia.com>
	 <477C2A99.9010208@shaw.ca> <477C61D3.30009@rtr.ca>
	 <477C6A85.9020607@shaw.ca> <477D02E0.5040301@rtr.ca>
	 <477D039F.6000206@rtr.ca> <1199394786.7291.21.camel@pasglop>
	 <477D8F4B.6000601@shaw.ca>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56232 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbYADFw0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jan 2008 00:52:26 -0500
In-Reply-To: <477D8F4B.6000601@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Allen Martin <AMartin@nvidia.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>


On Thu, 2008-01-03 at 19:43 -0600, Robert Hancock wrote:
> Benjamin Herrenschmidt wrote:
> >> Another thing about the PacDigi core:  one has to be very careful
> >> to avoid sequential accesses to sequential PCI locations when
> >> programming the chip -- it cannot handle merged register writes.
> >>
> >> So for any group of sequentially laid out registers, the code has
> >> to ensure it never writes two adjacent registers in sequence..
> > 
> > Ugh ? Write combining isn't permitted on normal registers afaik...
> > 
> > Ben.
> 
> Byte merging can be done by the chipset on MMIO writes (merging multiple 
> 8 or 16-bit writes into a single 32-bit cycle).

That is true, if they are consecutive. You mean that this HW is f*cked
up enough to actually have separate 8/16 bits registers that are
contiguous ? Yuck... I'm afraid you -have- to add reads in between to
guarantee that no merging will occur.

Cheers,

Ben.


