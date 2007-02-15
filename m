From: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Thu, 15 Feb 2007 11:41:49 +0100
Message-ID: <200702151141.49708.jens@de.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp> <45D3EAA7.80805@garzik.org> <1171525923.20192.243.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:17622 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965827AbXBOKlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Feb 2007 05:41:50 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1FAfn1E029374
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 10:41:49 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1FAfmqC1749244
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 11:41:48 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1FAflxY015215
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 11:41:48 +0100
In-Reply-To: <1171525923.20192.243.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, arnd@arndb.de, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, alan@lxorguk.ukuu.org.uk, linas@austin.ibm.com, James K Lewis <jim@jklewis.com>

On Thursday 15 February 2007, Benjamin Herrenschmidt wrote:
> 
> > I'm totally confused about who the heck is the spidernet maintainer.
> 
> Me too :-)
> 
> > My 
> > inbox is pelted by spidernet driver updates from multiple people, and 
> > often the spidernet patches (regardless of author) receive comments that 
> > give me pause.  The MAINTAINERS file says
> > 
> > > SPIDERNET NETWORK DRIVER for CELL
> > > P:      Jim Lewis
> > > M:      jim@jklewis.com
> > > L:      netdev@vger.kernel.org
> > > S:      Supported
> > 
> > but I do not see patch roll-ups or much activity from him at all.  In 
> > practice, it seems like Linas does patchsets for spidernet, but there is 
> > also Jakob Osterkemp(sp?) and Ishizaki and....
> 
> I think Jens Osterkampf should be the final ACK/NAK'er as he has all the
> hardware to test except the Toshiba gear :-) In fact, Jens, if you are
> ok with that, I'd like to have you be the maintainer of that driver,
> unless you think it's better for Linas to do it.
> 
> > My overall impression of spidernet development is that EVERYBODY is 
> > submitting patches at once, and expecting me to sort out the mess.  No 
> > thanks.
> 
> It's been a bit of a mess. I suggest we get our gear together (Linas,
> Jens, Kou) and provide you a single patch set from a single source in
> the upcoming couple of days coming from the designated maintainer.
> 
> Jens ? Linas ? Is that ok with you guys ? Who gets to be that
> maintainer ?
> 
> _ALSO_ since spidernet uses (and modifies) sungem_phy.c, we need either
> DaveM or my ack there (DaveM is sungem maintainer but I wrote sungem_phy
> and most of it is only used on powermacs).
> 
> Thus let's move that back to the cbe-oss-dev mailing list, our
> designated maintainer will post there a candidate patch set, I will
> verify the sungem_phy change is ok with powermac (I myself haven't
> followed enough to figure out what patch is the latest there), we'll all
> test on our respective hardware, and then that maintainer will send you
> one patch set to apply.
> 
> That shouldn't take more than a few days. If we miss -rc1, well, then it
> will be in -rc2, as most of the patches have been around for long enough
> etc... it's really mostly a matter of getting our gear together.
> 
> > Speaking with one voice would be much appreciated.  And said speaker 
> > should patch the MAINTAINERS file to reflect reality.

Sounds reasonable. I fully agree.

Linas has done a pretty good job on improving the driver in the last half
year or so and he also has access to all the necessary hardware so I think
he would be the right person for the job.

Jens
