From: Wakko Warner <wakko@animx.eu.org>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Sat, 28 Sep 2013 08:20:13 -0400
Message-ID: <20130928122013.GA26951@animx.eu.org>
References: <20130927231346.GA5662@animx.eu.org>
 <CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tn-76-7-162-101.sta.embarqhsd.net ([76.7.162.101]:46787 "EHLO
	animx.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab3I1MUP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Sep 2013 08:20:15 -0400
Content-Disposition: inline
In-Reply-To: <CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Reartes Guillermo <rtguille@gmail.com>
Cc: linux-ide@vger.kernel.org

Reartes Guillermo wrote:
> I am not sure it is the exact same [model] card., but check my bugreport:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=906532
> Hard freezes with ASMedia SATA (1b21:0612) (PCIe) and Optical Drive
> (iHBS112) (WORKAROUND = 'libata.atapi_passthru16=0')

I looked.  Here's my controller:
06:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA
Controller (rev 01) (prog-if 01 [AHCI 1.0])
        Subsystem: Super Micro Computer Inc Device 0805
        Flags: bus master, fast devsel, latency 0, IRQ 41
        I/O ports at d050 [size=8]
        I/O ports at d040 [size=4]
        I/O ports at d030 [size=8]
        I/O ports at d020 [size=4]
        I/O ports at d000 [size=32]
        Memory at f0400000 (32-bit, non-prefetchable) [size=512]
        Capabilities: <access denied>
        Kernel driver in use: ahci

What I found interesting was the fact that the PCI location (06:00.0) is the
same as yours.  Mine is built on the motherboard.

Did you wait to see if your system came responsive again?  Did you receive
ATA errors in your kernel log?  I unfortunately don't have the errors
written down and the system crashed before anything was logged.

I'll try the atapi passthrough thing.

> On Fri, Sep 27, 2013 at 8:13 PM, Wakko Warner <wakko@animx.eu.org> wrote:
> > I am not on this list, please keep me in CC.
> >
> > I have a SuperMicro X10SAE with a 2 port ASM1061 controller.  When a DVDRW
> > is plugged into the port and is accessed (ie udev rules), there will be some
> > errors, an ata reset then the system hangs.  Keyboard is non-responsive
> > (lock key lights won't change).  SYSRQ doesn't work.
> >
> > I tried both ports with the same result with 2 DVDRW drives (both same
> > model).
> >
> > I was able to use a hard disk attached to either port w/o problems.
> >
> > Kernel is vanilla 3.11.1 running on x86_64.
> >
> > --
> >  Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
> >  million bugs.
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
 Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
 million bugs.
