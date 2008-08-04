From: Mark Lord <liml@rtr.ca>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Mon, 04 Aug 2008 18:12:51 -0400
Message-ID: <48977EE3.8050806@rtr.ca>
References: <fa.OGeO7gZvBG4obEzRbVltjSebgTQ@ifi.uio.no>	<fa.KtvYE2B2yrJqUleolhtMPN9ljAQ@ifi.uio.no>	<fa.AqEKTvguYFAzDFHy/We/8MpOqmo@ifi.uio.no>	<48976168.3020804@shaw.ca> <20080804205508.20a3f917@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1447 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbYHDWMx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 18:12:53 -0400
In-Reply-To: <20080804205508.20a3f917@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockr@shaw.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Alan Cox wrote:
> You don't. Basically it is controller dependant. Pretty much all the
> newer controllers support the 32bit PIO data cycles. Most PCI controllers
> it makes no speed difference but host bus controllers (especially
> PIIX/ICH) really benefit.
..

By "most PCI controllers", did you really mean "most add-on PCI (card) controllers"?

Nearly all onboard "PCI" controllers (integrated into the host chipset) benefit hugely,
but I suppose that is what was meant by "host bus controllers".

Cheers

