From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Mon, 4 Aug 2008 23:00:11 +0100
Message-ID: <20080804230011.1640f011@lxorguk.ukuu.org.uk>
References: <fa.OGeO7gZvBG4obEzRbVltjSebgTQ@ifi.uio.no>
	<fa.KtvYE2B2yrJqUleolhtMPN9ljAQ@ifi.uio.no>
	<fa.AqEKTvguYFAzDFHy/We/8MpOqmo@ifi.uio.no>
	<48976168.3020804@shaw.ca>
	<20080804205508.20a3f917@lxorguk.ukuu.org.uk>
	<48977EE3.8050806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33698 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751147AbYHDWR3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 18:17:29 -0400
In-Reply-To: <48977EE3.8050806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Robert Hancock <hancockr@shaw.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Mon, 04 Aug 2008 18:12:51 -0400
Mark Lord <liml@rtr.ca> wrote:

> Alan Cox wrote:
> > You don't. Basically it is controller dependant. Pretty much all the
> > newer controllers support the 32bit PIO data cycles. Most PCI controllers
> > it makes no speed difference but host bus controllers (especially
> > PIIX/ICH) really benefit.
> ..
> 
> By "most PCI controllers", did you really mean "most add-on PCI (card) controllers"?

Yes

> Nearly all onboard "PCI" controllers (integrated into the host chipset) benefit hugely,
> but I suppose that is what was meant by "host bus controllers".

Yes
