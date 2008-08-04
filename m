From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Mon, 4 Aug 2008 20:55:08 +0100
Message-ID: <20080804205508.20a3f917@lxorguk.ukuu.org.uk>
References: <fa.OGeO7gZvBG4obEzRbVltjSebgTQ@ifi.uio.no>
	<fa.KtvYE2B2yrJqUleolhtMPN9ljAQ@ifi.uio.no>
	<fa.AqEKTvguYFAzDFHy/We/8MpOqmo@ifi.uio.no>
	<48976168.3020804@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57820 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755000AbYHDUM1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 16:12:27 -0400
In-Reply-To: <48976168.3020804@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

> I was looking into the 32-bit PIO issue a bit yesterday. It looks like 
> some of the VLB libata drivers are doing this internally already, so it 
> shouldn't be hard to do this in the core. Only question is how we know 
> generically if the controller can do it or not? It looks like in old

You don't. Basically it is controller dependant. Pretty much all the
newer controllers support the 32bit PIO data cycles. Most PCI controllers
it makes no speed difference but host bus controllers (especially
PIIX/ICH) really benefit.

> supported. I couldn't track down where that bit was actually defined in 
> the first place, all the way back to ATA-1 it seems to be indicated as 
> reserved. Actually, I'm not sure why the drive cares in the first place, 
> it would seem like a pure host controller issue..

It goes back before IDE into the depths of the original compaq spec. When
you have a device wired basically directly to the ISA bus (original IDE)
it mattered. I don't believe it is relevant to any of the PCI controllers.

Alan
