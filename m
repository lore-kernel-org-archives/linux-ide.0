From: Tyler <pml@dtbb.net>
Subject: Re: data corruption with DMA enabled on K7VT4A PRO (VIA KT400A)
Date: Thu, 20 Apr 2006 19:10:17 -0700
Message-ID: <44483F09.3020605@dtbb.net>
References: <7285a92f0604122257k2d3578b5re29699c91beeefe8@mail.gmail.com> <7285a92f0604170706l6e8786a2x8eb72ed75910b6ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.atws.ca ([209.52.90.118]:4756 "EHLO AT-MAIL")
	by vger.kernel.org with ESMTP id S1750712AbWDUCKV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Apr 2006 22:10:21 -0400
In-Reply-To: <7285a92f0604170706l6e8786a2x8eb72ed75910b6ae@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fpn@pobox.com
Cc: linux-ide@vger.kernel.org

Florian Nierhaus wrote:
> Hi everyone,
>
> not sure this is the right list.
>
> I currently have data corruption when I md5sum large files on both my
> SATA as well as my PATA drive. When I turn off DMA on the PATA drive
> it is slow, but no data corruption - I havent figured out to turn off
> DMA for the SATA.
>
>  If it helps, when I diff -u it looks like it is large blocks that are
> missing/mixed up whatever, but not a bit here or there.
>
> This is the second board (but the same model) and still have the same issue.
>  The board seems to have a VIA KT400A as well as a VT8237.
>
>   
I would suggest swapping your ram out for known tested-good chips, 
and/or even a different brand/model.  I had similar corruption on an 
Nforce4 system, transferring large files across the network, and it only 
stopped once I swapped out the ram (in my case, I removed the 512mb 
stick, and put a 256mb stick I had laying around).  I'm guessing that 
NOT using DMA may just be hiding a RAM issue.  There were no other 
symptoms, no crashes, etc, just screwed up files after transfers.

You could also try raising the VDIMM voltage to 2.6 or 2.65 if your 
motherboard supports that option in the bios, it may be enough to make 
the ram stable.  I had another system that was having random oopses, and 
raising the VDIMM voltage cured it with two generic Samsung 512mb DDR 
chips running in dual-channel.

After changing/checking these couple things, and the corruption is still 
occurring, then I would look deeper.. but RAM is a relatively easy thing 
to test/swap out, and is more often a problem than not.

Regards,
Tyler.
> The boot log is attached. Happens with all fedora kernels I tried and
> also with vanilla linux-2.6.16.4.
>
> cat /proc/interrupts shows:
>            CPU0
>   0:    9055498    IO-APIC-edge  timer
>   1:      19534    IO-APIC-edge  i8042
>   7:          2    IO-APIC-edge  parport0
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  14:    1399782    IO-APIC-edge  ide0
>  15:     108188    IO-APIC-edge  ide1
> 169:      13820   IO-APIC-level  libata
> 185:      47999   IO-APIC-level  eth1
> 193:          0   IO-APIC-level  VIA8237
> 201:     105733   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2,
> uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
> NMI:          0
> LOC:    9056156
> ERR:          0
> MIS:          0
>
> lspci shows:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
> Host Bridge (rev 80)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> 00:0c.0 Network controller: Intersil Corporation Intersil ISL3890
> [Prism GT/Prism Duette] (rev 01)
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA
> RAID Controller (rev 80)
> 00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
> [KT600/K8T800/K8T890 South]
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc.
> VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
> MX/MX 400] (rev a1)
>
> any ideas, patches I can try, etc. would be great!
>  Florian
>   
> ------------------------------------------------------------------------
>
> Linux version 2.6.16.4 (root@darkstar.fpn.dyndns.org) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 SMP Wed Apr 12 15:11:07 CEST 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000d2000 - 00000000000da000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
>  BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
>  BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
> On node 0 totalpages: 262128
>   DMA zone: 4096 pages, LIFO batch:0
>   DMA32 zone: 0 pages, LIFO batch:0
>   Normal zone: 225280 pages, LIFO batch:31
>   HighMem zone: 32752 pages, LIFO batch:7
> DMI 2.3 present.
> Using APIC driver default
> ACPI: RSDP (v000 AMI                                   ) @ 0x000fa8b0
> ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x3fff0000
> ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x3fff0030
> ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x3fff00c0
> ACPI: DSDT (v001    VIA    K7VT4 0x00001000 INTL 0x02002024) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x808
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 6:10 APIC version 16
> Overriding APIC driver with bigsmp
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Enabling APIC mode:  Physflat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
> Built 1 zonelists
> Kernel command line: ro root=/dev/hda2 rhgb quiet
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Initializing CPU#0
> CPU 0 irqstacks, hard=c0463000 soft=c0483000
> PID hash table entries: 4096 (order: 12, 65536 bytes)
> Detected 1833.230 MHz processor.
> Using pmtmr for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 1030416k/1048512k available (2386k kernel code, 17452k reserved, 816k data, 240k init, 131008k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 3671.77 BogoMIPS (lpj=7343549)
> Security Framework v1.0.0 initialized
> SELinux:  Initializing.
> SELinux:  Starting in permissive mode
> selinux_register_security:  Registering secondary module capability
> Capability LSM initialized as secondary
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
> CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 512K (64 bytes/line)
> CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Checking 'hlt' instruction... OK.
> CPU0: AMD Athlon(tm) XP 2500+ stepping 00
> Leaving ESR disabled.
> Total of 1 processors activated (3671.77 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> Brought up 1 CPUs
> migration_cost=0
> checking if image is initramfs... it is
> Freeing initrd memory: 1204k freed
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: PCI BIOS revision 2.10 entry at 0xfda71, last bus=1
> PCI: Using configuration type 1
> ACPI: Subsystem revision 20060127
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Scanning bus 0000:00
> PCI: Found 0000:00:00.0 [1106/3189] 000600 00
> PCI: Calling quirk c0206430 for 0000:00:00.0
> PCI: Calling quirk c02dac90 for 0000:00:00.0
> PCI: Calling quirk c02da6d0 for 0000:00:00.0
> PCI: Found 0000:00:01.0 [1106/b198] 000604 01
> PCI: Calling quirk c0206430 for 0000:00:01.0
> PCI: Calling quirk c02dac90 for 0000:00:01.0
> PCI: Calling quirk c02da6d0 for 0000:00:01.0
> PCI: Found 0000:00:0c.0 [1260/3890] 000280 00
> PCI: Calling quirk c0206430 for 0000:00:0c.0
> PCI: Calling quirk c02dac90 for 0000:00:0c.0
> PCI: Calling quirk c02da6d0 for 0000:00:0c.0
> PCI: Found 0000:00:0f.0 [1106/3149] 000104 00
> PCI: Calling quirk c0206430 for 0000:00:0f.0
> PCI: Calling quirk c02dac90 for 0000:00:0f.0
> PCI: Calling quirk c02da6d0 for 0000:00:0f.0
> PCI: Found 0000:00:0f.1 [1106/0571] 000101 00
> PCI: Calling quirk c0206430 for 0000:00:0f.1
> PCI: Calling quirk c02dac90 for 0000:00:0f.1
> PCI: Calling quirk c02da6d0 for 0000:00:0f.1
> PCI: Found 0000:00:10.0 [1106/3038] 000c03 00
> PCI: Calling quirk c0206430 for 0000:00:10.0
> PCI: Calling quirk c02dac90 for 0000:00:10.0
> PCI: Calling quirk c02da6d0 for 0000:00:10.0
> PCI: Found 0000:00:10.1 [1106/3038] 000c03 00
> PCI: Calling quirk c0206430 for 0000:00:10.1
> PCI: Calling quirk c02dac90 for 0000:00:10.1
> PCI: Calling quirk c02da6d0 for 0000:00:10.1
> PCI: Found 0000:00:10.2 [1106/3038] 000c03 00
> PCI: Calling quirk c0206430 for 0000:00:10.2
> PCI: Calling quirk c02dac90 for 0000:00:10.2
> PCI: Calling quirk c02da6d0 for 0000:00:10.2
> PCI: Found 0000:00:10.3 [1106/3038] 000c03 00
> PCI: Calling quirk c0206430 for 0000:00:10.3
> PCI: Calling quirk c02dac90 for 0000:00:10.3
> PCI: Calling quirk c02da6d0 for 0000:00:10.3
> PCI: Found 0000:00:10.4 [1106/3104] 000c03 00
> PCI: Calling quirk c0206430 for 0000:00:10.4
> PCI: Calling quirk c02dac90 for 0000:00:10.4
> PCI: Calling quirk c02da6d0 for 0000:00:10.4
> PCI: Found 0000:00:11.0 [1106/3227] 000601 00
> PCI: Calling quirk c0206430 for 0000:00:11.0
> PCI: Calling quirk c02dac90 for 0000:00:11.0
> PCI: Calling quirk c02da6d0 for 0000:00:11.0
> PCI: Found 0000:00:11.5 [1106/3059] 000401 00
> PCI: Calling quirk c0206430 for 0000:00:11.5
> PCI: Calling quirk c02dac90 for 0000:00:11.5
> PCI: Calling quirk c02da6d0 for 0000:00:11.5
> PCI: Found 0000:00:12.0 [1106/3065] 000200 00
> PCI: Calling quirk c0206430 for 0000:00:12.0
> PCI: Calling quirk c02dac90 for 0000:00:12.0
> PCI: Calling quirk c02da6d0 for 0000:00:12.0
> PCI: Fixups for bus 0000:00
> PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
> PCI: Scanning bus 0000:01
> PCI: Found 0000:01:00.0 [10de/0110] 000300 00
> PCI: Calling quirk c0206430 for 0000:01:00.0
> PCI: Calling quirk c02dac90 for 0000:01:00.0
> Boot video device is 0000:01:00.0
> PCI: Calling quirk c02da6d0 for 0000:01:00.0
> PCI: Fixups for bus 0000:01
> PCI: Bus scan for 0000:01 returning with max=01
> PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
> PCI: Bus scan for 0000:00 returning with max=01
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Power Resource [URP1] (off)
> ACPI: Power Resource [URP2] (off)
> ACPI: Power Resource [FDDP] (off)
> ACPI: Power Resource [LPTP] (off)
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 12 devices
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> PCI: Bridge: 0000:00:01.0
>   IO window: disabled.
>   MEM window: dde00000-dfefffff
>   PREFETCH window: cdd00000-ddcfffff
> PCI: Calling quirk c02065f0 for 0000:00:01.0
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> apm: BIOS not found.
> audit: initializing netlink socket (disabled)
> audit(1144900290.776:1): initialized
> highmem bounce pool size: 64 pages
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> SELinux:  Registering netfilter hooks
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> PCI: Calling quirk c0205b30 for 0000:00:00.0
> PCI: Calling quirk c02b8890 for 0000:00:00.0
> PCI: Calling quirk c0205b30 for 0000:00:01.0
> PCI: Calling quirk c02b8890 for 0000:00:01.0
> PCI: Calling quirk c0205b30 for 0000:00:0c.0
> PCI: Calling quirk c02b8890 for 0000:00:0c.0
> PCI: Calling quirk c0205b30 for 0000:00:0f.0
> PCI: Calling quirk c02b8890 for 0000:00:0f.0
> PCI: Calling quirk c0205b30 for 0000:00:0f.1
> PCI: Calling quirk c02b8890 for 0000:00:0f.1
> PCI: Calling quirk c0205b30 for 0000:00:10.3
> PCI: Calling quirk c02b8890 for 0000:00:10.3
> PCI: Calling quirk c0205b30 for 0000:00:10.2
> PCI: Calling quirk c02b8890 for 0000:00:10.2
> PCI: Calling quirk c0205b30 for 0000:00:10.1
> PCI: Calling quirk c02b8890 for 0000:00:10.1
> PCI: Calling quirk c0205b30 for 0000:00:10.0
> PCI: Calling quirk c02b8890 for 0000:00:10.0
> PCI: Calling quirk c0205b30 for 0000:00:10.4
> PCI: Calling quirk c02b8890 for 0000:00:10.4
> PCI: Calling quirk c0205b30 for 0000:00:11.0
> PCI: Calling quirk c0206150 for 0000:00:11.0
> PCI: Bypassing VIA 8237 APIC De-Assert Message
> PCI: Calling quirk c02b8890 for 0000:00:11.0
> PCI: Calling quirk c0205b30 for 0000:00:11.5
> PCI: Calling quirk c02b8890 for 0000:00:11.5
> PCI: Calling quirk c0205b30 for 0000:00:12.0
> PCI: Calling quirk c02b8890 for 0000:00:12.0
> PCI: Calling quirk c0205b30 for 0000:01:00.0
> PCI: Calling quirk c02b8890 for 0000:01:00.0
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12ac
> Linux agpgart interface v0.101 (c) Dave Jones
> agpgart: Detected VIA KT400/KT400A/KT600 chipset
> agpgart: AGP aperture is 32M @ 0xe0000000
> PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> PNP: PS/2 controller doesn't have AUX irq; using default 12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:0f.1
> ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 169
> PCI: Calling quirk c02065f0 for 0000:00:0f.1
> PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 9
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: ST380021A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: DVD-ROM BDV316C, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63
> hda: cache flushes not supported
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
> Uniform CD-ROM driver Revision: 3.20
> ide-floppy driver 0.99.newide
> usbcore: registered new driver libusual
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> mice: PS/2 mouse device common for all mice
> md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: bitmap version 4.39
> NET: Registered protocol family 2
> IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
> TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> TCP bic registered
> Initializing IPsec netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Using IPI No-Shortcut mode
> ACPI wakeup devices: 
> PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD PS2K  AC9  MC9 ILAN SLPB 
> ACPI: (supports S0 S1 S4 S5)
> Freeing unused kernel memory: 240k freed
> Write protecting the kernel read-only data: 350k
> SCSI subsystem initialized
> libata version 1.20 loaded.
> sata_via 0000:00:0f.0: version 1.1
> ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
> PCI: Calling quirk c02065f0 for 0000:00:0f.0
> PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 9
> sata_via 0000:00:0f.0: routed to hard irq line 9
> ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 169
> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 169
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> input: AT Translated Set 2 keyboard as /class/input/input0
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
> ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
> ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
> ata1: dev 0 configured for UDMA/133
> scsi0 : sata_via
> input: AT Translated Set 2 keyboard as /class/input/input1
> ata2: SATA link down (SStatus 0)
> scsi1 : sata_via
>   Vendor: ATA       Model: ST3250624AS       Rev: 3.AA
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3
> sd 0:0:0:0: Attached scsi disk sda
> device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
> ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 177
> PCI: Calling quirk c02065f0 for 0000:00:12.0
> PCI: Via IRQ fixup for 0000:00:12.0, from 11 to 1
> eth0: VIA Rhine II at 0xdfff9d00, 00:13:8f:23:79:99, IRQ 177.
> eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
> Loaded prism54 driver, version 1.2
> ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 185
> ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 193
> PCI: Calling quirk c02065f0 for 0000:00:11.5
> PCI: Via IRQ fixup for 0000:00:11.5, from 10 to 1
> PCI: Enabling bus mastering for device 0000:00:11.5
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 201
> PCI: Calling quirk c02065f0 for 0000:00:10.4
> PCI: Via IRQ fixup for 0000:00:10.4, from 10 to 9
> ehci_hcd 0000:00:10.4: EHCI Host Controller
> ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:10.4: irq 201, io mem 0xdfff9e00
> ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 8 ports detected
> USB Universal Host Controller Interface driver v2.3
> ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 201
> PCI: Calling quirk c02065f0 for 0000:00:10.0
> PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 9
> uhci_hcd 0000:00:10.0: UHCI Host Controller
> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:10.0: irq 201, io base 0x0000c800
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201
> PCI: Calling quirk c02065f0 for 0000:00:10.1
> PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 9
> uhci_hcd 0000:00:10.1: UHCI Host Controller
> uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:10.1: irq 201, io base 0x0000cc00
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 201
> PCI: Calling quirk c02065f0 for 0000:00:10.2
> PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 9
> uhci_hcd 0000:00:10.2: UHCI Host Controller
> uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:10.2: irq 201, io base 0x0000d000
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 1-6: new high speed USB device using ehci_hcd and address 3
> ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 201
> PCI: Calling quirk c02065f0 for 0000:00:10.3
> PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 9
> uhci_hcd 0000:00:10.3: UHCI Host Controller
> uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
> uhci_hcd 0000:00:10.3: irq 201, io base 0x0000d400
> usb usb5: configuration #1 chosen from 1 choice
> usb 1-6: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 2 ports detected
> usb 2-1: new low speed USB device using uhci_hcd and address 2
> Initializing USB Mass Storage driver...
> usb 2-1: configuration #1 chosen from 1 choice
> input: Logitech USB-PS/2 Mouse M-BA47 as /class/input/input2
> input: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse M-BA47] on usb-0000:00:10.0-1
> scsi2 : SCSI emulation for USB Mass Storage devices
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usb-storage: device found at 3
> usb-storage: waiting for device to settle before scanning
>   Vendor: FSC       Model: MEMORYBIRD USB2   Rev: 2.00
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> SCSI device sdb: 1020160 512-byte hdwr sectors (522 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 03 00 00 00
> sdb: assuming drive cache: write through
> SCSI device sdb: 1020160 512-byte hdwr sectors (522 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 03 00 00 00
> sdb: assuming drive cache: write through
>  sdb: unknown partition table
> sd 2:0:0:0: Attached scsi removable disk sdb
> usb-storage: device scan complete
> ACPI: Power Button (FF) [PWRF]
> ACPI: Power Button (CM) [PWRB]
> ACPI: Sleep Button (CM) [SLPB]
> ibm_acpi: ec object not found
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> EXT3 FS on hda2, internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda5, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda6, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> Adding 1048784k swap on /dev/hda1.  Priority:-1 extents:1 across:1048784k
> ip_tables: (C) 2000-2006 Netfilter Core Team
> Netfilter messages via NETLINK v0.30.
> ip_conntrack version 2.4 (8191 buckets, 65528 max) - 232 bytes per conntrack
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
> lp0: using parport0 (interrupt-driven).
> lp0: console ready
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
> NFSD: starting 90-second grace period
> Linux video capture interface: v1.00
> usbcore: registered new driver dsbr100
> drivers/usb/media/dsbr100.c: v0.40:D-Link DSB-R100 USB FM radio driver
> ieee1394: Initialized config rom entry `ip1394'
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs warning: checktime reached, running e2fsck is recommended
> EXT3 FS on hda3, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on dm-3, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> eth1: resetting device...
> eth1: uploading firmware...
> eth1: firmware version: 1.0.3.0
> eth1: firmware upload complete
> eth1: interface reset complete
> hda: DMA disabled
>   
