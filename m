From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA timeouts on old thinkpad
Date: Thu, 11 Jun 2009 12:40:46 +0100
Message-ID: <20090611124046.539dc8f3@lxorguk.ukuu.org.uk>
References: <20081121002521.GA12626@flint.arm.linux.org.uk>
	<20081121003723.03bcef7e@lxorguk.ukuu.org.uk>
	<20090610233634.GA691@flint.arm.linux.org.uk>
	<20090611120508.6779a8d8@lxorguk.ukuu.org.uk>
	<20090611112944.GA7050@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56856 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752053AbZFKLj2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jun 2009 07:39:28 -0400
In-Reply-To: <20090611112944.GA7050@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org

> Hmm, is there a way to get a dump of the host side registers when a
> timeout occurs?

Add printks and recompile ?

There is almost no host side register state on the PIIX4 like most older
IDE controllers, just a few timing registers. You can certainly print out
the failing task file (and the drive itself will if you use the smart
utils dump out the last 5 failed commands)

> | What I would say is that turning off the drive side power management
> | (-S0) will prevent the problem occuring - it only appears to occur when
> | the drive has already been spun down.
> 
> which I would now delete because I can't keep it in -S0 mode! ;(

If the APM bios code is randomly issuing drive task files behind our back
then its going to go kerboom when APM falls out with us. However that
might suggest why only you see a problem and only with libata. The libata
code manages the taskfile writes intelligently (as they are expensive)
which old IDE doesn't. That means old IDE is much more resilient to that
kind of BIOS abuse if that is what occurs.

If so you can try pasting the standard tf write routine into the driver,
removing the caching checks so you always write the whole taskfile
(except the LBA48 check) and see if that cures it.

Alan
