From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PATA timeouts on old thinkpad
Date: Thu, 11 Jun 2009 12:29:44 +0100
Message-ID: <20090611112944.GA7050@flint.arm.linux.org.uk>
References: <20081121002521.GA12626@flint.arm.linux.org.uk> <20081121003723.03bcef7e@lxorguk.ukuu.org.uk> <20090610233634.GA691@flint.arm.linux.org.uk> <20090611120508.6779a8d8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38521 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZFKL35 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jun 2009 07:29:57 -0400
Content-Disposition: inline
In-Reply-To: <20090611120508.6779a8d8@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Thu, Jun 11, 2009 at 12:05:08PM +0100, Alan Cox wrote:
> > ata1.00: status: { DRDY }
> > 
> > which seems to suggest that it's sitting there waiting for the data to
> > be transferred... but for some reason it's just not happening.
> 
> Yes - it indicates the two ends have probably fallen out over the
> transfer length. It could also however be the drive took so long to
> respond we got bored of waiting for DF to appear.

Hmm, is there a way to get a dump of the host side registers when a
timeout occurs?

> > The IDE interface on this is:
> 
> Utterly generic aging PIIX4. Thinkpad 600 kind of era, no known bugs.

Indeed, it's my old 380XD "brick".

> Two things to check
> 
> - disable the SMART stuff
> - turn off drive side power saving (hdparm)
> 
> see if that makes any difference.

I don't have any smart process running, and although I do have hdparm
installed, I don't have any reference to it in any script in /etc/rc.d.

As far as the drive power saving goes, that seems to be managed (somewhat
randomly) by the BIOS - while I can use hdparm to change the settings,
the BIOS at some random point will change them back to what it wants.
It's something this laptop has always done, even back in the days of
2.4 kernels.  To give an example, I used 'hdparm -S0 /dev/sda' before
typing the following paragraph, but by the end of it, the disk has been
spun back down.

| What I would say is that turning off the drive side power management
| (-S0) will prevent the problem occuring - it only appears to occur when
| the drive has already been spun down.

which I would now delete because I can't keep it in -S0 mode! ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
