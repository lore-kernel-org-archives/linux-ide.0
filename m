From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Mon, 18 Apr 2011 10:55:14 -0500
Message-ID: <1303142114.7167.6.camel@mulgrave.site>
References: <1303084704.2583.23.camel@mulgrave.site>
	 <4DAC0EAB.2090306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43314 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753692Ab1DRPzS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Apr 2011 11:55:18 -0400
In-Reply-To: <4DAC0EAB.2090306@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, 622997@bugs.debian.org

On Mon, 2011-04-18 at 14:12 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 18-04-2011 3:58, James Bottomley wrote:
> 
> > I've got a parisc system where the DVD drive is hardwired to a silicon
> > image controller:
> 
> > 00:02.0 IDE interface: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to
> > ATA Host Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
> >          Subsystem: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to ATA
> > Host Controller
> >          Flags: bus master, medium devsel, latency 64, IRQ 69
> >          I/O ports at 0d18 [size=8]
> >          I/O ports at 0d24 [size=4]
> >          I/O ports at 0d10 [size=8]
> >          I/O ports at 0d20 [size=4]
> >          I/O ports at 0d00 [size=16]
> >          Capabilities: [60] Power Management version 2
> >          Kernel driver in use: pata_cmd64x
> 
> > The specific problem is that any access to the registers where the
> > secondary port should be causes an instant fault on the box (I think
> > because the second port just isn't wired up internally, so the memory
> > doesn't respond), so the default libata-sff driver that pata_cmd64x is
> > attached to causes this by insisting on probing both ports.
> 
>     Perhaps the secondary port is disabled (though it's strange that your 
> lspci dump shows I/O resources for both ports allocated).

It's a last minute wedgie into an enterprise system because they wanted
a DVD and there are no SCSI ones ... although why they didn't do USB 

> > I can get all of this working by fixing up all the hard coded knowledge
> > in libata-sff only to use a single port.
> 
> > However, I can't fix the libata-sff driver until I know how to tell
> > there's only one port wired.  Does anyone with cmd649 knowledge have any
> > idea how I might tell this?
> 
>     The secondary port is enabled in the PCI config. space: register 0x51 bit 
> 3 controls this. Unfortunately, pata_cmd64x driver still doesn't check the 
> channel enable bits; the cmd64x driver does though, so it might be worth trying...

So this is the enablebits code in driver/ide that's missing from any of
the libata stuff?  Should this be generic in libata-sff? ... I mean even
on an x86 where arbitrary memory can be poked without consequence,
trying to activate a disabled port will still produce lots of noise.

James


