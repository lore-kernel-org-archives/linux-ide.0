From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sun, 18 Mar 2007 07:42:55 +0100
Message-ID: <45FCDF6F.5020104@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703171429.49646.bzolnier@gmail.com> <45FBFD89.3080308@tw.ibm.com> <200703171600.55863.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000202050007030807070406"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:61950 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbXCRGnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 02:43:04 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1037986uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 23:43:02 -0700 (PDT)
In-Reply-To: <200703171600.55863.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202050007030807070406
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bartek and Albert,

I did the test. Well, this time I have both - cd and dvd drives. I 
attached my dmesg.

Yarema


> Which unfortunately says us nothing besides that pdc202xx_new works great
> on this system... ;-)
> 
> Yarema, could you disable ata_piix, enable drivers/ide piix driver and retest?
> 
> Thanks,
> Bart
> 


--------------000202050007030807070406
Content-Type: text/plain;
 name="dmesg_output_ide"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_output_ide"

[    0.000000] Linux version 2.6.20.3 (root@zaraza) (gcc version 4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #1 Fri Mar 16 17:07:50 CET 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000001fef0000 end: 000000001fff0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000001fff0000 size: 0000000000003000 end: 000000001fff3000 type: 4
[    0.000000] copy_e820_map() start: 000000001fff3000 size: 000000000000d000 end: 0000000020000000 type: 3
[    0.000000] copy_e820_map() start: 00000000fec00000 size: 0000000001400000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f4c80
[    0.000000] Entering add_active_range(0, 0, 131056) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   131056
[    0.000000]   HighMem    131056 ->   131056
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   131056
[    0.000000] On node 0 totalpages: 131056
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 991 pages used for memmap
[    0.000000]   Normal zone: 125969 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages used for memmap
[    0.000000] DMI not present or invalid.
[    0.000000] ACPI: RSDP (v000 GBT                                   ) @ 0x000f6710
[    0.000000] ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
[    0.000000] ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
[    0.000000] ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff6800
[    0.000000] ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
[    0.000000] ACPI: Disabling ACPI support
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
[    0.000000] Processor #0 15:1 APIC version 17
[    0.000000] I/O APIC #2 Version 17 at 0xFEC00000.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Processors: 1
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
[    0.000000] Detected 1800.160 MHz processor.
[   21.710785] Built 1 zonelists.  Total pages: 130033
[   21.710788] Kernel command line: root=UUID=bdcb0225-6620-4d74-9fe5-2f008da464c7 ro quiet splash
[   21.711034] mapped APIC to ffffd000 (fee00000)
[   21.711037] mapped IOAPIC to ffffc000 (fec00000)
[   21.711043] Enabling fast FPU save and restore... done.
[   21.711047] Enabling unmasked SIMD FPU exception support... done.
[   21.711072] Initializing CPU#0
[   21.711194] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   21.712878] Console: colour VGA+ 80x25
[   21.713540] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   21.714210] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   21.736853] Memory: 474616k/524224k available (1898k kernel code, 48984k reserved, 850k data, 320k init, 0k highmem)
[   21.736866] virtual kernel memory layout:
[   21.736868]     fixmap  : 0xfffa9000 - 0xfffff000   ( 344 kB)
[   21.736870]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   21.736871]     vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
[   21.736873]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[   21.736875]       .init : 0xc03b2000 - 0xc0402000   ( 320 kB)
[   21.736876]       .data : 0xc02dab73 - 0xc03af434   ( 850 kB)
[   21.736878]       .text : 0xc0100000 - 0xc02dab73   (1898 kB)
[   21.736882] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   21.815045] Calibrating delay using timer specific routine.. 3603.21 BogoMIPS (lpj=7206434)
[   21.815095] Security Framework v1.0.0 initialized
[   21.815107] SELinux:  Disabled at boot.
[   21.815124] Mount-cache hash table entries: 512
[   21.815283] CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 00000000 00000000 00000000
[   21.815298] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   21.815301] CPU: L2 cache: 256K
[   21.815304] CPU: After all inits, caps: 3febfbff 00000000 00000000 00003080 00000000 00000000 00000000
[   21.815335] CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 02
[   21.815347] Checking 'hlt' instruction... OK.
[   21.831724] ExtINT not setup in hardware but reported by MP table
[   21.831809] ENABLING IO-APIC IRQs
[   21.832047] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
[   21.978900] PM: Adding info for No Bus:platform
[   21.979143] Booting paravirtualized kernel on bare hardware
[   21.979260] Time: 21:21:38  Date: 02/16/107
[   21.979319] NET: Registered protocol family 16
[   21.979377] PM: Adding info for No Bus:vtcon0
[   21.979517] EISA bus registered
[   22.005146] PCI: PCI BIOS revision 2.10 entry at 0xfb230, last bus=2
[   22.005150] PCI: Using configuration type 1
[   22.005153] Setting up standard PCI resources
[   22.011855] ACPI: Interpreter disabled.
[   22.011864] Linux Plug and Play Support v0.97 (c) Adam Belay
[   22.011884] pnp: PnP ACPI: disabled
[   22.011888] PnPBIOS: Scanning system for PnP BIOS support...
[   22.011944] PnPBIOS: Found PnP BIOS installation structure at 0xc00fbc20
[   22.011948] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbc50, dseg 0xf0000
[   22.011964] PM: Adding info for No Bus:pnp0
[   22.012001] PM: Adding info for pnp:00:00
[   22.012115] PM: Adding info for pnp:00:01
[   22.012172] PM: Adding info for pnp:00:02
[   22.012224] PM: Adding info for pnp:00:03
[   22.012274] PM: Adding info for pnp:00:04
[   22.012337] PM: Adding info for pnp:00:05
[   22.012393] PM: Adding info for pnp:00:06
[   22.012446] PM: Adding info for pnp:00:07
[   22.012497] PM: Adding info for pnp:00:08
[   22.012555] PM: Adding info for pnp:00:09
[   22.012608] PM: Adding info for pnp:00:0a
[   22.012673] PM: Adding info for pnp:00:0b
[   22.012768] PM: Adding info for pnp:00:0c
[   22.012845] PM: Adding info for pnp:00:0d
[   22.012949] PM: Adding info for pnp:00:0f
[   22.013044] PM: Adding info for pnp:00:10
[   22.013134] PM: Adding info for pnp:00:11
[   22.013224] PM: Adding info for pnp:00:12
[   22.013279] PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
[   22.013354] PCI: Probing PCI hardware
[   22.013361] PCI: Probing PCI hardware (bus 00)
[   22.013371] PM: Adding info for No Bus:pci0000:00
[   22.013640] PCI quirk: region 4000-407f claimed by ICH4 ACPI/GPIO/TCO
[   22.013646] PCI quirk: region 4080-40bf claimed by ICH4 GPIO
[   22.014012] Boot video device is 0000:01:00.0
[   22.014250] PCI: Transparent bridge - 0000:00:1e.0
[   22.014278] PM: Adding info for pci:0000:00:00.0
[   22.014347] PM: Adding info for pci:0000:00:01.0
[   22.014404] PM: Adding info for pci:0000:00:1e.0
[   22.014456] PM: Adding info for pci:0000:00:1f.0
[   22.014510] PM: Adding info for pci:0000:00:1f.1
[   22.014579] PM: Adding info for pci:0000:00:1f.2
[   22.014633] PM: Adding info for pci:0000:00:1f.3
[   22.014689] PM: Adding info for pci:0000:00:1f.4
[   22.014769] PM: Adding info for pci:0000:00:1f.5
[   22.014832] PM: Adding info for pci:0000:01:00.0
[   22.014894] PM: Adding info for pci:0000:02:01.0
[   22.014948] PM: Adding info for pci:0000:02:05.0
[   22.015099] PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
[   22.015120] PCI->APIC IRQ transform: 0000:00:1f.2[D] -> IRQ 19
[   22.015125] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[   22.015129] PCI->APIC IRQ transform: 0000:00:1f.4[C] -> IRQ 23
[   22.015133] PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
[   22.015137] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[   22.015141] PCI->APIC IRQ transform: 0000:02:01.0[A] -> IRQ 21
[   22.015145] PCI->APIC IRQ transform: 0000:02:05.0[A] -> IRQ 21
[   22.030443] NET: Registered protocol family 8
[   22.030446] NET: Registered protocol family 20
[   22.030613] PM: Adding info for No Bus:mem
[   22.030673] PM: Adding info for No Bus:kmem
[   22.030715] PM: Adding info for No Bus:null
[   22.030770] PM: Adding info for No Bus:port
[   22.030826] PM: Adding info for No Bus:zero
[   22.030866] PM: Adding info for No Bus:full
[   22.030904] PM: Adding info for No Bus:random
[   22.030946] PM: Adding info for No Bus:urandom
[   22.030985] PM: Adding info for No Bus:kmsg
[   22.031023] PM: Adding info for No Bus:oldmem
[   22.031100] PCI: Bridge: 0000:00:01.0
[   22.031104]   IO window: c000-cfff
[   22.031109]   MEM window: ec000000-edffffff
[   22.031114]   PREFETCH window: e0000000-e7ffffff
[   22.031120] PCI: Bridge: 0000:00:1e.0
[   22.031123]   IO window: a000-bfff
[   22.031130]   MEM window: ee000000-efffffff
[   22.031135]   PREFETCH window: 30000000-300fffff
[   22.031158] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   22.031207] NET: Registered protocol family 2
[   22.058780] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   22.058921] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[   22.059012] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[   22.059062] TCP: Hash tables configured (established 16384 bind 8192)
[   22.059066] TCP reno registered
[   22.070890] checking if image is initramfs... it is
[   27.506291] Freeing initrd memory: 41014k freed
[   27.506611] PM: Adding info for platform:pcspkr
[   27.507009] PM: Adding info for No Bus:snapshot
[   27.507058] audit: initializing netlink socket (disabled)
[   27.507084] audit(1174080102.888:1): initialized
[   27.507289] VFS: Disk quotas dquot_6.5.1
[   27.507326] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   27.507425] io scheduler noop registered
[   27.507430] io scheduler anticipatory registered
[   27.507433] io scheduler deadline registered
[   27.507452] io scheduler cfq registered (default)
[   27.507831] PM: Adding info for No Bus:pnp1
[   27.507842] isapnp: Scanning for PnP cards...
[   27.861570] isapnp: No Plug & Play device found
[   27.861606] PM: Adding info for No Bus:tty
[   27.861668] PM: Adding info for No Bus:console
[   27.861713] PM: Adding info for No Bus:ptmx
[   27.861752] PM: Adding info for No Bus:tty0
[   27.861813] PM: Adding info for No Bus:vcs
[   27.861855] PM: Adding info for No Bus:vcsa
[   27.861915] PM: Adding info for No Bus:tty1
[   27.861959] PM: Adding info for No Bus:tty2
[   27.862009] PM: Adding info for No Bus:tty3
[   27.862047] PM: Adding info for No Bus:tty4
[   27.862087] PM: Adding info for No Bus:tty5
[   27.862124] PM: Adding info for No Bus:tty6
[   27.862163] PM: Adding info for No Bus:tty7
[   27.862210] PM: Adding info for No Bus:tty8
[   27.862254] PM: Adding info for No Bus:tty9
[   27.862292] PM: Adding info for No Bus:tty10
[   27.862341] PM: Adding info for No Bus:tty11
[   27.862382] PM: Adding info for No Bus:tty12
[   27.862424] PM: Adding info for No Bus:tty13
[   27.862474] PM: Adding info for No Bus:tty14
[   27.862517] PM: Adding info for No Bus:tty15
[   27.862555] PM: Adding info for No Bus:tty16
[   27.862600] PM: Adding info for No Bus:tty17
[   27.862642] PM: Adding info for No Bus:tty18
[   27.862684] PM: Adding info for No Bus:tty19
[   27.862727] PM: Adding info for No Bus:tty20
[   27.862780] PM: Adding info for No Bus:tty21
[   27.862825] PM: Adding info for No Bus:tty22
[   27.862871] PM: Adding info for No Bus:tty23
[   27.862913] PM: Adding info for No Bus:tty24
[   27.862958] PM: Adding info for No Bus:tty25
[   27.862999] PM: Adding info for No Bus:tty26
[   27.863049] PM: Adding info for No Bus:tty27
[   27.863091] PM: Adding info for No Bus:tty28
[   27.863135] PM: Adding info for No Bus:tty29
[   27.863176] PM: Adding info for No Bus:tty30
[   27.863222] PM: Adding info for No Bus:tty31
[   27.863267] PM: Adding info for No Bus:tty32
[   27.863313] PM: Adding info for No Bus:tty33
[   27.863365] PM: Adding info for No Bus:tty34
[   27.863410] PM: Adding info for No Bus:tty35
[   27.863451] PM: Adding info for No Bus:tty36
[   27.863496] PM: Adding info for No Bus:tty37
[   27.863542] PM: Adding info for No Bus:tty38
[   27.863587] PM: Adding info for No Bus:tty39
[   27.863639] PM: Adding info for No Bus:tty40
[   27.863690] PM: Adding info for No Bus:tty41
[   27.863732] PM: Adding info for No Bus:tty42
[   27.863775] PM: Adding info for No Bus:tty43
[   27.863822] PM: Adding info for No Bus:tty44
[   27.863867] PM: Adding info for No Bus:tty45
[   27.863909] PM: Adding info for No Bus:tty46
[   27.863969] PM: Adding info for No Bus:tty47
[   27.864016] PM: Adding info for No Bus:tty48
[   27.864062] PM: Adding info for No Bus:tty49
[   27.864115] PM: Adding info for No Bus:tty50
[   27.864161] PM: Adding info for No Bus:tty51
[   27.864206] PM: Adding info for No Bus:tty52
[   27.864263] PM: Adding info for No Bus:tty53
[   27.864309] PM: Adding info for No Bus:tty54
[   27.864356] PM: Adding info for No Bus:tty55
[   27.864403] PM: Adding info for No Bus:tty56
[   27.864453] PM: Adding info for No Bus:tty57
[   27.864499] PM: Adding info for No Bus:tty58
[   27.864550] PM: Adding info for No Bus:tty59
[   27.864606] PM: Adding info for No Bus:tty60
[   27.864652] PM: Adding info for No Bus:tty61
[   27.864700] PM: Adding info for No Bus:tty62
[   27.864747] PM: Adding info for No Bus:tty63
[   27.864883] PM: Adding info for No Bus:ptyp0
[   27.864945] PM: Adding info for No Bus:ptyp1
[   27.865002] PM: Adding info for No Bus:ptyp2
[   27.865054] PM: Adding info for No Bus:ptyp3
[   27.865101] PM: Adding info for No Bus:ptyp4
[   27.865147] PM: Adding info for No Bus:ptyp5
[   27.865190] PM: Adding info for No Bus:ptyp6
[   27.865243] PM: Adding info for No Bus:ptyp7
[   27.865290] PM: Adding info for No Bus:ptyp8
[   27.865350] PM: Adding info for No Bus:ptyp9
[   27.865396] PM: Adding info for No Bus:ptypa
[   27.865445] PM: Adding info for No Bus:ptypb
[   27.865489] PM: Adding info for No Bus:ptypc
[   27.865540] PM: Adding info for No Bus:ptypd
[   27.865588] PM: Adding info for No Bus:ptype
[   27.865648] PM: Adding info for No Bus:ptypf
[   27.865698] PM: Adding info for No Bus:ptyq0
[   27.865748] PM: Adding info for No Bus:ptyq1
[   27.865796] PM: Adding info for No Bus:ptyq2
[   27.865858] PM: Adding info for No Bus:ptyq3
[   27.865908] PM: Adding info for No Bus:ptyq4
[   27.865955] PM: Adding info for No Bus:ptyq5
[   27.866082] PM: Adding info for No Bus:ptyq6
[   27.866136] PM: Adding info for No Bus:ptyq7
[   27.866182] PM: Adding info for No Bus:ptyq8
[   27.866233] PM: Adding info for No Bus:ptyq9
[   27.866282] PM: Adding info for No Bus:ptyqa
[   27.866333] PM: Adding info for No Bus:ptyqb
[   27.866392] PM: Adding info for No Bus:ptyqc
[   27.866446] PM: Adding info for No Bus:ptyqd
[   27.866495] PM: Adding info for No Bus:ptyqe
[   27.866552] PM: Adding info for No Bus:ptyqf
[   27.866606] PM: Adding info for No Bus:ptyr0
[   27.866659] PM: Adding info for No Bus:ptyr1
[   27.866714] PM: Adding info for No Bus:ptyr2
[   27.866781] PM: Adding info for No Bus:ptyr3
[   27.866832] PM: Adding info for No Bus:ptyr4
[   27.866885] PM: Adding info for No Bus:ptyr5
[   27.866935] PM: Adding info for No Bus:ptyr6
[   27.866987] PM: Adding info for No Bus:ptyr7
[   27.867042] PM: Adding info for No Bus:ptyr8
[   27.867102] PM: Adding info for No Bus:ptyr9
[   27.867161] PM: Adding info for No Bus:ptyra
[   27.867222] PM: Adding info for No Bus:ptyrb
[   27.867275] PM: Adding info for No Bus:ptyrc
[   27.867327] PM: Adding info for No Bus:ptyrd
[   27.867384] PM: Adding info for No Bus:ptyre
[   27.867440] PM: Adding info for No Bus:ptyrf
[   27.867507] PM: Adding info for No Bus:ptys0
[   27.867565] PM: Adding info for No Bus:ptys1
[   27.867618] PM: Adding info for No Bus:ptys2
[   27.867673] PM: Adding info for No Bus:ptys3
[   27.867731] PM: Adding info for No Bus:ptys4
[   27.867786] PM: Adding info for No Bus:ptys5
[   27.867852] PM: Adding info for No Bus:ptys6
[   27.867914] PM: Adding info for No Bus:ptys7
[   27.867972] PM: Adding info for No Bus:ptys8
[   27.868030] PM: Adding info for No Bus:ptys9
[   27.868090] PM: Adding info for No Bus:ptysa
[   27.868147] PM: Adding info for No Bus:ptysb
[   27.868202] PM: Adding info for No Bus:ptysc
[   27.868277] PM: Adding info for No Bus:ptysd
[   27.868332] PM: Adding info for No Bus:ptyse
[   27.868389] PM: Adding info for No Bus:ptysf
[   27.868448] PM: Adding info for No Bus:ptyt0
[   27.868505] PM: Adding info for No Bus:ptyt1
[   27.868566] PM: Adding info for No Bus:ptyt2
[   27.868645] PM: Adding info for No Bus:ptyt3
[   27.868705] PM: Adding info for No Bus:ptyt4
[   27.868764] PM: Adding info for No Bus:ptyt5
[   27.868824] PM: Adding info for No Bus:ptyt6
[   27.868886] PM: Adding info for No Bus:ptyt7
[   27.868948] PM: Adding info for No Bus:ptyt8
[   27.869010] PM: Adding info for No Bus:ptyt9
[   27.869081] PM: Adding info for No Bus:ptyta
[   27.869147] PM: Adding info for No Bus:ptytb
[   27.869212] PM: Adding info for No Bus:ptytc
[   27.869275] PM: Adding info for No Bus:ptytd
[   27.869338] PM: Adding info for No Bus:ptyte
[   27.869408] PM: Adding info for No Bus:ptytf
[   27.869480] PM: Adding info for No Bus:ptyu0
[   27.869544] PM: Adding info for No Bus:ptyu1
[   27.869607] PM: Adding info for No Bus:ptyu2
[   27.869674] PM: Adding info for No Bus:ptyu3
[   27.869737] PM: Adding info for No Bus:ptyu4
[   27.869802] PM: Adding info for No Bus:ptyu5
[   27.869913] PM: Adding info for No Bus:ptyu6
[   27.870040] PM: Adding info for No Bus:ptyu7
[   27.870119] PM: Adding info for No Bus:ptyu8
[   27.870186] PM: Adding info for No Bus:ptyu9
[   27.870249] PM: Adding info for No Bus:ptyua
[   27.870319] PM: Adding info for No Bus:ptyub
[   27.870383] PM: Adding info for No Bus:ptyuc
[   27.870454] PM: Adding info for No Bus:ptyud
[   27.870526] PM: Adding info for No Bus:ptyue
[   27.870591] PM: Adding info for No Bus:ptyuf
[   27.870651] PM: Adding info for No Bus:ptyv0
[   27.870714] PM: Adding info for No Bus:ptyv1
[   27.870776] PM: Adding info for No Bus:ptyv2
[   27.870845] PM: Adding info for No Bus:ptyv3
[   27.870937] PM: Adding info for No Bus:ptyv4
[   27.871005] PM: Adding info for No Bus:ptyv5
[   27.871075] PM: Adding info for No Bus:ptyv6
[   27.871146] PM: Adding info for No Bus:ptyv7
[   27.871214] PM: Adding info for No Bus:ptyv8
[   27.871280] PM: Adding info for No Bus:ptyv9
[   27.871359] PM: Adding info for No Bus:ptyva
[   27.871431] PM: Adding info for No Bus:ptyvb
[   27.871497] PM: Adding info for No Bus:ptyvc
[   27.871567] PM: Adding info for No Bus:ptyvd
[   27.871638] PM: Adding info for No Bus:ptyve
[   27.871703] PM: Adding info for No Bus:ptyvf
[   27.871776] PM: Adding info for No Bus:ptyw0
[   27.871856] PM: Adding info for No Bus:ptyw1
[   27.871926] PM: Adding info for No Bus:ptyw2
[   27.872000] PM: Adding info for No Bus:ptyw3
[   27.872069] PM: Adding info for No Bus:ptyw4
[   27.872139] PM: Adding info for No Bus:ptyw5
[   27.872214] PM: Adding info for No Bus:ptyw6
[   27.872295] PM: Adding info for No Bus:ptyw7
[   27.872368] PM: Adding info for No Bus:ptyw8
[   27.872446] PM: Adding info for No Bus:ptyw9
[   27.872516] PM: Adding info for No Bus:ptywa
[   27.872588] PM: Adding info for No Bus:ptywb
[   27.872664] PM: Adding info for No Bus:ptywc
[   27.872736] PM: Adding info for No Bus:ptywd
[   27.872817] PM: Adding info for No Bus:ptywe
[   27.872897] PM: Adding info for No Bus:ptywf
[   27.872972] PM: Adding info for No Bus:ptyx0
[   27.873045] PM: Adding info for No Bus:ptyx1
[   27.873122] PM: Adding info for No Bus:ptyx2
[   27.873201] PM: Adding info for No Bus:ptyx3
[   27.873288] PM: Adding info for No Bus:ptyx4
[   27.873370] PM: Adding info for No Bus:ptyx5
[   27.873445] PM: Adding info for No Bus:ptyx6
[   27.873518] PM: Adding info for No Bus:ptyx7
[   27.873596] PM: Adding info for No Bus:ptyx8
[   27.873676] PM: Adding info for No Bus:ptyx9
[   27.873755] PM: Adding info for No Bus:ptyxa
[   27.873911] PM: Adding info for No Bus:ptyxb
[   27.874065] PM: Adding info for No Bus:ptyxc
[   27.874154] PM: Adding info for No Bus:ptyxd
[   27.874239] PM: Adding info for No Bus:ptyxe
[   27.874318] PM: Adding info for No Bus:ptyxf
[   27.874396] PM: Adding info for No Bus:ptyy0
[   27.874482] PM: Adding info for No Bus:ptyy1
[   27.874561] PM: Adding info for No Bus:ptyy2
[   27.874640] PM: Adding info for No Bus:ptyy3
[   27.874720] PM: Adding info for No Bus:ptyy4
[   27.874797] PM: Adding info for No Bus:ptyy5
[   27.874875] PM: Adding info for No Bus:ptyy6
[   27.874957] PM: Adding info for No Bus:ptyy7
[   27.875050] PM: Adding info for No Bus:ptyy8
[   27.875129] PM: Adding info for No Bus:ptyy9
[   27.875210] PM: Adding info for No Bus:ptyya
[   27.875298] PM: Adding info for No Bus:ptyyb
[   27.875378] PM: Adding info for No Bus:ptyyc
[   27.875463] PM: Adding info for No Bus:ptyyd
[   27.875551] PM: Adding info for No Bus:ptyye
[   27.875630] PM: Adding info for No Bus:ptyyf
[   27.875714] PM: Adding info for No Bus:ptyz0
[   27.875800] PM: Adding info for No Bus:ptyz1
[   27.875881] PM: Adding info for No Bus:ptyz2
[   27.875970] PM: Adding info for No Bus:ptyz3
[   27.876052] PM: Adding info for No Bus:ptyz4
[   27.876144] PM: Adding info for No Bus:ptyz5
[   27.876232] PM: Adding info for No Bus:ptyz6
[   27.876313] PM: Adding info for No Bus:ptyz7
[   27.876391] PM: Adding info for No Bus:ptyz8
[   27.876481] PM: Adding info for No Bus:ptyz9
[   27.876569] PM: Adding info for No Bus:ptyza
[   27.876666] PM: Adding info for No Bus:ptyzb
[   27.876766] PM: Adding info for No Bus:ptyzc
[   27.876856] PM: Adding info for No Bus:ptyzd
[   27.876943] PM: Adding info for No Bus:ptyze
[   27.877036] PM: Adding info for No Bus:ptyzf
[   27.877129] PM: Adding info for No Bus:ptya0
[   27.877221] PM: Adding info for No Bus:ptya1
[   27.877335] PM: Adding info for No Bus:ptya2
[   27.877426] PM: Adding info for No Bus:ptya3
[   27.877512] PM: Adding info for No Bus:ptya4
[   27.877602] PM: Adding info for No Bus:ptya5
[   27.877693] PM: Adding info for No Bus:ptya6
[   27.877786] PM: Adding info for No Bus:ptya7
[   27.877949] PM: Adding info for No Bus:ptya8
[   27.878124] PM: Adding info for No Bus:ptya9
[   27.878225] PM: Adding info for No Bus:ptyaa
[   27.878323] PM: Adding info for No Bus:ptyab
[   27.878415] PM: Adding info for No Bus:ptyac
[   27.878509] PM: Adding info for No Bus:ptyad
[   27.878606] PM: Adding info for No Bus:ptyae
[   27.878716] PM: Adding info for No Bus:ptyaf
[   27.878808] PM: Adding info for No Bus:ptyb0
[   27.878903] PM: Adding info for No Bus:ptyb1
[   27.879000] PM: Adding info for No Bus:ptyb2
[   27.879094] PM: Adding info for No Bus:ptyb3
[   27.879193] PM: Adding info for No Bus:ptyb4
[   27.879298] PM: Adding info for No Bus:ptyb5
[   27.879394] PM: Adding info for No Bus:ptyb6
[   27.879498] PM: Adding info for No Bus:ptyb7
[   27.879595] PM: Adding info for No Bus:ptyb8
[   27.879694] PM: Adding info for No Bus:ptyb9
[   27.879798] PM: Adding info for No Bus:ptyba
[   27.879904] PM: Adding info for No Bus:ptybb
[   27.880017] PM: Adding info for No Bus:ptybc
[   27.880122] PM: Adding info for No Bus:ptybd
[   27.880224] PM: Adding info for No Bus:ptybe
[   27.880321] PM: Adding info for No Bus:ptybf
[   27.880425] PM: Adding info for No Bus:ptyc0
[   27.880530] PM: Adding info for No Bus:ptyc1
[   27.880640] PM: Adding info for No Bus:ptyc2
[   27.880767] PM: Adding info for No Bus:ptyc3
[   27.880881] PM: Adding info for No Bus:ptyc4
[   27.880988] PM: Adding info for No Bus:ptyc5
[   27.881099] PM: Adding info for No Bus:ptyc6
[   27.881206] PM: Adding info for No Bus:ptyc7
[   27.881309] PM: Adding info for No Bus:ptyc8
[   27.881429] PM: Adding info for No Bus:ptyc9
[   27.881536] PM: Adding info for No Bus:ptyca
[   27.881642] PM: Adding info for No Bus:ptycb
[   27.881752] PM: Adding info for No Bus:ptycc
[   27.881910] PM: Adding info for No Bus:ptycd
[   27.882099] PM: Adding info for No Bus:ptyce
[   27.882233] PM: Adding info for No Bus:ptycf
[   27.882342] PM: Adding info for No Bus:ptyd0
[   27.882444] PM: Adding info for No Bus:ptyd1
[   27.882544] PM: Adding info for No Bus:ptyd2
[   27.882658] PM: Adding info for No Bus:ptyd3
[   27.882768] PM: Adding info for No Bus:ptyd4
[   27.882877] PM: Adding info for No Bus:ptyd5
[   27.883008] PM: Adding info for No Bus:ptyd6
[   27.883118] PM: Adding info for No Bus:ptyd7
[   27.883232] PM: Adding info for No Bus:ptyd8
[   27.883348] PM: Adding info for No Bus:ptyd9
[   27.883461] PM: Adding info for No Bus:ptyda
[   27.883584] PM: Adding info for No Bus:ptydb
[   27.883712] PM: Adding info for No Bus:ptydc
[   27.883832] PM: Adding info for No Bus:ptydd
[   27.883944] PM: Adding info for No Bus:ptyde
[   27.884063] PM: Adding info for No Bus:ptydf
[   27.884182] PM: Adding info for No Bus:ptye0
[   27.884301] PM: Adding info for No Bus:ptye1
[   27.884429] PM: Adding info for No Bus:ptye2
[   27.884569] PM: Adding info for No Bus:ptye3
[   27.884692] PM: Adding info for No Bus:ptye4
[   27.884818] PM: Adding info for No Bus:ptye5
[   27.884937] PM: Adding info for No Bus:ptye6
[   27.885060] PM: Adding info for No Bus:ptye7
[   27.885188] PM: Adding info for No Bus:ptye8
[   27.885324] PM: Adding info for No Bus:ptye9
[   27.885447] PM: Adding info for No Bus:ptyea
[   27.885575] PM: Adding info for No Bus:ptyeb
[   27.885697] PM: Adding info for No Bus:ptyec
[   27.885892] PM: Adding info for No Bus:ptyed
[   27.886123] PM: Adding info for No Bus:ptyee
[   27.886268] PM: Adding info for No Bus:ptyef
[   27.886425] PM: Adding info for No Bus:ttyp0
[   27.886551] PM: Adding info for No Bus:ttyp1
[   27.886664] PM: Adding info for No Bus:ttyp2
[   27.886793] PM: Adding info for No Bus:ttyp3
[   27.886910] PM: Adding info for No Bus:ttyp4
[   27.887024] PM: Adding info for No Bus:ttyp5
[   27.887153] PM: Adding info for No Bus:ttyp6
[   27.887269] PM: Adding info for No Bus:ttyp7
[   27.887385] PM: Adding info for No Bus:ttyp8
[   27.887505] PM: Adding info for No Bus:ttyp9
[   27.887628] PM: Adding info for No Bus:ttypa
[   27.887756] PM: Adding info for No Bus:ttypb
[   27.887881] PM: Adding info for No Bus:ttypc
[   27.888021] PM: Adding info for No Bus:ttypd
[   27.888151] PM: Adding info for No Bus:ttype
[   27.888289] PM: Adding info for No Bus:ttypf
[   27.888414] PM: Adding info for No Bus:ttyq0
[   27.888542] PM: Adding info for No Bus:ttyq1
[   27.888673] PM: Adding info for No Bus:ttyq2
[   27.888818] PM: Adding info for No Bus:ttyq3
[   27.888952] PM: Adding info for No Bus:ttyq4
[   27.889081] PM: Adding info for No Bus:ttyq5
[   27.889206] PM: Adding info for No Bus:ttyq6
[   27.889333] PM: Adding info for No Bus:ttyq7
[   27.889461] PM: Adding info for No Bus:ttyq8
[   27.889598] PM: Adding info for No Bus:ttyq9
[   27.889745] PM: Adding info for No Bus:ttyqa
[   27.890047] PM: Adding info for No Bus:ttyqb
[   27.890218] PM: Adding info for No Bus:ttyqc
[   27.890351] PM: Adding info for No Bus:ttyqd
[   27.890479] PM: Adding info for No Bus:ttyqe
[   27.890605] PM: Adding info for No Bus:ttyqf
[   27.890743] PM: Adding info for No Bus:ttyr0
[   27.890878] PM: Adding info for No Bus:ttyr1
[   27.891008] PM: Adding info for No Bus:ttyr2
[   27.891146] PM: Adding info for No Bus:ttyr3
[   27.891278] PM: Adding info for No Bus:ttyr4
[   27.891405] PM: Adding info for No Bus:ttyr5
[   27.891538] PM: Adding info for No Bus:ttyr6
[   27.891697] PM: Adding info for No Bus:ttyr7
[   27.891832] PM: Adding info for No Bus:ttyr8
[   27.891962] PM: Adding info for No Bus:ttyr9
[   27.892103] PM: Adding info for No Bus:ttyra
[   27.892247] PM: Adding info for No Bus:ttyrb
[   27.892389] PM: Adding info for No Bus:ttyrc
[   27.892542] PM: Adding info for No Bus:ttyrd
[   27.892690] PM: Adding info for No Bus:ttyre
[   27.892830] PM: Adding info for No Bus:ttyrf
[   27.892975] PM: Adding info for No Bus:ttys0
[   27.893120] PM: Adding info for No Bus:ttys1
[   27.893263] PM: Adding info for No Bus:ttys2
[   27.893413] PM: Adding info for No Bus:ttys3
[   27.893577] PM: Adding info for No Bus:ttys4
[   27.893720] PM: Adding info for No Bus:ttys5
[   27.894026] PM: Adding info for No Bus:ttys6
[   27.894221] PM: Adding info for No Bus:ttys7
[   27.894372] PM: Adding info for No Bus:ttys8
[   27.894517] PM: Adding info for No Bus:ttys9
[   27.894670] PM: Adding info for No Bus:ttysa
[   27.894826] PM: Adding info for No Bus:ttysb
[   27.894967] PM: Adding info for No Bus:ttysc
[   27.895108] PM: Adding info for No Bus:ttysd
[   27.895251] PM: Adding info for No Bus:ttyse
[   27.895407] PM: Adding info for No Bus:ttysf
[   27.895555] PM: Adding info for No Bus:ttyt0
[   27.895721] PM: Adding info for No Bus:ttyt1
[   27.895871] PM: Adding info for No Bus:ttyt2
[   27.896035] PM: Adding info for No Bus:ttyt3
[   27.896183] PM: Adding info for No Bus:ttyt4
[   27.896327] PM: Adding info for No Bus:ttyt5
[   27.896479] PM: Adding info for No Bus:ttyt6
[   27.896646] PM: Adding info for No Bus:ttyt7
[   27.896811] PM: Adding info for No Bus:ttyt8
[   27.896972] PM: Adding info for No Bus:ttyt9
[   27.897127] PM: Adding info for No Bus:ttyta
[   27.897291] PM: Adding info for No Bus:ttytb
[   27.897448] PM: Adding info for No Bus:ttytc
[   27.897607] PM: Adding info for No Bus:ttytd
[   27.897841] PM: Adding info for No Bus:ttyte
[   27.898107] PM: Adding info for No Bus:ttytf
[   27.898285] PM: Adding info for No Bus:ttyu0
[   27.898445] PM: Adding info for No Bus:ttyu1
[   27.898599] PM: Adding info for No Bus:ttyu2
[   27.898766] PM: Adding info for No Bus:ttyu3
[   27.898938] PM: Adding info for No Bus:ttyu4
[   27.899104] PM: Adding info for No Bus:ttyu5
[   27.899263] PM: Adding info for No Bus:ttyu6
[   27.899429] PM: Adding info for No Bus:ttyu7
[   27.899586] PM: Adding info for No Bus:ttyu8
[   27.899744] PM: Adding info for No Bus:ttyu9
[   27.899902] PM: Adding info for No Bus:ttyua
[   27.900087] PM: Adding info for No Bus:ttyub
[   27.900248] PM: Adding info for No Bus:ttyuc
[   27.900408] PM: Adding info for No Bus:ttyud
[   27.900569] PM: Adding info for No Bus:ttyue
[   27.900742] PM: Adding info for No Bus:ttyuf
[   27.900911] PM: Adding info for No Bus:ttyv0
[   27.901090] PM: Adding info for No Bus:ttyv1
[   27.901274] PM: Adding info for No Bus:ttyv2
[   27.901459] PM: Adding info for No Bus:ttyv3
[   27.901632] PM: Adding info for No Bus:ttyv4
[   27.901879] PM: Adding info for No Bus:ttyv5
[   27.902167] PM: Adding info for No Bus:ttyv6
[   27.902354] PM: Adding info for No Bus:ttyv7
[   27.902545] PM: Adding info for No Bus:ttyv8
[   27.902717] PM: Adding info for No Bus:ttyv9
[   27.902887] PM: Adding info for No Bus:ttyva
[   27.903070] PM: Adding info for No Bus:ttyvb
[   27.903242] PM: Adding info for No Bus:ttyvc
[   27.903411] PM: Adding info for No Bus:ttyvd
[   27.903599] PM: Adding info for No Bus:ttyve
[   27.903784] PM: Adding info for No Bus:ttyvf
[   27.903954] PM: Adding info for No Bus:ttyw0
[   27.904127] PM: Adding info for No Bus:ttyw1
[   27.904304] PM: Adding info for No Bus:ttyw2
[   27.904488] PM: Adding info for No Bus:ttyw3
[   27.904668] PM: Adding info for No Bus:ttyw4
[   27.904861] PM: Adding info for No Bus:ttyw5
[   27.905047] PM: Adding info for No Bus:ttyw6
[   27.905235] PM: Adding info for No Bus:ttyw7
[   27.905430] PM: Adding info for No Bus:ttyw8
[   27.905616] PM: Adding info for No Bus:ttyw9
[   27.905869] PM: Adding info for No Bus:ttywa
[   27.906218] PM: Adding info for No Bus:ttywb
[   27.906430] PM: Adding info for No Bus:ttywc
[   27.906619] PM: Adding info for No Bus:ttywd
[   27.906808] PM: Adding info for No Bus:ttywe
[   27.907002] PM: Adding info for No Bus:ttywf
[   27.907193] PM: Adding info for No Bus:ttyx0
[   27.907380] PM: Adding info for No Bus:ttyx1
[   27.907594] PM: Adding info for No Bus:ttyx2
[   27.907798] PM: Adding info for No Bus:ttyx3
[   27.907991] PM: Adding info for No Bus:ttyx4
[   27.908178] PM: Adding info for No Bus:ttyx5
[   27.908368] PM: Adding info for No Bus:ttyx6
[   27.908569] PM: Adding info for No Bus:ttyx7
[   27.908771] PM: Adding info for No Bus:ttyx8
[   27.908970] PM: Adding info for No Bus:ttyx9
[   27.909162] PM: Adding info for No Bus:ttyxa
[   27.909370] PM: Adding info for No Bus:ttyxb
[   27.909577] PM: Adding info for No Bus:ttyxc
[   27.909843] PM: Adding info for No Bus:ttyxd
[   27.910163] PM: Adding info for No Bus:ttyxe
[   27.910421] PM: Adding info for No Bus:ttyxf
[   27.910627] PM: Adding info for No Bus:ttyy0
[   27.910827] PM: Adding info for No Bus:ttyy1
[   27.911026] PM: Adding info for No Bus:ttyy2
[   27.911244] PM: Adding info for No Bus:ttyy3
[   27.911446] PM: Adding info for No Bus:ttyy4
[   27.911659] PM: Adding info for No Bus:ttyy5
[   27.911869] PM: Adding info for No Bus:ttyy6
[   27.912070] PM: Adding info for No Bus:ttyy7
[   27.912272] PM: Adding info for No Bus:ttyy8
[   27.912476] PM: Adding info for No Bus:ttyy9
[   27.912684] PM: Adding info for No Bus:ttyya
[   27.912897] PM: Adding info for No Bus:ttyyb
[   27.913117] PM: Adding info for No Bus:ttyyc
[   27.913326] PM: Adding info for No Bus:ttyyd
[   27.913543] PM: Adding info for No Bus:ttyye
[   27.913832] PM: Adding info for No Bus:ttyyf
[   27.914169] PM: Adding info for No Bus:ttyz0
[   27.914397] PM: Adding info for No Bus:ttyz1
[   27.914622] PM: Adding info for No Bus:ttyz2
[   27.914844] PM: Adding info for No Bus:ttyz3
[   27.915060] PM: Adding info for No Bus:ttyz4
[   27.915273] PM: Adding info for No Bus:ttyz5
[   27.915486] PM: Adding info for No Bus:ttyz6
[   27.915702] PM: Adding info for No Bus:ttyz7
[   27.915920] PM: Adding info for No Bus:ttyz8
[   27.916151] PM: Adding info for No Bus:ttyz9
[   27.916367] PM: Adding info for No Bus:ttyza
[   27.916602] PM: Adding info for No Bus:ttyzb
[   27.916823] PM: Adding info for No Bus:ttyzc
[   27.917042] PM: Adding info for No Bus:ttyzd
[   27.917267] PM: Adding info for No Bus:ttyze
[   27.917492] PM: Adding info for No Bus:ttyzf
[   27.917718] PM: Adding info for No Bus:ttya0
[   27.918154] PM: Adding info for No Bus:ttya1
[   27.918402] PM: Adding info for No Bus:ttya2
[   27.918637] PM: Adding info for No Bus:ttya3
[   27.918862] PM: Adding info for No Bus:ttya4
[   27.919085] PM: Adding info for No Bus:ttya5
[   27.919328] PM: Adding info for No Bus:ttya6
[   27.919564] PM: Adding info for No Bus:ttya7
[   27.919788] PM: Adding info for No Bus:ttya8
[   27.920012] PM: Adding info for No Bus:ttya9
[   27.920251] PM: Adding info for No Bus:ttyaa
[   27.920492] PM: Adding info for No Bus:ttyab
[   27.920741] PM: Adding info for No Bus:ttyac
[   27.920986] PM: Adding info for No Bus:ttyad
[   27.921215] PM: Adding info for No Bus:ttyae
[   27.921454] PM: Adding info for No Bus:ttyaf
[   27.921690] PM: Adding info for No Bus:ttyb0
[   27.922106] PM: Adding info for No Bus:ttyb1
[   27.922372] PM: Adding info for No Bus:ttyb2
[   27.922639] PM: Adding info for No Bus:ttyb3
[   27.922875] PM: Adding info for No Bus:ttyb4
[   27.923116] PM: Adding info for No Bus:ttyb5
[   27.923352] PM: Adding info for No Bus:ttyb6
[   27.923585] PM: Adding info for No Bus:ttyb7
[   27.923822] PM: Adding info for No Bus:ttyb8
[   27.924074] PM: Adding info for No Bus:ttyb9
[   27.924323] PM: Adding info for No Bus:ttyba
[   27.924574] PM: Adding info for No Bus:ttybb
[   27.924816] PM: Adding info for No Bus:ttybc
[   27.925055] PM: Adding info for No Bus:ttybd
[   27.925302] PM: Adding info for No Bus:ttybe
[   27.925554] PM: Adding info for No Bus:ttybf
[   27.925995] PM: Adding info for No Bus:ttyc0
[   27.926304] PM: Adding info for No Bus:ttyc1
[   27.926552] PM: Adding info for No Bus:ttyc2
[   27.926825] PM: Adding info for No Bus:ttyc3
[   27.927079] PM: Adding info for No Bus:ttyc4
[   27.927326] PM: Adding info for No Bus:ttyc5
[   27.927590] PM: Adding info for No Bus:ttyc6
[   27.927847] PM: Adding info for No Bus:ttyc7
[   27.928094] PM: Adding info for No Bus:ttyc8
[   27.928344] PM: Adding info for No Bus:ttyc9
[   27.928598] PM: Adding info for No Bus:ttyca
[   27.928874] PM: Adding info for No Bus:ttycb
[   27.929126] PM: Adding info for No Bus:ttycc
[   27.929398] PM: Adding info for No Bus:ttycd
[   27.929658] PM: Adding info for No Bus:ttyce
[   27.930093] PM: Adding info for No Bus:ttycf
[   27.930379] PM: Adding info for No Bus:ttyd0
[   27.930632] PM: Adding info for No Bus:ttyd1
[   27.930894] PM: Adding info for No Bus:ttyd2
[   27.931177] PM: Adding info for No Bus:ttyd3
[   27.931444] PM: Adding info for No Bus:ttyd4
[   27.931698] PM: Adding info for No Bus:ttyd5
[   27.931954] PM: Adding info for No Bus:ttyd6
[   27.932226] PM: Adding info for No Bus:ttyd7
[   27.932487] PM: Adding info for No Bus:ttyd8
[   27.932742] PM: Adding info for No Bus:ttyd9
[   27.933023] PM: Adding info for No Bus:ttyda
[   27.933293] PM: Adding info for No Bus:ttydb
[   27.933558] PM: Adding info for No Bus:ttydc
[   27.933994] PM: Adding info for No Bus:ttydd
[   27.934315] PM: Adding info for No Bus:ttyde
[   27.934587] PM: Adding info for No Bus:ttydf
[   27.934865] PM: Adding info for No Bus:ttye0
[   27.935136] PM: Adding info for No Bus:ttye1
[   27.935405] PM: Adding info for No Bus:ttye2
[   27.935692] PM: Adding info for No Bus:ttye3
[   27.935966] PM: Adding info for No Bus:ttye4
[   27.936239] PM: Adding info for No Bus:ttye5
[   27.936508] PM: Adding info for No Bus:ttye6
[   27.936805] PM: Adding info for No Bus:ttye7
[   27.937086] PM: Adding info for No Bus:ttye8
[   27.937363] PM: Adding info for No Bus:ttye9
[   27.937640] PM: Adding info for No Bus:ttyea
[   27.938135] PM: Adding info for No Bus:ttyeb
[   27.938451] PM: Adding info for No Bus:ttyec
[   27.938743] PM: Adding info for No Bus:ttyed
[   27.939034] PM: Adding info for No Bus:ttyee
[   27.939321] PM: Adding info for No Bus:ttyef
[   27.939418] PM: Adding info for No Bus:hpet
[   27.939478] PM: Removing info for No Bus:hpet
[   27.939528] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   27.939555] PM: Adding info for platform:serial8250
[   27.939679] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   27.939962] PM: Adding info for No Bus:ttyS0
[   27.940110] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   27.940355] PM: Adding info for No Bus:ttyS1
[   27.940675] PM: Adding info for No Bus:ttyS2
[   27.941014] PM: Adding info for No Bus:ttyS3
[   27.941556] PM: Removing info for No Bus:ttyS0
[   27.941694] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   27.942091] PM: Adding info for No Bus:ttyS0
[   27.942368] PM: Removing info for No Bus:ttyS1
[   27.942500] 00:10: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   27.942777] PM: Adding info for No Bus:ttyS1
[   27.942987] PM: Adding info for No Bus:isa
[   27.943750] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   27.944014] input: Macintosh mouse button emulation as /class/input/input0
[   27.944031] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   27.944037] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   27.944405] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
[   27.944516] PM: Adding info for platform:i8042
[   27.947105] serio: i8042 KBD port at 0x60,0x64 irq 1
[   27.947114] serio: i8042 AUX port at 0x60,0x64 irq 12
[   27.947162] PM: Adding info for serio:serio0
[   27.947255] PM: Adding info for serio:serio1
[   27.947361] PM: Adding info for No Bus:psaux
[   27.947395] mice: PS/2 mouse device common for all mice
[   27.947527] PM: Adding info for platform:eisa.0
[   27.947573] EISA: Probing bus 0 at eisa.0
[   27.947598] Cannot allocate resource for EISA slot 4
[   27.947601] Cannot allocate resource for EISA slot 5
[   27.947615] EISA: Detected 0 cards.
[   27.947763] TCP cubic registered
[   27.947779] NET: Registered protocol family 1
[   27.947823] Using IPI Shortcut mode
[   27.947860]   Magic number: 15:234:399
[   27.948904] Freeing unused kernel memory: 320k freed
[   27.948992] PM: Adding info for No Bus:vcs1
[   27.949114] PM: Adding info for No Bus:vcsa1
[   27.949877] Time: tsc clocksource has been installed.
[   27.974094] input: AT Translated Set 2 keyboard as /class/input/input1
[   28.142095] PM: Adding info for No Bus:vcs2
[   28.142208] PM: Adding info for No Bus:vcsa2
[   28.143019] PM: Removing info for No Bus:vcs2
[   28.143131] PM: Removing info for No Bus:vcsa2
[   28.146357] PM: Adding info for No Bus:vcs2
[   28.146483] PM: Adding info for No Bus:vcsa2
[   28.151373] PM: Removing info for No Bus:vcs2
[   28.151517] PM: Removing info for No Bus:vcsa2
[   28.153861] PM: Adding info for No Bus:vcs2
[   28.153962] PM: Adding info for No Bus:vcsa2
[   28.155728] PM: Removing info for No Bus:vcs2
[   28.155839] PM: Removing info for No Bus:vcsa2
[   28.157332] PM: Adding info for No Bus:vcs3
[   28.157493] PM: Adding info for No Bus:vcsa3
[   28.158387] PM: Removing info for No Bus:vcs3
[   28.158504] PM: Removing info for No Bus:vcsa3
[   28.161751] PM: Adding info for No Bus:vcs3
[   28.161873] PM: Adding info for No Bus:vcsa3
[   28.166897] PM: Removing info for No Bus:vcs3
[   28.167040] PM: Removing info for No Bus:vcsa3
[   28.169403] PM: Adding info for No Bus:vcs3
[   28.169508] PM: Adding info for No Bus:vcsa3
[   28.171338] PM: Removing info for No Bus:vcs3
[   28.171453] PM: Removing info for No Bus:vcsa3
[   28.172960] PM: Adding info for No Bus:vcs4
[   28.173064] PM: Adding info for No Bus:vcsa4
[   28.173939] PM: Removing info for No Bus:vcs4
[   28.174051] PM: Removing info for No Bus:vcsa4
[   28.177247] PM: Adding info for No Bus:vcs4
[   28.177384] PM: Adding info for No Bus:vcsa4
[   28.182370] PM: Removing info for No Bus:vcs4
[   28.182509] PM: Removing info for No Bus:vcsa4
[   28.184804] PM: Adding info for No Bus:vcs4
[   28.184913] PM: Adding info for No Bus:vcsa4
[   28.186747] PM: Removing info for No Bus:vcs4
[   28.186864] PM: Removing info for No Bus:vcsa4
[   28.188405] PM: Adding info for No Bus:vcs5
[   28.188511] PM: Adding info for No Bus:vcsa5
[   28.189325] PM: Removing info for No Bus:vcs5
[   28.189487] PM: Removing info for No Bus:vcsa5
[   28.192760] PM: Adding info for No Bus:vcs5
[   28.192889] PM: Adding info for No Bus:vcsa5
[   28.198000] PM: Removing info for No Bus:vcs5
[   28.198138] PM: Removing info for No Bus:vcsa5
[   28.200422] PM: Adding info for No Bus:vcs5
[   28.200527] PM: Adding info for No Bus:vcsa5
[   28.202354] PM: Removing info for No Bus:vcs5
[   28.202472] PM: Removing info for No Bus:vcsa5
[   28.203975] PM: Adding info for No Bus:vcs6
[   28.204082] PM: Adding info for No Bus:vcsa6
[   28.204901] PM: Removing info for No Bus:vcs6
[   28.205012] PM: Removing info for No Bus:vcsa6
[   28.208215] PM: Adding info for No Bus:vcs6
[   28.208348] PM: Adding info for No Bus:vcsa6
[   28.213341] PM: Removing info for No Bus:vcs6
[   28.213564] PM: Removing info for No Bus:vcsa6
[   28.215832] PM: Adding info for No Bus:vcs6
[   28.215931] PM: Adding info for No Bus:vcsa6
[   28.217844] PM: Removing info for No Bus:vcs6
[   28.217955] PM: Removing info for No Bus:vcsa6
[   28.324125] PM: Adding info for No Bus:vcs8
[   28.324257] PM: Adding info for No Bus:vcsa8
[   29.521146] thermal: Unknown symbol acpi_processor_set_thermal_limit
[   30.508970] SCSI subsystem initialized
[   30.519854] libata version 2.00 loaded.
[   30.522951] ata_piix 0000:00:1f.1: version 2.00ac7
[   30.522995] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   30.523140] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
[   30.523202] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
[   30.523232] scsi0 : ata_piix
[   30.523249] PM: Adding info for No Bus:host0
[   30.550217] usbcore: registered new interface driver usbfs
[   30.550257] usbcore: registered new interface driver hub
[   30.550298] usbcore: registered new device driver usb
[   30.552764] USB Universal Host Controller Interface driver v3.0
[   30.640707] Linux Tulip driver version 1.1.14 (May 11, 2002)
[   30.841828] ata1.00: ATAPI, max UDMA/33
[   30.863680] Floppy drive(s): fd0 is 1.44M
[   30.940952] FDC 0 is a post-1991 82077
[   30.958682] PM: Adding info for platform:floppy.0
[   31.005533] ata1.00: configured for UDMA/33
[   31.005560] scsi1 : ata_piix
[   31.005593] PM: Adding info for No Bus:host1
[   31.172448] ATA: abnormal status 0x7F on port 0x177
[   31.333039] ata2.01: ATAPI, max MWDMA2
[   31.496799] ata2.01: configured for MWDMA2
[   31.496863] PM: Adding info for No Bus:target0:0:0
[   31.499200] scsi 0:0:0:0: CD-ROM            HP       DVD Writer 200j  1.36 PQ: 0 ANSI: 5
[   31.499214] PM: Adding info for scsi:0:0:0:0
[   31.499783] PM: Adding info for No Bus:target1:0:1
[   31.500477] scsi 1:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH   A80  PQ: 0 ANSI: 5
[   31.500492] PM: Adding info for scsi:1:0:1:0
[   31.510680] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   31.510689] uhci_hcd 0000:00:1f.2: UHCI Host Controller
[   31.510944] uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
[   31.510985] uhci_hcd 0000:00:1f.2: irq 19, io base 0x0000d000
[   31.511089] PM: Adding info for usb:usb1
[   31.511175] PM: Adding info for No Bus:usbdev1.1_ep00
[   31.511199] usb usb1: configuration #1 chosen from 1 choice
[   31.511215] PM: Adding info for usb:1-0:1.0
[   31.511244] hub 1-0:1.0: USB hub found
[   31.511262] hub 1-0:1.0: 2 ports detected
[   31.552229] sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   31.552239] Uniform CD-ROM driver Revision: 3.20
[   31.552635] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   31.561599] sr1: scsi3-mmc drive: 231x/52x cd/rw xa/form2 cdda tray
[   31.561965] sr 1:0:1:0: Attached scsi CD-ROM sr1
[   31.571463] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   31.571685] sr 1:0:1:0: Attached scsi generic sg1 type 5
[   31.612494] PM: Adding info for No Bus:usbdev1.1_ep81
[   31.612669] PCI: Setting latency timer of device 0000:00:1f.4 to 64
[   31.612675] uhci_hcd 0000:00:1f.4: UHCI Host Controller
[   31.612717] uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
[   31.612755] uhci_hcd 0000:00:1f.4: irq 23, io base 0x0000d800
[   31.612829] PM: Adding info for usb:usb2
[   31.612886] PM: Adding info for No Bus:usbdev2.1_ep00
[   31.612912] usb usb2: configuration #1 chosen from 1 choice
[   31.612927] PM: Adding info for usb:2-0:1.0
[   31.612963] hub 2-0:1.0: USB hub found
[   31.612975] hub 2-0:1.0: 2 ports detected
[   31.716329] PM: Adding info for No Bus:usbdev2.1_ep81
[   31.716631] PDC20269: IDE controller at PCI slot 0000:02:01.0
[   31.716668] PDC20269: chipset revision 2
[   31.716673] PDC20269: ROM enabled at 0x30020000
[   31.726626] PDC20269: PLL input clock is 16565 kHz
[   31.756376] PDC20269: 100% native mode on irq 21
[   31.756387]     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
[   31.757010]     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
[   31.757027] Probing IDE interface ide2...
[   32.044020] hde: SAMSUNG SP1203N, ATA DISK drive
[   32.044077] PM: Adding info for No Bus:ide2
[   32.388718] PM: Removing info for No Bus:vcs8
[   32.388777] PM: Removing info for No Bus:vcsa8
[   32.555258] hdf: Maxtor 6Y160P0, ATA DISK drive
[   32.611416] ide2 at 0xa000-0xa007,0xa402 on irq 21
[   32.611464] PM: Adding info for ide:2.0
[   32.611842] PM: Adding info for ide:2.1
[   32.612050] Probing IDE interface ide3...
[   33.179031] tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
[   33.186241] eth0: ADMtek Comet rev 17 at Port 0xb400, 00:04:5A:8A:55:7B, IRQ 21.
[   33.197996] hde: max request size: 512KiB
[   33.207974] hde: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
[   33.208614] hde: cache flushes supported
[   33.208697]  hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 >
[   33.248309] hdf: max request size: 512KiB
[   33.248888] hdf: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
[   33.249048] hdf: cache flushes supported
[   33.249097]  hdf: hdf1 hdf2 hdf3 < hdf5 hdf6 >
[   33.856216] Attempting manual resume
[   33.856223] swsusp: Resume From Partition 33:6
[   33.856226] PM: Checking swsusp image.
[   33.856465] PM: Resume from disk failed.
[   33.908042] kjournald starting.  Commit interval 5 seconds
[   33.908067] EXT3-fs: mounted filesystem with ordered data mode.
[   34.283024] PM: Removing info for No Bus:vcs1
[   34.283072] PM: Removing info for No Bus:vcsa1
[   34.283151] PM: Adding info for No Bus:vcs1
[   34.283170] PM: Adding info for No Bus:vcsa1
[   38.911927] PM: Adding info for No Bus:vcs2
[   38.911970] PM: Adding info for No Bus:vcsa2
[   38.913910] PM: Removing info for No Bus:vcs2
[   38.913957] PM: Removing info for No Bus:vcsa2
[   38.914202] PM: Adding info for No Bus:vcs3
[   38.914226] PM: Adding info for No Bus:vcsa3
[   38.916103] PM: Removing info for No Bus:vcs3
[   38.916150] PM: Removing info for No Bus:vcsa3
[   38.916399] PM: Adding info for No Bus:vcs4
[   38.916422] PM: Adding info for No Bus:vcsa4
[   38.918341] PM: Removing info for No Bus:vcs4
[   38.918388] PM: Removing info for No Bus:vcsa4
[   38.918630] PM: Adding info for No Bus:vcs5
[   38.918651] PM: Adding info for No Bus:vcsa5
[   38.920529] PM: Removing info for No Bus:vcs5
[   38.920577] PM: Removing info for No Bus:vcsa5
[   38.920825] PM: Adding info for No Bus:vcs6
[   38.920847] PM: Adding info for No Bus:vcsa6
[   38.922782] PM: Removing info for No Bus:vcs6
[   38.922832] PM: Removing info for No Bus:vcsa6
[   41.690206] NET: Registered protocol family 10
[   41.690392] lo: Disabled Privacy Extensions
[   42.793564] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   42.857861] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   43.308782] 0000:02:05.0: tulip_stop_rxtx() failed
[   43.308797] eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
[   43.758608] input: PC Speaker as /class/input/input2
[   43.775702] PM: Adding info for No Bus:rtc
[   43.775761] Real Time Clock Driver v1.12ac
[   43.867350] Linux agpgart interface v0.101 (c) Dave Jones
[   43.888646] agpgart: Detected an Intel i845 Chipset.
[   43.892561] PM: Adding info for No Bus:agpgart
[   43.892660] agpgart: AGP aperture is 64M @ 0xe8000000
[   43.906434] iTCO_vendor_support: vendor-support=0
[   43.925774] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (11-Nov-2006)
[   43.925840] PM: Adding info for platform:iTCO_wdt
[   43.925904] iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled by hardware
[   43.925964] iTCO_wdt: No card detected
[   44.100776] PM: Adding info for No Bus:timer
[   44.970774] input: ImPS/2 Generic Wheel Mouse as /class/input/input3
[   45.142803] PM: Adding info for No Bus:seq
[   45.279073] PM: Adding info for No Bus:midiC1D0
[   45.279129] PM: Adding info for No Bus:midi1
[   45.279172] PM: Adding info for No Bus:dmmidi1
[   45.279220] PM: Adding info for No Bus:controlC1
[   45.364773] parport: PnPBIOS parport detected.
[   45.364842] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   45.425667] PM: Adding info for No Bus:sequencer
[   45.425727] PM: Adding info for No Bus:sequencer2
[   45.555865] PM: Adding info for No Bus:mixer1
[   45.926138] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   46.238517] intel8x0_measure_ac97_clock: measured 54900 usecs
[   46.238523] intel8x0: clocking to 48000
[   46.238580] PM: Adding info for No Bus:pcmC0D1c
[   46.238745] PM: Adding info for No Bus:adsp
[   46.238795] PM: Adding info for No Bus:pcmC0D0p
[   46.238841] PM: Adding info for No Bus:pcmC0D0c
[   46.238888] PM: Adding info for No Bus:dsp
[   46.238932] PM: Adding info for No Bus:audio
[   46.238980] PM: Adding info for ac97:0-0:ALC200,200P
[   46.239099] PM: Adding info for No Bus:controlC0
[   46.239164] PM: Adding info for No Bus:mixer
[   52.053820] eth0: no IPv6 routers present
[   61.559632] ata2.01: qc timeout (cmd 0xa0)
[   61.559654] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   61.559710] ata2.01: (BMDMA stat 0x45)
[   61.559758] ata2.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
[   61.559761]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
[   68.549185] ata2: port is slow to respond, please be patient (Status 0xd8)
[   91.530775] ata2: port failed to respond (30 secs, Status 0xd8)
[   91.530843] ata2: soft resetting port
[   91.697897] ATA: abnormal status 0x7F on port 0x177
[   91.858328] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[   91.858335] ata2.01: revalidation failed (errno=-5)
[   91.858400] ata2: failed to recover some devices, retrying in 5 secs
[   96.854849] ata2: soft resetting port
[   97.021957] ATA: abnormal status 0x7F on port 0x177
[   97.346290] ata2.01: configured for MWDMA2
[   97.346336] ata2: EH complete
[  127.321273] ata2.01: qc timeout (cmd 0xa0)
[  127.321295] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  127.321361] ata2.01: (BMDMA stat 0x45)
[  127.321416] ata2.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
[  127.321419]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
[  134.310818] ata2: port is slow to respond, please be patient (Status 0xd8)
[  157.292413] ata2: port failed to respond (30 secs, Status 0xd8)
[  157.292485] ata2: soft resetting port
[  157.459536] ATA: abnormal status 0x7F on port 0x177
[  157.619967] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  157.619976] ata2.01: revalidation failed (errno=-5)
[  157.620042] ata2: failed to recover some devices, retrying in 5 secs
[  162.616486] ata2: soft resetting port
[  162.783578] ATA: abnormal status 0x7F on port 0x177
[  163.107943] ata2.01: configured for MWDMA2
[  163.107994] ata2: EH complete
[  193.070927] ata2.01: qc timeout (cmd 0xa0)
[  193.070949] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  193.071014] ata2.01: (BMDMA stat 0x45)
[  193.071070] ata2.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
[  193.071072]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
[  200.060476] ata2: port is slow to respond, please be patient (Status 0xd8)
[  220.160401] fuse init (API version 7.8)
[  220.160498] PM: Adding info for No Bus:fuse
[  220.201566] lp0: using parport0 (interrupt-driven).
[  220.270196] PM: Adding info for No Bus:i2c-0
[  220.322173] PM: Adding info for i2c:0-0050
[  220.338152] PM: Adding info for i2c:0-0051
[  220.411715] PM: Adding info for No Bus:i2c-9191
[  220.458828] it87: Found IT8712F chip at 0x290, revision 4
[  220.461321] PM: Adding info for i2c:9191-0290
[  220.463797] it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
[  220.683723] Adding 1044184k swap on /dev/disk/by-uuid/5c6a2d8c-54c1-44cb-8f1b-4a159373a120.  Priority:-1 extents:1 across:1044184k
[  220.997416] EXT3 FS on hde7, internal journal
[  223.042077] ata2: port failed to respond (30 secs, Status 0xd8)
[  223.042149] ata2: soft resetting port
[  223.209223] ATA: abnormal status 0x7F on port 0x177
[  223.369700] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  223.369710] ata2.01: revalidation failed (errno=-5)
[  223.369784] ata2: failed to recover some devices, retrying in 5 secs
[  224.555235] kjournald starting.  Commit interval 5 seconds
[  224.555360] EXT3 FS on hde1, internal journal
[  224.555367] EXT3-fs: mounted filesystem with ordered data mode.
[  224.581094] kjournald starting.  Commit interval 5 seconds
[  224.581248] EXT3 FS on hde3, internal journal
[  224.581256] EXT3-fs: mounted filesystem with ordered data mode.
[  224.630208] kjournald starting.  Commit interval 5 seconds
[  224.630415] EXT3 FS on hdf5, internal journal
[  224.630423] EXT3-fs: mounted filesystem with ordered data mode.
[  224.710512] NTFS driver 2.1.28 [Flags: R/O MODULE].
[  224.779116] NTFS volume version 3.1.
[  224.904552] kjournald starting.  Commit interval 5 seconds
[  224.904792] EXT3 FS on hdf6, internal journal
[  224.904801] EXT3-fs: mounted filesystem with ordered data mode.
[  224.921254] kjournald starting.  Commit interval 5 seconds
[  224.921396] EXT3 FS on hde5, internal journal
[  224.921405] EXT3-fs: mounted filesystem with ordered data mode.
[  224.951048] kjournald starting.  Commit interval 5 seconds
[  224.951174] EXT3 FS on hde2, internal journal
[  224.951182] EXT3-fs: mounted filesystem with ordered data mode.
[  226.942631] NET: Registered protocol family 17
[  228.366147] ata2: soft resetting port
[  228.533250] ATA: abnormal status 0x7F on port 0x177
[  228.857581] ata2.01: configured for MWDMA2
[  228.857623] ata2: EH complete
[  231.087788] PM: Adding info for No Bus:vcs2
[  231.090822] PM: Adding info for No Bus:vcsa2
[  231.095414] PM: Removing info for No Bus:vcs2
[  231.098071] PM: Removing info for No Bus:vcsa2
[  231.102746] PM: Adding info for No Bus:vcs2
[  231.105757] PM: Adding info for No Bus:vcsa2
[  231.114804] PM: Removing info for No Bus:vcs2
[  231.117455] PM: Removing info for No Bus:vcsa2
[  231.120508] PM: Adding info for No Bus:vcs3
[  231.123535] PM: Adding info for No Bus:vcsa3
[  231.128090] PM: Removing info for No Bus:vcs3
[  231.130788] PM: Removing info for No Bus:vcsa3
[  231.135506] PM: Adding info for No Bus:vcs3
[  231.138561] PM: Adding info for No Bus:vcsa3
[  231.147594] PM: Removing info for No Bus:vcs3
[  231.150291] PM: Removing info for No Bus:vcsa3
[  231.153298] PM: Adding info for No Bus:vcs4
[  231.156321] PM: Adding info for No Bus:vcsa4
[  231.160904] PM: Removing info for No Bus:vcs4
[  231.163584] PM: Removing info for No Bus:vcsa4
[  231.168258] PM: Adding info for No Bus:vcs4
[  231.171320] PM: Adding info for No Bus:vcsa4
[  231.180320] PM: Removing info for No Bus:vcs4
[  231.182985] PM: Removing info for No Bus:vcsa4
[  231.186026] PM: Adding info for No Bus:vcs5
[  231.189011] PM: Adding info for No Bus:vcsa5
[  231.193560] PM: Removing info for No Bus:vcs5
[  231.196245] PM: Removing info for No Bus:vcsa5
[  231.200924] PM: Adding info for No Bus:vcs5
[  231.203993] PM: Adding info for No Bus:vcsa5
[  231.213029] PM: Removing info for No Bus:vcs5
[  231.215713] PM: Removing info for No Bus:vcsa5
[  231.218728] PM: Adding info for No Bus:vcs6
[  231.221712] PM: Adding info for No Bus:vcsa6
[  231.226321] PM: Removing info for No Bus:vcs6
[  231.228953] PM: Removing info for No Bus:vcsa6
[  231.233664] PM: Adding info for No Bus:vcs6
[  231.236721] PM: Adding info for No Bus:vcsa6
[  231.245706] PM: Removing info for No Bus:vcs6
[  231.248394] PM: Removing info for No Bus:vcsa6
[  231.258666] PM: Adding info for No Bus:vcs2
[  231.261654] PM: Adding info for No Bus:vcsa2
[  231.266622] PM: Removing info for No Bus:vcs2
[  231.269246] PM: Removing info for No Bus:vcsa2
[  231.272104] PM: Adding info for No Bus:vcs3
[  231.275110] PM: Adding info for No Bus:vcsa3
[  231.280039] PM: Removing info for No Bus:vcs3
[  231.282690] PM: Removing info for No Bus:vcsa3
[  231.285513] PM: Adding info for No Bus:vcs4
[  231.288473] PM: Adding info for No Bus:vcsa4
[  231.293395] PM: Removing info for No Bus:vcs4
[  231.296029] PM: Removing info for No Bus:vcsa4
[  231.298902] PM: Adding info for No Bus:vcs5
[  231.301867] PM: Adding info for No Bus:vcsa5
[  231.306791] PM: Removing info for No Bus:vcs5
[  231.309415] PM: Removing info for No Bus:vcsa5
[  231.312261] PM: Adding info for No Bus:vcs6
[  231.315257] PM: Adding info for No Bus:vcsa6
[  231.320162] PM: Removing info for No Bus:vcs6
[  231.322840] PM: Removing info for No Bus:vcsa6
[  232.038765] PM: Adding info for No Bus:vcs2
[  232.041774] PM: Adding info for No Bus:vcsa2
[  232.044873] PM: Removing info for No Bus:vcs2
[  232.047473] PM: Removing info for No Bus:vcsa2
[  232.050232] PM: Adding info for No Bus:vcs3
[  232.053213] PM: Adding info for No Bus:vcsa3
[  232.056280] PM: Removing info for No Bus:vcs3
[  232.058907] PM: Removing info for No Bus:vcsa3
[  232.061649] PM: Adding info for No Bus:vcs4
[  232.064640] PM: Adding info for No Bus:vcsa4
[  232.067717] PM: Removing info for No Bus:vcs4
[  232.070321] PM: Removing info for No Bus:vcsa4
[  232.073078] PM: Adding info for No Bus:vcs5
[  232.076041] PM: Adding info for No Bus:vcsa5
[  232.079128] PM: Removing info for No Bus:vcs5
[  232.081752] PM: Removing info for No Bus:vcsa5
[  232.084465] PM: Adding info for No Bus:vcs6
[  232.087437] PM: Adding info for No Bus:vcsa6
[  232.090542] PM: Removing info for No Bus:vcs6
[  232.093156] PM: Removing info for No Bus:vcsa6
[  232.147683] PM: Adding info for No Bus:vcs2
[  232.150739] PM: Adding info for No Bus:vcsa2
[  232.155219] PM: Removing info for No Bus:vcs2
[  232.157888] PM: Removing info for No Bus:vcsa2
[  232.164439] PM: Adding info for No Bus:vcs3
[  232.167460] PM: Adding info for No Bus:vcsa3
[  232.171983] PM: Removing info for No Bus:vcs3
[  232.174649] PM: Removing info for No Bus:vcsa3
[  232.181234] PM: Adding info for No Bus:vcs4
[  232.184265] PM: Adding info for No Bus:vcsa4
[  232.188813] PM: Removing info for No Bus:vcs4
[  232.191450] PM: Removing info for No Bus:vcsa4
[  232.196475] PM: Adding info for No Bus:vcs5
[  232.197006] PM: Adding info for No Bus:vcsa5
[  232.198581] PM: Removing info for No Bus:vcs5
[  232.198636] PM: Removing info for No Bus:vcsa5
[  232.202637] PM: Adding info for No Bus:vcs6
[  232.202676] PM: Adding info for No Bus:vcsa6
[  232.204159] PM: Removing info for No Bus:vcs6
[  232.204210] PM: Removing info for No Bus:vcsa6
[  232.561348] PM: Adding info for No Bus:vcs4
[  232.562162] PM: Adding info for No Bus:vcsa4
[  232.566550] PM: Adding info for No Bus:vcs5
[  232.567364] PM: Adding info for No Bus:vcsa5
[  232.575960] PM: Adding info for No Bus:vcs2
[  232.578934] PM: Adding info for No Bus:vcsa2
[  232.583495] PM: Adding info for No Bus:vcs3
[  232.586498] PM: Adding info for No Bus:vcsa3
[  232.595450] PM: Adding info for No Bus:vcs6
[  232.598517] PM: Adding info for No Bus:vcsa6
[  237.912449] Capability LSM initialized
[  238.306966] PM: Adding info for No Bus:parport0
[  238.311900] ppdev: user-space parallel port driver
[  241.031388] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[  241.031987] PM: Adding info for No Bus:apm_bios
[  244.353872] PM: Adding info for No Bus:vcs7
[  244.358306] PM: Adding info for No Bus:vcsa7
[  244.816248] [drm] Initialized drm 1.1.0 20060810
[  244.887759] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[  245.600002] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  245.600263] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  245.600512] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  245.898897] [drm] Setting GART location based on new memory map
[  245.898969] [drm] writeback test succeeded in 1 usecs

--------------000202050007030807070406--
