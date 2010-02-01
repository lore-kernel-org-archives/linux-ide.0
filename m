From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/68] ide2libata
Date: Mon, 1 Feb 2010 11:48:24 +0000
Message-ID: <20100201114824.29682015@lxorguk.ukuu.org.uk>
References: <20100129232540.41f6c4f6@lxorguk.ukuu.org.uk>
	<20100131.234726.124893364.davem@davemloft.net>
	<20100201110723.54870f7f@lxorguk.ukuu.org.uk>
	<20100201.031725.144446744.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38998 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750970Ab0BALrb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2010 06:47:31 -0500
In-Reply-To: <20100201.031725.144446744.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 01 Feb 2010 03:17:25 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date: Mon, 1 Feb 2010 11:07:23 +0000
> 
> > I'm amazed that you'd suggest trashing the current ATA stack to make the
> > maintenance of the old ones easier - which aren't supposed to be in flux
> > in the first place.
> 
> I'm not, I'm saying leave the ATA stack as it is, but make the IDE
> legacy layer such that PATA drivers can compile into it.

I don't see the use of that either. The work has sone use in figuring out
what the technical differences are between the old and new, and to review
differences to see why the exist and if they matter.

The only way around that would actually be remotely useful for doing odd
debug checks would be the ability to run the old stack drivers under
libata. Even then it would probably be far simpler to move differences
over one by one and test them so as to understand what is actually going
on and fix a bug.

The old drivers contain a fair amount of crap, magic and gueswork so a
good deal of human analysis and testing is needed to move any change
around and prove it's real and valid not guesswork and fudging.

Alan
