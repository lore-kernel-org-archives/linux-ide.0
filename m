From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported modes
Date: Sat, 14 Jul 2007 00:20:38 +0100
Message-ID: <20070713232038.GA9352@flint.arm.linux.org.uk>
References: <200707110200.37607.bzolnier@gmail.com> <200707112321.41597.bzolnier@gmail.com> <46967FA8.4090406@ru.mvista.com> <200707132302.04065.bzolnier@gmail.com> <20070713213948.GA18000@flint.arm.linux.org.uk> <20070714001523.2dafed67@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:46126 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbXGMXVB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 19:21:01 -0400
Content-Disposition: inline
In-Reply-To: <20070714001523.2dafed67@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Sat, Jul 14, 2007 at 12:15:23AM +0100, Alan Cox wrote:
> On Fri, 13 Jul 2007 22:39:48 +0100
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > On Fri, Jul 13, 2007 at 11:02:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > weeeeee, take 3
> > 
> > I'm probably going to drop this driver as soon as the PATA people get
> > their finger(s) out and respond to the issues I raised when merging
> > the pata_icside driver.
> 
> Which issues are you still waiting solutions for ?

/*
 * We need to shut down unused ports to prevent spurious interrupts.
 * FIXME: the libata core doesn't call this function for PATA interfaces.
 */
static void pata_icside_port_disable(struct ata_port *ap)

Essentially, the interrupt lines to the drives end up floating if no
drives are attached (don't ask why they didn't fit the resistors.)
This leads to a great number of spurious interrupts if the hardware
is left with the individual channel IRQ enables set.

We need to set the IRQ enable initially so that the identity information
can be read and the drive accessed etc.  However, if no drives are
detected on a port, there is no callback into the low level driver -
the port_disable method is never called.  (I believe it is with SATA.)

I tried asking about this several times before the driver was merged
and every time it was completely ignored.  Eventually, I gave up and
merged the driver as is, with this disgusting hack in:

        /*
         * FIXME: work around libata's aversion to calling port_disable.
         * This permanently disables interrupts on port 0 - bad luck if
         * you have a drive on that port.
         */
        state->port[0].disabled = 1;

so at least it worked here.  The consequence of that is if you attach a
drive to port 0, the interrupts from that drive will be lost unless you
edit the driver.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
