From: chantra@debuntu.org
Subject: Freezes: ata1 is slow to respond, please be patient
Date: Wed, 9 Aug 2006 13:41:49 -0000 (GMT)
Message-ID: <37640.194.116.144.3.1155130909.squirrel@www.servage.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20060809134149_13959"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.servage.net ([62.214.98.16]:53427 "EHLO smtp1.servage.net")
	by vger.kernel.org with ESMTP id S1750787AbWHINlx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 09:41:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

------=_20060809134149_13959
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I'm mailing you as sata driver behave really badly on my new laptop. It
seems it affects only few people, but this is quite disturbing as the
computer locks-up for about 30 sec (timeout) and then operate fine again.

I'm actually using kernel 2.6.15-26 on a intel duo core laptop.
In general the computer runs fine, but I get freezes approximately every
30 second. Every time there is a freeze, I get a message from dmesg
telling me that ata1 is slow to respond.

There is a bug report about it at:
https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/53754

There you will be able to find dmesg dumps as well as lspci -vvvv

Lately, I added "lapic nmi_watchdog=1" to kernel boot parameters, it
"seems" that there is less freezes.
I'm going to try out "noapic acpi=off" tonight and see if it makes a
difference or not, will mail you then.

By the way, lately I tried ubuntu edgy eft and debian edgy, both of them
use a 2.6.17 kernel.... the kernel did not even boot. I didn't get a
kernel panic, the kernel simply hanged on "mounting root filesystem".

Please, feel free to mail me for anything you might require.

Thanks a lot in advance,
Regards, chantra

-- 
http://www.debuntu.org
http://repository.debuntu.org
------=_20060809134149_13959
Content-Type: text/plain; name="dmesg.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmesg.txt"

[17179569.184000] Linux version 2.6.15-26-686 (buildd@terranova) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP PREEMPT Thu Aug 3 03:13:28 UTC 2006
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[17179569.184000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000003fe90000 (usable)
[17179569.184000]  BIOS-e820: 000000003fe90000 - 000000003fe9e000 (ACPI data)
[17179569.184000]  BIOS-e820: 000000003fe9e000 - 000000003ff00000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[17179569.184000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[17179569.184000] 126MB HIGHMEM available.
[17179569.184000] 896MB LOWMEM available.
[17179569.184000] found SMP MP-table at 000f5c40
[17179569.184000] On node 0 totalpages: 261776
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   DMA32 zone: 0 pages, LIFO batch:0
[17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 32400 pages, LIFO batch:7
[17179569.184000] DMI present.
[17179569.184000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f5aa0
[17179569.184000] ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x3fe951f7
[17179569.184000] ACPI: FADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x3fe9ddee
[17179569.184000] ACPI: MADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x3fe9de62
[17179569.184000] ACPI: HPET (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x3fe9deca
[17179569.184000] ACPI: MCFG (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x3fe9df02
[17179569.184000] ACPI: TCPA (v001 PTLTD  CALISTGA 0x06040000  PTL 0x00000001) @ 0x3fe9df3e
[17179569.184000] ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x3fe9df70
[17179569.184000] ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x3fe9dfd8
[17179569.184000] ACPI: SSDT (v001 SataRe  SataPri 0x00001000 INTL 0x20050624) @ 0x3fe96329
[17179569.184000] ACPI: SSDT (v001 SataRe  SataSec 0x00001000 INTL 0x20050624) @ 0x3fe95c97
[17179569.184000] ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x3fe95243
[17179569.184000] ACPI: DSDT (v001 INTEL  CALISTGA 0x06040000 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x1008
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: 2 duplicate APIC table ignored.
[17179569.184000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:14 APIC version 20
[17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[17179569.184000] Processor #1 6:14 APIC version 20
[17179569.184000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 1 already used, trying 2
[17179569.184000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec18000] gsi_base[24])
[17179569.184000] IOAPIC[1]: apic_id 2 already used, trying 3
[17179569.184000] IOAPIC[1]: Unable to change apic_id!
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ0 used by override.
[17179569.184000] ACPI: IRQ2 used by override.
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/sda1 ro quiet splash lapic nmi_watchdog=1
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[17179569.184000] Console: colour VGA+ 80x25
[17179569.184000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[17179569.184000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179569.184000] Memory: 1025804k/1047104k available (2110k kernel code, 20608k reserved, 595k data, 332k init, 129600k highmem)
[17179569.184000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179569.184000] hpet0: at MMIO 0xfed00000 (virtual 0xf8800000), IRQs 2, 8, 0
[17179569.184000] hpet0: 3 64-bit timers, 14318180 Hz
[17179569.184000] Using HPET for base-timer
[17179569.184000] Using HPET for gettimeofday
[17179569.184000] Detected 1596.250 MHz processor.
[17179569.184000] Using hpet for high-res timesource
[17179569.268000] Calibrating delay using timer specific routine.. 3197.08 BogoMIPS (lpj=6394178)
[17179569.268000] Security Framework v1.0.0 initialized
[17179569.268000] SELinux:  Disabled at boot.
[17179569.268000] Mount-cache hash table entries: 512
[17179569.268000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[17179569.268000] CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[17179569.268000] monitor/mwait feature present.
[17179569.268000] using mwait in idle threads.
[17179569.268000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179569.268000] CPU: L2 cache: 2048K
[17179569.268000] CPU: Hyper-Threading is disabled
[17179569.268000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000040 0000c189 00000000 00000000
[17179569.268000] mtrr: v2.0 (20020519)
[17179569.268000] Enabling fast FPU save and restore... done.
[17179569.268000] Enabling unmasked SIMD FPU exception support... done.
[17179569.268000] Checking 'hlt' instruction... OK.
[17179569.284000] SMP alternatives: switching to UP code
[17179569.284000] checking if image is initramfs... it is
[17179570.532000] Freeing initrd memory: 6809k freed
[17179570.536000] ACPI: Looking for DSDT ... not found!
[17179570.564000] CPU0: Intel Genuine Intel(R) CPU           T2050  @ 1.60GHz stepping 08
[17179570.564000] SMP alternatives: switching to SMP code
[17179570.564000] Booting processor 1/1 eip 3000
[17179570.576000] Initializing CPU#1
[17179570.656000] Calibrating delay using timer specific routine.. 3192.61 BogoMIPS (lpj=6385231)
[17179570.656000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[17179570.656000] CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
[17179570.656000] monitor/mwait feature present.
[17179570.656000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179570.656000] CPU: L2 cache: 2048K
[17179570.656000] CPU: Hyper-Threading is disabled
[17179570.656000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000040 0000c189 00000000 00000000
[17179570.656000] CPU1: Intel Genuine Intel(R) CPU           T2050  @ 1.60GHz stepping 08
[17179570.656000] Total of 2 processors activated (6389.70 BogoMIPS).
[17179570.656000] ENABLING IO-APIC IRQs
[17179570.656000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[17179570.804000] checking TSC synchronization across 2 CPUs: passed.
[17179570.808000] Brought up 2 CPUs
[17179570.808000] NET: Registered protocol family 16
[17179570.808000] EISA bus registered
[17179570.808000] ACPI: bus type pci registered
[17179570.808000] PCI: PCI BIOS revision 2.10 entry at 0xfd5b3, last bus=10
[17179570.808000] PCI: Using MMCONFIG
[17179570.808000] ACPI: Subsystem revision 20051216
[17179570.812000] ACPI: Interpreter enabled
[17179570.812000] ACPI: Using IOAPIC for interrupt routing
[17179570.816000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[17179570.816000] PCI: Probing PCI hardware (bus 00)
[17179570.820000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
[17179570.820000] Boot video device is 0000:01:00.0
[17179570.820000] PCI: Transparent bridge - 0000:00:1e.0
[17179570.820000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179570.828000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
[17179570.832000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[17179570.832000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[17179570.832000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[17179570.832000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[17179570.836000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[17179570.836000] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
[17179570.836000] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
[17179570.836000] ACPI: PCI Interrupt Link [LNKC] (IRQs *10 11)
[17179570.840000] ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
[17179570.840000] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[17179570.840000] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[17179570.840000] ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
[17179570.840000] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
[17179570.840000] ACPI: Embedded Controller [EC0] (gpe 23) interrupt mode.
[17179570.852000] Linux Plug and Play Support v0.97 (c) Adam Belay
[17179570.852000] pnp: PnP ACPI init
[17179570.856000] pnp: PnP ACPI: found 10 devices
[17179570.856000] PnPBIOS: Disabled by ACPI PNP
[17179570.856000] PCI: Using ACPI for IRQ routing
[17179570.856000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179570.896000] pnp: 00:06: ioport range 0x6a0-0x6af has been reserved
[17179570.896000] pnp: 00:06: ioport range 0x6b0-0x6ff has been reserved
[17179570.896000] PCI: Failed to allocate mem resource #6:20000@c0000000 for 0000:01:00.0
[17179570.896000] PCI: Bridge: 0000:00:01.0
[17179570.896000]   IO window: disabled.
[17179570.896000]   MEM window: d0000000-d1ffffff
[17179570.896000]   PREFETCH window: b0000000-bfffffff
[17179570.896000] PCI: Bridge: 0000:00:1c.0
[17179570.896000]   IO window: 2000-2fff
[17179570.896000]   MEM window: c8000000-c9ffffff
[17179570.896000]   PREFETCH window: c0000000-c1ffffff
[17179570.896000] PCI: Bridge: 0000:00:1c.1
[17179570.896000]   IO window: 3000-3fff
[17179570.896000]   MEM window: ca000000-cbffffff
[17179570.896000]   PREFETCH window: c2000000-c3ffffff
[17179570.896000] PCI: Bridge: 0000:00:1c.2
[17179570.896000]   IO window: 4000-4fff
[17179570.896000]   MEM window: cc000000-cdffffff
[17179570.896000]   PREFETCH window: c4000000-c5ffffff
[17179570.896000] PCI: Bridge: 0000:00:1c.3
[17179570.896000]   IO window: 5000-5fff
[17179570.896000]   MEM window: ce000000-cfffffff
[17179570.896000]   PREFETCH window: c6000000-c7ffffff
[17179570.896000] PCI: Bus 11, cardbus bridge: 0000:0a:06.0
[17179570.896000]   IO window: 00006000-000060ff
[17179570.896000]   IO window: 00006400-000064ff
[17179570.896000]   PREFETCH window: 50000000-51ffffff
[17179570.896000]   MEM window: 52000000-53ffffff
[17179570.896000] PCI: Bridge: 0000:00:1e.0
[17179570.896000]   IO window: 6000-6fff
[17179570.896000]   MEM window: d2000000-d20fffff
[17179570.896000]   PREFETCH window: 50000000-51ffffff
[17179570.896000] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179570.896000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[17179570.900000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
[17179570.900000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179570.900000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
[17179570.900000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[17179570.900000] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
[17179570.900000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[17179570.900000] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
[17179570.900000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[17179570.900000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179570.900000] ACPI: PCI Interrupt 0000:0a:06.0[A] -> GSI 22 (level, low) -> IRQ 201
[17179570.900000] Simple Boot Flag at 0x36 set to 0x1
[17179570.900000] audit: initializing netlink socket (disabled)
[17179570.900000] audit(1155071988.896:1): initialized
[17179570.900000] highmem bounce pool size: 64 pages
[17179570.900000] VFS: Disk quotas dquot_6.5.1
[17179570.900000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179570.900000] Initializing Cryptographic API
[17179570.900000] io scheduler noop registered
[17179570.900000] io scheduler anticipatory registered
[17179570.900000] io scheduler deadline registered
[17179570.900000] io scheduler cfq registered
[17179570.900000] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179570.900000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[17179570.900000] assign_interrupt_mode Found MSI capability
[17179570.900000] Allocate Port Service[pcie00]
[17179570.900000] Allocate Port Service[pcie03]
[17179570.900000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
[17179570.900000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179570.900000] assign_interrupt_mode Found MSI capability
[17179570.900000] Allocate Port Service[pcie00]
[17179570.900000] Allocate Port Service[pcie02]
[17179570.900000] Allocate Port Service[pcie03]
[17179570.900000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
[17179570.900000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[17179570.900000] assign_interrupt_mode Found MSI capability
[17179570.900000] Allocate Port Service[pcie00]
[17179570.900000] Allocate Port Service[pcie02]
[17179570.900000] Allocate Port Service[pcie03]
[17179570.900000] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
[17179570.900000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[17179570.900000] assign_interrupt_mode Found MSI capability
[17179570.900000] Allocate Port Service[pcie00]
[17179570.900000] Allocate Port Service[pcie02]
[17179570.900000] Allocate Port Service[pcie03]
[17179570.900000] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
[17179570.900000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[17179570.900000] assign_interrupt_mode Found MSI capability
[17179570.900000] Allocate Port Service[pcie00]
[17179570.900000] Allocate Port Service[pcie02]
[17179570.900000] Allocate Port Service[pcie03]
[17179570.904000] isapnp: Scanning for PnP cards...
[17179571.260000] isapnp: No Plug & Play device found
[17179571.292000] Real Time Clock Driver v1.12
[17179571.292000] PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[17179571.304000] i8042.c: Detected active multiplexing controller, rev 1.1.
[17179571.308000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[17179571.308000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[17179571.308000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[17179571.308000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[17179571.312000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179571.312000] Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
[17179571.316000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[17179571.316000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179571.316000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179571.316000] mice: PS/2 mouse device common for all mice
[17179571.316000] EISA: Probing bus 0 at eisa.0
[17179571.316000] Cannot allocate resource for EISA slot 1
[17179571.316000] Cannot allocate resource for EISA slot 2
[17179571.316000] Cannot allocate resource for EISA slot 3
[17179571.316000] Cannot allocate resource for EISA slot 4
[17179571.316000] Cannot allocate resource for EISA slot 5
[17179571.316000] Cannot allocate resource for EISA slot 6
[17179571.316000] EISA: Detected 0 cards.
[17179571.316000] NET: Registered protocol family 2
[17179571.356000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[17179571.356000] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[17179571.356000] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[17179571.356000] TCP: Hash tables configured (established 131072 bind 65536)
[17179571.356000] TCP reno registered
[17179571.356000] TCP bic registered
[17179571.356000] NET: Registered protocol family 1
[17179571.356000] NET: Registered protocol family 8
[17179571.356000] NET: Registered protocol family 20
[17179571.356000] Testing NMI watchdog ... OK.
[17179571.396000] Starting balanced_irq
[17179571.396000] Using IPI No-Shortcut mode
[17179571.396000] ACPI wakeup devices: 
[17179571.396000] LID0 SLPB HDEF LANE PXS2 PXS3 PXS4 PXS5 PXS6 USB1 USB2 USB3 USB4 USB7 LANC MODM 
[17179571.396000] ACPI: (supports S0 S3 S4 S5)
[17179571.396000] Freeing unused kernel memory: 332k freed
[17179571.492000] vga16fb: initializing
[17179571.492000] vga16fb: mapped to 0xc00a0000
[17179571.712000] Console: switching to colour frame buffer device 80x25
[17179571.712000] fb0: VGA16 VGA frame buffer device
[17179571.940000] input: AT Translated Set 2 keyboard as /class/input/input0
[17179572.748000] Capability LSM initialized
[17179572.868000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[17179572.868000] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[17179572.880000] ACPI: Thermal Zone [TZS0] (52 C)
[17179572.884000] ACPI: Thermal Zone [TZS1] (44 C)
[17179573.752000] SCSI subsystem initialized
[17179573.756000] ACPI: bus type scsi registered
[17179573.756000] libata version 1.20 loaded.
[17179573.760000] ata_piix 0000:00:1f.2: version 1.05
[17179573.760000] ata_pci_init_one: pci_dev class+intf: 0x10180
[17179573.760000] ata_pci_init_one: NO_LEGACY == 0
[17179573.760000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
[17179573.760000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[17179573.760000] ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
[17179573.924000] ata1: dev 0 cfg 00:427a 49:2f00 82:306b 83:5809 84:4003 85:3069 86:1809 87:4003 88:203f 93:603b
[17179573.924000] ata1: dev 0 ATA-6, max UDMA/100, 156301488 sectors: LBA
[17179573.924000] ata1(0): applying bridge limits
[17179573.924000] ata_acpi_push_id: skipping for PATA mode
[17179574.104000] ata1: dev 1 cfg 00:85c0 49:0f00 82:0000 83:4000 84:4000 85:0000 86:0000 87:4000 88:0407 93:4101
[17179574.104000] ata1: dev 1 ATAPI, max UDMA/33
[17179574.104000] ata1(0): applying bridge limits
[17179574.104000] ata_acpi_push_id: skipping for PATA mode
[17179574.104000] ata1: dev 0 configured for UDMA/33
[17179574.104000] ata1: dev 1 configured for UDMA/33
[17179574.104000] pata_get_dev_handle: ENTER: dev->bus_id='0000:00:1f.2'
[17179574.104000] pata_get_dev_handle: dev_handle: 0xdffe1e60, parent_handle: 0xdffe8840
[17179574.104000] pata_get_dev_handle: for dev=0x1f.2, addr=0x1f0002, parent=0xdff5d000, *handle=0xdffe1e60
[17179574.104000] do_drive_get_GTF:   drive w/ adr=0: v: 0xdffdf760
[17179574.104000] pata_get_dev_handle: ENTER: dev->bus_id='0000:00:1f.2'
[17179574.104000] pata_get_dev_handle: dev_handle: 0xdffe1e60, parent_handle: 0xdffe8840
[17179574.104000] pata_get_dev_handle: for dev=0x1f.2, addr=0x1f0002, parent=0xdff5d000, *handle=0xdffe1e60
[17179574.104000] do_drive_get_GTF:   drive w/ adr=1: v: 0xdffdf700
[17179574.108000] scsi0 : ata_piix
[17179574.108000]   Vendor: ATA       Model: WDC WD800UE-22HC  Rev: 09.0
[17179574.108000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[17179579.152000] ata1 is slow to respond, please be patient
[17179579.608000] ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x60
[17179579.608000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[17179579.608000] scsi scan: 96 byte inquiry failed.  Consider BLIST_INQUIRY_36 for this device
[17179583.612000]   Vendor: TSSTcorp  Model: CD/DVDW TS-L632D  Rev: ac00
[17179583.612000]   Type:   CD-ROM                             ANSI SCSI revision: 05
[17179583.612000] pata_get_dev_handle: ENTER: dev->bus_id='0000:00:1f.2'
[17179583.612000] pata_get_dev_handle: dev_handle: 0xdffe1e60, parent_handle: 0xdffe8840
[17179583.612000] pata_get_dev_handle: for dev=0x1f.2, addr=0x1f0002, parent=0xdff5d000, *handle=0xdffe1e60
[17179583.612000] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
[17179583.668000] Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3548
[17179585.024000] ata2: disabling port
[17179585.024000] scsi1 : ata_piix
[17179585.024000] pata_get_dev_handle: ENTER: dev->bus_id='0000:00:1f.2'
[17179585.024000] pata_get_dev_handle: dev_handle: 0xdffe1e60, parent_handle: 0xdffe8840
[17179585.024000] pata_get_dev_handle: for dev=0x1f.2, addr=0x1f0002, parent=0xdff5d000, *handle=0xdffe1e60
[17179585.040000] Driver 'sd' needs updating - please use bus_type methods
[17179585.044000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[17179585.044000] SCSI device sda: drive cache: write back
[17179585.044000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[17179585.044000] SCSI device sda: drive cache: write back
[17179585.044000]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[17179585.448000] sd 0:0:0:0: Attached scsi disk sda
[17179586.016000] usbcore: registered new driver usbfs
[17179586.016000] usbcore: registered new driver hub
[17179586.016000] USB Universal Host Controller Interface driver v2.3
[17179586.016000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 66
[17179586.016000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179586.016000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179586.016000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[17179586.016000] uhci_hcd 0000:00:1d.0: irq 66, io base 0x00001800
[17179586.016000] hub 1-0:1.0: USB hub found
[17179586.016000] hub 1-0:1.0: 2 ports detected
[17179586.124000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
[17179586.124000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179586.124000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179586.124000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[17179586.124000] uhci_hcd 0000:00:1d.1: irq 193, io base 0x00001820
[17179586.124000] hub 2-0:1.0: USB hub found
[17179586.124000] hub 2-0:1.0: 2 ports detected
[17179586.228000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
[17179586.228000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179586.228000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[17179586.228000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[17179586.228000] uhci_hcd 0000:00:1d.2: irq 185, io base 0x00001840
[17179586.228000] hub 3-0:1.0: USB hub found
[17179586.228000] hub 3-0:1.0: 2 ports detected
[17179586.332000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
[17179586.332000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[17179586.332000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[17179586.332000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[17179586.332000] uhci_hcd 0000:00:1d.3: irq 169, io base 0x00001860
[17179586.332000] hub 4-0:1.0: USB hub found
[17179586.332000] hub 4-0:1.0: 2 ports detected
[17179586.436000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 66
[17179586.436000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179586.436000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179586.436000] ehci_hcd 0000:00:1d.7: debug port 1
[17179586.436000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179586.436000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[17179586.436000] ehci_hcd 0000:00:1d.7: irq 66, io mem 0xd2304000
[17179586.440000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179586.440000] hub 5-0:1.0: USB hub found
[17179586.440000] hub 5-0:1.0: 8 ports detected
[17179586.576000] ide0: I/O resource 0x1F0-0x1F7 not free.
[17179586.576000] ide0: ports already in use, skipping probe
[17179586.576000] ide1: I/O resource 0x170-0x177 not free.
[17179586.576000] ide1: ports already in use, skipping probe
[17179586.720000] Attempting manual resume
[17179586.772000] EXT3-fs: mounted filesystem with ordered data mode.
[17179586.772000] kjournald starting.  Commit interval 5 seconds
[17179587.140000] usb 5-7: new high speed USB device using ehci_hcd and address 3
[17179587.552000] usb 3-2: new low speed USB device using uhci_hcd and address 2
[17179599.160000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[17179599.160000]  0:0:1:0: Attached scsi generic sg1 type 5
[17179599.276000] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[17179599.276000] Uniform CD-ROM driver Revision: 3.20
[17179599.276000] sr 0:0:1:0: Attached scsi CD-ROM sr0
[17179600.976000] Linux agpgart interface v0.101 (c) Dave Jones
[17179600.980000] agpgart: Detected an Intel 945GM Chipset.
[17179601.004000] agpgart: AGP aperture is 256M @ 0x0
[17179601.232000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[17179601.236000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[17179601.428000] hw_random: cannot enable RNG, aborting
[17179601.652000] usbcore: registered new driver hiddev
[17179601.660000] ieee80211_1_1_13_crypt: registered algorithm 'NULL'
[17179601.700000] input: HID 04d9:0499 as /class/input/input1
[17179601.700000] input: USB HID v1.10 Mouse [HID 04d9:0499] on usb-0000:00:1d.2-2
[17179601.700000] usbcore: registered new driver usbhid
[17179601.700000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[17179601.748000] ieee80211_1_1_13: 802.11 data/management/control stack, 1.1.13
[17179601.748000] ieee80211_1_1_13: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[17179601.868000] ieee80211_crypt: registered algorithm 'NULL'
[17179601.892000] ieee80211: 802.11 data/management/control stack, git-1.1.7
[17179601.892000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[17179601.980000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 201
[17179601.980000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[17179602.096000] ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.0.5m
[17179602.096000] ipw3945: Copyright(c) 2003-2006 Intel Corporation
[17179602.364000] hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
[17179602.568000] ts: Compaq touchscreen protocol output
[17179602.604000] sdhci: Secure Digital Host Controller Interface driver, 0.10
[17179602.604000] sdhci: Copyright(c) Pierre Ossman
[17179602.740000] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x12a0b1, caps: 0xa04713/0x204000
[17179602.772000] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[17179602.776000] psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
[17179603.016000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[17179603.016000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[17179603.020000] eth0: Identified chip type is 'RTL8168B/8111B'.
[17179603.020000] eth0: r10001.02, the Linux device driver for Realtek Ethernet Controllers at 0x2000, 00:16:d3:41:85:d2, IRQ 169
[17179603.020000] eth0: Auto-negotiation Enabled.
[17179604.776000] eth0: 100Mbps Full-duplex operation.
[17179604.776000] Realtek RTL8168/8111 Family PCI-E Gigabit Ethernet Network Adapter
[17179604.776000] Driver version:1.02
[17179604.776000] Released date:2006/02/23
[17179604.776000] Link Status:Linked
[17179604.776000] Link Speed:100Mbps
[17179604.776000] Duplex mode:Full-Duplex
[17179604.776000] I/O Base:0x2000(I/O port)
[17179604.776000] IRQ:169
[17179604.776000] ACPI: PCI Interrupt 0000:0a:06.0[A] -> GSI 22 (level, low) -> IRQ 201
[17179604.776000] Yenta: CardBus bridge found at 0000:0a:06.0 [1025:0107]
[17179604.776000] Yenta: Using CSCINT to route CSC interrupts to PCI
[17179604.776000] Yenta: Routing CardBus interrupts to PCI
[17179604.776000] Yenta TI: socket 0000:0a:06.0, mfunc 0x01aa1b22, devctl 0x64
[17179604.776000] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 185
[17179604.776000] PCI: Setting latency timer of device 0000:05:00.0 to 64
[17179604.776000] ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
[17179605.008000] Yenta: ISA IRQ mask 0x0cf8, PCI irq 201
[17179605.008000] Socket status: 30000006
[17179605.008000] Yenta: Raising subordinate bus# of parent bus (#0a) from #0a to #0e
[17179605.008000] pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
[17179605.008000] cs: IO port probe 0x6000-0x6fff: clean.
[17179605.008000] pcmcia: parent PCI bridge Memory window: 0xd2000000 - 0xd20fffff
[17179605.008000] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
[17179605.012000] ACPI: PCI Interrupt 0000:0a:06.3[A] -> GSI 22 (level, low) -> IRQ 201
[17179605.060000] sdhci: ============== REGISTER DUMP ==============
[17179605.060000] sdhci: Sys addr: 0x00000000 | Version:  0x00008900
[17179605.060000] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[17179605.060000] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[17179605.060000] sdhci: Present:  0x000a0000 | Host ctl: 0x00000000
[17179605.060000] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[17179605.060000] sdhci: Walk up:  0x00000000 | Clock:    0x00000000
[17179605.060000] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[17179605.060000] sdhci: Int enab: 0x11ff00cf | Sig enab: 0x11ff00cf
[17179605.060000] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[17179605.060000] sdhci: Caps:     0x018030b0 | Max curr: 0x00000000
[17179605.060000] sdhci: ===========================================
[17179605.108000] mmc0: SDHCI at 0xd2005800 irq 201 DMA
[17179605.360000] cs: IO port probe 0x100-0x3af: excluding 0x370-0x377
[17179605.364000] cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3f7 0x4d0-0x4d7
[17179605.364000] cs: IO port probe 0x820-0x8ff: clean.
[17179605.364000] cs: IO port probe 0xc00-0xcf7: clean.
[17179605.368000] cs: IO port probe 0xa00-0xaff: clean.
[17179605.932000] ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
[17179606.224000] lp: driver loaded but no devices found
[17179606.320000] Linux video capture interface: v1.00
[17179606.416000] usbcore: registered new driver spca5xx
[17179606.416000] /usr/src/modules/spca5xx/drivers/usb/spca5xx.c: spca5xx driver 00.57.08 registered
[17179606.432000] NET: Registered protocol family 17
[17179606.504000] Adding 2096472k swap on /dev/sda2.  Priority:-1 extents:1 across:2096472k
[17179606.564000] EXT3 FS on sda1, internal journal
[17179606.852000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[17179606.852000] md: bitmap version 4.39
[17179607.432000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[17179608.096000] cdrom: open failed.
[17179613.468000] NET: Registered protocol family 10
[17179613.468000] lo: Disabled Privacy Extensions
[17179613.468000] IPv6 over IPv4 tunneling driver
[17179618.032000] ReiserFS: sda3: found reiserfs format "3.6" with standard journal
[17179618.732000] ReiserFS: sda3: using ordered data mode
[17179618.764000] ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[17179618.764000] ReiserFS: sda3: checking transaction log (sda3)
[17179618.796000] ReiserFS: sda3: Using r5 hash to sort names
[17179618.880000] ReiserFS: sda5: found reiserfs format "3.6" with standard journal
[17179621.300000] ReiserFS: sda5: using ordered data mode
[17179621.312000] ReiserFS: sda5: journal params: device sda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[17179621.312000] ReiserFS: sda5: checking transaction log (sda5)
[17179621.352000] ReiserFS: sda5: Using r5 hash to sort names
[17179624.096000] eth0: no IPv6 routers present
[17179626.692000] ACPI: AC Adapter [ADP1] (on-line)
[17179626.776000] ACPI: Battery Slot [BAT0] (battery present)
[17179626.920000] ACPI: Power Button (FF) [PWRF]
[17179626.920000] ACPI: Lid Switch [LID0]
[17179626.920000] ACPI: Sleep Button (CM) [SLPB]
[17179627.104000] ibm_acpi: ec object not found
[17179627.152000] pcc_acpi: loading...
[17179627.312000] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[17179627.312000] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[17179632.680000] apm: BIOS not found.
[17179637.780000] Bluetooth: Core ver 2.8
[17179637.780000] NET: Registered protocol family 31
[17179637.780000] Bluetooth: HCI device and connection manager initialized
[17179637.780000] Bluetooth: HCI socket layer initialized
[17179637.840000] Bluetooth: L2CAP ver 2.8
[17179637.840000] Bluetooth: L2CAP socket layer initialized
[17179637.852000] Bluetooth: RFCOMM socket layer initialized
[17179637.852000] Bluetooth: RFCOMM TTY layer initialized
[17179637.852000] Bluetooth: RFCOMM ver 1.7
[17180693.504000] ata1 is slow to respond, please be patient
[17180718.460000] ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x60
[17180718.460000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[17180719.788000] ata1: status=0x50 { DriveReady SeekComplete }
[17180719.792000] sda: Current: sense key: No Sense
[17180719.792000]     Additional sense: No additional sense information
[17180719.792000] Info fld=0x56c6
[17180722.452000] ACPI: read EC, OB not full
[17180722.452000]     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
[17180722.452000]     ACPI-0517: *** Error: Method parse/execution failed [\_TZ_.TZS0._TMP] (Node dffe9500), AE_TIME
------=_20060809134149_13959
Content-Type: text/plain; name="lspcivvvv.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="lspcivvvv.txt"

0000:00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [5109]

0000:00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics Port (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d0000000-d1ffffff
	Prefetchable memory behind bridge: 00000000b0000000-00000000bff00000
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40d9
	Capabilities: [a0] #10 [0141]

0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at d2300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c8000000-c9ffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000c1f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40e1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: ca000000-cbffffff
	Prefetchable memory behind bridge: 00000000c2000000-00000000c3f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40e9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=05, subordinate=06, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: cc000000-cdffffff
	Prefetchable memory behind bridge: 00000000c4000000-00000000c5f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 4032
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=07, subordinate=08, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: ce000000-cfffffff
	Prefetchable memory behind bridge: 00000000c6000000-00000000c7f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 403a
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 66
	Region 4: I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 193
	Region 4: I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 185
	Region 4: I/O ports at 1840 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 169
	Region 4: I/O ports at 1860 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 66
	Region 0: Memory at d2304000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=0a, subordinate=0e, sec-latency=56
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: d2000000-d20fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [100c]

0000:00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 193
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 18b0 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 18c0 [size=32]

0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 01d7 (rev a1) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d1000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at b0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at d0000000 (64-bit, non-prefetchable) [size=16M]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]

0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown device 8168 (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at 2000 [size=256]
	Region 2: Memory at c8000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at c0000000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
	Capabilities: [48] Vital Product Data
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] #10 [0001]
	Capabilities: [84] #09 [014c]

0000:05:00.0 Network controller: Intel Corporation: Unknown device 4222 (rev 02)
	Subsystem: Intel Corporation: Unknown device 1001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 185
	Region 0: Memory at cc000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] #10 [0011]

0000:0a:06.0 CardBus bridge: Texas Instruments: Unknown device 8039
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at d2000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=0a, secondary=0b, subordinate=0e, sec-latency=176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 52000000-53fff000
	I/O window 0: 00006000-000060ff
	I/O window 1: 00006400-000064ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:0a:06.2 Mass storage controller: Texas Instruments: Unknown device 803b
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d2004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:0a:06.3 0805: Texas Instruments: Unknown device 803c
	Subsystem: Acer Incorporated [ALI]: Unknown device 0107
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at d2005800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

------=_20060809134149_13959--

