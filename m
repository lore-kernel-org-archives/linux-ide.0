From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Fri, 16 Mar 2007 11:16:42 +0100
Message-ID: <45FA6E8A.5070507@gmail.com>
References: <45F873AC.6010204@gmail.com> <45F8C3E1.3080805@tw.ibm.com> <45F9460E.7020701@gmail.com> <45F98343.3060703@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000509000907060207020208"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:22545 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbXCPKQy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 06:16:54 -0400
Received: by nf-out-0910.google.com with SMTP id o25so189815nfa
        for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 03:16:52 -0700 (PDT)
In-Reply-To: <45F98343.3060703@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509000907060207020208
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit

Hi Albert,

> 2. Turn off ATAPI DMA by adding one line of
>  	{ "CD-ROM 56X/AKH", NULL,	ATA_HORKAGE_NODMA },
>    to  ata_device_blacklist[] and see if it helps. 
> 

Here is dmesg with blacklisted cdrom:



--------------000509000907060207020208
Content-Type: text/plain;
 name="blacklisted_cdrom"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blacklisted_cdrom"

[    0.000000] Linux version 2.6.20.3 (root@zaraza) (gcc version 4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #1 Thu Mar 15 23:53:58 CET 2007
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
[    0.000000] Detected 1800.150 MHz processor.
[   21.864686] Built 1 zonelists.  Total pages: 130033
[   21.864689] Kernel command line: root=UUID=bdcb0225-6620-4d74-9fe5-2f008da464c7 ro quiet splash
[   21.864936] mapped APIC to ffffd000 (fee00000)
[   21.864939] mapped IOAPIC to ffffc000 (fec00000)
[   21.864945] Enabling fast FPU save and restore... done.
[   21.864949] Enabling unmasked SIMD FPU exception support... done.
[   21.864972] Initializing CPU#0
[   21.865093] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   21.866773] Console: colour VGA+ 80x25
[   21.867436] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   21.868110] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   21.889292] Memory: 474608k/524224k available (1902k kernel code, 49000k reserved, 850k data, 320k init, 0k highmem)
[   21.889305] virtual kernel memory layout:
[   21.889307]     fixmap  : 0xfffa9000 - 0xfffff000   ( 344 kB)
[   21.889309]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   21.889311]     vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
[   21.889312]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[   21.889314]       .init : 0xc03b4000 - 0xc0404000   ( 320 kB)
[   21.889316]       .data : 0xc02db893 - 0xc03b0434   ( 850 kB)
[   21.889318]       .text : 0xc0100000 - 0xc02db893   (1902 kB)
[   21.889322] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   21.968944] Calibrating delay using timer specific routine.. 3603.21 BogoMIPS (lpj=7206428)
[   21.968995] Security Framework v1.0.0 initialized
[   21.969005] SELinux:  Disabled at boot.
[   21.969022] Mount-cache hash table entries: 512
[   21.969183] CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 00000000 00000000 00000000
[   21.969199] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   21.969202] CPU: L2 cache: 256K
[   21.969204] CPU: After all inits, caps: 3febfbff 00000000 00000000 00003080 00000000 00000000 00000000
[   21.969235] CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 02
[   21.969247] Checking 'hlt' instruction... OK.
[   21.985616] ExtINT not setup in hardware but reported by MP table
[   21.985701] ENABLING IO-APIC IRQs
[   21.985938] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
[   22.132798] PM: Adding info for No Bus:platform
[   22.133043] Booting paravirtualized kernel on bare hardware
[   22.133162] Time: 11:08:06  Date: 02/16/107
[   22.133223] NET: Registered protocol family 16
[   22.133276] PM: Adding info for No Bus:vtcon0
[   22.133418] EISA bus registered
[   22.159055] PCI: PCI BIOS revision 2.10 entry at 0xfb230, last bus=2
[   22.159059] PCI: Using configuration type 1
[   22.159062] Setting up standard PCI resources
[   22.165748] ACPI: Interpreter disabled.
[   22.165758] Linux Plug and Play Support v0.97 (c) Adam Belay
[   22.165780] pnp: PnP ACPI: disabled
[   22.165785] PnPBIOS: Scanning system for PnP BIOS support...
[   22.165838] PnPBIOS: Found PnP BIOS installation structure at 0xc00fbc20
[   22.165842] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbc50, dseg 0xf0000
[   22.165858] PM: Adding info for No Bus:pnp0
[   22.165892] PM: Adding info for pnp:00:00
[   22.166002] PM: Adding info for pnp:00:01
[   22.166061] PM: Adding info for pnp:00:02
[   22.166117] PM: Adding info for pnp:00:03
[   22.166167] PM: Adding info for pnp:00:04
[   22.166237] PM: Adding info for pnp:00:05
[   22.166293] PM: Adding info for pnp:00:06
[   22.166347] PM: Adding info for pnp:00:07
[   22.166405] PM: Adding info for pnp:00:08
[   22.166459] PM: Adding info for pnp:00:09
[   22.166510] PM: Adding info for pnp:00:0a
[   22.166581] PM: Adding info for pnp:00:0b
[   22.166678] PM: Adding info for pnp:00:0c
[   22.166758] PM: Adding info for pnp:00:0d
[   22.166864] PM: Adding info for pnp:00:0f
[   22.166961] PM: Adding info for pnp:00:10
[   22.167051] PM: Adding info for pnp:00:11
[   22.167138] PM: Adding info for pnp:00:12
[   22.167195] PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
[   22.167270] PCI: Probing PCI hardware
[   22.167278] PCI: Probing PCI hardware (bus 00)
[   22.167290] PM: Adding info for No Bus:pci0000:00
[   22.167557] PCI quirk: region 4000-407f claimed by ICH4 ACPI/GPIO/TCO
[   22.167562] PCI quirk: region 4080-40bf claimed by ICH4 GPIO
[   22.167929] Boot video device is 0000:01:00.0
[   22.168168] PCI: Transparent bridge - 0000:00:1e.0
[   22.168198] PM: Adding info for pci:0000:00:00.0
[   22.168270] PM: Adding info for pci:0000:00:01.0
[   22.168332] PM: Adding info for pci:0000:00:1e.0
[   22.168385] PM: Adding info for pci:0000:00:1f.0
[   22.168443] PM: Adding info for pci:0000:00:1f.1
[   22.168512] PM: Adding info for pci:0000:00:1f.2
[   22.168569] PM: Adding info for pci:0000:00:1f.3
[   22.168633] PM: Adding info for pci:0000:00:1f.4
[   22.168717] PM: Adding info for pci:0000:00:1f.5
[   22.168779] PM: Adding info for pci:0000:01:00.0
[   22.168850] PM: Adding info for pci:0000:02:01.0
[   22.168909] PM: Adding info for pci:0000:02:05.0
[   22.169069] PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
[   22.169090] PCI->APIC IRQ transform: 0000:00:1f.2[D] -> IRQ 19
[   22.169095] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[   22.169099] PCI->APIC IRQ transform: 0000:00:1f.4[C] -> IRQ 23
[   22.169103] PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
[   22.169107] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[   22.169111] PCI->APIC IRQ transform: 0000:02:01.0[A] -> IRQ 21
[   22.169115] PCI->APIC IRQ transform: 0000:02:05.0[A] -> IRQ 21
[   22.184378] NET: Registered protocol family 8
[   22.184382] NET: Registered protocol family 20
[   22.184554] PM: Adding info for No Bus:mem
[   22.184612] PM: Adding info for No Bus:kmem
[   22.184670] PM: Adding info for No Bus:null
[   22.184708] PM: Adding info for No Bus:port
[   22.184761] PM: Adding info for No Bus:zero
[   22.184801] PM: Adding info for No Bus:full
[   22.184839] PM: Adding info for No Bus:random
[   22.184878] PM: Adding info for No Bus:urandom
[   22.184916] PM: Adding info for No Bus:kmsg
[   22.184954] PM: Adding info for No Bus:oldmem
[   22.185035] PCI: Bridge: 0000:00:01.0
[   22.185040]   IO window: c000-cfff
[   22.185045]   MEM window: ec000000-edffffff
[   22.185050]   PREFETCH window: e0000000-e7ffffff
[   22.185056] PCI: Bridge: 0000:00:1e.0
[   22.185059]   IO window: a000-bfff
[   22.185065]   MEM window: ee000000-efffffff
[   22.185071]   PREFETCH window: 30000000-300fffff
[   22.185094] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   22.185148] NET: Registered protocol family 2
[   22.212687] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   22.212826] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[   22.212918] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[   22.212965] TCP: Hash tables configured (established 16384 bind 8192)
[   22.212969] TCP reno registered
[   22.224797] checking if image is initramfs... it is
[   27.706647] Freeing initrd memory: 41023k freed
[   27.706942] PM: Adding info for platform:pcspkr
[   27.707338] PM: Adding info for No Bus:snapshot
[   27.707384] audit: initializing netlink socket (disabled)
[   27.707410] audit(1174043291.932:1): initialized
[   27.707618] VFS: Disk quotas dquot_6.5.1
[   27.707654] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   27.707754] io scheduler noop registered
[   27.707759] io scheduler anticipatory registered
[   27.707762] io scheduler deadline registered
[   27.707778] io scheduler cfq registered (default)
[   27.708180] PM: Adding info for No Bus:pnp1
[   27.708189] isapnp: Scanning for PnP cards...
[   28.061919] isapnp: No Plug & Play device found
[   28.061947] PM: Adding info for No Bus:tty
[   28.062012] PM: Adding info for No Bus:console
[   28.062055] PM: Adding info for No Bus:ptmx
[   28.062095] PM: Adding info for No Bus:tty0
[   28.062158] PM: Adding info for No Bus:vcs
[   28.062209] PM: Adding info for No Bus:vcsa
[   28.062261] PM: Adding info for No Bus:tty1
[   28.062301] PM: Adding info for No Bus:tty2
[   28.062341] PM: Adding info for No Bus:tty3
[   28.062382] PM: Adding info for No Bus:tty4
[   28.062422] PM: Adding info for No Bus:tty5
[   28.062460] PM: Adding info for No Bus:tty6
[   28.062509] PM: Adding info for No Bus:tty7
[   28.062547] PM: Adding info for No Bus:tty8
[   28.062593] PM: Adding info for No Bus:tty9
[   28.062634] PM: Adding info for No Bus:tty10
[   28.062679] PM: Adding info for No Bus:tty11
[   28.062719] PM: Adding info for No Bus:tty12
[   28.062770] PM: Adding info for No Bus:tty13
[   28.062813] PM: Adding info for No Bus:tty14
[   28.062855] PM: Adding info for No Bus:tty15
[   28.062894] PM: Adding info for No Bus:tty16
[   28.062937] PM: Adding info for No Bus:tty17
[   28.062978] PM: Adding info for No Bus:tty18
[   28.063020] PM: Adding info for No Bus:tty19
[   28.063074] PM: Adding info for No Bus:tty20
[   28.063113] PM: Adding info for No Bus:tty21
[   28.063155] PM: Adding info for No Bus:tty22
[   28.063201] PM: Adding info for No Bus:tty23
[   28.063243] PM: Adding info for No Bus:tty24
[   28.063284] PM: Adding info for No Bus:tty25
[   28.063333] PM: Adding info for No Bus:tty26
[   28.063376] PM: Adding info for No Bus:tty27
[   28.063417] PM: Adding info for No Bus:tty28
[   28.063464] PM: Adding info for No Bus:tty29
[   28.063508] PM: Adding info for No Bus:tty30
[   28.063553] PM: Adding info for No Bus:tty31
[   28.063597] PM: Adding info for No Bus:tty32
[   28.063651] PM: Adding info for No Bus:tty33
[   28.063691] PM: Adding info for No Bus:tty34
[   28.063739] PM: Adding info for No Bus:tty35
[   28.063782] PM: Adding info for No Bus:tty36
[   28.063843] PM: Adding info for No Bus:tty37
[   28.063907] PM: Adding info for No Bus:tty38
[   28.063965] PM: Adding info for No Bus:tty39
[   28.064013] PM: Adding info for No Bus:tty40
[   28.064060] PM: Adding info for No Bus:tty41
[   28.064103] PM: Adding info for No Bus:tty42
[   28.064147] PM: Adding info for No Bus:tty43
[   28.064193] PM: Adding info for No Bus:tty44
[   28.064238] PM: Adding info for No Bus:tty45
[   28.064292] PM: Adding info for No Bus:tty46
[   28.064342] PM: Adding info for No Bus:tty47
[   28.064389] PM: Adding info for No Bus:tty48
[   28.064439] PM: Adding info for No Bus:tty49
[   28.064490] PM: Adding info for No Bus:tty50
[   28.064537] PM: Adding info for No Bus:tty51
[   28.064592] PM: Adding info for No Bus:tty52
[   28.064642] PM: Adding info for No Bus:tty53
[   28.064687] PM: Adding info for No Bus:tty54
[   28.064733] PM: Adding info for No Bus:tty55
[   28.064778] PM: Adding info for No Bus:tty56
[   28.064829] PM: Adding info for No Bus:tty57
[   28.064877] PM: Adding info for No Bus:tty58
[   28.064944] PM: Adding info for No Bus:tty59
[   28.064990] PM: Adding info for No Bus:tty60
[   28.065035] PM: Adding info for No Bus:tty61
[   28.065083] PM: Adding info for No Bus:tty62
[   28.065130] PM: Adding info for No Bus:tty63
[   28.065265] PM: Adding info for No Bus:ptyp0
[   28.065336] PM: Adding info for No Bus:ptyp1
[   28.065384] PM: Adding info for No Bus:ptyp2
[   28.065432] PM: Adding info for No Bus:ptyp3
[   28.065481] PM: Adding info for No Bus:ptyp4
[   28.065530] PM: Adding info for No Bus:ptyp5
[   28.065577] PM: Adding info for No Bus:ptyp6
[   28.065630] PM: Adding info for No Bus:ptyp7
[   28.065688] PM: Adding info for No Bus:ptyp8
[   28.065737] PM: Adding info for No Bus:ptyp9
[   28.065785] PM: Adding info for No Bus:ptypa
[   28.065835] PM: Adding info for No Bus:ptypb
[   28.065881] PM: Adding info for No Bus:ptypc
[   28.065932] PM: Adding info for No Bus:ptypd
[   28.065993] PM: Adding info for No Bus:ptype
[   28.066047] PM: Adding info for No Bus:ptypf
[   28.066099] PM: Adding info for No Bus:ptyq0
[   28.066149] PM: Adding info for No Bus:ptyq1
[   28.066197] PM: Adding info for No Bus:ptyq2
[   28.066254] PM: Adding info for No Bus:ptyq3
[   28.066307] PM: Adding info for No Bus:ptyq4
[   28.066370] PM: Adding info for No Bus:ptyq5
[   28.066421] PM: Adding info for No Bus:ptyq6
[   28.066469] PM: Adding info for No Bus:ptyq7
[   28.066517] PM: Adding info for No Bus:ptyq8
[   28.066568] PM: Adding info for No Bus:ptyq9
[   28.066617] PM: Adding info for No Bus:ptyqa
[   28.066679] PM: Adding info for No Bus:ptyqb
[   28.066730] PM: Adding info for No Bus:ptyqc
[   28.066781] PM: Adding info for No Bus:ptyqd
[   28.066830] PM: Adding info for No Bus:ptyqe
[   28.066891] PM: Adding info for No Bus:ptyqf
[   28.066941] PM: Adding info for No Bus:ptyr0
[   28.066991] PM: Adding info for No Bus:ptyr1
[   28.067055] PM: Adding info for No Bus:ptyr2
[   28.067112] PM: Adding info for No Bus:ptyr3
[   28.067164] PM: Adding info for No Bus:ptyr4
[   28.067218] PM: Adding info for No Bus:ptyr5
[   28.067268] PM: Adding info for No Bus:ptyr6
[   28.067318] PM: Adding info for No Bus:ptyr7
[   28.067385] PM: Adding info for No Bus:ptyr8
[   28.067449] PM: Adding info for No Bus:ptyr9
[   28.067504] PM: Adding info for No Bus:ptyra
[   28.067566] PM: Adding info for No Bus:ptyrb
[   28.067618] PM: Adding info for No Bus:ptyrc
[   28.067673] PM: Adding info for No Bus:ptyrd
[   28.067728] PM: Adding info for No Bus:ptyre
[   28.067795] PM: Adding info for No Bus:ptyrf
[   28.067919] PM: Adding info for No Bus:ptys0
[   28.067979] PM: Adding info for No Bus:ptys1
[   28.068032] PM: Adding info for No Bus:ptys2
[   28.068087] PM: Adding info for No Bus:ptys3
[   28.068141] PM: Adding info for No Bus:ptys4
[   28.068202] PM: Adding info for No Bus:ptys5
[   28.068258] PM: Adding info for No Bus:ptys6
[   28.068319] PM: Adding info for No Bus:ptys7
[   28.068371] PM: Adding info for No Bus:ptys8
[   28.068423] PM: Adding info for No Bus:ptys9
[   28.068479] PM: Adding info for No Bus:ptysa
[   28.068536] PM: Adding info for No Bus:ptysb
[   28.068607] PM: Adding info for No Bus:ptysc
[   28.068666] PM: Adding info for No Bus:ptysd
[   28.068721] PM: Adding info for No Bus:ptyse
[   28.068778] PM: Adding info for No Bus:ptysf
[   28.068836] PM: Adding info for No Bus:ptyt0
[   28.068892] PM: Adding info for No Bus:ptyt1
[   28.068954] PM: Adding info for No Bus:ptyt2
[   28.069019] PM: Adding info for No Bus:ptyt3
[   28.069075] PM: Adding info for No Bus:ptyt4
[   28.069133] PM: Adding info for No Bus:ptyt5
[   28.069190] PM: Adding info for No Bus:ptyt6
[   28.069253] PM: Adding info for No Bus:ptyt7
[   28.069310] PM: Adding info for No Bus:ptyt8
[   28.069385] PM: Adding info for No Bus:ptyt9
[   28.069441] PM: Adding info for No Bus:ptyta
[   28.069504] PM: Adding info for No Bus:ptytb
[   28.069565] PM: Adding info for No Bus:ptytc
[   28.069624] PM: Adding info for No Bus:ptytd
[   28.069682] PM: Adding info for No Bus:ptyte
[   28.069759] PM: Adding info for No Bus:ptytf
[   28.069821] PM: Adding info for No Bus:ptyu0
[   28.069878] PM: Adding info for No Bus:ptyu1
[   28.069942] PM: Adding info for No Bus:ptyu2
[   28.070003] PM: Adding info for No Bus:ptyu3
[   28.070063] PM: Adding info for No Bus:ptyu4
[   28.070127] PM: Adding info for No Bus:ptyu5
[   28.070203] PM: Adding info for No Bus:ptyu6
[   28.070265] PM: Adding info for No Bus:ptyu7
[   28.070333] PM: Adding info for No Bus:ptyu8
[   28.070396] PM: Adding info for No Bus:ptyu9
[   28.070457] PM: Adding info for No Bus:ptyua
[   28.070529] PM: Adding info for No Bus:ptyub
[   28.070602] PM: Adding info for No Bus:ptyuc
[   28.070668] PM: Adding info for No Bus:ptyud
[   28.070738] PM: Adding info for No Bus:ptyue
[   28.070805] PM: Adding info for No Bus:ptyuf
[   28.070867] PM: Adding info for No Bus:ptyv0
[   28.070934] PM: Adding info for No Bus:ptyv1
[   28.070997] PM: Adding info for No Bus:ptyv2
[   28.071082] PM: Adding info for No Bus:ptyv3
[   28.071153] PM: Adding info for No Bus:ptyv4
[   28.071221] PM: Adding info for No Bus:ptyv5
[   28.071284] PM: Adding info for No Bus:ptyv6
[   28.071354] PM: Adding info for No Bus:ptyv7
[   28.071464] PM: Adding info for No Bus:ptyv8
[   28.071551] PM: Adding info for No Bus:ptyv9
[   28.071619] PM: Adding info for No Bus:ptyva
[   28.071686] PM: Adding info for No Bus:ptyvb
[   28.071749] PM: Adding info for No Bus:ptyvc
[   28.071866] PM: Adding info for No Bus:ptyvd
[   28.071959] PM: Adding info for No Bus:ptyve
[   28.072023] PM: Adding info for No Bus:ptyvf
[   28.072102] PM: Adding info for No Bus:ptyw0
[   28.072167] PM: Adding info for No Bus:ptyw1
[   28.072233] PM: Adding info for No Bus:ptyw2
[   28.072303] PM: Adding info for No Bus:ptyw3
[   28.072366] PM: Adding info for No Bus:ptyw4
[   28.072430] PM: Adding info for No Bus:ptyw5
[   28.072510] PM: Adding info for No Bus:ptyw6
[   28.072583] PM: Adding info for No Bus:ptyw7
[   28.072656] PM: Adding info for No Bus:ptyw8
[   28.072729] PM: Adding info for No Bus:ptyw9
[   28.072795] PM: Adding info for No Bus:ptywa
[   28.072867] PM: Adding info for No Bus:ptywb
[   28.072939] PM: Adding info for No Bus:ptywc
[   28.073024] PM: Adding info for No Bus:ptywd
[   28.073095] PM: Adding info for No Bus:ptywe
[   28.073178] PM: Adding info for No Bus:ptywf
[   28.073252] PM: Adding info for No Bus:ptyx0
[   28.073322] PM: Adding info for No Bus:ptyx1
[   28.073393] PM: Adding info for No Bus:ptyx2
[   28.073481] PM: Adding info for No Bus:ptyx3
[   28.073556] PM: Adding info for No Bus:ptyx4
[   28.073630] PM: Adding info for No Bus:ptyx5
[   28.073700] PM: Adding info for No Bus:ptyx6
[   28.073770] PM: Adding info for No Bus:ptyx7
[   28.073844] PM: Adding info for No Bus:ptyx8
[   28.073917] PM: Adding info for No Bus:ptyx9
[   28.074001] PM: Adding info for No Bus:ptyxa
[   28.074086] PM: Adding info for No Bus:ptyxb
[   28.074160] PM: Adding info for No Bus:ptyxc
[   28.074230] PM: Adding info for No Bus:ptyxd
[   28.074306] PM: Adding info for No Bus:ptyxe
[   28.074379] PM: Adding info for No Bus:ptyxf
[   28.074459] PM: Adding info for No Bus:ptyy0
[   28.074541] PM: Adding info for No Bus:ptyy1
[   28.074620] PM: Adding info for No Bus:ptyy2
[   28.074702] PM: Adding info for No Bus:ptyy3
[   28.074784] PM: Adding info for No Bus:ptyy4
[   28.074855] PM: Adding info for No Bus:ptyy5
[   28.074931] PM: Adding info for No Bus:ptyy6
[   28.075032] PM: Adding info for No Bus:ptyy7
[   28.075111] PM: Adding info for No Bus:ptyy8
[   28.075191] PM: Adding info for No Bus:ptyy9
[   28.075276] PM: Adding info for No Bus:ptyya
[   28.075362] PM: Adding info for No Bus:ptyyb
[   28.075498] PM: Adding info for No Bus:ptyyc
[   28.075594] PM: Adding info for No Bus:ptyyd
[   28.075681] PM: Adding info for No Bus:ptyye
[   28.075761] PM: Adding info for No Bus:ptyyf
[   28.075926] PM: Adding info for No Bus:ptyz0
[   28.076021] PM: Adding info for No Bus:ptyz1
[   28.076112] PM: Adding info for No Bus:ptyz2
[   28.076212] PM: Adding info for No Bus:ptyz3
[   28.076312] PM: Adding info for No Bus:ptyz4
[   28.076399] PM: Adding info for No Bus:ptyz5
[   28.076487] PM: Adding info for No Bus:ptyz6
[   28.076569] PM: Adding info for No Bus:ptyz7
[   28.076654] PM: Adding info for No Bus:ptyz8
[   28.076752] PM: Adding info for No Bus:ptyz9
[   28.076855] PM: Adding info for No Bus:ptyza
[   28.076949] PM: Adding info for No Bus:ptyzb
[   28.077034] PM: Adding info for No Bus:ptyzc
[   28.077118] PM: Adding info for No Bus:ptyzd
[   28.077202] PM: Adding info for No Bus:ptyze
[   28.077291] PM: Adding info for No Bus:ptyzf
[   28.077375] PM: Adding info for No Bus:ptya0
[   28.077476] PM: Adding info for No Bus:ptya1
[   28.077567] PM: Adding info for No Bus:ptya2
[   28.077657] PM: Adding info for No Bus:ptya3
[   28.077745] PM: Adding info for No Bus:ptya4
[   28.077836] PM: Adding info for No Bus:ptya5
[   28.077925] PM: Adding info for No Bus:ptya6
[   28.078025] PM: Adding info for No Bus:ptya7
[   28.078125] PM: Adding info for No Bus:ptya8
[   28.078218] PM: Adding info for No Bus:ptya9
[   28.078314] PM: Adding info for No Bus:ptyaa
[   28.078419] PM: Adding info for No Bus:ptyab
[   28.078516] PM: Adding info for No Bus:ptyac
[   28.078616] PM: Adding info for No Bus:ptyad
[   28.078730] PM: Adding info for No Bus:ptyae
[   28.078827] PM: Adding info for No Bus:ptyaf
[   28.078921] PM: Adding info for No Bus:ptyb0
[   28.079022] PM: Adding info for No Bus:ptyb1
[   28.079114] PM: Adding info for No Bus:ptyb2
[   28.079210] PM: Adding info for No Bus:ptyb3
[   28.079323] PM: Adding info for No Bus:ptyb4
[   28.079475] PM: Adding info for No Bus:ptyb5
[   28.079586] PM: Adding info for No Bus:ptyb6
[   28.079702] PM: Adding info for No Bus:ptyb7
[   28.079866] PM: Adding info for No Bus:ptyb8
[   28.079995] PM: Adding info for No Bus:ptyb9
[   28.080104] PM: Adding info for No Bus:ptyba
[   28.080230] PM: Adding info for No Bus:ptybb
[   28.080338] PM: Adding info for No Bus:ptybc
[   28.080445] PM: Adding info for No Bus:ptybd
[   28.080548] PM: Adding info for No Bus:ptybe
[   28.080652] PM: Adding info for No Bus:ptybf
[   28.080770] PM: Adding info for No Bus:ptyc0
[   28.080887] PM: Adding info for No Bus:ptyc1
[   28.081001] PM: Adding info for No Bus:ptyc2
[   28.081126] PM: Adding info for No Bus:ptyc3
[   28.081244] PM: Adding info for No Bus:ptyc4
[   28.081360] PM: Adding info for No Bus:ptyc5
[   28.081477] PM: Adding info for No Bus:ptyc6
[   28.081588] PM: Adding info for No Bus:ptyc7
[   28.081718] PM: Adding info for No Bus:ptyc8
[   28.081836] PM: Adding info for No Bus:ptyc9
[   28.081949] PM: Adding info for No Bus:ptyca
[   28.082066] PM: Adding info for No Bus:ptycb
[   28.082188] PM: Adding info for No Bus:ptycc
[   28.082308] PM: Adding info for No Bus:ptycd
[   28.082433] PM: Adding info for No Bus:ptyce
[   28.082567] PM: Adding info for No Bus:ptycf
[   28.082684] PM: Adding info for No Bus:ptyd0
[   28.082802] PM: Adding info for No Bus:ptyd1
[   28.082925] PM: Adding info for No Bus:ptyd2
[   28.083051] PM: Adding info for No Bus:ptyd3
[   28.083167] PM: Adding info for No Bus:ptyd4
[   28.083302] PM: Adding info for No Bus:ptyd5
[   28.083466] PM: Adding info for No Bus:ptyd6
[   28.083599] PM: Adding info for No Bus:ptyd7
[   28.083720] PM: Adding info for No Bus:ptyd8
[   28.083920] PM: Adding info for No Bus:ptyd9
[   28.084049] PM: Adding info for No Bus:ptyda
[   28.084186] PM: Adding info for No Bus:ptydb
[   28.084308] PM: Adding info for No Bus:ptydc
[   28.084420] PM: Adding info for No Bus:ptydd
[   28.084529] PM: Adding info for No Bus:ptyde
[   28.084643] PM: Adding info for No Bus:ptydf
[   28.084765] PM: Adding info for No Bus:ptye0
[   28.084892] PM: Adding info for No Bus:ptye1
[   28.085037] PM: Adding info for No Bus:ptye2
[   28.085170] PM: Adding info for No Bus:ptye3
[   28.085301] PM: Adding info for No Bus:ptye4
[   28.085427] PM: Adding info for No Bus:ptye5
[   28.085550] PM: Adding info for No Bus:ptye6
[   28.085697] PM: Adding info for No Bus:ptye7
[   28.085841] PM: Adding info for No Bus:ptye8
[   28.085976] PM: Adding info for No Bus:ptye9
[   28.086109] PM: Adding info for No Bus:ptyea
[   28.086246] PM: Adding info for No Bus:ptyeb
[   28.086380] PM: Adding info for No Bus:ptyec
[   28.086519] PM: Adding info for No Bus:ptyed
[   28.086648] PM: Adding info for No Bus:ptyee
[   28.086796] PM: Adding info for No Bus:ptyef
[   28.086948] PM: Adding info for No Bus:ttyp0
[   28.087086] PM: Adding info for No Bus:ttyp1
[   28.087216] PM: Adding info for No Bus:ttyp2
[   28.087354] PM: Adding info for No Bus:ttyp3
[   28.087566] PM: Adding info for No Bus:ttyp4
[   28.087711] PM: Adding info for No Bus:ttyp5
[   28.087938] PM: Adding info for No Bus:ttyp6
[   28.088084] PM: Adding info for No Bus:ttyp7
[   28.088213] PM: Adding info for No Bus:ttyp8
[   28.088340] PM: Adding info for No Bus:ttyp9
[   28.088466] PM: Adding info for No Bus:ttypa
[   28.088606] PM: Adding info for No Bus:ttypb
[   28.088756] PM: Adding info for No Bus:ttypc
[   28.088888] PM: Adding info for No Bus:ttypd
[   28.089012] PM: Adding info for No Bus:ttype
[   28.089151] PM: Adding info for No Bus:ttypf
[   28.089284] PM: Adding info for No Bus:ttyq0
[   28.089420] PM: Adding info for No Bus:ttyq1
[   28.089561] PM: Adding info for No Bus:ttyq2
[   28.089699] PM: Adding info for No Bus:ttyq3
[   28.089829] PM: Adding info for No Bus:ttyq4
[   28.089958] PM: Adding info for No Bus:ttyq5
[   28.090103] PM: Adding info for No Bus:ttyq6
[   28.090249] PM: Adding info for No Bus:ttyq7
[   28.090389] PM: Adding info for No Bus:ttyq8
[   28.090545] PM: Adding info for No Bus:ttyq9
[   28.090685] PM: Adding info for No Bus:ttyqa
[   28.090832] PM: Adding info for No Bus:ttyqb
[   28.090975] PM: Adding info for No Bus:ttyqc
[   28.091120] PM: Adding info for No Bus:ttyqd
[   28.091263] PM: Adding info for No Bus:ttyqe
[   28.091478] PM: Adding info for No Bus:ttyqf
[   28.091639] PM: Adding info for No Bus:ttyr0
[   28.091854] PM: Adding info for No Bus:ttyr1
[   28.092026] PM: Adding info for No Bus:ttyr2
[   28.092182] PM: Adding info for No Bus:ttyr3
[   28.092328] PM: Adding info for No Bus:ttyr4
[   28.092469] PM: Adding info for No Bus:ttyr5
[   28.092632] PM: Adding info for No Bus:ttyr6
[   28.092782] PM: Adding info for No Bus:ttyr7
[   28.092926] PM: Adding info for No Bus:ttyr8
[   28.093070] PM: Adding info for No Bus:ttyr9
[   28.093211] PM: Adding info for No Bus:ttyra
[   28.093366] PM: Adding info for No Bus:ttyrb
[   28.093520] PM: Adding info for No Bus:ttyrc
[   28.093673] PM: Adding info for No Bus:ttyrd
[   28.093819] PM: Adding info for No Bus:ttyre
[   28.093973] PM: Adding info for No Bus:ttyrf
[   28.094127] PM: Adding info for No Bus:ttys0
[   28.094284] PM: Adding info for No Bus:ttys1
[   28.094443] PM: Adding info for No Bus:ttys2
[   28.094623] PM: Adding info for No Bus:ttys3
[   28.094781] PM: Adding info for No Bus:ttys4
[   28.094939] PM: Adding info for No Bus:ttys5
[   28.095097] PM: Adding info for No Bus:ttys6
[   28.095252] PM: Adding info for No Bus:ttys7
[   28.095476] PM: Adding info for No Bus:ttys8
[   28.095657] PM: Adding info for No Bus:ttys9
[   28.095905] PM: Adding info for No Bus:ttysa
[   28.096092] PM: Adding info for No Bus:ttysb
[   28.096255] PM: Adding info for No Bus:ttysc
[   28.096412] PM: Adding info for No Bus:ttysd
[   28.096568] PM: Adding info for No Bus:ttyse
[   28.096730] PM: Adding info for No Bus:ttysf
[   28.096902] PM: Adding info for No Bus:ttyt0
[   28.097069] PM: Adding info for No Bus:ttyt1
[   28.097231] PM: Adding info for No Bus:ttyt2
[   28.097399] PM: Adding info for No Bus:ttyt3
[   28.097561] PM: Adding info for No Bus:ttyt4
[   28.097723] PM: Adding info for No Bus:ttyt5
[   28.097897] PM: Adding info for No Bus:ttyt6
[   28.098072] PM: Adding info for No Bus:ttyt7
[   28.098243] PM: Adding info for No Bus:ttyt8
[   28.098411] PM: Adding info for No Bus:ttyt9
[   28.098587] PM: Adding info for No Bus:ttyta
[   28.098778] PM: Adding info for No Bus:ttytb
[   28.098958] PM: Adding info for No Bus:ttytc
[   28.099148] PM: Adding info for No Bus:ttytd
[   28.099329] PM: Adding info for No Bus:ttyte
[   28.099584] PM: Adding info for No Bus:ttytf
[   28.099765] PM: Adding info for No Bus:ttyu0
[   28.100041] PM: Adding info for No Bus:ttyu1
[   28.100224] PM: Adding info for No Bus:ttyu2
[   28.100409] PM: Adding info for No Bus:ttyu3
[   28.100592] PM: Adding info for No Bus:ttyu4
[   28.100765] PM: Adding info for No Bus:ttyu5
[   28.100935] PM: Adding info for No Bus:ttyu6
[   28.101120] PM: Adding info for No Bus:ttyu7
[   28.101299] PM: Adding info for No Bus:ttyu8
[   28.101477] PM: Adding info for No Bus:ttyu9
[   28.101676] PM: Adding info for No Bus:ttyua
[   28.101856] PM: Adding info for No Bus:ttyub
[   28.102036] PM: Adding info for No Bus:ttyuc
[   28.102210] PM: Adding info for No Bus:ttyud
[   28.102396] PM: Adding info for No Bus:ttyue
[   28.102578] PM: Adding info for No Bus:ttyuf
[   28.102768] PM: Adding info for No Bus:ttyv0
[   28.102967] PM: Adding info for No Bus:ttyv1
[   28.103155] PM: Adding info for No Bus:ttyv2
[   28.103350] PM: Adding info for No Bus:ttyv3
[   28.103615] PM: Adding info for No Bus:ttyv4
[   28.103894] PM: Adding info for No Bus:ttyv5
[   28.104109] PM: Adding info for No Bus:ttyv6
[   28.104317] PM: Adding info for No Bus:ttyv7
[   28.104506] PM: Adding info for No Bus:ttyv8
[   28.104694] PM: Adding info for No Bus:ttyv9
[   28.104887] PM: Adding info for No Bus:ttyva
[   28.105090] PM: Adding info for No Bus:ttyvb
[   28.105291] PM: Adding info for No Bus:ttyvc
[   28.105488] PM: Adding info for No Bus:ttyvd
[   28.105688] PM: Adding info for No Bus:ttyve
[   28.105890] PM: Adding info for No Bus:ttyvf
[   28.106086] PM: Adding info for No Bus:ttyw0
[   28.106279] PM: Adding info for No Bus:ttyw1
[   28.106472] PM: Adding info for No Bus:ttyw2
[   28.106668] PM: Adding info for No Bus:ttyw3
[   28.106883] PM: Adding info for No Bus:ttyw4
[   28.107089] PM: Adding info for No Bus:ttyw5
[   28.107290] PM: Adding info for No Bus:ttyw6
[   28.107573] PM: Adding info for No Bus:ttyw7
[   28.107870] PM: Adding info for No Bus:ttyw8
[   28.108151] PM: Adding info for No Bus:ttyw9
[   28.108377] PM: Adding info for No Bus:ttywa
[   28.108591] PM: Adding info for No Bus:ttywb
[   28.108788] PM: Adding info for No Bus:ttywc
[   28.108983] PM: Adding info for No Bus:ttywd
[   28.109183] PM: Adding info for No Bus:ttywe
[   28.109381] PM: Adding info for No Bus:ttywf
[   28.109587] PM: Adding info for No Bus:ttyx0
[   28.109808] PM: Adding info for No Bus:ttyx1
[   28.110007] PM: Adding info for No Bus:ttyx2
[   28.110218] PM: Adding info for No Bus:ttyx3
[   28.110427] PM: Adding info for No Bus:ttyx4
[   28.110631] PM: Adding info for No Bus:ttyx5
[   28.110835] PM: Adding info for No Bus:ttyx6
[   28.111058] PM: Adding info for No Bus:ttyx7
[   28.111270] PM: Adding info for No Bus:ttyx8
[   28.111555] PM: Adding info for No Bus:ttyx9
[   28.111858] PM: Adding info for No Bus:ttyxa
[   28.112108] PM: Adding info for No Bus:ttyxb
[   28.112325] PM: Adding info for No Bus:ttyxc
[   28.112533] PM: Adding info for No Bus:ttyxd
[   28.112762] PM: Adding info for No Bus:ttyxe
[   28.112976] PM: Adding info for No Bus:ttyxf
[   28.113187] PM: Adding info for No Bus:ttyy0
[   28.113399] PM: Adding info for No Bus:ttyy1
[   28.113609] PM: Adding info for No Bus:ttyy2
[   28.113836] PM: Adding info for No Bus:ttyy3
[   28.114059] PM: Adding info for No Bus:ttyy4
[   28.114277] PM: Adding info for No Bus:ttyy5
[   28.114489] PM: Adding info for No Bus:ttyy6
[   28.114706] PM: Adding info for No Bus:ttyy7
[   28.114917] PM: Adding info for No Bus:ttyy8
[   28.115132] PM: Adding info for No Bus:ttyy9
[   28.115428] PM: Adding info for No Bus:ttyya
[   28.115688] PM: Adding info for No Bus:ttyyb
[   28.116026] PM: Adding info for No Bus:ttyyc
[   28.116268] PM: Adding info for No Bus:ttyyd
[   28.116488] PM: Adding info for No Bus:ttyye
[   28.116723] PM: Adding info for No Bus:ttyyf
[   28.116943] PM: Adding info for No Bus:ttyz0
[   28.117173] PM: Adding info for No Bus:ttyz1
[   28.117408] PM: Adding info for No Bus:ttyz2
[   28.117642] PM: Adding info for No Bus:ttyz3
[   28.117872] PM: Adding info for No Bus:ttyz4
[   28.118101] PM: Adding info for No Bus:ttyz5
[   28.118329] PM: Adding info for No Bus:ttyz6
[   28.118558] PM: Adding info for No Bus:ttyz7
[   28.118813] PM: Adding info for No Bus:ttyz8
[   28.119042] PM: Adding info for No Bus:ttyz9
[   28.119272] PM: Adding info for No Bus:ttyza
[   28.119596] PM: Adding info for No Bus:ttyzb
[   28.119941] PM: Adding info for No Bus:ttyzc
[   28.120251] PM: Adding info for No Bus:ttyzd
[   28.120518] PM: Adding info for No Bus:ttyze
[   28.120762] PM: Adding info for No Bus:ttyzf
[   28.120995] PM: Adding info for No Bus:ttya0
[   28.121227] PM: Adding info for No Bus:ttya1
[   28.121466] PM: Adding info for No Bus:ttya2
[   28.121712] PM: Adding info for No Bus:ttya3
[   28.121949] PM: Adding info for No Bus:ttya4
[   28.122201] PM: Adding info for No Bus:ttya5
[   28.122435] PM: Adding info for No Bus:ttya6
[   28.122678] PM: Adding info for No Bus:ttya7
[   28.122917] PM: Adding info for No Bus:ttya8
[   28.123153] PM: Adding info for No Bus:ttya9
[   28.123468] PM: Adding info for No Bus:ttyaa
[   28.123834] PM: Adding info for No Bus:ttyab
[   28.124120] PM: Adding info for No Bus:ttyac
[   28.124366] PM: Adding info for No Bus:ttyad
[   28.124604] PM: Adding info for No Bus:ttyae
[   28.124846] PM: Adding info for No Bus:ttyaf
[   28.125088] PM: Adding info for No Bus:ttyb0
[   28.125331] PM: Adding info for No Bus:ttyb1
[   28.125596] PM: Adding info for No Bus:ttyb2
[   28.125850] PM: Adding info for No Bus:ttyb3
[   28.126104] PM: Adding info for No Bus:ttyb4
[   28.126352] PM: Adding info for No Bus:ttyb5
[   28.126596] PM: Adding info for No Bus:ttyb6
[   28.126838] PM: Adding info for No Bus:ttyb7
[   28.127093] PM: Adding info for No Bus:ttyb8
[   28.127417] PM: Adding info for No Bus:ttyb9
[   28.127691] PM: Adding info for No Bus:ttyba
[   28.128089] PM: Adding info for No Bus:ttybb
[   28.128357] PM: Adding info for No Bus:ttybc
[   28.128611] PM: Adding info for No Bus:ttybd
[   28.128861] PM: Adding info for No Bus:ttybe
[   28.129138] PM: Adding info for No Bus:ttybf
[   28.129390] PM: Adding info for No Bus:ttyc0
[   28.129638] PM: Adding info for No Bus:ttyc1
[   28.129893] PM: Adding info for No Bus:ttyc2
[   28.130158] PM: Adding info for No Bus:ttyc3
[   28.130416] PM: Adding info for No Bus:ttyc4
[   28.130677] PM: Adding info for No Bus:ttyc5
[   28.130940] PM: Adding info for No Bus:ttyc6
[   28.131195] PM: Adding info for No Bus:ttyc7
[   28.131545] PM: Adding info for No Bus:ttyc8
[   28.131920] PM: Adding info for No Bus:ttyc9
[   28.132204] PM: Adding info for No Bus:ttyca
[   28.132494] PM: Adding info for No Bus:ttycb
[   28.132777] PM: Adding info for No Bus:ttycc
[   28.133034] PM: Adding info for No Bus:ttycd
[   28.133292] PM: Adding info for No Bus:ttyce
[   28.133546] PM: Adding info for No Bus:ttycf
[   28.133876] PM: Adding info for No Bus:ttyd0
[   28.134162] PM: Adding info for No Bus:ttyd1
[   28.134442] PM: Adding info for No Bus:ttyd2
[   28.134722] PM: Adding info for No Bus:ttyd3
[   28.134999] PM: Adding info for No Bus:ttyd4
[   28.135264] PM: Adding info for No Bus:ttyd5
[   28.135622] PM: Adding info for No Bus:ttyd6
[   28.136036] PM: Adding info for No Bus:ttyd7
[   28.136328] PM: Adding info for No Bus:ttyd8
[   28.136624] PM: Adding info for No Bus:ttyd9
[   28.136894] PM: Adding info for No Bus:ttyda
[   28.137174] PM: Adding info for No Bus:ttydb
[   28.137448] PM: Adding info for No Bus:ttydc
[   28.137715] PM: Adding info for No Bus:ttydd
[   28.137988] PM: Adding info for No Bus:ttyde
[   28.138271] PM: Adding info for No Bus:ttydf
[   28.138552] PM: Adding info for No Bus:ttye0
[   28.138828] PM: Adding info for No Bus:ttye1
[   28.139104] PM: Adding info for No Bus:ttye2
[   28.139493] PM: Adding info for No Bus:ttye3
[   28.139902] PM: Adding info for No Bus:ttye4
[   28.140213] PM: Adding info for No Bus:ttye5
[   28.140514] PM: Adding info for No Bus:ttye6
[   28.140795] PM: Adding info for No Bus:ttye7
[   28.141072] PM: Adding info for No Bus:ttye8
[   28.141351] PM: Adding info for No Bus:ttye9
[   28.141626] PM: Adding info for No Bus:ttyea
[   28.141918] PM: Adding info for No Bus:ttyeb
[   28.142216] PM: Adding info for No Bus:ttyec
[   28.142510] PM: Adding info for No Bus:ttyed
[   28.142792] PM: Adding info for No Bus:ttyee
[   28.143086] PM: Adding info for No Bus:ttyef
[   28.143182] PM: Adding info for No Bus:hpet
[   28.143248] PM: Removing info for No Bus:hpet
[   28.143343] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   28.143375] PM: Adding info for platform:serial8250
[   28.143510] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   28.143830] PM: Adding info for No Bus:ttyS0
[   28.143985] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   28.144228] PM: Adding info for No Bus:ttyS1
[   28.144576] PM: Adding info for No Bus:ttyS2
[   28.144911] PM: Adding info for No Bus:ttyS3
[   28.145461] PM: Removing info for No Bus:ttyS0
[   28.145595] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   28.145894] PM: Adding info for No Bus:ttyS0
[   28.146150] PM: Removing info for No Bus:ttyS1
[   28.146279] 00:10: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   28.146555] PM: Adding info for No Bus:ttyS1
[   28.146767] PM: Adding info for No Bus:isa
[   28.147529] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   28.147873] input: Macintosh mouse button emulation as /class/input/input0
[   28.147895] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   28.147900] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   28.148249] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
[   28.148307] PM: Adding info for platform:i8042
[   28.151067] serio: i8042 KBD port at 0x60,0x64 irq 1
[   28.151077] serio: i8042 AUX port at 0x60,0x64 irq 12
[   28.151126] PM: Adding info for serio:serio0
[   28.151220] PM: Adding info for serio:serio1
[   28.151319] PM: Adding info for No Bus:psaux
[   28.151352] mice: PS/2 mouse device common for all mice
[   28.151482] PM: Adding info for platform:eisa.0
[   28.151527] EISA: Probing bus 0 at eisa.0
[   28.151552] Cannot allocate resource for EISA slot 4
[   28.151555] Cannot allocate resource for EISA slot 5
[   28.151569] EISA: Detected 0 cards.
[   28.151736] TCP cubic registered
[   28.151750] NET: Registered protocol family 1
[   28.151791] Using IPI Shortcut mode
[   28.151829]   Magic number: 15:412:125
[   28.152877] Freeing unused kernel memory: 320k freed
[   28.152963] PM: Adding info for No Bus:vcs1
[   28.153092] PM: Adding info for No Bus:vcsa1
[   28.155698] Time: tsc clocksource has been installed.
[   28.179069] input: AT Translated Set 2 keyboard as /class/input/input1
[   28.343278] PM: Adding info for No Bus:vcs2
[   28.343391] PM: Adding info for No Bus:vcsa2
[   28.344318] PM: Removing info for No Bus:vcs2
[   28.344429] PM: Removing info for No Bus:vcsa2
[   28.347730] PM: Adding info for No Bus:vcs2
[   28.347851] PM: Adding info for No Bus:vcsa2
[   28.353123] PM: Removing info for No Bus:vcs2
[   28.353265] PM: Removing info for No Bus:vcsa2
[   28.355733] PM: Adding info for No Bus:vcs2
[   28.355839] PM: Adding info for No Bus:vcsa2
[   28.357629] PM: Removing info for No Bus:vcs2
[   28.357747] PM: Removing info for No Bus:vcsa2
[   28.359329] PM: Adding info for No Bus:vcs3
[   28.359485] PM: Adding info for No Bus:vcsa3
[   28.360350] PM: Removing info for No Bus:vcs3
[   28.360458] PM: Removing info for No Bus:vcsa3
[   28.363721] PM: Adding info for No Bus:vcs3
[   28.363852] PM: Adding info for No Bus:vcsa3
[   28.368961] PM: Removing info for No Bus:vcs3
[   28.369092] PM: Removing info for No Bus:vcsa3
[   28.371491] PM: Adding info for No Bus:vcs3
[   28.371602] PM: Adding info for No Bus:vcsa3
[   28.373403] PM: Removing info for No Bus:vcs3
[   28.373520] PM: Removing info for No Bus:vcsa3
[   28.375071] PM: Adding info for No Bus:vcs4
[   28.375182] PM: Adding info for No Bus:vcsa4
[   28.376068] PM: Removing info for No Bus:vcs4
[   28.376179] PM: Removing info for No Bus:vcsa4
[   28.379445] PM: Adding info for No Bus:vcs4
[   28.379566] PM: Adding info for No Bus:vcsa4
[   28.384490] PM: Removing info for No Bus:vcs4
[   28.384631] PM: Removing info for No Bus:vcsa4
[   28.387021] PM: Adding info for No Bus:vcs4
[   28.387127] PM: Adding info for No Bus:vcsa4
[   28.388990] PM: Removing info for No Bus:vcs4
[   28.389109] PM: Removing info for No Bus:vcsa4
[   28.390662] PM: Adding info for No Bus:vcs5
[   28.390769] PM: Adding info for No Bus:vcsa5
[   28.391757] PM: Removing info for No Bus:vcs5
[   28.391872] PM: Removing info for No Bus:vcsa5
[   28.395151] PM: Adding info for No Bus:vcs5
[   28.395275] PM: Adding info for No Bus:vcsa5
[   28.400323] PM: Removing info for No Bus:vcs5
[   28.400463] PM: Removing info for No Bus:vcsa5
[   28.402901] PM: Adding info for No Bus:vcs5
[   28.403005] PM: Adding info for No Bus:vcsa5
[   28.404832] PM: Removing info for No Bus:vcs5
[   28.404948] PM: Removing info for No Bus:vcsa5
[   28.406517] PM: Adding info for No Bus:vcs6
[   28.406624] PM: Adding info for No Bus:vcsa6
[   28.407537] PM: Removing info for No Bus:vcs6
[   28.407647] PM: Removing info for No Bus:vcsa6
[   28.410913] PM: Adding info for No Bus:vcs6
[   28.411050] PM: Adding info for No Bus:vcsa6
[   28.416143] PM: Removing info for No Bus:vcs6
[   28.416275] PM: Removing info for No Bus:vcsa6
[   28.418650] PM: Adding info for No Bus:vcs6
[   28.418759] PM: Adding info for No Bus:vcsa6
[   28.420568] PM: Removing info for No Bus:vcs6
[   28.420681] PM: Removing info for No Bus:vcsa6
[   28.524688] PM: Adding info for No Bus:vcs8
[   28.524828] PM: Adding info for No Bus:vcsa8
[   29.718952] thermal: Unknown symbol acpi_processor_set_thermal_limit
[   30.746025] usbcore: registered new interface driver usbfs
[   30.746085] usbcore: registered new interface driver hub
[   30.746127] usbcore: registered new device driver usb
[   30.748688] USB Universal Host Controller Interface driver v3.0
[   30.748797] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   30.748803] uhci_hcd 0000:00:1f.2: UHCI Host Controller
[   30.749038] uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
[   30.749080] uhci_hcd 0000:00:1f.2: irq 19, io base 0x0000d000
[   30.749170] PM: Adding info for usb:usb1
[   30.749263] PM: Adding info for No Bus:usbdev1.1_ep00
[   30.749290] usb usb1: configuration #1 chosen from 1 choice
[   30.749306] PM: Adding info for usb:1-0:1.0
[   30.749334] hub 1-0:1.0: USB hub found
[   30.749349] hub 1-0:1.0: 2 ports detected
[   30.829507] SCSI subsystem initialized
[   30.840610] libata version 2.00 loaded.
[   30.851753] PM: Adding info for No Bus:usbdev1.1_ep81
[   30.851919] PCI: Setting latency timer of device 0000:00:1f.4 to 64
[   30.851925] uhci_hcd 0000:00:1f.4: UHCI Host Controller
[   30.851976] uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
[   30.852013] uhci_hcd 0000:00:1f.4: irq 23, io base 0x0000d800
[   30.852089] PM: Adding info for usb:usb2
[   30.852159] PM: Adding info for No Bus:usbdev2.1_ep00
[   30.852181] usb usb2: configuration #1 chosen from 1 choice
[   30.852199] PM: Adding info for usb:2-0:1.0
[   30.852226] hub 2-0:1.0: USB hub found
[   30.852244] hub 2-0:1.0: 2 ports detected
[   30.862114] Linux Tulip driver version 1.1.14 (May 11, 2002)
[   30.955636] PM: Adding info for No Bus:usbdev2.1_ep81
[   30.980056] pata_pdc2027x 0000:02:01.0: version 0.74-ac5
[   31.079273] pata_pdc2027x 0000:02:01.0: PLL input clock 16550 kHz
[   31.143890] ata1: PATA max UDMA/133 cmd 0xE08517C0 ctl 0xE0851FDA bmdma 0xE0851000 irq 21
[   31.143939] ata2: PATA max UDMA/133 cmd 0xE08515C0 ctl 0xE0851DDA bmdma 0xE0851008 irq 21
[   31.143962] scsi0 : pata_pdc2027x
[   31.144002] PM: Adding info for No Bus:host0
[   31.187961] Floppy drive(s): fd0 is 1.44M
[   31.257445] FDC 0 is a post-1991 82077
[   31.278397] PM: Adding info for platform:floppy.0
[   31.307401] ata1.00: ATA-7, max UDMA/100, 234493056 sectors: LBA48 
[   31.307407] ata1.00: ata1: dev 0 multi count 16
[   31.315341] ata1.01: ATA-7, max UDMA/133, 320173056 sectors: LBA48 
[   31.315348] ata1.01: ata1: dev 1 multi count 16
[   31.323327] ata1.00: configured for UDMA/100
[   31.331336] ata1.01: configured for UDMA/133
[   31.331376] scsi1 : pata_pdc2027x
[   31.331423] PM: Adding info for No Bus:host1
[   31.498123] ATA: abnormal status 0x7F on port 0xE08515DF
[   31.509508] ATA: abnormal status 0x7F on port 0xE08515DF
[   31.638396] PM: Removing info for No Bus:vcs8
[   31.638451] PM: Removing info for No Bus:vcsa8
[   31.670767] ata2.01: ATAPI, max MWDMA2
[   31.670779] ata2.01: device is on DMA blacklist, disabling DMA
[   31.834514] ata2.01: configured for PIO4
[   31.834585] PM: Adding info for No Bus:target0:0:0
[   31.834757] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP1203N  TL10 PQ: 0 ANSI: 5
[   31.834772] PM: Adding info for scsi:0:0:0:0
[   31.834853] PM: Adding info for No Bus:target0:0:1
[   31.835435] scsi 0:0:1:0: Direct-Access     ATA      Maxtor 6Y160P0   YAR4 PQ: 0 ANSI: 5
[   31.835459] PM: Adding info for scsi:0:0:1:0
[   31.835549] PM: Adding info for No Bus:target1:0:1
[   31.836116] scsi 1:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH   A80  PQ: 0 ANSI: 5
[   31.836139] PM: Adding info for scsi:1:0:1:0
[   31.837144] tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
[   31.844041] eth0: ADMtek Comet rev 17 at Port 0xb400, 00:04:5A:8A:55:7B, IRQ 21.
[   31.844513] ata_piix 0000:00:1f.1: version 2.00ac7
[   31.844552] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   31.844648] ata3: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
[   31.844713] ata4: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
[   31.844746] scsi2 : ata_piix
[   31.844772] PM: Adding info for No Bus:host2
[   31.874227] SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
[   31.876140] sda: Write Protect is off
[   31.876148] sda: Mode Sense: 00 3a 00 00
[   31.876200] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   31.876321] SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
[   31.876333] sda: Write Protect is off
[   31.876337] sda: Mode Sense: 00 3a 00 00
[   31.876354] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   31.876360]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
[   31.930547] sd 0:0:0:0: Attached scsi disk sda
[   31.930887] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   31.930906] sdb: Write Protect is off
[   31.930910] sdb: Mode Sense: 00 3a 00 00
[   31.930929] SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   31.931017] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   31.931029] sdb: Write Protect is off
[   31.931033] sdb: Mode Sense: 00 3a 00 00
[   31.931051] SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   31.931056]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 >
[   31.956568] sd 0:0:1:0: Attached scsi disk sdb
[   31.966535] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   31.966777] sd 0:0:1:0: Attached scsi generic sg1 type 0
[   31.967009] sr 1:0:1:0: Attached scsi generic sg2 type 5
[   32.009563] sr0: scsi3-mmc drive: 229x/52x cd/rw xa/form2 cdda tray
[   32.009573] Uniform CD-ROM driver Revision: 3.20
[   32.009974] sr 1:0:1:0: Attached scsi CD-ROM sr0
[   32.162001] ata3.00: ATAPI, max UDMA/33
[   32.325697] ata3.00: configured for UDMA/33
[   32.325727] scsi3 : ata_piix
[   32.325761] PM: Adding info for No Bus:host3
[   32.481337] PM: Adding info for No Bus:target2:0:0
[   32.483575] scsi 2:0:0:0: CD-ROM            HP       DVD Writer 200j  1.36 PQ: 0 ANSI: 5
[   32.483590] PM: Adding info for scsi:2:0:0:0
[   32.487568] sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   32.487758] sr 2:0:0:0: Attached scsi CD-ROM sr1
[   32.487850] sr 2:0:0:0: Attached scsi generic sg3 type 5
[   32.586158] Attempting manual resume
[   32.586165] swsusp: Resume From Partition 8:6
[   32.586167] PM: Checking swsusp image.
[   32.594160] PM: Resume from disk failed.
[   32.648471] kjournald starting.  Commit interval 5 seconds
[   32.648495] EXT3-fs: mounted filesystem with ordered data mode.
[   33.007169] PM: Removing info for No Bus:vcs1
[   33.007216] PM: Removing info for No Bus:vcsa1
[   33.007300] PM: Adding info for No Bus:vcs1
[   33.007319] PM: Adding info for No Bus:vcsa1
[   37.668888] PM: Adding info for No Bus:vcs2
[   37.668929] PM: Adding info for No Bus:vcsa2
[   37.670856] PM: Removing info for No Bus:vcs2
[   37.670903] PM: Removing info for No Bus:vcsa2
[   37.671155] PM: Adding info for No Bus:vcs3
[   37.671178] PM: Adding info for No Bus:vcsa3
[   37.673056] PM: Removing info for No Bus:vcs3
[   37.673102] PM: Removing info for No Bus:vcsa3
[   37.673360] PM: Adding info for No Bus:vcs4
[   37.673382] PM: Adding info for No Bus:vcsa4
[   37.675310] PM: Removing info for No Bus:vcs4
[   37.675359] PM: Removing info for No Bus:vcsa4
[   37.675608] PM: Adding info for No Bus:vcs5
[   37.675632] PM: Adding info for No Bus:vcsa5
[   37.677592] PM: Removing info for No Bus:vcs5
[   37.677640] PM: Removing info for No Bus:vcsa5
[   37.677894] PM: Adding info for No Bus:vcs6
[   37.677918] PM: Adding info for No Bus:vcsa6
[   37.679801] PM: Removing info for No Bus:vcs6
[   37.679850] PM: Removing info for No Bus:vcsa6
[   40.253492] NET: Registered protocol family 10
[   40.253691] lo: Disabled Privacy Extensions
[   41.654379] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   41.702491] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   42.028844] 0000:02:05.0: tulip_stop_rxtx() failed
[   42.028859] eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
[   42.348211] input: PC Speaker as /class/input/input2
[   42.392817] iTCO_vendor_support: vendor-support=0
[   42.419619] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (11-Nov-2006)
[   42.419685] PM: Adding info for platform:iTCO_wdt
[   42.419744] iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled by hardware
[   42.419804] iTCO_wdt: No card detected
[   42.431118] PM: Adding info for No Bus:rtc
[   42.431187] Real Time Clock Driver v1.12ac
[   42.461676] Linux agpgart interface v0.101 (c) Dave Jones
[   42.479668] agpgart: Detected an Intel i845 Chipset.
[   42.483579] PM: Adding info for No Bus:agpgart
[   42.483677] agpgart: AGP aperture is 64M @ 0xe8000000
[   43.427358] parport: PnPBIOS parport detected.
[   43.427428] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   43.731141] PM: Adding info for No Bus:timer
[   43.814766] PM: Adding info for No Bus:seq
[   43.940800] PM: Adding info for No Bus:sequencer
[   43.940851] PM: Adding info for No Bus:sequencer2
[   44.285467] input: ImPS/2 Generic Wheel Mouse as /class/input/input3
[   44.290828] PM: Adding info for No Bus:midiC1D0
[   44.290865] PM: Adding info for No Bus:midi1
[   44.290885] PM: Adding info for No Bus:dmmidi1
[   44.290946] PM: Adding info for No Bus:controlC1
[   44.290979] PM: Adding info for No Bus:mixer1
[   44.291826] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   44.607088] intel8x0_measure_ac97_clock: measured 54895 usecs
[   44.607093] intel8x0: clocking to 48000
[   44.607149] PM: Adding info for No Bus:pcmC0D1c
[   44.607302] PM: Adding info for No Bus:adsp
[   44.607349] PM: Adding info for No Bus:pcmC0D0p
[   44.607401] PM: Adding info for No Bus:pcmC0D0c
[   44.607447] PM: Adding info for No Bus:dsp
[   44.607503] PM: Adding info for No Bus:audio
[   44.607560] PM: Adding info for ac97:0-0:ALC200,200P
[   44.607611] PM: Adding info for No Bus:controlC0
[   44.607667] PM: Adding info for No Bus:mixer
[   50.889690] eth0: no IPv6 routers present
[   62.013082] ata2.01: qc timeout (cmd 0xa0)
[   62.013098] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   62.013160] ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
[   62.013163]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
[   69.002638] ata2: port is slow to respond, please be patient (Status 0xd8)
[   91.984233] ata2: port failed to respond (30 secs, Status 0xd8)
[   91.984292] ata2: soft resetting port
[   92.151391] ATA: abnormal status 0x7F on port 0xE08515DF
[   92.162767] ATA: abnormal status 0x7F on port 0xE08515DF
[   92.323758] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[   92.323766] ata2.01: revalidation failed (errno=-5)
[   92.323821] ata2: failed to recover some devices, retrying in 5 secs
[   97.320272] ata2: soft resetting port
[   97.487428] ATA: abnormal status 0x7F on port 0xE08515DF
[   97.498808] ATA: abnormal status 0x7F on port 0xE08515DF
[   97.660041] ata2.01: device is on DMA blacklist, disabling DMA
[   97.823822] ata2.01: configured for PIO4
[   97.823874] ata2: EH complete
[  127.798684] ata2.01: qc timeout (cmd 0xa0)
[  127.798702] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  127.798762] ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
[  127.798764]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
[  134.788234] ata2: port is slow to respond, please be patient (Status 0xd8)
[  157.769854] ata2: port failed to respond (30 secs, Status 0xd8)
[  157.769913] ata2: soft resetting port
[  157.936980] ATA: abnormal status 0x7F on port 0xE08515DF
[  157.948359] ATA: abnormal status 0x7F on port 0xE08515DF
[  158.109360] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  158.109367] ata2.01: revalidation failed (errno=-5)
[  158.109422] ata2: failed to recover some devices, retrying in 5 secs
[  163.105873] ata2: soft resetting port
[  163.273031] ATA: abnormal status 0x7F on port 0xE08515DF
[  163.284407] ATA: abnormal status 0x7F on port 0xE08515DF
[  163.445644] ata2.01: device is on DMA blacklist, disabling DMA
[  163.609414] ata2.01: configured for PIO4
[  163.609465] ata2: EH complete
[  193.576298] ata2.01: qc timeout (cmd 0xa0)
[  193.576316] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  193.576378] ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
[  193.576380]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
[  200.565848] ata2: port is slow to respond, please be patient (Status 0xd8)
[  218.829995] fuse init (API version 7.8)
[  218.830085] PM: Adding info for No Bus:fuse
[  218.868534] lp0: using parport0 (interrupt-driven).
[  218.931362] PM: Adding info for No Bus:i2c-0
[  218.986295] PM: Adding info for i2c:0-0050
[  219.002275] PM: Adding info for i2c:0-0051
[  219.072822] PM: Adding info for No Bus:i2c-9191
[  219.111646] it87: Found IT8712F chip at 0x290, revision 4
[  219.114138] PM: Adding info for i2c:9191-0290
[  219.116585] it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
[  219.183076] Adding 1044184k swap on /dev/disk/by-uuid/5c6a2d8c-54c1-44cb-8f1b-4a159373a120.  Priority:-1 extents:1 across:1044184k
[  219.427288] EXT3 FS on sda7, internal journal
[  222.960271] kjournald starting.  Commit interval 5 seconds
[  222.960444] EXT3 FS on sda1, internal journal
[  222.960451] EXT3-fs: mounted filesystem with ordered data mode.
[  222.986146] kjournald starting.  Commit interval 5 seconds
[  222.986337] EXT3 FS on sda3, internal journal
[  222.986344] EXT3-fs: mounted filesystem with ordered data mode.
[  223.034396] kjournald starting.  Commit interval 5 seconds
[  223.034642] EXT3 FS on sdb5, internal journal
[  223.034649] EXT3-fs: mounted filesystem with ordered data mode.
[  223.103760] NTFS driver 2.1.28 [Flags: R/O MODULE].
[  223.183821] NTFS volume version 3.1.
[  223.317066] kjournald starting.  Commit interval 5 seconds
[  223.317338] EXT3 FS on sdb6, internal journal
[  223.317345] EXT3-fs: mounted filesystem with ordered data mode.
[  223.333630] kjournald starting.  Commit interval 5 seconds
[  223.333788] EXT3 FS on sda5, internal journal
[  223.333796] EXT3-fs: mounted filesystem with ordered data mode.
[  223.364396] kjournald starting.  Commit interval 5 seconds
[  223.364553] EXT3 FS on sda2, internal journal
[  223.364561] EXT3-fs: mounted filesystem with ordered data mode.
[  223.547444] ata2: port failed to respond (30 secs, Status 0xd8)
[  223.547504] ata2: soft resetting port
[  223.714662] ATA: abnormal status 0x7F on port 0xE08515DF
[  223.726189] ATA: abnormal status 0x7F on port 0xE08515DF
[  223.886974] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  223.886982] ata2.01: revalidation failed (errno=-5)
[  223.887037] ata2: failed to recover some devices, retrying in 5 secs
[  225.378920] NET: Registered protocol family 17
[  228.883486] ata2: soft resetting port
[  229.050629] ATA: abnormal status 0x7F on port 0xE08515DF
[  229.062003] ATA: abnormal status 0x7F on port 0xE08515DF
[  229.223263] ata2.01: device is on DMA blacklist, disabling DMA
[  229.387034] ata2.01: configured for PIO4
[  229.387079] ata2: EH complete
[  229.517651] PM: Adding info for No Bus:vcs2
[  229.520683] PM: Adding info for No Bus:vcsa2
[  229.525249] PM: Removing info for No Bus:vcs2
[  229.527875] PM: Removing info for No Bus:vcsa2
[  229.532537] PM: Adding info for No Bus:vcs2
[  229.535581] PM: Adding info for No Bus:vcsa2
[  229.544509] PM: Removing info for No Bus:vcs2
[  229.547175] PM: Removing info for No Bus:vcsa2
[  229.550172] PM: Adding info for No Bus:vcs3
[  229.553182] PM: Adding info for No Bus:vcsa3
[  229.557709] PM: Removing info for No Bus:vcs3
[  229.560384] PM: Removing info for No Bus:vcsa3
[  229.565022] PM: Adding info for No Bus:vcs3
[  229.568050] PM: Adding info for No Bus:vcsa3
[  229.577018] PM: Removing info for No Bus:vcs3
[  229.579670] PM: Removing info for No Bus:vcsa3
[  229.582686] PM: Adding info for No Bus:vcs4
[  229.585641] PM: Adding info for No Bus:vcsa4
[  229.590187] PM: Removing info for No Bus:vcs4
[  229.592854] PM: Removing info for No Bus:vcsa4
[  229.597495] PM: Adding info for No Bus:vcs4
[  229.600545] PM: Adding info for No Bus:vcsa4
[  229.609510] PM: Removing info for No Bus:vcs4
[  229.612171] PM: Removing info for No Bus:vcsa4
[  229.615182] PM: Adding info for No Bus:vcs5
[  229.618150] PM: Adding info for No Bus:vcsa5
[  229.622735] PM: Removing info for No Bus:vcs5
[  229.625355] PM: Removing info for No Bus:vcsa5
[  229.629959] PM: Adding info for No Bus:vcs5
[  229.632994] PM: Adding info for No Bus:vcsa5
[  229.642019] PM: Removing info for No Bus:vcs5
[  229.644679] PM: Removing info for No Bus:vcsa5
[  229.647695] PM: Adding info for No Bus:vcs6
[  229.650666] PM: Adding info for No Bus:vcsa6
[  229.655279] PM: Removing info for No Bus:vcs6
[  229.657901] PM: Removing info for No Bus:vcsa6
[  229.662609] PM: Adding info for No Bus:vcs6
[  229.665584] PM: Adding info for No Bus:vcsa6
[  229.674548] PM: Removing info for No Bus:vcs6
[  229.677190] PM: Removing info for No Bus:vcsa6
[  229.687379] PM: Adding info for No Bus:vcs2
[  229.690392] PM: Adding info for No Bus:vcsa2
[  229.695297] PM: Removing info for No Bus:vcs2
[  229.697892] PM: Removing info for No Bus:vcsa2
[  229.700735] PM: Adding info for No Bus:vcs3
[  229.703734] PM: Adding info for No Bus:vcsa3
[  229.708605] PM: Removing info for No Bus:vcs3
[  229.711250] PM: Removing info for No Bus:vcsa3
[  229.714049] PM: Adding info for No Bus:vcs4
[  229.717010] PM: Adding info for No Bus:vcsa4
[  229.721892] PM: Removing info for No Bus:vcs4
[  229.724511] PM: Removing info for No Bus:vcsa4
[  229.727372] PM: Adding info for No Bus:vcs5
[  229.730324] PM: Adding info for No Bus:vcsa5
[  229.735183] PM: Removing info for No Bus:vcs5
[  229.737783] PM: Removing info for No Bus:vcsa5
[  229.740613] PM: Adding info for No Bus:vcs6
[  229.743572] PM: Adding info for No Bus:vcsa6
[  229.748413] PM: Removing info for No Bus:vcs6
[  229.751060] PM: Removing info for No Bus:vcsa6
[  229.759522] PM: Adding info for No Bus:vcs6
[  229.762651] PM: Adding info for No Bus:vcsa6
[  230.352093] PM: Removing info for No Bus:vcs6
[  230.354757] PM: Removing info for No Bus:vcsa6
[  230.493471] PM: Adding info for No Bus:vcs2
[  230.496434] PM: Adding info for No Bus:vcsa2
[  230.499626] PM: Removing info for No Bus:vcs2
[  230.502206] PM: Removing info for No Bus:vcsa2
[  230.504891] PM: Adding info for No Bus:vcs3
[  230.507858] PM: Adding info for No Bus:vcsa3
[  230.510906] PM: Removing info for No Bus:vcs3
[  230.513511] PM: Removing info for No Bus:vcsa3
[  230.516195] PM: Adding info for No Bus:vcs4
[  230.519135] PM: Adding info for No Bus:vcsa4
[  230.522205] PM: Removing info for No Bus:vcs4
[  230.524774] PM: Removing info for No Bus:vcsa4
[  230.527479] PM: Adding info for No Bus:vcs5
[  230.530467] PM: Adding info for No Bus:vcsa5
[  230.533528] PM: Removing info for No Bus:vcs5
[  230.536084] PM: Removing info for No Bus:vcsa5
[  230.538825] PM: Adding info for No Bus:vcs6
[  230.541757] PM: Adding info for No Bus:vcsa6
[  230.544844] PM: Removing info for No Bus:vcs6
[  230.547452] PM: Removing info for No Bus:vcsa6
[  230.594087] PM: Adding info for No Bus:vcs2
[  230.597095] PM: Adding info for No Bus:vcsa2
[  230.601565] PM: Removing info for No Bus:vcs2
[  230.604168] PM: Removing info for No Bus:vcsa2
[  230.610636] PM: Adding info for No Bus:vcs3
[  230.613666] PM: Adding info for No Bus:vcsa3
[  230.618117] PM: Removing info for No Bus:vcs3
[  230.620724] PM: Removing info for No Bus:vcsa3
[  230.627269] PM: Adding info for No Bus:vcs4
[  230.630310] PM: Adding info for No Bus:vcsa4
[  230.634739] PM: Removing info for No Bus:vcs4
[  230.637399] PM: Removing info for No Bus:vcsa4
[  230.643862] PM: Adding info for No Bus:vcs5
[  230.646881] PM: Adding info for No Bus:vcsa5
[  230.651343] PM: Removing info for No Bus:vcs5
[  230.653992] PM: Removing info for No Bus:vcsa5
[  230.660475] PM: Adding info for No Bus:vcs6
[  230.663518] PM: Adding info for No Bus:vcsa6
[  230.667963] PM: Removing info for No Bus:vcs6
[  230.670619] PM: Removing info for No Bus:vcsa6
[  230.677292] PM: Adding info for No Bus:vcs6
[  230.680256] PM: Adding info for No Bus:vcsa6
[  230.688494] PM: Removing info for No Bus:vcs6
[  230.691150] PM: Removing info for No Bus:vcsa6
[  230.695194] PM: Adding info for No Bus:vcs6
[  230.695721] PM: Adding info for No Bus:vcsa6
[  230.695925] PM: Removing info for No Bus:vcs6
[  230.695956] PM: Removing info for No Bus:vcsa6
[  230.699839] PM: Adding info for No Bus:vcs6
[  230.699881] PM: Adding info for No Bus:vcsa6
[  230.731208] PM: Removing info for No Bus:vcs6
[  230.733846] PM: Removing info for No Bus:vcsa6
[  230.740270] PM: Adding info for No Bus:vcs6
[  230.743274] PM: Adding info for No Bus:vcsa6
[  230.748173] PM: Removing info for No Bus:vcs6
[  230.750831] PM: Removing info for No Bus:vcsa6
[  230.757351] PM: Adding info for No Bus:vcs6
[  230.760340] PM: Adding info for No Bus:vcsa6
[  230.765080] PM: Removing info for No Bus:vcs6
[  230.767677] PM: Removing info for No Bus:vcsa6
[  230.774274] PM: Adding info for No Bus:vcs6
[  230.777281] PM: Adding info for No Bus:vcsa6
[  230.781869] PM: Removing info for No Bus:vcs6
[  230.784467] PM: Removing info for No Bus:vcsa6
[  231.074427] PM: Adding info for No Bus:vcs6
[  231.075248] PM: Adding info for No Bus:vcsa6
[  231.091025] PM: Adding info for No Bus:vcs4
[  231.091812] PM: Adding info for No Bus:vcsa4
[  231.094189] PM: Adding info for No Bus:vcs5
[  231.095030] PM: Adding info for No Bus:vcsa5
[  231.123168] PM: Adding info for No Bus:vcs2
[  231.126207] PM: Adding info for No Bus:vcsa2
[  231.130894] PM: Adding info for No Bus:vcs3
[  231.133917] PM: Adding info for No Bus:vcsa3
[  236.594800] Capability LSM initialized
[  237.034619] PM: Adding info for No Bus:parport0
[  237.039139] ppdev: user-space parallel port driver
[  239.729681] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[  239.730291] PM: Adding info for No Bus:apm_bios
[  243.107859] PM: Adding info for No Bus:vcs7
[  243.111994] PM: Adding info for No Bus:vcsa7
[  243.533096] [drm] Initialized drm 1.1.0 20060810
[  243.627045] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[  244.268157] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  244.268424] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  244.268673] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  244.577952] [drm] Setting GART location based on new memory map
[  244.578022] [drm] writeback test succeeded in 1 usecs

--------------000509000907060207020208--
