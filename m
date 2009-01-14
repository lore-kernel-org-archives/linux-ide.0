From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Wed, 14 Jan 2009 15:14:09 +0000
Message-ID: <20090114151409.383e76a1@lxorguk.ukuu.org.uk>
References: <200901141345.42583.stf_xl@wp.pl>
	<20090114131727.5b0e5193@lxorguk.ukuu.org.uk>
	<200901141535.13189.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36335 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755355AbZANPOH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 10:14:07 -0500
In-Reply-To: <200901141535.13189.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

> > I see nothing guaranteeing atomicity here and I suspect you either need
> > locks or (for single processor only) some carefully arranged scheme to
> > 'stack' the 8/16bit select status.
> I thought ide_port callbacks are serialized by IDE layer. I will use locks, I think.

So all your accesses are within the various IDE locks so you never
taken an interrupt or timer at the wrong moment. Ok - that should be
documented though.

Alan
