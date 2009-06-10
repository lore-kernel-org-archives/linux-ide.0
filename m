From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PATA timeouts on old thinkpad
Date: Thu, 11 Jun 2009 00:36:34 +0100
Message-ID: <20090610233634.GA691@flint.arm.linux.org.uk>
References: <20081121002521.GA12626@flint.arm.linux.org.uk> <20081121003723.03bcef7e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38802 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZFJXgt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 19:36:49 -0400
Content-Disposition: inline
In-Reply-To: <20081121003723.03bcef7e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, Nov 21, 2008 at 12:37:23AM +0000, Alan Cox wrote:
> On Fri, 21 Nov 2008 00:25:21 +0000
> Russell King <rmk@arm.linux.org.uk> wrote:
> > Last weekend I upgraded my old Thinkpad from Fedora Core 2 to F9
> > (a 2.6.9 kernel to a 2.6.25 kernel).  The old 2.6.9 kernel was
> > using the IDE drivers, and there have been no issues with IDE on
> > this hardware until this upgrade.
> 
> Can you double the timeouts for block I/O commands. The libata core uses
> 30 second timeouts for a lot of stuff and some PATA drives really do want
> 60.
> 
> Other than that there really isn't any difference in the settings the two
> drivers use as they are all written up exactly in the Intel docs.

I notice that the later F9 kernels seem to have doubled the timeout to
60 secs - that makes the error recovery take longer.  I also notice that
there's a higher chance of the disk spinning down while we wait for the
DMA to happen - remember the status upon error recovery was:

ata1.00: status: { DRDY }

which seems to suggest that it's sitting there waiting for the data to
be transferred... but for some reason it's just not happening.

As a reminder, on the 2.6.9 kernel using the old IDE driver, everything
was fine.  As soon as I upgraded the laptop to F9 which involved switching
over to the ATA driver, it started behaving like this.

Is it possible to tell F9 to use the old IDE driver instead of libata, or
is it hard-wired to always use ATA now?

The IDE interface on this is:

00:06.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
        Region 4: I/O ports at fcf0 [size=16]
        Kernel driver in use: ata_piix
        Kernel modules: ata_piix


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
