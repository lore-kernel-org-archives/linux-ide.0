From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Crash when inserting media bay CD with 2.6.15-rc3
Date: Wed, 30 Nov 2005 16:44:37 +1100
Message-ID: <1133329478.16726.65.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:62898 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751047AbVK3FvW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2005 00:51:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: list linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Hi Bart !

When inserting my pmac hotswap bay CD-ROM drive, I get a crash that
looks like :

Probing IDE interface ide1....
hdc: MATSHITA CR-174, ATAPI CD/DVD-ROM drive.

Then the crash:

Vector: 300 (Data Access) at [c5e1fdc0]
    pc: c00b7370: create_dir+0x20/0x200
    lr: c00b7598: sysfs_create_dir+0x48/0xa0
    sp: c5e1fe70
   msr: 9032
   dar: 65670008
 dsisr: 40000000
  current = 0xc5f44070
    pid   = 730, comm = media-bay
enter ? for help
mon> t
[c5e1fe90] c00b7598 sysfs_create_dir+0x48/0xa0
[c5e1feb0] c0124380 kobject_add+0x80/0x190
[c5e1fed0] c01cb9e0 device_add+0xa0/0x170
[c5e1fef0] c020540c probe_hwif+0x2ac/0x8a0
[c5e1ff30] c02065ac probe_hwif_init_with_fixup+0x1c/0xb0
[c5e1ff40] c01fe20c ide_register_hw_with_fixup+0x1fc/0x230
[c5e1ff70] c01f09f0 media_bay_step+0x5a0/0x5b0
[c5e1ffd0] c01f0ca4 media_bay_task+0xe4/0x140
[c5e1fff0] c000f4e8 kernel_thread+0x44/0x60

This "translates" to an Oops accessing a wrong pointer, 0x65670008 is
the pointer value (totally bogus) and you can see the backtrace above.

The interfaces are as follow:

ide0: Found Apple Heathrow ATA controller, bus ID 0, irq 13
hda: IBM-DTCA-24090, ATA DISK drive
hda: Enabling MultiWord DMA 2
ide0 at 0xc701a000-0xc701a007,0xc701a160 on irq 13
ide1: Found Apple Heathrow ATA controller, bus ID 1 (mediabay), irq 14
ide2: Found Apple Heathrow ATA controller, bus ID 4 (mediabay), irq 78

As you see, ide1 and ide2 are there and have been setup with the various
fields for ide/ppc/pmac.c. They have not been probed at boot though as
the media bay was empty.

Any idea ? I'll try to track it down on my side too but I'm chasing a
few different issues at the same time, so if you have a clue, you are
welcome :)

For your information, the media bay driver, when detecting an IDE
device, first waits for the BUSY bit to clear (historical reasons: the
IDE driver used not to do it before I fixed it and I never udpated the
mediabay driver) and then does:

ide_init_hwif_ports(&hw, (unsigned long) bay->cd_base, (unsigned long) 0, NULL);
hw.irq = bay->cd_irq;
hw.chipset = ide_pmac;
bay->cd_index = ide_register_hw(&hw, NULL);

cd_base and cd_irq have been set by the ide-pmac driver (it calls into the
mediabay driver to "inform" it of the base & irq of the controller hooked to
that bay).

This code used to work, I can't tell for sure when this broke as I didn't
test on that old machine with a mediabay for a long time.

Any clue welcome.

Cheers,
Ben.


