From: "M. Grabert" <xam@cs.ucc.ie>
Subject: siimage problems on Linux/PA-RISC
Date: Mon, 8 Dec 2003 23:47:13 +0000 (GMT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0312082315170.13596@sal.ucc.ie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from csmail.ucc.ie ([143.239.211.231]:19617 "EHLO csmail.ucc.ie")
	by vger.kernel.org with ESMTP id S261875AbTLHXrW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2003 18:47:22 -0500
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

Hi,

I'm having troubles getting a (rather new) SiliconImage PCI IDE
controller working on Linux/PA-RISC.

The original/full error report can be found here:
http://lists.parisc-linux.org/pipermail/parisc-linux/2003-December/021839.html

Alan suggests it may be more likely a bug in the siimage driver, rather
than in the PA-RISC specific bits and I may ask here for more help.
Please also read Alans comments (forwarded) at the end of this mail.


A short summary:
================
- 2.4.23 (with and without ide=nodma passed as kernel options) produces
  'hda lost interrupt' messages; /dev/hda is not accessible (read errors)

- 2.6.0-test11 creates a kernel ooops ('Your system ate a SPARC'),
  passing ide=nodma doesn't change anything

The full bootlogs/.config/System.maps can be found here:

http://www.cs.ucc.ie/~xam/siimage/



There might be also big-endian issues, as the bootlog reveals. The
siimage driver in 2.4.23 says:

  hda: TS130220A2, ATA DISK drive
  hda: 0 sectors (0 MB) w/8KiB Cache, CHS=65343/0/0
  hda: INVALID GEOMETRY: 0 PHYSICAL HEADS?

and the siimage driver in 2.6.0-test11 also says:

  hda: TS130220A2, ATA DISK drive


Whereas a 2.4.23 kernel using the (crappy but working) onboard NS87415 IDE
controller of the PA-RISC workstation identifies the Seagate hard disk
correctly as:

 hda: ST3120022A, ATA DISK drive
 hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=14593/255/63, (U)DMA
 Partition check:
   hda: hda1



Thanks alot in advance for any help,
  Max



---------- Forwarded message ----------
Date: Mon, 08 Dec 2003 20:11:09 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: M. Grabert <xam@cs.ucc.ie>, parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] test11-pa2 & serial console on C3k success,
     siimage problems

On Llu, 2003-12-08 at 18:35, Grant Grundler wrote:
> On Mon, Dec 08, 2003 at 08:20:38AM +0000, M. Grabert wrote:
> ...
> > SiI680: 100% native mode on irq 128
> >     ide0: MMIO-DMA at 0xf4800000-0xf4800007 -- Error, MMIO ports already in use.
> >     ide1: MMIO-DMA at 0xf4800008-0xf480000f -- Error, MMIO ports already in use.
>
> Look at the code that prints this line and the error msg.

This can only occur if critical 2.4 IDE fixes for mmio are missing from
2.6 or some kind of implementation error is being tripped. Ask
Bartlomiej why mmio==2 mode ("check by host driver only") isn't
implemented. Its requited for mmio PCI devices to work properly even on
x86. That or the SI680/3112 driver in 2.6 is not setting it and the
kernel code is there but not being used.

That message just can't occur on the proper code.

Background:
	Drivers use ioremap returns for mmio registers
	IDE core only knows ioremap data
	IDE core used to try and reserve the matching physical locations

On x86 it "happens" to work until you have more than about 2.5Gb of RAM

Alan
