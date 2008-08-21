From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Driver for Promise PDC42819 SATA/SAS controller
Date: Thu, 21 Aug 2008 15:27:29 +0200
Message-ID: <18605.27969.933718.902876@harpo.it.uu.se>
References: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
	<18597.25642.934859.944853@harpo.it.uu.se>
	<65a6ef750808210557o1cf07c5fj9d273413003037f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48791 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbYHUN1f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 09:27:35 -0400
In-Reply-To: <65a6ef750808210557o1cf07c5fj9d273413003037f8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Mark Nelson writes:
 > On Fri, Aug 15, 2008 at 9:10 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
 > > Mark Nelson writes:
 > >  > Hi All,
 > >  >
 > >  > I recently bought an MSI K9A2 Platinum motherboard and it has a Promise
 > >  > PDC42819 SATA/SAS controller onboard. I haven't been able to get the
 > >  > controller to work with any of the libata sata drivers in mainline
 > >  > (although I did only try sata_promise, sata_sx4 or ahci; last two I was
 > >  > doubtful about but I figured it was worth a try).
 > >  >
 > >  > Has anyone played with this controller under Linux before and can it be
 > >  > made to work with any of the open source drivers - I would realy like
 > >  > to use the eSATA and internal SATA ports attached to this controller
 > >  > (and I don't want to trust my data to the promise binary blob)? Maybe
 > >  > it's as simple as adding the right PCI ID to sata_promise, but I wasn't
 > >  > sure what kind of board it should be: 2037x, 2057x, 20319, 40518, 20619,
 > >  > or maybe some new one...
 > >  >
 > >  > I'm not sure how important this is but I gathered the following info
 > >  > about the controller:
 > >  >
 > >  > References to the controller in the motherboard manual and the
 > >  > motherboard manufacturer's website: Promise T3 [1]
 > >  >
 > >  > Written on the actual chip on the motherboard: Promise PDC42819 [2]
 > >  >
 > >  > This chip is also used on Promise's own FastTrak TX2650 & TX4650
 > >  > adapters [3] which have "partial open source" drivers [4], [5]. This
 > >  > driver looks like an open source wrapper around a binary blob (some
 > >  > fasttrak library for software fake raid, I think).
 > >  >
 > >  > Having a quick look through the source of Promise's driver, it looks
 > >  > like the driver has been hacked up out of a driver that was originally
 > >  > used for fakeraid on ATI and intel southbridges as well as Promise's
 > >  > SX4 adapter (and some Promise adapter called the OCTOPUSII).
 > >  >
 > >  > Promise has an open source commitment written on its werbsite [6] but
 > >  > it just relates to their SuperTrak products (not their FastTrak ones)
 > >  > and the stex driver.
 > >  >
 > >  > The following is the hunk of lspci output that refers to the controller:
 > >  >
 > >  > 02:00.0 RAID bus controller [0104]: Promise Technology, Inc. Unknown
 > >  > device [105a:3f20]
 > >
 > > This is pure speculation, but _if_ it is similar to the chips
 > > driven by sata_promise then it should be close to the 40518 family
 > > (all the other ones are older). So adding that PCI id as a
 > > board_40518 in pdc_ata_pci_tbl[] just might do the trick.
 > >
 > Hi Mikael,
 > 
 > First of all thanks for the reply. It's taken me a while because I
 > had to get my hands on a spare SATA disk to test with (ended up
 > with a 60GB eSATA disk).
 > 
 > So, after adding the following PCI ID line:
 > 
 >        { PCI_VDEVICE(PROMISE, 0x3f20), board_40518 },
 > 
 > I can load the module and I get the following in dmesg:
 > 
 > sata_promise 0000:02:00.0: version 2.12
 > ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
 > PCI: Setting latency timer of device 0000:02:00.0 to 64
 > scsi7 : sata_promise
 > scsi8 : sata_promise
 > scsi9 : sata_promise
 > scsi10 : sata_promise
 > ata7: SATA max UDMA/133 mmio m4096@0xfbeff000 ata 0xfbeff380 irq 17
 > ata8: SATA max UDMA/133 mmio m4096@0xfbeff000 ata 0xfbeff280 irq 17
 > ata9: SATA max UDMA/133 mmio m4096@0xfbeff000 ata 0xfbeff200 irq 17
 > ata10: SATA max UDMA/133 mmio m4096@0xfbeff000 ata 0xfbeff300 irq 17
 > ata7: SATA link down (SStatus 0 SControl 0)
 > ata8: SATA link down (SStatus 0 SControl 0)
 > ata9: SATA link down (SStatus 0 SControl 0)
 > ata10: SATA link down (SStatus 0 SControl 0)
 > 
 > So it looks like it's at least found the SATA ports. But something's
 > not quite right because as soon as I load the module, the hard disk
 > activity LEDs are constantly on (my motherboard has two LEDs for
 > any drive activity on the Promise controller).
 > 
 > If I plug the eSATA disk I'm using to test into one of the eSATA
 > ports of the Promise controller after I've already booted and loaded
 > the module, I see the following in dmesg:
 > 
 > ata10: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
 > ata10: hotplug_status 0x40
 > ata10: hard resetting link
 > ata10: SATA link down (SStatus 0 SControl 0)
 > ata10: EH complete
 > ata10: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
 > ata10: hotplug_status 0x40
 > ata10: hard resetting link
 > ata10: SATA link down (SStatus 0 SControl 0)
 > ata10: EH complete
 > 
 > But I'm not sure if sata_promise supports hotplug of drives so maybe
 > that's to be expected.
 > 
 > If I boot with the eSATA drive connected (the drive is found in the
 > Promise FastTrak BIOS), when I load the sata_promise module no hard
 > disks are found and I get exactly the same output to dmesg as the
 > first example I showed above.
 > 
 > Is there some way I can turn on more debugging output in the
 > sata_promise driver or libata?
 > 
 > And (possibly too early to tell, but) does this look promising (no pun
 > intended)?

Not so promising. It didn't "find" the SATA ports, those addresses
are a function of the PCI BARs and the board type we assign to the
PCI ID, and we just guessed the board type.

sata_promise does support hotplugging (since 2.6.22 or so), but the
messages you got do not indicate successful hotplugging. In particular,
you should see "link up" not "link down".

It does look like 0x3f20 is fairly different from previous chips.
But without docs or a reference driver I cannot really say what it
would take to support it, sorry.

/Mikael
