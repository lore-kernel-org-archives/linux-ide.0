From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Sat, 05 May 2007 14:43:08 -0300
Message-ID: <463CC22C.20902@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com> <463B71FA.8090005@gmail.com> <463B74DB.8060509@gmail.com> <463B89B9.8050104@gmail.com> <463B8B3C.9010509@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060403020308080601010708"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:12831 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934118AbXEERnT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 13:43:19 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1039108wxd
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 10:43:18 -0700 (PDT)
In-Reply-To: <463B8B3C.9010509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de

This is a multi-part message in MIME format.
--------------060403020308080601010708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Tejun Heo escribió:
> Yeah, apparently.
>
> 00:02.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI-X Root Port
> [1002:5a34]
>
> So, there are two broken PCI bridges.  Argh....  Okay, please try the
> attached patch.  It includes both 5a34 and 5a3f.
>
> Thanks for your patience.
>
>   
No problem, is you who i'm bottering so my computer works right!

It isn't working:
...
[   89.098980] Kernel command line: 
root=UUID=5875415d-590b-47be-8e7c-30e4c073c6d2 ro
...
[    5.816000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, 
low) -> IRQ 21
[    6.820000] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 
0xf impl SATA mode
[    6.820000] ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pmp 
pio slum part
[    6.820000] ata1: SATA max UDMA/133 cmd 0xF88A0D00 ctl 0x0 bmdma 0x0 
irq 222
[    6.820000] ata2: SATA max UDMA/133 cmd 0xF88A0D80 ctl 0x0 bmdma 0x0 
irq 222
[    6.820000] ata3: SATA max UDMA/133 cmd 0xF88A0E00 ctl 0x0 bmdma 0x0 
irq 222
[    6.820000] ata4: SATA max UDMA/133 cmd 0xF88A0E80 ctl 0x0 bmdma 0x0 
irq 222
[    6.820000] scsi0 : ahci
[    6.820000] PM: Adding info for No Bus:host0
[    7.132000] ata1: SATA link down (SStatus 0 SControl 300)
[    7.132000] scsi1 : ahci
[    7.132000] PM: Adding info for No Bus:host1
[    7.616000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   37.616000] ata2.00: qc timeout (cmd 0xec)
[   37.616000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   38.440000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   68.440000] ata2.00: qc timeout (cmd 0xec)
[   68.440000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   69.264000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   99.264000] ata2.00: qc timeout (cmd 0xec)
[   99.264000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[  100.088000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  100.088000] scsi2 : ahci
[  100.088000] PM: Adding info for No Bus:host2
[  100.400000] ata3: SATA link down (SStatus 0 SControl 300)
[  100.400000] scsi3 : ahci
[  100.400000] PM: Adding info for No Bus:host3
[  100.712000] ata4: SATA link down (SStatus 0 SControl 300)
[  100.712000] SB600_PATA: IDE controller at PCI slot 0000:00:14.1

The same errors than before, but I think MSI is being disabled now, or 
well, trying at least:

[    3.700000] PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for 
0000:00:02.0 subordinate bus.

May be it disables MSI for some other device/bridge/what ever:

[    5.812000] r8169 Gigabit Ethernet driver 2.2LK loaded
[    5.812000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 21 (level, 
low) -> IRQ 20
[    5.812000] eth0: RTL8169sc/8110sc at 0xf8840800, 00:16:17:c3:b8:f9, 
IRQ 20
[    5.816000] ahci 0000:00:12.0: version 2.0
[    5.816000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, 
low) -> IRQ 21

I attach the boot log so you can check this, because I don't know 
anything about this.

Matías

--------------060403020308080601010708
Content-Type: text/plain;
 name="dmesg.2.6.20-generic-with-pci-quirks-patch2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg.2.6.20-generic-with-pci-quirks-patch2"

[    0.000000] Linux version 2.6.20-generic-with-pci-quirks-patch2 (root@matias) (gcc versiÃ³n 4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #1 SMP Fri May 4 20:20:25 ART 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 0000000000098000 end: 0000000000098000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 0000000000098000 size: 0000000000008000 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000e4000 size: 000000000001c000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000003fec0000 end: 000000003ffc0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000003ffc0000 size: 000000000000e000 end: 000000003ffce000 type: 3
[    0.000000] copy_e820_map() start: 000000003ffce000 size: 0000000000032000 end: 0000000040000000 type: 4
[    0.000000] copy_e820_map() start: 00000000ff780000 size: 0000000000880000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000098000 (usable)
[    0.000000]  BIOS-e820: 0000000000098000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
[    0.000000]  BIOS-e820: 000000003ffc0000 - 000000003ffce000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ffce000 - 0000000040000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000ff780
[    0.000000] Entering add_active_range(0, 0, 262080) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   262080
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   262080
[    0.000000] On node 0 totalpages: 262080
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 255 pages used for memmap
[    0.000000]   HighMem zone: 32449 pages, LIFO batch:7
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f84e0
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x07000604 MSFT 0x00000097) @ 0x3ffc0000
[    0.000000] ACPI: FADT (v002 A M I  OEMFACP  0x07000604 MSFT 0x00000097) @ 0x3ffc0200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x07000604 MSFT 0x00000097) @ 0x3ffc0390
[    0.000000] ACPI: MCFG (v001 A M I  OEMMCFG  0x07000604 MSFT 0x00000097) @ 0x3ffc03f0
[    0.000000] ACPI: WDRT (v001 A M I  OEMWDRT  0x07000604 MSFT 0x00000097) @ 0x3ffc0430
[    0.000000] ACPI: OEMB (v001 A M I  AMI_OEM  0x07000604 MSFT 0x00000097) @ 0x3ffce040
[    0.000000] ACPI: HPET (v001 A M I  OEMHPET  0x07000604 MSFT 0x00000097) @ 0x3ffc4250
[    0.000000] ACPI: SSDT (v001 A M I  ACPI2PPC 0x00000001 AMI  0x00000001) @ 0x3ffc4290
[    0.000000] ACPI: DSDT (v001  AMMR_ AMMR_B36 0x00000b36 INTL 0x20051117) @ 0x00000000
[    0.000000] ATI board detected. Disabling timer routing over 8254.
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:11 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:11 APIC version 16
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x8000 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bf780000)
[    0.000000] Detected 2000.281 MHz processor.
[   89.098977] Built 1 zonelists.  Total pages: 260033
[   89.098980] Kernel command line: root=UUID=5875415d-590b-47be-8e7c-30e4c073c6d2 ro 
[   89.099097] mapped APIC to ffffd000 (fee00000)
[   89.099100] mapped IOAPIC to ffffc000 (fec00000)
[   89.099103] Enabling fast FPU save and restore... done.
[   89.099106] Enabling unmasked SIMD FPU exception support... done.
[   89.099113] Initializing CPU#0
[   89.099165] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   89.101466] Console: colour VGA+ 80x25
[   89.104647] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   89.105457] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   89.125685] Memory: 992952k/1048320k available (1975k kernel code, 54648k reserved, 882k data, 324k init, 130816k highmem)
[   89.125767] virtual kernel memory layout:
[   89.125768]     fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
[   89.125769]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   89.125771]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   89.125772]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   89.125773]       .init : 0xc03d1000 - 0xc0422000   ( 324 kB)
[   89.125774]       .data : 0xc02edc94 - 0xc03ca6d4   ( 882 kB)
[   89.125775]       .text : 0xc0100000 - 0xc02edc94   (1975 kB)
[   89.126219] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   89.126467] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[   89.126724] hpet0: 4 32-bit timers, 14318180 Hz
[   89.127784] Using HPET for base-timer
[   89.206315] Calibrating delay using timer specific routine.. 4003.34 BogoMIPS (lpj=8006689)
[   89.206463] Security Framework v1.0.0 initialized
[   89.206523] SELinux:  Disabled at boot.
[   89.206590] Mount-cache hash table entries: 512
[   89.206771] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[   89.206780] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   89.206839] CPU: L2 Cache: 256K (64 bytes/line)
[   89.206896] CPU 0(2) -> Core 0
[   89.206950] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[   89.206967] Checking 'hlt' instruction... OK.
[   89.222462] SMP alternatives: switching to UP code
[   89.222792] ACPI: Core revision 20060707
[   89.225480] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ stepping 02
[   89.225641] SMP alternatives: switching to SMP code
[   89.225812] Booting processor 1/1 eip 3000
[   89.234626] Initializing CPU#1
[   89.312719] Calibrating delay using timer specific routine.. 4000.21 BogoMIPS (lpj=8000431)
[   89.312726] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[   89.312732] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   89.312734] CPU: L2 Cache: 256K (64 bytes/line)
[   89.312737] CPU 1(2) -> Core 1
[   89.312738] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[   89.314295] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ stepping 02
[   89.314730] Total of 2 processors activated (8003.56 BogoMIPS).
[   89.314926] ENABLING IO-APIC IRQs
[   89.315154] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   89.461822] checking TSC synchronization across 2 CPUs: 
[    0.000050] CPU#0 had 695 usecs TSC skew, fixed it up.
[    0.000107] CPU#1 had -695 usecs TSC skew, fixed it up.
[    0.003946] Brought up 2 CPUs
[    0.044773] migration_cost=139
[    0.045003] PM: Adding info for No Bus:platform
[    0.045147] Booting paravirtualized kernel on bare hardware
[    0.045283] Time: 14:14:12  Date: 04/05/107
[    0.045366] NET: Registered protocol family 16
[    0.045445] PM: Adding info for No Bus:vtcon0
[    0.045499] EISA bus registered
[    0.045554] ACPI: bus type pci registered
[    0.045617] PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
[    0.045675] PCI: Not using MMCONFIG.
[    0.046497] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=2
[    0.046555] PCI: Using configuration type 1
[    0.046611] Setting up standard PCI resources
[    0.063445] ACPI: Interpreter enabled
[    0.063504] ACPI: Using IOAPIC for interrupt routing
[    0.063771] PM: Adding info for acpi:acpi
[    0.063893] Error attaching device data
[    0.063952] Error attaching device data
[    0.064131] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.064189] PCI: Probing PCI hardware (bus 00)
[    0.064364] PM: Adding info for No Bus:pci0000:00
[    0.066668] Boot video device is 0000:01:00.0
[    0.066867] PCI: Transparent bridge - 0000:00:14.4
[    0.066951] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.068169] PM: Adding info for pci:0000:00:00.0
[    0.069282] PM: Adding info for pci:0000:00:02.0
[    0.070387] PM: Adding info for pci:0000:00:12.0
[    0.071490] PM: Adding info for pci:0000:00:13.0
[    0.072596] PM: Adding info for pci:0000:00:13.1
[    0.073701] PM: Adding info for pci:0000:00:13.2
[    0.074803] PM: Adding info for pci:0000:00:13.3
[    0.075939] PM: Adding info for pci:0000:00:13.4
[    0.077042] PM: Adding info for pci:0000:00:13.5
[    0.078144] PM: Adding info for pci:0000:00:14.0
[    0.079247] PM: Adding info for pci:0000:00:14.1
[    0.080361] PM: Adding info for pci:0000:00:14.2
[    0.081464] PM: Adding info for pci:0000:00:14.3
[    0.082569] PM: Adding info for pci:0000:00:14.4
[    0.083672] PM: Adding info for pci:0000:00:18.0
[    0.084778] PM: Adding info for pci:0000:00:18.1
[    0.085882] PM: Adding info for pci:0000:00:18.2
[    0.086985] PM: Adding info for pci:0000:00:18.3
[    0.087016] PM: Adding info for pci:0000:01:00.0
[    0.087051] PM: Adding info for pci:0000:02:06.0
[    0.090459] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.093511] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE2._PRT]
[    0.094851] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.095642] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.096459] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.097240] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.098023] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.098805] ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0, disabled.
[    0.099261] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.100053] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
[    0.100758] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.100823] pnp: PnP ACPI init
[    0.100884] PM: Adding info for No Bus:pnp0
[    0.101014] PM: Adding info for pnp:00:00
[    0.101199] PM: Adding info for pnp:00:01
[    0.101252] PM: Adding info for pnp:00:02
[    0.101294] PM: Adding info for pnp:00:03
[    0.101324] PM: Adding info for pnp:00:04
[    0.101358] PM: Adding info for pnp:00:05
[    0.101914] PM: Adding info for pnp:00:06
[    0.102496] PM: Adding info for pnp:00:07
[    0.103372] PM: Adding info for pnp:00:08
[    0.103615] PM: Adding info for pnp:00:09
[    0.103695] PM: Adding info for pnp:00:0a
[    0.103778] PM: Adding info for pnp:00:0b
[    0.103926] PM: Adding info for pnp:00:0c
[    0.104031] PM: Adding info for pnp:00:0d
[    0.104244] PM: Adding info for pnp:00:0e
[    0.104334] PM: Adding info for pnp:00:0f
[    0.104767] PM: Adding info for pnp:00:10
[    0.105060] pnp: PnP ACPI: found 17 devices
[    0.105118] PnPBIOS: Disabled by ACPI PNP
[    0.105228] PCI: Using ACPI for IRQ routing
[    0.105286] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.115194] pnp: 00:0e: ioport range 0xa00-0xa0f has been reserved
[    0.115253] pnp: 00:0e: ioport range 0x600-0x60f has been reserved
[    0.115324] PM: Adding info for No Bus:mem
[    0.115348] PM: Adding info for No Bus:kmem
[    0.115377] PM: Adding info for No Bus:null
[    0.115399] PM: Adding info for No Bus:port
[    0.115423] PM: Adding info for No Bus:zero
[    0.115444] PM: Adding info for No Bus:full
[    0.115466] PM: Adding info for No Bus:random
[    0.115489] PM: Adding info for No Bus:urandom
[    0.115519] PM: Adding info for No Bus:kmsg
[    0.115540] PM: Adding info for No Bus:oldmem
[    0.115578] PCI: Bridge: 0000:00:02.0
[    0.115633]   IO window: disabled.
[    0.115690]   MEM window: fa900000-fe9fffff
[    0.115751]   PREFETCH window: bff00000-dfefffff
[    0.115809] PCI: Bridge: 0000:00:14.4
[    0.115865]   IO window: b000-bfff
[    0.115923]   MEM window: fea00000-feafffff
[    0.115981]   PREFETCH window: 50000000-500fffff
[    0.116050] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.116089] NET: Registered protocol family 2
[    0.163702] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.163910] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.165021] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.165590] TCP: Hash tables configured (established 131072 bind 65536)
[    0.165651] TCP reno registered
[    0.179739] checking if image is initramfs... it is
[    3.457533] Freeing initrd memory: 41967k freed
[    3.457653] PM: Adding info for platform:pcspkr
[    3.700000] PM: Adding info for No Bus:snapshot
[    3.700000] audit: initializing netlink socket (disabled)
[    3.700000] audit(1178374455.884:1): initialized
[    3.700000] highmem bounce pool size: 64 pages
[    3.700000] VFS: Disk quotas dquot_6.5.1
[    3.700000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    3.700000] io scheduler noop registered
[    3.700000] io scheduler anticipatory registered
[    3.700000] io scheduler deadline registered
[    3.700000] io scheduler cfq registered (default)
[    3.700000] PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for 0000:00:02.0 subordinate bus.
[    3.800000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    3.800000] assign_interrupt_mode Found MSI capability
[    3.800000] Allocate Port Service[0000:00:02.0:pcie00]
[    3.800000] PM: Adding info for pci_express:0000:00:02.0:pcie00
[    3.800000] PM: Adding info for No Bus:pnp1
[    3.800000] isapnp: Scanning for PnP cards...
[    4.152000] isapnp: No Plug & Play device found
[    4.152000] PM: Adding info for No Bus:tty
[    4.152000] PM: Adding info for No Bus:console
[    4.152000] PM: Adding info for No Bus:ptmx
[    4.152000] PM: Adding info for No Bus:tty0
[    4.152000] PM: Adding info for No Bus:vcs
[    4.152000] PM: Adding info for No Bus:vcsa
[    4.152000] PM: Adding info for No Bus:tty1
[    4.152000] PM: Adding info for No Bus:tty2
[    4.152000] PM: Adding info for No Bus:tty3
[    4.152000] PM: Adding info for No Bus:tty4
[    4.152000] PM: Adding info for No Bus:tty5
[    4.152000] PM: Adding info for No Bus:tty6
[    4.152000] PM: Adding info for No Bus:tty7
[    4.152000] PM: Adding info for No Bus:tty8
[    4.152000] PM: Adding info for No Bus:tty9
[    4.152000] PM: Adding info for No Bus:tty10
[    4.152000] PM: Adding info for No Bus:tty11
[    4.152000] PM: Adding info for No Bus:tty12
[    4.152000] PM: Adding info for No Bus:tty13
[    4.152000] PM: Adding info for No Bus:tty14
[    4.152000] PM: Adding info for No Bus:tty15
[    4.152000] PM: Adding info for No Bus:tty16
[    4.152000] PM: Adding info for No Bus:tty17
[    4.152000] PM: Adding info for No Bus:tty18
[    4.152000] PM: Adding info for No Bus:tty19
[    4.152000] PM: Adding info for No Bus:tty20
[    4.152000] PM: Adding info for No Bus:tty21
[    4.152000] PM: Adding info for No Bus:tty22
[    4.152000] PM: Adding info for No Bus:tty23
[    4.152000] PM: Adding info for No Bus:tty24
[    4.152000] PM: Adding info for No Bus:tty25
[    4.152000] PM: Adding info for No Bus:tty26
[    4.152000] PM: Adding info for No Bus:tty27
[    4.152000] PM: Adding info for No Bus:tty28
[    4.152000] PM: Adding info for No Bus:tty29
[    4.152000] PM: Adding info for No Bus:tty30
[    4.152000] PM: Adding info for No Bus:tty31
[    4.152000] PM: Adding info for No Bus:tty32
[    4.152000] PM: Adding info for No Bus:tty33
[    4.152000] PM: Adding info for No Bus:tty34
[    4.152000] PM: Adding info for No Bus:tty35
[    4.152000] PM: Adding info for No Bus:tty36
[    4.152000] PM: Adding info for No Bus:tty37
[    4.152000] PM: Adding info for No Bus:tty38
[    4.152000] PM: Adding info for No Bus:tty39
[    4.152000] PM: Adding info for No Bus:tty40
[    4.152000] PM: Adding info for No Bus:tty41
[    4.152000] PM: Adding info for No Bus:tty42
[    4.152000] PM: Adding info for No Bus:tty43
[    4.152000] PM: Adding info for No Bus:tty44
[    4.152000] PM: Adding info for No Bus:tty45
[    4.152000] PM: Adding info for No Bus:tty46
[    4.152000] PM: Adding info for No Bus:tty47
[    4.152000] PM: Adding info for No Bus:tty48
[    4.152000] PM: Adding info for No Bus:tty49
[    4.152000] PM: Adding info for No Bus:tty50
[    4.152000] PM: Adding info for No Bus:tty51
[    4.152000] PM: Adding info for No Bus:tty52
[    4.152000] PM: Adding info for No Bus:tty53
[    4.152000] PM: Adding info for No Bus:tty54
[    4.152000] PM: Adding info for No Bus:tty55
[    4.152000] PM: Adding info for No Bus:tty56
[    4.152000] PM: Adding info for No Bus:tty57
[    4.152000] PM: Adding info for No Bus:tty58
[    4.152000] PM: Adding info for No Bus:tty59
[    4.152000] PM: Adding info for No Bus:tty60
[    4.152000] PM: Adding info for No Bus:tty61
[    4.152000] PM: Adding info for No Bus:tty62
[    4.152000] PM: Adding info for No Bus:tty63
[    4.156000] PM: Adding info for No Bus:ptyp0
[    4.156000] PM: Adding info for No Bus:ptyp1
[    4.156000] PM: Adding info for No Bus:ptyp2
[    4.156000] PM: Adding info for No Bus:ptyp3
[    4.156000] PM: Adding info for No Bus:ptyp4
[    4.156000] PM: Adding info for No Bus:ptyp5
[    4.156000] PM: Adding info for No Bus:ptyp6
[    4.156000] PM: Adding info for No Bus:ptyp7
[    4.156000] PM: Adding info for No Bus:ptyp8
[    4.156000] PM: Adding info for No Bus:ptyp9
[    4.156000] PM: Adding info for No Bus:ptypa
[    4.156000] PM: Adding info for No Bus:ptypb
[    4.156000] PM: Adding info for No Bus:ptypc
[    4.156000] PM: Adding info for No Bus:ptypd
[    4.156000] PM: Adding info for No Bus:ptype
[    4.156000] PM: Adding info for No Bus:ptypf
[    4.156000] PM: Adding info for No Bus:ptyq0
[    4.156000] PM: Adding info for No Bus:ptyq1
[    4.156000] PM: Adding info for No Bus:ptyq2
[    4.156000] PM: Adding info for No Bus:ptyq3
[    4.156000] PM: Adding info for No Bus:ptyq4
[    4.156000] PM: Adding info for No Bus:ptyq5
[    4.156000] PM: Adding info for No Bus:ptyq6
[    4.156000] PM: Adding info for No Bus:ptyq7
[    4.156000] PM: Adding info for No Bus:ptyq8
[    4.156000] PM: Adding info for No Bus:ptyq9
[    4.156000] PM: Adding info for No Bus:ptyqa
[    4.156000] PM: Adding info for No Bus:ptyqb
[    4.156000] PM: Adding info for No Bus:ptyqc
[    4.156000] PM: Adding info for No Bus:ptyqd
[    4.156000] PM: Adding info for No Bus:ptyqe
[    4.156000] PM: Adding info for No Bus:ptyqf
[    4.156000] PM: Adding info for No Bus:ptyr0
[    4.156000] PM: Adding info for No Bus:ptyr1
[    4.156000] PM: Adding info for No Bus:ptyr2
[    4.156000] PM: Adding info for No Bus:ptyr3
[    4.156000] PM: Adding info for No Bus:ptyr4
[    4.156000] PM: Adding info for No Bus:ptyr5
[    4.156000] PM: Adding info for No Bus:ptyr6
[    4.156000] PM: Adding info for No Bus:ptyr7
[    4.156000] PM: Adding info for No Bus:ptyr8
[    4.156000] PM: Adding info for No Bus:ptyr9
[    4.156000] PM: Adding info for No Bus:ptyra
[    4.156000] PM: Adding info for No Bus:ptyrb
[    4.156000] PM: Adding info for No Bus:ptyrc
[    4.156000] PM: Adding info for No Bus:ptyrd
[    4.156000] PM: Adding info for No Bus:ptyre
[    4.156000] PM: Adding info for No Bus:ptyrf
[    4.156000] PM: Adding info for No Bus:ptys0
[    4.156000] PM: Adding info for No Bus:ptys1
[    4.156000] PM: Adding info for No Bus:ptys2
[    4.156000] PM: Adding info for No Bus:ptys3
[    4.156000] PM: Adding info for No Bus:ptys4
[    4.156000] PM: Adding info for No Bus:ptys5
[    4.156000] PM: Adding info for No Bus:ptys6
[    4.156000] PM: Adding info for No Bus:ptys7
[    4.156000] PM: Adding info for No Bus:ptys8
[    4.156000] PM: Adding info for No Bus:ptys9
[    4.156000] PM: Adding info for No Bus:ptysa
[    4.156000] PM: Adding info for No Bus:ptysb
[    4.156000] PM: Adding info for No Bus:ptysc
[    4.156000] PM: Adding info for No Bus:ptysd
[    4.156000] PM: Adding info for No Bus:ptyse
[    4.156000] PM: Adding info for No Bus:ptysf
[    4.156000] PM: Adding info for No Bus:ptyt0
[    4.156000] PM: Adding info for No Bus:ptyt1
[    4.156000] PM: Adding info for No Bus:ptyt2
[    4.156000] PM: Adding info for No Bus:ptyt3
[    4.156000] PM: Adding info for No Bus:ptyt4
[    4.156000] PM: Adding info for No Bus:ptyt5
[    4.156000] PM: Adding info for No Bus:ptyt6
[    4.156000] PM: Adding info for No Bus:ptyt7
[    4.156000] PM: Adding info for No Bus:ptyt8
[    4.156000] PM: Adding info for No Bus:ptyt9
[    4.156000] PM: Adding info for No Bus:ptyta
[    4.156000] PM: Adding info for No Bus:ptytb
[    4.156000] PM: Adding info for No Bus:ptytc
[    4.156000] PM: Adding info for No Bus:ptytd
[    4.156000] PM: Adding info for No Bus:ptyte
[    4.156000] PM: Adding info for No Bus:ptytf
[    4.156000] PM: Adding info for No Bus:ptyu0
[    4.156000] PM: Adding info for No Bus:ptyu1
[    4.156000] PM: Adding info for No Bus:ptyu2
[    4.156000] PM: Adding info for No Bus:ptyu3
[    4.156000] PM: Adding info for No Bus:ptyu4
[    4.156000] PM: Adding info for No Bus:ptyu5
[    4.156000] PM: Adding info for No Bus:ptyu6
[    4.156000] PM: Adding info for No Bus:ptyu7
[    4.156000] PM: Adding info for No Bus:ptyu8
[    4.156000] PM: Adding info for No Bus:ptyu9
[    4.156000] PM: Adding info for No Bus:ptyua
[    4.156000] PM: Adding info for No Bus:ptyub
[    4.156000] PM: Adding info for No Bus:ptyuc
[    4.156000] PM: Adding info for No Bus:ptyud
[    4.156000] PM: Adding info for No Bus:ptyue
[    4.156000] PM: Adding info for No Bus:ptyuf
[    4.156000] PM: Adding info for No Bus:ptyv0
[    4.156000] PM: Adding info for No Bus:ptyv1
[    4.156000] PM: Adding info for No Bus:ptyv2
[    4.156000] PM: Adding info for No Bus:ptyv3
[    4.156000] PM: Adding info for No Bus:ptyv4
[    4.156000] PM: Adding info for No Bus:ptyv5
[    4.156000] PM: Adding info for No Bus:ptyv6
[    4.156000] PM: Adding info for No Bus:ptyv7
[    4.156000] PM: Adding info for No Bus:ptyv8
[    4.156000] PM: Adding info for No Bus:ptyv9
[    4.156000] PM: Adding info for No Bus:ptyva
[    4.156000] PM: Adding info for No Bus:ptyvb
[    4.156000] PM: Adding info for No Bus:ptyvc
[    4.156000] PM: Adding info for No Bus:ptyvd
[    4.156000] PM: Adding info for No Bus:ptyve
[    4.156000] PM: Adding info for No Bus:ptyvf
[    4.156000] PM: Adding info for No Bus:ptyw0
[    4.156000] PM: Adding info for No Bus:ptyw1
[    4.156000] PM: Adding info for No Bus:ptyw2
[    4.156000] PM: Adding info for No Bus:ptyw3
[    4.156000] PM: Adding info for No Bus:ptyw4
[    4.156000] PM: Adding info for No Bus:ptyw5
[    4.156000] PM: Adding info for No Bus:ptyw6
[    4.156000] PM: Adding info for No Bus:ptyw7
[    4.156000] PM: Adding info for No Bus:ptyw8
[    4.156000] PM: Adding info for No Bus:ptyw9
[    4.156000] PM: Adding info for No Bus:ptywa
[    4.156000] PM: Adding info for No Bus:ptywb
[    4.156000] PM: Adding info for No Bus:ptywc
[    4.156000] PM: Adding info for No Bus:ptywd
[    4.156000] PM: Adding info for No Bus:ptywe
[    4.156000] PM: Adding info for No Bus:ptywf
[    4.156000] PM: Adding info for No Bus:ptyx0
[    4.156000] PM: Adding info for No Bus:ptyx1
[    4.156000] PM: Adding info for No Bus:ptyx2
[    4.156000] PM: Adding info for No Bus:ptyx3
[    4.156000] PM: Adding info for No Bus:ptyx4
[    4.156000] PM: Adding info for No Bus:ptyx5
[    4.156000] PM: Adding info for No Bus:ptyx6
[    4.156000] PM: Adding info for No Bus:ptyx7
[    4.156000] PM: Adding info for No Bus:ptyx8
[    4.156000] PM: Adding info for No Bus:ptyx9
[    4.156000] PM: Adding info for No Bus:ptyxa
[    4.156000] PM: Adding info for No Bus:ptyxb
[    4.156000] PM: Adding info for No Bus:ptyxc
[    4.156000] PM: Adding info for No Bus:ptyxd
[    4.156000] PM: Adding info for No Bus:ptyxe
[    4.156000] PM: Adding info for No Bus:ptyxf
[    4.156000] PM: Adding info for No Bus:ptyy0
[    4.156000] PM: Adding info for No Bus:ptyy1
[    4.156000] PM: Adding info for No Bus:ptyy2
[    4.156000] PM: Adding info for No Bus:ptyy3
[    4.160000] PM: Adding info for No Bus:ptyy4
[    4.160000] PM: Adding info for No Bus:ptyy5
[    4.160000] PM: Adding info for No Bus:ptyy6
[    4.160000] PM: Adding info for No Bus:ptyy7
[    4.160000] PM: Adding info for No Bus:ptyy8
[    4.160000] PM: Adding info for No Bus:ptyy9
[    4.160000] PM: Adding info for No Bus:ptyya
[    4.160000] PM: Adding info for No Bus:ptyyb
[    4.160000] PM: Adding info for No Bus:ptyyc
[    4.160000] PM: Adding info for No Bus:ptyyd
[    4.160000] PM: Adding info for No Bus:ptyye
[    4.160000] PM: Adding info for No Bus:ptyyf
[    4.160000] PM: Adding info for No Bus:ptyz0
[    4.160000] PM: Adding info for No Bus:ptyz1
[    4.160000] PM: Adding info for No Bus:ptyz2
[    4.160000] PM: Adding info for No Bus:ptyz3
[    4.160000] PM: Adding info for No Bus:ptyz4
[    4.160000] PM: Adding info for No Bus:ptyz5
[    4.160000] PM: Adding info for No Bus:ptyz6
[    4.160000] PM: Adding info for No Bus:ptyz7
[    4.160000] PM: Adding info for No Bus:ptyz8
[    4.160000] PM: Adding info for No Bus:ptyz9
[    4.160000] PM: Adding info for No Bus:ptyza
[    4.160000] PM: Adding info for No Bus:ptyzb
[    4.160000] PM: Adding info for No Bus:ptyzc
[    4.160000] PM: Adding info for No Bus:ptyzd
[    4.160000] PM: Adding info for No Bus:ptyze
[    4.160000] PM: Adding info for No Bus:ptyzf
[    4.160000] PM: Adding info for No Bus:ptya0
[    4.160000] PM: Adding info for No Bus:ptya1
[    4.160000] PM: Adding info for No Bus:ptya2
[    4.160000] PM: Adding info for No Bus:ptya3
[    4.160000] PM: Adding info for No Bus:ptya4
[    4.160000] PM: Adding info for No Bus:ptya5
[    4.160000] PM: Adding info for No Bus:ptya6
[    4.160000] PM: Adding info for No Bus:ptya7
[    4.160000] PM: Adding info for No Bus:ptya8
[    4.160000] PM: Adding info for No Bus:ptya9
[    4.160000] PM: Adding info for No Bus:ptyaa
[    4.160000] PM: Adding info for No Bus:ptyab
[    4.160000] PM: Adding info for No Bus:ptyac
[    4.160000] PM: Adding info for No Bus:ptyad
[    4.160000] PM: Adding info for No Bus:ptyae
[    4.160000] PM: Adding info for No Bus:ptyaf
[    4.160000] PM: Adding info for No Bus:ptyb0
[    4.160000] PM: Adding info for No Bus:ptyb1
[    4.160000] PM: Adding info for No Bus:ptyb2
[    4.160000] PM: Adding info for No Bus:ptyb3
[    4.160000] PM: Adding info for No Bus:ptyb4
[    4.160000] PM: Adding info for No Bus:ptyb5
[    4.160000] PM: Adding info for No Bus:ptyb6
[    4.160000] PM: Adding info for No Bus:ptyb7
[    4.160000] PM: Adding info for No Bus:ptyb8
[    4.160000] PM: Adding info for No Bus:ptyb9
[    4.160000] PM: Adding info for No Bus:ptyba
[    4.160000] PM: Adding info for No Bus:ptybb
[    4.160000] PM: Adding info for No Bus:ptybc
[    4.160000] PM: Adding info for No Bus:ptybd
[    4.160000] PM: Adding info for No Bus:ptybe
[    4.160000] PM: Adding info for No Bus:ptybf
[    4.160000] PM: Adding info for No Bus:ptyc0
[    4.160000] PM: Adding info for No Bus:ptyc1
[    4.160000] PM: Adding info for No Bus:ptyc2
[    4.160000] PM: Adding info for No Bus:ptyc3
[    4.160000] PM: Adding info for No Bus:ptyc4
[    4.160000] PM: Adding info for No Bus:ptyc5
[    4.160000] PM: Adding info for No Bus:ptyc6
[    4.160000] PM: Adding info for No Bus:ptyc7
[    4.160000] PM: Adding info for No Bus:ptyc8
[    4.160000] PM: Adding info for No Bus:ptyc9
[    4.160000] PM: Adding info for No Bus:ptyca
[    4.160000] PM: Adding info for No Bus:ptycb
[    4.160000] PM: Adding info for No Bus:ptycc
[    4.160000] PM: Adding info for No Bus:ptycd
[    4.160000] PM: Adding info for No Bus:ptyce
[    4.160000] PM: Adding info for No Bus:ptycf
[    4.160000] PM: Adding info for No Bus:ptyd0
[    4.160000] PM: Adding info for No Bus:ptyd1
[    4.160000] PM: Adding info for No Bus:ptyd2
[    4.160000] PM: Adding info for No Bus:ptyd3
[    4.160000] PM: Adding info for No Bus:ptyd4
[    4.160000] PM: Adding info for No Bus:ptyd5
[    4.160000] PM: Adding info for No Bus:ptyd6
[    4.160000] PM: Adding info for No Bus:ptyd7
[    4.160000] PM: Adding info for No Bus:ptyd8
[    4.160000] PM: Adding info for No Bus:ptyd9
[    4.160000] PM: Adding info for No Bus:ptyda
[    4.160000] PM: Adding info for No Bus:ptydb
[    4.160000] PM: Adding info for No Bus:ptydc
[    4.160000] PM: Adding info for No Bus:ptydd
[    4.160000] PM: Adding info for No Bus:ptyde
[    4.160000] PM: Adding info for No Bus:ptydf
[    4.160000] PM: Adding info for No Bus:ptye0
[    4.160000] PM: Adding info for No Bus:ptye1
[    4.160000] PM: Adding info for No Bus:ptye2
[    4.160000] PM: Adding info for No Bus:ptye3
[    4.160000] PM: Adding info for No Bus:ptye4
[    4.160000] PM: Adding info for No Bus:ptye5
[    4.160000] PM: Adding info for No Bus:ptye6
[    4.160000] PM: Adding info for No Bus:ptye7
[    4.160000] PM: Adding info for No Bus:ptye8
[    4.160000] PM: Adding info for No Bus:ptye9
[    4.160000] PM: Adding info for No Bus:ptyea
[    4.160000] PM: Adding info for No Bus:ptyeb
[    4.160000] PM: Adding info for No Bus:ptyec
[    4.160000] PM: Adding info for No Bus:ptyed
[    4.160000] PM: Adding info for No Bus:ptyee
[    4.160000] PM: Adding info for No Bus:ptyef
[    4.160000] PM: Adding info for No Bus:ttyp0
[    4.160000] PM: Adding info for No Bus:ttyp1
[    4.160000] PM: Adding info for No Bus:ttyp2
[    4.164000] PM: Adding info for No Bus:ttyp3
[    4.164000] PM: Adding info for No Bus:ttyp4
[    4.164000] PM: Adding info for No Bus:ttyp5
[    4.164000] PM: Adding info for No Bus:ttyp6
[    4.164000] PM: Adding info for No Bus:ttyp7
[    4.164000] PM: Adding info for No Bus:ttyp8
[    4.164000] PM: Adding info for No Bus:ttyp9
[    4.164000] PM: Adding info for No Bus:ttypa
[    4.164000] PM: Adding info for No Bus:ttypb
[    4.164000] PM: Adding info for No Bus:ttypc
[    4.164000] PM: Adding info for No Bus:ttypd
[    4.164000] PM: Adding info for No Bus:ttype
[    4.164000] PM: Adding info for No Bus:ttypf
[    4.164000] PM: Adding info for No Bus:ttyq0
[    4.164000] PM: Adding info for No Bus:ttyq1
[    4.164000] PM: Adding info for No Bus:ttyq2
[    4.164000] PM: Adding info for No Bus:ttyq3
[    4.164000] PM: Adding info for No Bus:ttyq4
[    4.164000] PM: Adding info for No Bus:ttyq5
[    4.164000] PM: Adding info for No Bus:ttyq6
[    4.164000] PM: Adding info for No Bus:ttyq7
[    4.164000] PM: Adding info for No Bus:ttyq8
[    4.164000] PM: Adding info for No Bus:ttyq9
[    4.164000] PM: Adding info for No Bus:ttyqa
[    4.164000] PM: Adding info for No Bus:ttyqb
[    4.164000] PM: Adding info for No Bus:ttyqc
[    4.164000] PM: Adding info for No Bus:ttyqd
[    4.164000] PM: Adding info for No Bus:ttyqe
[    4.164000] PM: Adding info for No Bus:ttyqf
[    4.164000] PM: Adding info for No Bus:ttyr0
[    4.164000] PM: Adding info for No Bus:ttyr1
[    4.164000] PM: Adding info for No Bus:ttyr2
[    4.164000] PM: Adding info for No Bus:ttyr3
[    4.164000] PM: Adding info for No Bus:ttyr4
[    4.164000] PM: Adding info for No Bus:ttyr5
[    4.164000] PM: Adding info for No Bus:ttyr6
[    4.164000] PM: Adding info for No Bus:ttyr7
[    4.164000] PM: Adding info for No Bus:ttyr8
[    4.164000] PM: Adding info for No Bus:ttyr9
[    4.164000] PM: Adding info for No Bus:ttyra
[    4.164000] PM: Adding info for No Bus:ttyrb
[    4.164000] PM: Adding info for No Bus:ttyrc
[    4.164000] PM: Adding info for No Bus:ttyrd
[    4.164000] PM: Adding info for No Bus:ttyre
[    4.164000] PM: Adding info for No Bus:ttyrf
[    4.164000] PM: Adding info for No Bus:ttys0
[    4.164000] PM: Adding info for No Bus:ttys1
[    4.164000] PM: Adding info for No Bus:ttys2
[    4.164000] PM: Adding info for No Bus:ttys3
[    4.164000] PM: Adding info for No Bus:ttys4
[    4.164000] PM: Adding info for No Bus:ttys5
[    4.164000] PM: Adding info for No Bus:ttys6
[    4.164000] PM: Adding info for No Bus:ttys7
[    4.164000] PM: Adding info for No Bus:ttys8
[    4.164000] PM: Adding info for No Bus:ttys9
[    4.164000] PM: Adding info for No Bus:ttysa
[    4.164000] PM: Adding info for No Bus:ttysb
[    4.164000] PM: Adding info for No Bus:ttysc
[    4.164000] PM: Adding info for No Bus:ttysd
[    4.164000] PM: Adding info for No Bus:ttyse
[    4.164000] PM: Adding info for No Bus:ttysf
[    4.164000] PM: Adding info for No Bus:ttyt0
[    4.164000] PM: Adding info for No Bus:ttyt1
[    4.164000] PM: Adding info for No Bus:ttyt2
[    4.164000] PM: Adding info for No Bus:ttyt3
[    4.164000] PM: Adding info for No Bus:ttyt4
[    4.164000] PM: Adding info for No Bus:ttyt5
[    4.164000] PM: Adding info for No Bus:ttyt6
[    4.164000] PM: Adding info for No Bus:ttyt7
[    4.164000] PM: Adding info for No Bus:ttyt8
[    4.164000] PM: Adding info for No Bus:ttyt9
[    4.164000] PM: Adding info for No Bus:ttyta
[    4.164000] PM: Adding info for No Bus:ttytb
[    4.164000] PM: Adding info for No Bus:ttytc
[    4.164000] PM: Adding info for No Bus:ttytd
[    4.164000] PM: Adding info for No Bus:ttyte
[    4.164000] PM: Adding info for No Bus:ttytf
[    4.164000] PM: Adding info for No Bus:ttyu0
[    4.164000] PM: Adding info for No Bus:ttyu1
[    4.164000] PM: Adding info for No Bus:ttyu2
[    4.164000] PM: Adding info for No Bus:ttyu3
[    4.168000] PM: Adding info for No Bus:ttyu4
[    4.168000] PM: Adding info for No Bus:ttyu5
[    4.168000] PM: Adding info for No Bus:ttyu6
[    4.168000] PM: Adding info for No Bus:ttyu7
[    4.168000] PM: Adding info for No Bus:ttyu8
[    4.168000] PM: Adding info for No Bus:ttyu9
[    4.168000] PM: Adding info for No Bus:ttyua
[    4.168000] PM: Adding info for No Bus:ttyub
[    4.168000] PM: Adding info for No Bus:ttyuc
[    4.168000] PM: Adding info for No Bus:ttyud
[    4.168000] PM: Adding info for No Bus:ttyue
[    4.168000] PM: Adding info for No Bus:ttyuf
[    4.168000] PM: Adding info for No Bus:ttyv0
[    4.168000] PM: Adding info for No Bus:ttyv1
[    4.168000] PM: Adding info for No Bus:ttyv2
[    4.168000] PM: Adding info for No Bus:ttyv3
[    4.168000] PM: Adding info for No Bus:ttyv4
[    4.168000] PM: Adding info for No Bus:ttyv5
[    4.168000] PM: Adding info for No Bus:ttyv6
[    4.168000] PM: Adding info for No Bus:ttyv7
[    4.168000] PM: Adding info for No Bus:ttyv8
[    4.168000] PM: Adding info for No Bus:ttyv9
[    4.168000] PM: Adding info for No Bus:ttyva
[    4.168000] PM: Adding info for No Bus:ttyvb
[    4.168000] PM: Adding info for No Bus:ttyvc
[    4.168000] PM: Adding info for No Bus:ttyvd
[    4.168000] PM: Adding info for No Bus:ttyve
[    4.168000] PM: Adding info for No Bus:ttyvf
[    4.168000] PM: Adding info for No Bus:ttyw0
[    4.168000] PM: Adding info for No Bus:ttyw1
[    4.168000] PM: Adding info for No Bus:ttyw2
[    4.168000] PM: Adding info for No Bus:ttyw3
[    4.168000] PM: Adding info for No Bus:ttyw4
[    4.168000] PM: Adding info for No Bus:ttyw5
[    4.168000] PM: Adding info for No Bus:ttyw6
[    4.168000] PM: Adding info for No Bus:ttyw7
[    4.168000] PM: Adding info for No Bus:ttyw8
[    4.168000] PM: Adding info for No Bus:ttyw9
[    4.168000] PM: Adding info for No Bus:ttywa
[    4.168000] PM: Adding info for No Bus:ttywb
[    4.168000] PM: Adding info for No Bus:ttywc
[    4.168000] PM: Adding info for No Bus:ttywd
[    4.168000] PM: Adding info for No Bus:ttywe
[    4.168000] PM: Adding info for No Bus:ttywf
[    4.168000] PM: Adding info for No Bus:ttyx0
[    4.168000] PM: Adding info for No Bus:ttyx1
[    4.168000] PM: Adding info for No Bus:ttyx2
[    4.168000] PM: Adding info for No Bus:ttyx3
[    4.168000] PM: Adding info for No Bus:ttyx4
[    4.168000] PM: Adding info for No Bus:ttyx5
[    4.168000] PM: Adding info for No Bus:ttyx6
[    4.168000] PM: Adding info for No Bus:ttyx7
[    4.168000] PM: Adding info for No Bus:ttyx8
[    4.168000] PM: Adding info for No Bus:ttyx9
[    4.168000] PM: Adding info for No Bus:ttyxa
[    4.168000] PM: Adding info for No Bus:ttyxb
[    4.168000] PM: Adding info for No Bus:ttyxc
[    4.168000] PM: Adding info for No Bus:ttyxd
[    4.168000] PM: Adding info for No Bus:ttyxe
[    4.168000] PM: Adding info for No Bus:ttyxf
[    4.168000] PM: Adding info for No Bus:ttyy0
[    4.172000] PM: Adding info for No Bus:ttyy1
[    4.172000] PM: Adding info for No Bus:ttyy2
[    4.172000] PM: Adding info for No Bus:ttyy3
[    4.172000] PM: Adding info for No Bus:ttyy4
[    4.172000] PM: Adding info for No Bus:ttyy5
[    4.172000] PM: Adding info for No Bus:ttyy6
[    4.172000] PM: Adding info for No Bus:ttyy7
[    4.172000] PM: Adding info for No Bus:ttyy8
[    4.172000] PM: Adding info for No Bus:ttyy9
[    4.172000] PM: Adding info for No Bus:ttyya
[    4.172000] PM: Adding info for No Bus:ttyyb
[    4.172000] PM: Adding info for No Bus:ttyyc
[    4.172000] PM: Adding info for No Bus:ttyyd
[    4.172000] PM: Adding info for No Bus:ttyye
[    4.172000] PM: Adding info for No Bus:ttyyf
[    4.172000] PM: Adding info for No Bus:ttyz0
[    4.172000] PM: Adding info for No Bus:ttyz1
[    4.172000] PM: Adding info for No Bus:ttyz2
[    4.172000] PM: Adding info for No Bus:ttyz3
[    4.172000] PM: Adding info for No Bus:ttyz4
[    4.172000] PM: Adding info for No Bus:ttyz5
[    4.172000] PM: Adding info for No Bus:ttyz6
[    4.172000] PM: Adding info for No Bus:ttyz7
[    4.172000] PM: Adding info for No Bus:ttyz8
[    4.172000] PM: Adding info for No Bus:ttyz9
[    4.172000] PM: Adding info for No Bus:ttyza
[    4.172000] PM: Adding info for No Bus:ttyzb
[    4.172000] PM: Adding info for No Bus:ttyzc
[    4.172000] PM: Adding info for No Bus:ttyzd
[    4.172000] PM: Adding info for No Bus:ttyze
[    4.172000] PM: Adding info for No Bus:ttyzf
[    4.172000] PM: Adding info for No Bus:ttya0
[    4.172000] PM: Adding info for No Bus:ttya1
[    4.172000] PM: Adding info for No Bus:ttya2
[    4.172000] PM: Adding info for No Bus:ttya3
[    4.172000] PM: Adding info for No Bus:ttya4
[    4.172000] PM: Adding info for No Bus:ttya5
[    4.172000] PM: Adding info for No Bus:ttya6
[    4.172000] PM: Adding info for No Bus:ttya7
[    4.172000] PM: Adding info for No Bus:ttya8
[    4.172000] PM: Adding info for No Bus:ttya9
[    4.172000] PM: Adding info for No Bus:ttyaa
[    4.172000] PM: Adding info for No Bus:ttyab
[    4.172000] PM: Adding info for No Bus:ttyac
[    4.172000] PM: Adding info for No Bus:ttyad
[    4.172000] PM: Adding info for No Bus:ttyae
[    4.172000] PM: Adding info for No Bus:ttyaf
[    4.172000] PM: Adding info for No Bus:ttyb0
[    4.172000] PM: Adding info for No Bus:ttyb1
[    4.176000] PM: Adding info for No Bus:ttyb2
[    4.176000] PM: Adding info for No Bus:ttyb3
[    4.176000] PM: Adding info for No Bus:ttyb4
[    4.176000] PM: Adding info for No Bus:ttyb5
[    4.176000] PM: Adding info for No Bus:ttyb6
[    4.176000] PM: Adding info for No Bus:ttyb7
[    4.176000] PM: Adding info for No Bus:ttyb8
[    4.176000] PM: Adding info for No Bus:ttyb9
[    4.176000] PM: Adding info for No Bus:ttyba
[    4.176000] PM: Adding info for No Bus:ttybb
[    4.176000] PM: Adding info for No Bus:ttybc
[    4.176000] PM: Adding info for No Bus:ttybd
[    4.176000] PM: Adding info for No Bus:ttybe
[    4.176000] PM: Adding info for No Bus:ttybf
[    4.176000] PM: Adding info for No Bus:ttyc0
[    4.176000] PM: Adding info for No Bus:ttyc1
[    4.176000] PM: Adding info for No Bus:ttyc2
[    4.176000] PM: Adding info for No Bus:ttyc3
[    4.176000] PM: Adding info for No Bus:ttyc4
[    4.176000] PM: Adding info for No Bus:ttyc5
[    4.176000] PM: Adding info for No Bus:ttyc6
[    4.176000] PM: Adding info for No Bus:ttyc7
[    4.176000] PM: Adding info for No Bus:ttyc8
[    4.176000] PM: Adding info for No Bus:ttyc9
[    4.176000] PM: Adding info for No Bus:ttyca
[    4.176000] PM: Adding info for No Bus:ttycb
[    4.176000] PM: Adding info for No Bus:ttycc
[    4.176000] PM: Adding info for No Bus:ttycd
[    4.176000] PM: Adding info for No Bus:ttyce
[    4.176000] PM: Adding info for No Bus:ttycf
[    4.176000] PM: Adding info for No Bus:ttyd0
[    4.176000] PM: Adding info for No Bus:ttyd1
[    4.176000] PM: Adding info for No Bus:ttyd2
[    4.176000] PM: Adding info for No Bus:ttyd3
[    4.176000] PM: Adding info for No Bus:ttyd4
[    4.176000] PM: Adding info for No Bus:ttyd5
[    4.176000] PM: Adding info for No Bus:ttyd6
[    4.176000] PM: Adding info for No Bus:ttyd7
[    4.176000] PM: Adding info for No Bus:ttyd8
[    4.176000] PM: Adding info for No Bus:ttyd9
[    4.176000] PM: Adding info for No Bus:ttyda
[    4.176000] PM: Adding info for No Bus:ttydb
[    4.176000] PM: Adding info for No Bus:ttydc
[    4.180000] PM: Adding info for No Bus:ttydd
[    4.180000] PM: Adding info for No Bus:ttyde
[    4.180000] PM: Adding info for No Bus:ttydf
[    4.180000] PM: Adding info for No Bus:ttye0
[    4.180000] PM: Adding info for No Bus:ttye1
[    4.180000] PM: Adding info for No Bus:ttye2
[    4.180000] PM: Adding info for No Bus:ttye3
[    4.180000] PM: Adding info for No Bus:ttye4
[    4.180000] PM: Adding info for No Bus:ttye5
[    4.180000] PM: Adding info for No Bus:ttye6
[    4.180000] PM: Adding info for No Bus:ttye7
[    4.180000] PM: Adding info for No Bus:ttye8
[    4.180000] PM: Adding info for No Bus:ttye9
[    4.180000] PM: Adding info for No Bus:ttyea
[    4.180000] PM: Adding info for No Bus:ttyeb
[    4.180000] PM: Adding info for No Bus:ttyec
[    4.180000] PM: Adding info for No Bus:ttyed
[    4.180000] PM: Adding info for No Bus:ttyee
[    4.180000] PM: Adding info for No Bus:ttyef
[    4.180000] PM: Adding info for No Bus:rtc
[    4.180000] Real Time Clock Driver v1.12ac
[    4.180000] PM: Adding info for No Bus:hpet
[    4.180000] hpet_resources: 0xfed00000 is busy
[    4.180000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    4.180000] PM: Adding info for platform:serial8250
[    4.180000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.180000] PM: Adding info for No Bus:ttyS0
[    4.180000] PM: Adding info for No Bus:ttyS1
[    4.180000] PM: Adding info for No Bus:ttyS2
[    4.180000] PM: Adding info for No Bus:ttyS3
[    4.180000] PM: Removing info for No Bus:ttyS0
[    4.180000] 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.180000] PM: Adding info for No Bus:ttyS0
[    4.180000] PM: Adding info for No Bus:isa
[    4.180000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    4.184000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    4.184000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    4.184000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    4.184000] PM: Adding info for platform:i8042
[    4.184000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.184000] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.184000] PM: Adding info for serio:serio0
[    4.188000] PM: Adding info for serio:serio1
[    4.188000] PM: Adding info for No Bus:psaux
[    4.188000] mice: PS/2 mouse device common for all mice
[    4.188000] PM: Adding info for platform:eisa.0
[    4.188000] EISA: Probing bus 0 at eisa.0
[    4.188000] EISA: Detected 0 cards.
[    4.216000] TCP cubic registered
[    4.216000] NET: Registered protocol family 1
[    4.216000] NET: Registered protocol family 8
[    4.216000] NET: Registered protocol family 20
[    4.216000] Starting balanced_irq
[    4.216000] Using IPI No-Shortcut mode
[    4.220000] input: AT Translated Set 2 keyboard as /class/input/input0
[    4.220000] ACPI: (supports S0 S1 S3 S4 S5)
[    4.220000]   Magic number: 7:21:232
[    4.220000]   hash matches device ttyv2
[    4.220000] Freeing unused kernel memory: 324k freed
[    4.220000] PM: Adding info for No Bus:vcs1
[    4.220000] PM: Adding info for No Bus:vcsa1
[    4.224000] Time: hpet clocksource has been installed.
[    4.324000] PM: Adding info for No Bus:vcs2
[    4.324000] PM: Adding info for No Bus:vcsa2
[    4.324000] PM: Removing info for No Bus:vcs2
[    4.324000] PM: Removing info for No Bus:vcsa2
[    4.324000] PM: Adding info for No Bus:vcs2
[    4.324000] PM: Adding info for No Bus:vcsa2
[    4.328000] PM: Removing info for No Bus:vcs2
[    4.328000] PM: Removing info for No Bus:vcsa2
[    4.328000] PM: Adding info for No Bus:vcs2
[    4.328000] PM: Adding info for No Bus:vcsa2
[    4.332000] PM: Removing info for No Bus:vcs2
[    4.332000] PM: Removing info for No Bus:vcsa2
[    4.332000] PM: Adding info for No Bus:vcs3
[    4.332000] PM: Adding info for No Bus:vcsa3
[    4.332000] PM: Removing info for No Bus:vcs3
[    4.332000] PM: Removing info for No Bus:vcsa3
[    4.332000] PM: Adding info for No Bus:vcs3
[    4.332000] PM: Adding info for No Bus:vcsa3
[    4.336000] PM: Removing info for No Bus:vcs3
[    4.336000] PM: Removing info for No Bus:vcsa3
[    4.336000] PM: Adding info for No Bus:vcs3
[    4.336000] PM: Adding info for No Bus:vcsa3
[    4.340000] PM: Removing info for No Bus:vcs3
[    4.340000] PM: Removing info for No Bus:vcsa3
[    4.340000] PM: Adding info for No Bus:vcs4
[    4.340000] PM: Adding info for No Bus:vcsa4
[    4.340000] PM: Removing info for No Bus:vcs4
[    4.340000] PM: Removing info for No Bus:vcsa4
[    4.340000] PM: Adding info for No Bus:vcs4
[    4.340000] PM: Adding info for No Bus:vcsa4
[    4.344000] PM: Removing info for No Bus:vcs4
[    4.344000] PM: Removing info for No Bus:vcsa4
[    4.344000] PM: Adding info for No Bus:vcs4
[    4.344000] PM: Adding info for No Bus:vcsa4
[    4.344000] PM: Removing info for No Bus:vcs4
[    4.344000] PM: Removing info for No Bus:vcsa4
[    4.348000] PM: Adding info for No Bus:vcs5
[    4.348000] PM: Adding info for No Bus:vcsa5
[    4.348000] PM: Removing info for No Bus:vcs5
[    4.348000] PM: Removing info for No Bus:vcsa5
[    4.348000] PM: Adding info for No Bus:vcs5
[    4.348000] PM: Adding info for No Bus:vcsa5
[    4.352000] PM: Removing info for No Bus:vcs5
[    4.352000] PM: Removing info for No Bus:vcsa5
[    4.352000] PM: Adding info for No Bus:vcs5
[    4.352000] PM: Adding info for No Bus:vcsa5
[    4.352000] PM: Removing info for No Bus:vcs5
[    4.352000] PM: Removing info for No Bus:vcsa5
[    4.356000] PM: Adding info for No Bus:vcs6
[    4.356000] PM: Adding info for No Bus:vcsa6
[    4.356000] PM: Removing info for No Bus:vcs6
[    4.356000] PM: Removing info for No Bus:vcsa6
[    4.356000] PM: Adding info for No Bus:vcs6
[    4.356000] PM: Adding info for No Bus:vcsa6
[    4.360000] PM: Removing info for No Bus:vcs6
[    4.360000] PM: Removing info for No Bus:vcsa6
[    4.360000] PM: Adding info for No Bus:vcs6
[    4.360000] PM: Adding info for No Bus:vcsa6
[    4.360000] PM: Removing info for No Bus:vcs6
[    4.360000] PM: Removing info for No Bus:vcsa6
[    4.448000] ACPI: duty_cycle spans bit 4
[    4.884000] usbcore: registered new interface driver usbfs
[    4.884000] usbcore: registered new interface driver hub
[    4.884000] usbcore: registered new device driver usb
[    4.888000] ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 16
[    4.888000] ehci_hcd 0000:00:13.5: EHCI Host Controller
[    4.888000] ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
[    4.888000] ehci_hcd 0000:00:13.5: debug port 1
[    4.888000] ehci_hcd 0000:00:13.5: irq 16, io mem 0xfebff800
[    4.888000] ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    4.888000] PM: Adding info for usb:usb1
[    4.888000] PM: Adding info for No Bus:usbdev1.1_ep00
[    4.888000] usb usb1: configuration #1 chosen from 1 choice
[    4.888000] PM: Adding info for usb:1-0:1.0
[    4.888000] hub 1-0:1.0: USB hub found
[    4.888000] hub 1-0:1.0: 10 ports detected
[    4.892000] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[    4.968000] SCSI subsystem initialized
[    4.976000] libata version 2.00 loaded.
[    4.992000] PM: Adding info for No Bus:usbdev1.1_ep81
[    4.992000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 17
[    4.992000] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    4.992000] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
[    4.992000] ohci_hcd 0000:00:13.0: irq 17, io mem 0xfebfe000
[    5.052000] PM: Adding info for usb:usb2
[    5.052000] Floppy drive(s): fd0 is 1.44M
[    5.052000] PM: Adding info for No Bus:usbdev2.1_ep00
[    5.052000] usb usb2: configuration #1 chosen from 1 choice
[    5.052000] PM: Adding info for usb:2-0:1.0
[    5.052000] hub 2-0:1.0: USB hub found
[    5.052000] hub 2-0:1.0: 2 ports detected
[    5.068000] FDC 0 is a post-1991 82077
[    5.072000] PM: Adding info for platform:floppy.0
[    5.156000] PM: Adding info for No Bus:usbdev2.1_ep81
[    5.156000] ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 18
[    5.156000] ohci_hcd 0000:00:13.1: OHCI Host Controller
[    5.156000] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
[    5.156000] ohci_hcd 0000:00:13.1: irq 18, io mem 0xfebfd000
[    5.216000] PM: Adding info for usb:usb3
[    5.216000] PM: Adding info for No Bus:usbdev3.1_ep00
[    5.216000] usb usb3: configuration #1 chosen from 1 choice
[    5.216000] PM: Adding info for usb:3-0:1.0
[    5.216000] hub 3-0:1.0: USB hub found
[    5.216000] hub 3-0:1.0: 2 ports detected
[    5.320000] PM: Adding info for No Bus:usbdev3.1_ep81
[    5.320000] ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 19
[    5.320000] ohci_hcd 0000:00:13.2: OHCI Host Controller
[    5.320000] ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
[    5.320000] ohci_hcd 0000:00:13.2: irq 19, io mem 0xfebfc000
[    5.380000] PM: Adding info for usb:usb4
[    5.380000] PM: Adding info for No Bus:usbdev4.1_ep00
[    5.380000] usb usb4: configuration #1 chosen from 1 choice
[    5.380000] PM: Adding info for usb:4-0:1.0
[    5.380000] hub 4-0:1.0: USB hub found
[    5.380000] hub 4-0:1.0: 2 ports detected
[    5.484000] PM: Adding info for No Bus:usbdev4.1_ep81
[    5.484000] ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 18
[    5.484000] ohci_hcd 0000:00:13.3: OHCI Host Controller
[    5.484000] ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 5
[    5.484000] ohci_hcd 0000:00:13.3: irq 18, io mem 0xfebfb000
[    5.544000] PM: Adding info for usb:usb5
[    5.544000] PM: Adding info for No Bus:usbdev5.1_ep00
[    5.544000] usb usb5: configuration #1 chosen from 1 choice
[    5.544000] PM: Adding info for usb:5-0:1.0
[    5.544000] hub 5-0:1.0: USB hub found
[    5.544000] hub 5-0:1.0: 2 ports detected
[    5.648000] PM: Adding info for No Bus:usbdev5.1_ep81
[    5.648000] ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 19
[    5.648000] ohci_hcd 0000:00:13.4: OHCI Host Controller
[    5.648000] ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 6
[    5.648000] ohci_hcd 0000:00:13.4: irq 19, io mem 0xfebfa000
[    5.708000] PM: Adding info for usb:usb6
[    5.708000] PM: Adding info for No Bus:usbdev6.1_ep00
[    5.708000] usb usb6: configuration #1 chosen from 1 choice
[    5.708000] PM: Adding info for usb:6-0:1.0
[    5.708000] hub 6-0:1.0: USB hub found
[    5.708000] hub 6-0:1.0: 2 ports detected
[    5.812000] PM: Adding info for No Bus:usbdev6.1_ep81
[    5.812000] r8169 Gigabit Ethernet driver 2.2LK loaded
[    5.812000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 21 (level, low) -> IRQ 20
[    5.812000] eth0: RTL8169sc/8110sc at 0xf8840800, 00:16:17:c3:b8:f9, IRQ 20
[    5.816000] ahci 0000:00:12.0: version 2.0
[    5.816000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 21
[    6.820000] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    6.820000] ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pmp pio slum part 
[    6.820000] ata1: SATA max UDMA/133 cmd 0xF88A0D00 ctl 0x0 bmdma 0x0 irq 222
[    6.820000] ata2: SATA max UDMA/133 cmd 0xF88A0D80 ctl 0x0 bmdma 0x0 irq 222
[    6.820000] ata3: SATA max UDMA/133 cmd 0xF88A0E00 ctl 0x0 bmdma 0x0 irq 222
[    6.820000] ata4: SATA max UDMA/133 cmd 0xF88A0E80 ctl 0x0 bmdma 0x0 irq 222
[    6.820000] scsi0 : ahci
[    6.820000] PM: Adding info for No Bus:host0
[    7.132000] ata1: SATA link down (SStatus 0 SControl 300)
[    7.132000] scsi1 : ahci
[    7.132000] PM: Adding info for No Bus:host1
[    7.616000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   37.616000] ata2.00: qc timeout (cmd 0xec)
[   37.616000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   38.440000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   68.440000] ata2.00: qc timeout (cmd 0xec)
[   68.440000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   69.264000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   99.264000] ata2.00: qc timeout (cmd 0xec)
[   99.264000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[  100.088000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  100.088000] scsi2 : ahci
[  100.088000] PM: Adding info for No Bus:host2
[  100.400000] ata3: SATA link down (SStatus 0 SControl 300)
[  100.400000] scsi3 : ahci
[  100.400000] PM: Adding info for No Bus:host3
[  100.712000] ata4: SATA link down (SStatus 0 SControl 300)
[  100.712000] SB600_PATA: IDE controller at PCI slot 0000:00:14.1
[  100.712000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 17
[  100.712000] SB600_PATA: chipset revision 0
[  100.712000] SB600_PATA: not 100% native mode: will probe irqs later
[  100.712000]     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
[  100.712000] Probing IDE interface ide0...
[  101.000000] hda: HDS728080PLAT20, ATA DISK drive
[  101.000000] PM: Adding info for No Bus:ide0
[  101.448000] hdb: ASUS DRW-1608P3S, ATAPI CD/DVD-ROM drive
[  101.504000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[  101.504000] PM: Adding info for ide:0.0
[  101.504000] PM: Adding info for ide:0.1
[  101.528000] hdb: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2000kB Cache, UDMA(66)
[  101.528000] Uniform CD-ROM driver Revision: 3.20
[  101.544000] hda: max request size: 512KiB
[  101.564000] hda: 160836480 sectors (82348 MB) w/1719KiB Cache, CHS=16383/255/63, UDMA(100)
[  101.568000] hda: cache flushes supported
[  101.568000]  hda: hda1 hda2 < hda5 hda6 >
[  101.904000] Attempting manual resume
[  101.904000] swsusp: Resume From Partition 3:6
[  101.904000] PM: Checking swsusp image.
[  101.904000] PM: Resume from disk failed.
[  101.928000] kjournald starting.  Commit interval 5 seconds
[  101.928000] EXT3-fs: mounted filesystem with ordered data mode.
[  102.460000] PM: Removing info for No Bus:vcs1
[  102.460000] PM: Removing info for No Bus:vcsa1
[  102.460000] PM: Adding info for No Bus:vcs1
[  102.460000] PM: Adding info for No Bus:vcsa1
[  110.728000] PM: Adding info for No Bus:vcs2
[  110.728000] PM: Adding info for No Bus:vcsa2
[  110.732000] PM: Removing info for No Bus:vcs2
[  110.732000] PM: Removing info for No Bus:vcsa2
[  110.732000] PM: Adding info for No Bus:vcs3
[  110.732000] PM: Adding info for No Bus:vcsa3
[  110.732000] PM: Removing info for No Bus:vcs3
[  110.732000] PM: Removing info for No Bus:vcsa3
[  110.732000] PM: Adding info for No Bus:vcs4
[  110.732000] PM: Adding info for No Bus:vcsa4
[  110.732000] PM: Removing info for No Bus:vcs4
[  110.732000] PM: Removing info for No Bus:vcsa4
[  110.732000] PM: Adding info for No Bus:vcs5
[  110.732000] PM: Adding info for No Bus:vcsa5
[  110.736000] PM: Removing info for No Bus:vcs5
[  110.736000] PM: Removing info for No Bus:vcsa5
[  110.736000] PM: Adding info for No Bus:vcs6
[  110.736000] PM: Adding info for No Bus:vcsa6
[  110.736000] PM: Removing info for No Bus:vcs6
[  110.736000] PM: Removing info for No Bus:vcsa6
[  111.504000] r8169: eth0: link up
[  113.156000] Linux agpgart interface v0.101 (c) Dave Jones
[  113.184000] input: PC Speaker as /class/input/input1
[  113.220000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  113.272000] NET: Registered protocol family 17
[  113.432000] parport: PnPBIOS parport detected.
[  113.432000] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[  113.452000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[  113.512000] PM: Adding info for No Bus:timer
[  113.616000] PM: Adding info for No Bus:seq
[  113.724000] PM: Adding info for No Bus:sequencer
[  113.724000] PM: Adding info for No Bus:sequencer2
[  114.000000] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 17
[  114.200000] hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
[  114.200000] input: ImPS/2 Generic Wheel Mouse as /class/input/input2
[  114.316000] PM: Adding info for No Bus:pcmC0D2c
[  114.316000] PM: Adding info for No Bus:pcmC0D1p
[  114.316000] PM: Adding info for No Bus:pcmC0D1c
[  114.316000] PM: Adding info for No Bus:adsp
[  114.316000] PM: Adding info for No Bus:pcmC0D0p
[  114.316000] PM: Adding info for No Bus:pcmC0D0c
[  114.316000] PM: Adding info for No Bus:dsp
[  114.316000] PM: Adding info for No Bus:audio
[  114.316000] PM: Adding info for No Bus:controlC0
[  114.316000] PM: Adding info for No Bus:mixer
[  114.448000] lp0: using parport0 (interrupt-driven).
[  114.616000] PM: Adding info for No Bus:i2c-9191
[  114.736000] PM: Adding info for i2c:9191-0600
[  114.772000] Adding 1052216k swap on /dev/disk/by-uuid/ba363ce4-0f51-4ff4-abdb-c02e7467cc43.  Priority:-1 extents:1 across:1052216k
[  114.872000] EXT3 FS on hda5, internal journal
[  115.332000] NTFS driver 2.1.28 [Flags: R/O MODULE].
[  115.432000] NTFS volume version 3.1.
[  117.184000] PM: Adding info for No Bus:vcs2
[  117.188000] PM: Adding info for No Bus:vcsa2
[  117.188000] PM: Removing info for No Bus:vcs2
[  117.188000] PM: Removing info for No Bus:vcsa2
[  117.188000] PM: Adding info for No Bus:vcs2
[  117.188000] PM: Adding info for No Bus:vcsa2
[  117.192000] PM: Removing info for No Bus:vcs2
[  117.192000] PM: Removing info for No Bus:vcsa2
[  117.192000] PM: Adding info for No Bus:vcs3
[  117.192000] PM: Adding info for No Bus:vcsa3
[  117.200000] PM: Removing info for No Bus:vcs3
[  117.200000] PM: Removing info for No Bus:vcsa3
[  117.204000] PM: Adding info for No Bus:vcs3
[  117.204000] PM: Adding info for No Bus:vcsa3
[  117.208000] PM: Removing info for No Bus:vcs3
[  117.212000] PM: Removing info for No Bus:vcsa3
[  117.212000] PM: Adding info for No Bus:vcs4
[  117.212000] PM: Adding info for No Bus:vcsa4
[  117.212000] PM: Removing info for No Bus:vcs4
[  117.212000] PM: Removing info for No Bus:vcsa4
[  117.216000] PM: Adding info for No Bus:vcs4
[  117.216000] PM: Adding info for No Bus:vcsa4
[  117.220000] PM: Removing info for No Bus:vcs4
[  117.220000] PM: Removing info for No Bus:vcsa4
[  117.220000] PM: Adding info for No Bus:vcs5
[  117.220000] PM: Adding info for No Bus:vcsa5
[  117.224000] PM: Removing info for No Bus:vcs5
[  117.224000] PM: Removing info for No Bus:vcsa5
[  117.228000] PM: Adding info for No Bus:vcs5
[  117.232000] PM: Adding info for No Bus:vcsa5
[  117.232000] PM: Removing info for No Bus:vcs5
[  117.232000] PM: Removing info for No Bus:vcsa5
[  117.232000] PM: Adding info for No Bus:vcs6
[  117.232000] PM: Adding info for No Bus:vcsa6
[  117.236000] PM: Removing info for No Bus:vcs6
[  117.236000] PM: Removing info for No Bus:vcsa6
[  117.236000] PM: Adding info for No Bus:vcs6
[  117.236000] PM: Adding info for No Bus:vcsa6
[  117.240000] PM: Removing info for No Bus:vcs6
[  117.240000] PM: Removing info for No Bus:vcsa6
[  117.248000] PM: Adding info for No Bus:vcs2
[  117.248000] PM: Adding info for No Bus:vcsa2
[  117.252000] PM: Removing info for No Bus:vcs2
[  117.252000] PM: Removing info for No Bus:vcsa2
[  117.252000] PM: Adding info for No Bus:vcs3
[  117.256000] PM: Adding info for No Bus:vcsa3
[  117.256000] PM: Removing info for No Bus:vcs3
[  117.256000] PM: Removing info for No Bus:vcsa3
[  117.256000] PM: Adding info for No Bus:vcs4
[  117.260000] PM: Adding info for No Bus:vcsa4
[  117.260000] PM: Removing info for No Bus:vcs4
[  117.260000] PM: Removing info for No Bus:vcsa4
[  117.260000] PM: Adding info for No Bus:vcs5
[  117.260000] PM: Adding info for No Bus:vcsa5
[  117.264000] PM: Removing info for No Bus:vcs5
[  117.264000] PM: Removing info for No Bus:vcsa5
[  117.264000] PM: Adding info for No Bus:vcs6
[  117.264000] PM: Adding info for No Bus:vcsa6
[  117.264000] PM: Removing info for No Bus:vcs6
[  117.264000] PM: Removing info for No Bus:vcsa6
[  117.856000] PM: Adding info for No Bus:vcs4
[  117.860000] PM: Adding info for No Bus:vcsa4
[  117.884000] PM: Adding info for No Bus:vcs5
[  117.884000] PM: Adding info for No Bus:vcs2
[  117.884000] PM: Adding info for No Bus:vcsa2
[  117.884000] PM: Adding info for No Bus:vcsa5
[  117.884000] PM: Adding info for No Bus:vcs6
[  117.884000] PM: Adding info for No Bus:vcsa6
[  117.884000] PM: Adding info for No Bus:vcs3
[  117.884000] PM: Adding info for No Bus:vcsa3
[  118.204000] input: Power Button (FF) as /class/input/input3
[  118.204000] ACPI: Power Button (FF) [PWRF]
[  118.204000] input: Power Button (CM) as /class/input/input4
[  118.204000] ACPI: Power Button (CM) [PWRB]
[  118.268000] Using specific hotkey driver
[  118.328000] No dock devices found.
[  118.388000] ibm_acpi: ec object not found
[  118.472000] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[  118.836000] powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 3600+ processors (version 2.00.00)
[  118.836000] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0xe
[  118.836000] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x10
[  118.836000] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
[  121.980000] Capability LSM initialized
[  122.572000] PM: Adding info for No Bus:vcs7
[  122.572000] PM: Adding info for No Bus:vcsa7
[  122.732000] PM: Removing info for No Bus:vcs7
[  122.736000] PM: Removing info for No Bus:vcsa7
[  122.768000] PM: Adding info for No Bus:parport0
[  122.772000] ppdev: user-space parallel port driver
[  122.792000] PM: Adding info for No Bus:vcs7
[  122.796000] PM: Adding info for No Bus:vcsa7
[  123.452000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[  123.452000] apm: disabled - APM is not SMP safe.
[  123.688000] ip_tables: (C) 2000-2006 Netfilter Core Team
[  123.812000] Netfilter messages via NETLINK v0.30.
[  123.868000] nf_conntrack version 0.5.0 (8190 buckets, 65520 max)
[  125.620000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  125.956000] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[  125.972000] NFSD: starting 90-second grace period
[  128.044000] NET: Registered protocol family 10
[  128.044000] lo: Disabled Privacy Extensions
[  130.528000] hda-intel: Invalid position buffer, using LPIB read method instead.
[  138.456000] eth0: no IPv6 routers present

--------------060403020308080601010708--
