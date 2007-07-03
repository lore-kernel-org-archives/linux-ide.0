From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 03 Jul 2007 13:44:20 +0100
Message-ID: <468A44A4.3080406@genesi-usa.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com> <20070623105344.3ece6db1@the-village.bc.nu> <467CF1E6.8000905@genesi-usa.com> <4689FBCB.90608@gmail.com> <468A04A0.1020003@genesi-usa.com> <468A1510.6070803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3802 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbXGCMnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 08:43:35 -0400
In-Reply-To: <468A1510.6070803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

I can't personally test anything (no Pegasos here) but I'm sure I can find some
people who can.

MMIO is required. There is no other way on PowerPC. You can do some funny tricks
in some northbridges to map certain memory ranges as PCI IO addresses through
the northbridge but we don't implement them (I think not anyway).

The "bugs" so far, are:

* IDE class code is set to "legacy" mode even though the controller is in
  "native" mode (MMIO to PCI BAR)
* ISA bridge IDE IRQ Steering register is set to push 14/15 as IDE IRQs

There are two fixes to consider; one, is that we fix the class code with a
firmware fix (or forth script or boot loader hack or platform support code
in arch/powerpc/platforms/chrp/*) and then the ISA IDE IRQ Steering is
still using two IRQs. This will not break the old via82cxxx.c driver as
it has no care in the world what the class code is.

Two, is that we fix the IDE IRQ Steering but we would break via82cxxx.c
since it freaks out when the controller is in true native mode on some
if not most (if not all) kernel versions. We would therefore by having
any firmware fix break everyone's systems and force them to use libata.
Old Linux distributions using non-libata drivers (pre-pata_via) would
stop working. If we had it as a Forth script or boot loader hack it
would be optional. If we put it in the kernel (I hope not..) then it
would just fix new users.

All in all I think the easiest way that entails the least line of
resistance and support for users for Genesi and the Linux IDE team
is to make pata_via handle this quirky but perfectly working chip
configuration (it is the best of both worlds for using PCI MBAR
register locations and legacy IRQs). I think that is what your patch
does some of the way but does it handle both problems? I'll check,
I'm pretty busy today :/

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Tejun Heo wrote:
> Matt Sealey wrote:
>> So we actually have to fix up some platform support for it? That's not very
>> nice.
> 
> Well, the hardware isn't very nice, is it?  :-)
> 
>> We can't make the controller TRULY legacy since there is not any good way
>> of mapping the IDE/BMDMA registers into the lower kilobyte or so of
>> memory - obviously PPC has no "io address space", it's all memory mapped,
>> so the lower kilobyte of "IO ports" is really the CPU zero page. It's not
>> a good idea to be poking around just there and we never intended that to work.
> 
> So, the legacy ioport addresses aren't fixed.  It can be determined by
> the previously-said arch macros.  Or are you saying that mmio is required?
> 
>> Is it possible to perhaps replace ata_pci_init_one with a custom
>> function which handles this (in pata_via.c) quirky behaviour and
>> #ifdef it out with a Kconfig variable?
> 
> Yeah, sure.  I was gonna do it once the native PCI BARs + legacy IRQ
> hack I posted to the bugzilla bug is verified to work.  There's a
> pending cleanup to ata_pci_init_once() and friends which will make the
> job easier.  Can you test the patch and try to determine why it doesn't
> work?
> 
> Thanks.
> 
