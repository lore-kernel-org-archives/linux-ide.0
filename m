From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/7] libata: Add 32bit PIO support
Date: Sat, 6 Dec 2008 00:25:48 +0000
Message-ID: <20081206002548.3ad6b632@lxorguk.ukuu.org.uk>
References: <20081205194231.17133.42760.stgit@localhost.localdomain>
	<20081205194355.17133.23019.stgit@localhost.localdomain>
	<87ej0mnzrg.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52564 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755122AbYLFAZo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2008 19:25:44 -0500
In-Reply-To: <87ej0mnzrg.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

> > +			pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
> > +			memcpy(buf + buflen - slop, &pad, slop);
> > +		} else {
> > +			memcpy(&pad, buf + buflen - slop, slop);
> > +			iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
> 
> Shouldn't the rest of pad be initialised to zero or something before it
> is written?

It really doesn't matter but I suppose it wouldn't do any harm not to
expose 3 random bytes of stack to the io bus.

Alan

