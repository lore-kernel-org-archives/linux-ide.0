From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/68] ide2libata
Date: Mon, 1 Feb 2010 11:07:23 +0000
Message-ID: <20100201110723.54870f7f@lxorguk.ukuu.org.uk>
References: <20100129160308.21495.14120.sendpatchset@localhost>
	<4B6355DF.9050001@garzik.org>
	<20100129232540.41f6c4f6@lxorguk.ukuu.org.uk>
	<20100131.234726.124893364.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42507 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095Ab0BALGe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2010 06:06:34 -0500
In-Reply-To: <20100131.234726.124893364.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> The cost and risk is testing the morphing changes, but I think the
> scales tip towards making this truly worth it.

The cost and risk is taking two stable and quite maintainable stacks and
turning them into one unmaintainable broken one..

I'm a little surprised that the old IDE layer which was supposed to be
maintenance only is getting this treatment - except for the research
value of seeing what the differences are in the drivers.

I'm amazed that you'd suggest trashing the current ATA stack to make the
maintenance of the old ones easier - which aren't supposed to be in flux
in the first place.

Alan


