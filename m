From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA_ARTOP reads byte from PCI IO port without mapping it to
 the right address.
Date: Wed, 30 Mar 2011 21:24:40 +0100
Message-ID: <20110330212440.794e85de@lxorguk.ukuu.org.uk>
References: <4D937FDC.4090607@danielpalmer.co.uk>
	<20110330202628.5dc8db5f@lxorguk.ukuu.org.uk>
	<4D93890A.60307@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38132 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932906Ab1C3UYH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2011 16:24:07 -0400
In-Reply-To: <4D93890A.60307@danielpalmer.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Palmer <me@danielpalmer.co.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 30 Mar 2011 20:48:26 +0100
Daniel Palmer <me@danielpalmer.co.uk> wrote:

> 
> >  That is the PCI port address.
> 
> I don't pretend to understand most of this fully.
> On the board the PCI address space/PCI controller is apparently at 
> 0xfe240000
> So I guess that when that byte is read it should read from 0xfe240000 + 
> 0x1400?
> That doesn't happen and a read happens at 0x1400 and an oops results.
> I don't know enough to point the finger really.
> 
> There are probably only 2 people using this board still too. So I doubt 
> it really matters. :)

That sounds like the inb() function has been broken by a change perhaps
by some related board change - if your I/O is mapped as you describe I'd
expect inb() to be implemented as something like


	return *(volatile u8 *)(0xfe2400 + addr)

Might be worth bisecting between a good and bad release as it ought to be
easy to find

Alan
