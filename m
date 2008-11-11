From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Tue, 11 Nov 2008 11:59:10 +0000
Message-ID: <20081111115910.54d86403@lxorguk.ukuu.org.uk>
References: <200811061144.35556.marc.pignat@hevs.ch>
	<49193C0F.5000908@garzik.org>
	<20081111084053.GA12965@isilmar.linta.de>
	<491945D9.2080201@garzik.org>
	<20081111112243.GA6271@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59354 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754895AbYKKL7T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 06:59:19 -0500
In-Reply-To: <20081111112243.GA6271@comet.dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Jeff Garzik <jeff@garzik.org>, Marc Pignat <marc.pignat@hevs.ch>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Tue, 11 Nov 2008 12:22:43 +0100
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Jeff,
> 
> On Tue, Nov 11, 2008 at 03:44:09AM -0500, Jeff Garzik wrote:
> > It is not normal practice to merge add-device-id patches through 
> > bus-specific trees.  We do not do such things with PCI IDs, for example.
> 
> Well, it's been normal practice for pcmcia IDs.

Not for ide or ATA in the past few years.

Alan
