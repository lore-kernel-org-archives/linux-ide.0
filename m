From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA timeouts on old thinkpad
Date: Thu, 11 Jun 2009 12:05:08 +0100
Message-ID: <20090611120508.6779a8d8@lxorguk.ukuu.org.uk>
References: <20081121002521.GA12626@flint.arm.linux.org.uk>
	<20081121003723.03bcef7e@lxorguk.ukuu.org.uk>
	<20090610233634.GA691@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55413 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754432AbZFKLD6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jun 2009 07:03:58 -0400
In-Reply-To: <20090610233634.GA691@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org

> ata1.00: status: { DRDY }
> 
> which seems to suggest that it's sitting there waiting for the data to
> be transferred... but for some reason it's just not happening.

Yes - it indicates the two ends have probably fallen out over the
transfer length. It could also however be the drive took so long to
respond we got bored of waiting for DF to appear.

> As a reminder, on the 2.6.9 kernel using the old IDE driver, everything
> was fine.  As soon as I upgraded the laptop to F9 which involved switching
> over to the ATA driver, it started behaving like this.

And also changed a whole pile of user space code which issues commands
directly, and the power management. Certainly some older versions of
smartutils and certain drives would do that and a priviledged user app
getting sizes wrong (as far as the drive is concerned) will do that.

> The IDE interface on this is:

Utterly generic aging PIIX4. Thinkpad 600 kind of era, no known bugs.

Two things to check

- disable the SMART stuff
- turn off drive side power saving (hdparm)

see if that makes any difference.

Alan
