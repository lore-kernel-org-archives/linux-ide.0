From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: hda on Via Epia-ML motherboard seen on 2.6.18, but not 2.6.19
Date: Fri, 22 Dec 2006 10:04:19 +0800
Message-ID: <200612220204.kBM24JG4011147@freya.yggdrasil.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [61.48.53.27] ([61.48.53.27]:44610 "EHLO freya.yggdrasil.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1945922AbWLVC4D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Dec 2006 21:56:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

	I have a 666MHz Via Epia-ML motherboard (using a Via Eden, I
think).  I am booting it from a CompactFlash card attached by an
IDE-CF adapter.  Everything works fine under 2.6.18.  Under 2.6.19,
2.6.19.1 and 2.6.20-rc1, the master device on ide0 is not seen.

	With all of the kernels, good and bad, I see approximately the
following two lines after the via82cxxx module loads:

ide0: BM-DMA at 0xdc00-dc07, BIOS settings:hda: DMA, hdb: pio
ide0: BM-DMA at 0xdc08-dc0f, BIOS settings:hdc: pio, hdd: pio

	Under 2.6.18 and before, I also a line like this shortly
thereafter, which is absent under 2.6.19.1 and 2.6.20-rc1.

hda: TRANSCEND, CFA disk drive

	After that, the ide-disk module sees hda as a hard disk under
2.6.18, and does not see the device under 2.6.19 and later.

	2.6.19 and later see the hard disk if I have it connected to
the ide1 cable (that is, as hdc) instead of ide0.  In that case, I
have tried booting with the flash disk as hdc and a CD-ROM as hda, and
the result is that the CD-ROM in hda is not seen.

	I have another computer, with a much faster CPU, that also
uses the via82cxxx module for IDE, using the same kernel and module
binaries, which does see a flash card attached as ide0 master under
all of these kernel versions.

	I know that there is plenty more that I can do to narrow this
problem myself, such as narrowing the problem to intermediate kernel
versions, trying libata + via_pata instead, and other things, but I am
reporting it now in case anyone else is already aware of the problem,
as I've already been fiddling with it on and off for a few days.  If
nobody has anything to add about this, then I'll post follow-ups as a
narrow or resolve it.

Adam Richter
