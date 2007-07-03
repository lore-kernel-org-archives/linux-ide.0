From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 03 Jul 2007 09:11:12 +0100
Message-ID: <468A04A0.1020003@genesi-usa.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com> <20070623105344.3ece6db1@the-village.bc.nu> <467CF1E6.8000905@genesi-usa.com> <4689FBCB.90608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:4879 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbXGCIKn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 04:10:43 -0400
In-Reply-To: <4689FBCB.90608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org



Tejun Heo wrote:
> Matt Sealey wrote:
>> I'm a litle confused here.
>>
>> Page 10 (4.2.1) so I just mask off bit 0 and bit 2 of the class prog-if byte and set
>> it to "compatible" mode which will basically mean PCI mapped registers and
>> two IRQs? This corresponds with the table on Page 7 (4.2.1.1)..
>>
>> Checked the Pegasos IDE class code and in the firmware it's set to 0x1018F so, I
>> would assume the correct value is 0x1018A (knocking out the "native mode").
>>
>> Okay! Great. This looks easy. Just gotta decode PCI addresses in Forth now..
> 
> I think I wrote this in the bugzilla entry but my memory is fuzzy as
> always, so I'll repeat it here.  If you turn off the native bits,
> libata-sff will use ATA_PRIMARY_CMD and its friends to determine IO
> ports and ATA_PRIMARY_IRQ and friends to determine IRQs.  PCI BAR is
> only used to determine IO ports for BMDMA register.
> 
> ie. The legacy mode means "there's no standard way to configure the damn
> thing.  Just believe what the arch code says.  However, BMDMA is
> introduced after PCI so let's use PCI BAR for it."  So, if you're gonna
> make the controller legacy (which I think is the correct way), don't
> forget to update those arch macros.

So we actually have to fix up some platform support for it? That's not very
nice.

We can't make the controller TRULY legacy since there is not any good way
of mapping the IDE/BMDMA registers into the lower kilobyte or so of
memory - obviously PPC has no "io address space", it's all memory mapped,
so the lower kilobyte of "IO ports" is really the CPU zero page. It's not
a good idea to be poking around just there and we never intended that to work.

However the VT8231 (and probably all the Via chips) do happily operate in
"native PCI mode" with the line register reporting 14 or 10, and IRQ steering
still set to two IRQs (10/11 or 14/15 or some combination). You might
consider this an ATA specification violation or a chipset bug, but it
does in fact work.. my original patch handled it as a quirk (it is a
quirk, a very strange way of operating..) - isn't there a way we can get
the same kind of quirky fix in libata or are we being super-clean about
it?

The patch I made for the old IDE driver looks to be a clumsy version of
what some of libata-sff does in ata_pci_init_one and ata_pci_probe_ent
and maybe a little bit of ata_pci_init_native_mode.

Is it possible to perhaps replace ata_pci_init_one with a custom
function which handles this (in pata_via.c) quirky behaviour and
#ifdef it out with a Kconfig variable? CONFIG_ATA_VIA_HALFNATIVE_QUIRK
or something? I think that would be best. Everyone can ignore it
and distributions building for Pegasos can enable it.. but I think
"fixing" IDE chipset quirks by reconfiguring the chipset in some
platform support code is the wrong place. It either needs to be
set up properly in firmware (breaking ide/via82cxxx.c in the process
and therefore any old kernels anyone is running. We don't want to
impose a kernel upgrade with our firmware upgrades..) or fixed
in the IDE driver (libata and it's drivers are eminently updatable
by unloading modules, whereas platform support is a reboot job..)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
