From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/02] sata_mv: workaround for multi_count errata sata24
Date: Mon, 13 Apr 2009 16:40:34 +0100
Message-ID: <20090413164034.20f1695a@lxorguk.ukuu.org.uk>
References: <49E359D6.1090309@rtr.ca>
	<49E35A5E.4020204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50920 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752603AbZDMPjc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 11:39:32 -0400
In-Reply-To: <49E35A5E.4020204@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 13 Apr 2009 11:29:34 -0400
Mark Lord <liml@rtr.ca> wrote:

> Workaround for errata SATA#24 in sata_mv.
> This errata affects WRITE_MULTI* commands when
> the device multi_count produces a DRQ block size >= 4Kbytes.
> 
> We work around it here by converting such operations
> into ordinary PIO_WRITEs instead.
> 
> Note that this might result in a PIO FUA write unavoidably being converted
> into a non-FUA write.  In practice, any system using FUA is also going to be
> using DMA rather than PIO, so this shouldn't affect anyone in the real world.

You can just screen the FUA bit from the identify data when you do the
drive setup to avoid that bit.

Alan
