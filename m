From: infernix <infernix@infernix.net>
Subject: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Fri, 22 Jan 2010 04:37:05 +0100
Message-ID: <4B591D61.8030003@infernix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:39326 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755688Ab0AVDnr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jan 2010 22:43:47 -0500
Received: from [192.168.0.3] (believe.infernix.lan [192.168.0.3])
	by dx.infernix.net (8.14.3/8.14.3/Debian-5) with ESMTP id o0M3b1SE029897
	for <linux-ide@vger.kernel.org>; Fri, 22 Jan 2010 04:37:03 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've got an Intel SS4200(-ESW) here which according to lspci has an
Intel 82801GB/GR/GH controller. It has 4 sata ports + 1 pata port in
which i have a 4GB IDE flash DOM. It also has a SIL 3132 for 2 external
eSATA ports. There are no disks connected to any of the SATA ports.

The bios allows for two modes:

- Compatible mode, which makes the kernel use ata_piix. lspci shows that 
the chipset uses pci id 8086:27c0.

- Enhanced mode (with sub options IDE, RAID or AHCI - using AHCI here),
which of course makes the kernel use ahci. lspci shows the the chipset
now uses pci id 8086:27c1.

In compatible mode, the bios can be configured to make the pata
controller the first and the sata controller the second controller under
ata_piix. This works and I can boot off the IDE in the PATA DOM without
issues. The DOM works fine under ata_piix as /dev/sda.

The problem is with the Enhanced mode with the sub mode set to AHCI (or
IDE for that matter, it didn't change anything). In Enhanced AHCI mode,
the SATA ports are detected just fine, but the PATA port is not
detected. As I'm using an IDE DOM as root device, I can't boot in AHCI
mode.

What's weird though is that if I enable the old IDE PIIX driver, the
PATA port does get detected and the DOM shows up as /dev/hda. But
performance is abysmal, and since this is now deprecated we should try
to get the PATA port working while in Enhanced AHCI mode.

Running in compatible mode is not an option because this allows me to
chose PATA for controller 0 and SATA for controller 1, but as a
consequence i lose 2 sata ports as can be seen in the dmesg output. Or I 
could set it to full SATA but then the PATA port is rendered useless.

Relevant dmesg data follows; i've just checked out and built
linux-ide-next so this is from 2.6.33-rc3. Please advise, as I'm unsure
what to do next.

Thanks!


Dmesg output when in Compatible mode (IDE DOM in PATA port detected as sda):

[    0.264944] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by
ICH6 ACPI/GPIO/TCO
[    0.268007] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by
ICH6 GPIO
[    0.272003] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at
0a00 (mask 00ff)
[    0.276397] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.280202] pci 0000:00:1c.2: PCI bridge to [bus 02-02]
[    0.284063] pci 0000:00:1e.0: PCI bridge to [bus 03-03] (subtractive
decode)
...
[    1.292271] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low)
-> IRQ 19
[    1.299403] ata_piix 0000:00:1f.2: MAP [ IDE IDE P1 P3 ]
[    1.460138] scsi0 : ata_piix
[    1.463105] scsi1 : ata_piix
[    1.467639] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0
irq 14
[    1.474591] ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xffa8
irq 15
[    1.481608] sata_sil24 0000:02:00.0: PCI INT A -> GSI 18 (level, low)
-> IRQ 18
[    1.489384] scsi2 : sata_sil24
[    1.492521] scsi3 : sata_sil24
[    1.495599] ata3: SATA max UDMA/100 host m128@0xff8ffc00 port
0xff8f8000 irq 18
[    1.502891] ata4: SATA max UDMA/100 host m128@0xff8ffc00 port
0xff8fa000 irq 18
...
[    1.655192] ata1.00: CFA: TRANSCEND, 20071207, max UDMA/66
[    1.660665] ata1.00: 7831152 sectors, multi 0: LBA
[    1.665543] ata1.00: limited to UDMA/33 due to 40-wire cable
...
[    1.756218] ata1.00: configured for UDMA/33
[    1.760510] scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND
  2007 PQ: 0 ANSI: 5
[    1.768801] sd 0:0:0:0: [sda] 7831152 512-byte logical blocks: (4.00
GB/3.73 GiB)
[    1.776324] sd 0:0:0:0: [sda] Write Protect is off
[    1.781128] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    1.790375]  sda:
...
[    1.842954]  sda1
...[    3.572048] ata3: SATA link down (SStatus 0 SControl 0)
[    5.656053] ata4: SATA link down (SStatus 0 SControl 0)


dmesg when in Enhanced AHCI mode (no sdX detected but IDE DOM is in PATA
port):

[    0.272934] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by
ICH6 ACPI/GPIO/TCO
[    0.276006] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by
ICH6 GPIO
[    0.280005] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at
0a00 (mask 00ff)
[    0.284407] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.288200] pci 0000:00:1c.2: PCI bridge to [bus 02-02]
[    0.292063] pci 0000:00:1e.0: PCI bridge to [bus 03-03] (subtractive
decode)
...
[    1.296627] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.303527] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps
0xf impl SATA mode
[    1.311599] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
[    1.318752] scsi0 : ahci
[    1.321466] scsi1 : ahci
[    1.324066] scsi2 : ahci
[    1.326640] scsi3 : ahci
[    1.329319] ata1: SATA max UDMA/133 abar m1024@0xffa3fc00 port
0xffa3fd00 irq 26
[    1.336697] ata2: SATA max UDMA/133 abar m1024@0xffa3fc00 port
0xffa3fd80 irq 26
[    1.344069] ata3: SATA max UDMA/133 abar m1024@0xffa3fc00 port
0xffa3fe00 irq 26
[    1.351439] ata4: SATA max UDMA/133 abar m1024@0xffa3fc00 port
0xffa3fe80 irq 26
[    1.358898] sata_sil24 0000:02:00.0: PCI INT A -> GSI 18 (level, low)
-> IRQ 18
[    1.366581] scsi4 : sata_sil24
[    1.369736] scsi5 : sata_sil24
[    1.372825] ata5: SATA max UDMA/100 host m128@0xff8ffc00 port
0xff8f8000 irq 18
[    1.380114] ata6: SATA max UDMA/100 host m128@0xff8ffc00 port
0xff8fa000 irq 18
...
[    1.733350] ata1: SATA link down (SStatus 0 SControl 300)
[    1.738751] ata2: SATA link down (SStatus 0 SControl 300)
[    1.744157] ata3: SATA link down (SStatus 0 SControl 300)
[    1.749553] ata4: SATA link down (SStatus 0 SControl 300)
..
[    3.520041] ata5: SATA link down (SStatus 0 SControl 0)
[    5.604028] ata6: SATA link down (SStatus 0 SControl 0)



dmesg when in Enhanced AHCI mode + IDE PIIX driver (IDE DOM detected as
hda on ide0):

[    0.268942] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by
ICH6 ACPI/GPIO/TCO
[    0.272008] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by
ICH6 GPIO
[    0.276003] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at
0a00 (mask 00ff)
[    0.280407] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.284200] pci 0000:00:1c.2: PCI bridge to [bus 02-02]
[    0.288063] pci 0000:00:1e.0: PCI bridge to [bus 03-03] (subtractive
decode)
...
[    1.287943] Uniform Multi-Platform E-IDE driver
[    1.292538] ide_generic: please use "probe_mask=0x3f" module
parameter for probing all legacy ISA IDE ports
[    1.588285] hda: TRANSCEND, CFA DISK drive
[    2.264079] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.836073] ide1 at 0x170-0x177,0x376 on irq 15
[    2.840612] ide-gd driver 1.18
[    2.843672] hda: max request size: 128KiB
[    2.847677] hda: 7831152 sectors (4009 MB) w/1KiB Cache, CHS=7769/16/63
[    2.854349]  hda: hda1
[    2.867317] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    2.874213] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps
0xf impl SATA mode
[    2.882285] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
[    2.889423] scsi0 : ahci
[    2.892141] scsi1 : ahci
[    2.894722] scsi2 : ahci
[    2.897317] scsi3 : ahci
[    2.899988] ata1: SATA max UDMA/133 abar m1024@0xffa3fc00 port
0xffa3fd00 irq 26
[    2.907371] ata2: SATA max UDMA/133 abar m1024@0xffa3fc00 port
0xffa3fd80 irq 26
[    2.914742] ata3: SATA max UDMA/133 abar m1024@0xffa3fc00 port
0xffa3fe00 irq 26
[    2.922114] ata4: SATA max UDMA/133 abar m1024@0xffa3fc00 port
0xffa3fe80 irq 26
[    2.929583] sata_sil24 0000:02:00.0: PCI INT A -> GSI 18 (level, low)
-> IRQ 18
[    2.937272] scsi4 : sata_sil24
[    2.940422] scsi5 : sata_sil24
[    2.943498] ata5: SATA max UDMA/100 host m128@0xff8ffc00 port
0xff8f8000 irq 18
[    2.950799] ata6: SATA max UDMA/100 host m128@0xff8ffc00 port
0xff8fa000 irq 18
...
[    3.305027] ata1: SATA link down (SStatus 0 SControl 300)
[    3.310429] ata2: SATA link down (SStatus 0 SControl 300)
[    3.315836] ata3: SATA link down (SStatus 0 SControl 300)
[    3.321232] ata4: SATA link down (SStatus 0 SControl 300)
..
[    5.092032] ata5: SATA link down (SStatus 0 SControl 0)
[    7.176025] ata6: SATA link down (SStatus 0 SControl 0)
