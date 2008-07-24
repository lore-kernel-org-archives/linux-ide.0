From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Thu, 24 Jul 2008 15:05:02 +0100
Message-ID: <20080724150502.503c6f9f@lxorguk.ukuu.org.uk>
References: <20080723144227.253944199@fluff.org>
	<20080723163216.7477be06@lxorguk.ukuu.org.uk>
	<20080723190433.GB26938@trinity.fluff.org>
	<20080723201349.33226d58@lxorguk.ukuu.org.uk>
	<20080724112637.GG26938@trinity.fluff.org>
	<20080724121328.5d281b97@lxorguk.ukuu.org.uk>
	<20080724115042.GK26938@trinity.fluff.org>
	<20080724125922.744923d7@lxorguk.ukuu.org.uk>
	<20080724135002.GL26938@trinity.fluff.org>
	<20080724145215.496d3ed4@lxorguk.ukuu.org.uk>
	<20080724141710.GN26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34639 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751816AbYGXOWS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 10:22:18 -0400
In-Reply-To: <20080724141710.GN26938@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

> So just because we fit a chip, we're suddenyly a special case? Moving
> to libata has ignored the code in the old IDE driver which ensures that
> the IRQ driver is used. I have no idea how many other systems have this
> same problems, but the systems we've shipped have had this chip setup
> for nearly 10 years now.

Yes and it happened to work by luck. Now it doesn't, instead standards
compliant systems work better.

> I admit the original fix is wrong, the change should be handled by some
> form of callback or a method of passing the interrupt numbers in when
> registering with the libata-sff.c driver.

Why do you want to hack up the libata driver code ? You've said yourself
you have put the chip into native mode yet are using the legacy
interrupts. Thats misconfiguration and you can undo that by configuring
the chip right in the first place - as per the BIOS guide.
