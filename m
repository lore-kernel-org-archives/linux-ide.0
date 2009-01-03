From: Mark Lord <liml@rtr.ca>
Subject: Re: marvell sata status?
Date: Sat, 03 Jan 2009 09:44:04 -0500
Message-ID: <495F79B4.2050309@rtr.ca>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan> <495CCE0F.7010002@rtr.ca> <20090101184450.GG3386@pimb.org> <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan> <20090101194302.GH3386@pimb.org> <495E3C92.2070304@rtr.ca> <alpine.DEB.1.10.0901021302560.26159@p34.internal.lan> <495E769B.8000407@rtr.ca> <alpine.DEB.1.10.0901021518150.8210@p34.internal.lan> <495EF1D5.1020106@rtr.ca> <alpine.DEB.1.10.0901030411510.11184@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:34707 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbZACOmf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jan 2009 09:42:35 -0500
In-Reply-To: <alpine.DEB.1.10.0901030411510.11184@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Jody Belka <lists-lkml@pimb.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Justin Piszcz wrote:
> 
..
> One would think if the controller overwrites bits on the device when 
> mdadm assembles the raid device it would kick it out of the array for 
> being unclean or find a lot of mismatches on the array or is that the 
> wrong idea?
..

No, there's nothing in mdadm that I know of which will detect this.
You'd basically need to run a job in the background, reading/comparing
all of the mirrors with each other.

But even that mightn't work, since the BIOS would have corrupted the
exact same sector on every drive attached to it, quite possibly with
the same contents, so the mirror-compare wouldn't see anything different.

The only way to know for sure is to test it manually,
by zeroing the entire drive, power/reboot, scan the entire
drive for non-zero.  Then repeat with a different pattern
just in case "zero" is what the BIOS wrote.

Very very messy, at least for the Highpoint RAID cards.
But we really don't know about what the others do,
apart from some historical data in the dm code.

Cheers
