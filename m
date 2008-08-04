From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Mon, 4 Aug 2008 22:06:19 +0100
Message-ID: <20080804220619.76b94ceb@lxorguk.ukuu.org.uk>
References: <fa.OGeO7gZvBG4obEzRbVltjSebgTQ@ifi.uio.no>
	<fa.KtvYE2B2yrJqUleolhtMPN9ljAQ@ifi.uio.no>
	<fa.AqEKTvguYFAzDFHy/We/8MpOqmo@ifi.uio.no>
	<48976168.3020804@shaw.ca>
	<20080804205508.20a3f917@lxorguk.ukuu.org.uk>
	<48977200.3050307@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37513 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753273AbYHDV0K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 17:26:10 -0400
In-Reply-To: <48977200.3050307@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

> I guess that bit doesn't really make any difference with remotely modern 
> drives, then.. Could we make that ata_id_has_dword_io check always 
> return true if ata_id_is_ata returns true and only check word 48 if not?

I suspect (but need to dig further) that ata_id_has_dword_io should only
be called by pata_legacy.

> I saw Willy Tarreau's patch from February for this, I agree that we 
> should likely use a separate data_xfer method for 32-bit transfer (or if 
> enough controllers should support 32-bit, then just make it be the 
> default and make a separate 16-bit only function for those that don't), 
> rather than punting the decision to the user with hdparm.

Definitely.

> You mentioned in the thread for Willy's patch that "some
> controllers have quirky rules for 32bit xfers" - any details anywhere?

There are two main ones

- Some controllers only support 32bit I/O for a multiple of 32bit values
[sometimes 'unless the fifo is disabled']. I'd have to go back over the
docs but I think the AMD may be one of those
- Some controllers (VLB generally) require a magic sequence before the
transfer. You'll see that in the pata_legacy bits.

Alan
