From: christian montanari <cp.montanari@tiscali.co.uk>
Subject: how to detect a JM20330 based IDE-SATA adapter
Date: Mon, 6 Jun 2016 13:29:53 +0000 (UTC)
Message-ID: <loom.20160606T150416-740@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38086 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcFFNpO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2016 09:45:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1b9uq0-0000O4-Ra
	for linux-ide@vger.kernel.org; Mon, 06 Jun 2016 15:45:05 +0200
Received: from host-92-21-196-52.as13285.net ([92.21.196.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2016 15:45:04 +0200
Received: from cp.montanari by host-92-21-196-52.as13285.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2016 15:45:04 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, here a PC P4 would detect a SATA drive attached to this bi directionnal 
IDE-SATA adapter (from Dynamode) at bios time (so the connections are 
good!) ,

however carrying on booting linux-4.5.0-1-686-pae,
 and even forcing module pata_jmicron,  no PCI device of the chip is 
seen...and then the SATA drive is not detected...:


if id code 197b  is "JMicron Technology Corp.":

 lspci -d 197b:* 

returns zit.


would anyone have some idea how I could revive this cheap peace of kit,
using setpci, maybe?


Thanks.


here is my IDE interface...

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE 
Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd. [MSI] 82801EB/ER 
(ICH5/ICH5R) IDE Controller
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 01f0 [size=8]
        I/O ports at 03f4
        I/O ports at 0170 [size=8]
        I/O ports at 0374
        I/O ports at fc00 [size=16]
        Memory at 20000400 (32-bit, non-prefetchable) [size=1K]
        Kernel driver in use: ata_piix
        Kernel modules: ata_piix, ata_generic

and the dmesg snippet:
[    0.237071] pnp: PnP ACPI init
[    0.237509] system 00:00: [io  0x0290-0x0297] has been reserved
[    0.237557] system 00:00: [io  0x03f0-0x03f1] has been reserved
[    0.237603] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.237648] system 00:00: [io  0x0400-0x043f] has been reserved
[    0.237695] system 00:00: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.237742] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.237792] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.237890] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.238024] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b 
(active)
[    0.238154] pnp 00:03: [dma 2]
[    0.238238] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.238622] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.239136] pnp 00:05: [dma 3]
[    0.239275] pnp 00:05: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.239725] pnp: PnP ACPI: found 6 devices
[    0.239775] PnPBIOS: Disabled by ACPI PNP
[    0.279512] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, 
max_idle_ns: 2085701024 ns
[    0.279607] pci 0000:00:1f.0: BAR 13: [io  size 0x0080] has bogus
alignment <<<=== LPC
[    0.279665] pci 0000:00:1d.7: BAR 0: assigned [mem 0x20000000-
0x200003ff]

[    0.279717] pci 0000:00:1f.1: BAR 5: assigned [mem
0x20000400-0x200007ff] <==ide bridge

[    0.279768] pci 0000:00:1f.5: BAR 2: assigned [mem 0x20000800-
0x200009ff]
1f.5 <==audio
[    0.279817] pci 0000:00:1f.5: BAR 3: assigned [mem 0x20000a00-
0x20000aff]
[    0.279868] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.279913] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.279961] pci 0000:00:01.0:   bridge window [mem 0xffc00000-0xffcfffff]
[    0.280016] pci 0000:00:01.0:   bridge window [mem 0x9ff00000-0xdfefffff 
pref]
[    0.280073] pci 0000:00:1e.0: PCI bridge to [bus 02]
[    0.280119] pci 0000:00:1e.0:   bridge window [io  0xb000-0xbfff]
[    0.280167] pci 0000:00:1e.0:   bridge window [mem 0xffd00000-0xffdfffff]
[    0.280221] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.280225] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.280229] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.280232] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff 
window]
[    0.280236] pci_bus 0000:00: resource 8 [mem 0x20000000-0xffdfffff 
window]
[    0.280240] pci_bus 0000:01: resource 0 [io  0xa000-0xafff]
[    0.280244] pci_bus 0000:01: resource 1 [mem 0xffc00000-0xffcfffff]
[    0.280248] pci_bus 0000:01: resource 2 [mem 0x9ff00000-0xdfefffff pref]
[    0.280252] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
[    0.280256] pci_bus 0000:02: resource 1 [mem 0xffd00000-0xffdfffff]
[    0.280259] pci_bus 0000:02: resource 4 [io  0x0000-0x0cf7 window]
[    0.280263] pci_bus 0000:02: resource 5 [io  0x0d00-0xffff window]
[    0.280267] pci_bus 0000:02: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.280271] pci_bus 0000:02: resource 7 [mem 0x000c0000-0x000dffff 
window]
[    0.280275] pci_bus 0000:02: resource 8 [mem 0x20000000-0xffdfffff 
window]
...
[    1.467926] libata version 3.00 loaded....


