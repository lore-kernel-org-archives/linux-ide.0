From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 6883] ide-probe.c attempts to use polling designed for ancient Seagate drives on some compact flash disks
Date: Sun, 22 Jun 2008 05:41:55 -0700 (PDT)
Message-ID: <20080622124155.8437C108035@picon.linux-foundation.org>
References: <bug-6883-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39505 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751401AbYFVMl6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jun 2008 08:41:58 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5MCftfA005371
	for <linux-ide@vger.kernel.org>; Sun, 22 Jun 2008 05:41:56 -0700
In-Reply-To: <bug-6883-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=6883





------- Comment #2 from vkelim@bigpond.com  2008-06-22 05:41 -------
The situation appears improved with 2.6.24/2.6.25 compared to 2.6.16, but
occasionally, on card insertion, I still get the error log as below (test
machine is a Fujitsu P-1610)...

<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<7>Probing IDE interface ide0...
<6>cs: IO port probe 0x100-0x3af: clean.
<6>cs: IO port probe 0x3e0-0x4ff: clean.
<6>cs: IO port probe 0x820-0x8ff: clean.
<6>cs: IO port probe 0xc00-0xcf7: clean.
<6>cs: IO port probe 0xa00-0xaff: clean.
<4>hda: CF500, CFA DISK drive
<6>hdb: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
<6>hdb: probing with STATUS(0x04) instead of ALTSTATUS(0x0a)
<4>hdb:
^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L^B^L,
ATA DISK drive
<4>ide0 at 0x3100-0x3107,0x310e on irq 3
<6>ide-cs: hda: Vpp = 0.0
<6>sdhci: SDHCI controller found at 0000:08:03.1 [1180:0822] (rev 13)
<6>ACPI: PCI Interrupt 0000:08:03.1[B] -> GSI 17 (level, low) -> IRQ 17
<4>sdhc0:slot0: Will use DMA mode even though HW doesn't fully claim to support
it.
<6>mmc0: SDHCI at 0xf0200000 irq 17 DMA
<6>hda: max request size: 128KiB
<6>hda: 8060928 sectors (4127 MB) w/1KiB Cache, CHS=15744/16/32
<6> hda: hda1
<6>hdb: max request size: 512KiB
<4>hdb: lost interrupt
<4>hdb: lost interrupt
<4>hdb: lost interrupt
<4>hdb: lost interrupt
<4>hdb: lost interrupt


May 10 10:55:22 linux-khsr kernel: pccard: PCMCIA card inserted into slot 0
May 10 10:55:22 linux-khsr kernel: cs: memory probe 0xf0200000-0xf02fffff:
excluding 0xf0200000-0xf020ffff
May 10 10:55:22 linux-khsr kernel: pcmcia: registering new device pcmcia0.0
May 10 10:55:22 linux-khsr kernel: Uniform Multi-Platform E-IDE driver
May 10 10:55:22 linux-khsr kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
May 10 10:55:22 linux-khsr kernel: Probing IDE interface ide0...
May 10 10:55:22 linux-khsr kernel: hda: CF500, CFA DISK drive
May 10 10:55:23 linux-khsr kernel: hdb: probing with STATUS(0x50) instead of
ALTSTATUS(0x0a)
May 10 10:55:23 linux-khsr kernel: hdb: probing with STATUS(0x00) instead of
ALTSTATUS(0x0a)
May 10 10:55:24 Vigor15 syslog-ng[1618]: last message repeated 2 times
May 10 10:55:24 linux-khsr kernel: ide0 at 0x3100-0x3107,0x310e on irq 3
May 10 10:55:24 linux-khsr kernel: ide-cs: hda: Vpp = 0.0
May 10 10:55:24 linux-khsr kernel: hda: max request size: 128KiB
May 10 10:55:24 linux-khsr kernel: hda: 8060928 sectors (4127 MB) w/1KiB Cache,
CHS=15744/16/32
May 10 10:55:24 linux-khsr kernel:  hda: hda1


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
