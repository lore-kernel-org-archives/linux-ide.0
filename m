From: "Jonathan Cohen" <jcohen@llnl.gov>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Thu, 9 Nov 2006 14:29:32 -0800
Message-ID: <1163523e0611091429x4725fbc8p563201285d8b1371@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:56971 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1424201AbWKIW3d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 17:29:33 -0500
Received: by wx-out-0506.google.com with SMTP id h27so314612wxd
        for <linux-ide@vger.kernel.org>; Thu, 09 Nov 2006 14:29:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm not sure if this will make it to the list or be filtered out (I'm
not a list member), but I am having what looks like a very similar
problem to Mark Hatle with NVRAID on 2.6.18 (fc6). My machine is
working for a number of hours and then has some kind of disk problem
(so far, it has been mostly when I leave in the evening). My log file
is below. Please cc any responses to me at jcohen@llnl.gov. Thanks!

Jon

Nov  8 16:04:27 foo syslogd 1.4.1: restart.
Nov  8 16:04:27 foo kernel: klogd 1.4.1, log source = /proc/kmsg started.
Nov  8 16:04:27 foo kernel: Linux version 2.6.18-1.2798.fc6PAE
(brewbuilder@hs20-bc2-4.build.redhat.com) (gcc version 4.1.1 20061011
(Red Hat 4.1.1-30)) #1 SMP Mon Oct 16 14:54:22 EDT 2006
Nov  8 16:04:27 foo kernel: BIOS-provided physical RAM map:
Nov  8 16:04:27 foo kernel:  BIOS-e820: 0000000000000000 -
000000000009d000 (usable)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 0000000000100000 -
000000009fdecc00 (usable)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 000000009fdecc00 -
000000009fdeec00 (ACPI NVS)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 000000009fdeec00 -
000000009fdf0c00 (ACPI data)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 000000009fdf0c00 -
00000000a0000000 (reserved)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 00000000e0000000 -
00000000f0000000 (reserved)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 00000000fec00000 -
00000000fed00000 (reserved)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 00000000fee00000 -
00000000fef00000 (reserved)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 00000000ffb00000 -
0000000100000000 (reserved)
Nov  8 16:04:27 foo kernel:  BIOS-e820: 0000000100000000 -
0000000160000000 (usable)
Nov  8 16:04:27 foo kernel: 4736MB HIGHMEM available.
Nov  8 16:04:27 foo kernel: 896MB LOWMEM available.
Nov  8 16:04:27 foo kernel: found SMP MP-table at 000fe710
Nov  8 16:04:27 foo kernel: NX (Execute Disable) protection: active
Nov  8 16:04:27 foo kernel: DMI 2.3 present.
Nov  8 16:04:27 foo kernel: Using APIC driver default
Nov  8 16:04:27 foo kernel: ACPI: PM-Timer IO Port: 0x4008
Nov  8 16:04:27 foo kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Nov  8 16:04:27 foo kernel: Processor #0 15:6 APIC version 20
Nov  8 16:04:27 foo kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Nov  8 16:04:27 foo kernel: Processor #1 15:6 APIC version 20
Nov  8 16:04:27 foo kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] disabled)
Nov  8 16:04:27 foo kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
Nov  8 16:04:27 foo kernel: ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
Nov  8 16:04:27 foo kernel: ACPI: LAPIC (acpi_id[0x06] lapic_id[0x01] disabled)
Nov  8 16:04:27 foo kernel: ACPI: LAPIC (acpi_id[0x07] lapic_id[0x02] disabled)
Nov  8 16:04:27 foo kernel: ACPI: LAPIC (acpi_id[0x08] lapic_id[0x03] disabled)
Nov  8 16:04:27 foo kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
Nov  8 16:04:27 foo kernel: ACPI: IOAPIC (id[0x08] address[0xfec00000]
gsi_base[0])
Nov  8 16:04:27 foo kernel: IOAPIC[0]: apic_id 8, version 17, address
0xfec00000, GSI 0-23
Nov  8 16:04:27 foo kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
Nov  8 16:04:27 foo kernel: ACPI: BIOS IRQ0 pin2 override ignored.
Nov  8 16:04:27 foo kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 high level)
Nov  8 16:04:27 foo kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Nov  8 16:04:27 foo kernel: Using ACPI (MADT) for SMP configuration information
Nov  8 16:04:27 foo kernel: Allocating PCI resources starting at
a4000000 (gap: a0000000:40000000)
Nov  8 16:04:27 foo kernel: Detected 2993.312 MHz processor.
Nov  8 16:04:27 foo kernel: Built 1 zonelists.  Total pages: 1441792
Nov  8 16:04:27 foo kernel: Kernel command line: ro
root=/dev/VolGroup00/LogVol00 rhgb quiet
Nov  8 16:04:27 foo kernel: Enabling fast FPU save and restore... done.
Nov  8 16:04:27 foo kernel: Enabling unmasked SIMD FPU exception
support... done.
Nov  8 16:04:27 foo kernel: Initializing CPU#0
Nov  8 16:04:27 foo kernel: CPU 0 irqstacks, hard=c07ad000 soft=c078d000
Nov  8 16:04:27 foo kernel: PID hash table entries: 4096 (order: 12,
16384 bytes)
Nov  8 16:04:27 foo kernel: Console: colour VGA+ 80x25
Nov  8 16:04:27 foo kernel: Dentry cache hash table entries: 131072
(order: 7, 524288 bytes)
Nov  8 16:04:27 foo kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Nov  8 16:04:27 foo kernel: Memory: 4138148k/5767168k available (2135k
kernel code, 52676k reserved, 862k data, 244k init, 3274672k highmem)
Nov  8 16:04:27 foo kernel: Checking if this processor honours the WP
bit even in supervisor mode... Ok.
Nov  8 16:04:27 foo kernel: Calibrating delay using timer specific
routine.. 5992.02 BogoMIPS (lpj=11984051)
Nov  8 16:04:27 foo kernel: Security Framework v1.0.0 initialized
Nov  8 16:04:27 foo kernel: SELinux:  Initializing.
Nov  8 16:04:27 foo kernel: SELinux:  Starting in permissive mode
Nov  8 16:04:27 foo kernel: selinux_register_security:  Registering
secondary module capability
Nov  8 16:04:27 foo kernel: Capability LSM initialized as secondary
Nov  8 16:04:27 foo kernel: Mount-cache hash table entries: 512
Nov  8 16:04:27 foo kernel: monitor/mwait feature present.
Nov  8 16:04:27 foo kernel: using mwait in idle threads.
Nov  8 16:04:27 foo kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Nov  8 16:04:27 foo kernel: CPU: L2 cache: 2048K
Nov  8 16:04:27 foo kernel: CPU: Physical Processor ID: 0
Nov  8 16:04:27 foo kernel: CPU: Processor Core ID: 0
Nov  8 16:04:27 foo kernel: Intel machine check architecture supported.
Nov  8 16:04:27 foo kernel: Intel machine check reporting enabled on CPU#0.
Nov  8 16:04:27 foo kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Nov  8 16:04:27 foo kernel: CPU0: Thermal monitoring enabled
Nov  8 16:04:27 foo kernel: Checking 'hlt' instruction... OK.
Nov  8 16:04:27 foo kernel: SMP alternatives: switching to UP code
Nov  8 16:04:27 foo kernel: ACPI: Core revision 20060707
Nov  8 16:04:27 foo kernel: CPU0: Intel(R) Pentium(R) D CPU 3.00GHz stepping 04
Nov  8 16:04:27 foo kernel: SMP alternatives: switching to SMP code
Nov  8 16:04:27 foo kernel: Booting processor 1/1 eip 3000
Nov  8 16:04:27 foo kernel: CPU 1 irqstacks, hard=c07ae000 soft=c078e000
Nov  8 16:04:27 foo kernel: Initializing CPU#1
Nov  8 16:04:27 foo kernel: Calibrating delay using timer specific
routine.. 5986.38 BogoMIPS (lpj=11972768)
Nov  8 16:04:27 foo kernel: monitor/mwait feature present.
Nov  8 16:04:27 foo kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Nov  8 16:04:27 foo kernel: CPU: L2 cache: 2048K
Nov  8 16:04:27 foo kernel: CPU: Physical Processor ID: 0
Nov  8 16:04:27 foo kernel: CPU: Processor Core ID: 1
Nov  8 16:04:27 foo kernel: Intel machine check architecture supported.
Nov  8 16:04:27 foo kernel: Intel machine check reporting enabled on CPU#1.
Nov  8 16:04:27 foo kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
Nov  8 16:04:27 foo kernel: CPU1: Thermal monitoring enabled
Nov  8 16:04:27 foo kernel: CPU1: Intel(R) Pentium(R) D CPU 3.00GHz stepping 04
Nov  8 16:04:27 foo kernel: Total of 2 processors activated (11978.40 BogoMIPS).
Nov  8 16:04:27 foo kernel: ENABLING IO-APIC IRQs
Nov  8 16:04:27 foo kernel: ..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
Nov  8 16:04:27 foo kernel: checking TSC synchronization across 2 CPUs: passed.
Nov  8 16:04:27 foo kernel: Brought up 2 CPUs
Nov  8 16:04:27 foo kernel: migration_cost=1257
Nov  8 16:04:27 foo kernel: checking if image is initramfs... it is
Nov  8 16:04:27 foo kernel: Freeing initrd memory: 2278k freed
Nov  8 16:04:27 foo kernel: NET: Registered protocol family 16
Nov  8 16:04:27 foo kernel: ACPI: bus type pci registered
Nov  8 16:04:27 foo kernel: PCI: Using MMCONFIG
Nov  8 16:04:27 foo kernel: Setting up standard PCI resources
Nov  8 16:04:27 foo kernel: ACPI: Interpreter enabled
Nov  8 16:04:27 foo kernel: ACPI: Using IOAPIC for interrupt routing
Nov  8 16:04:27 foo kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Nov  8 16:04:27 foo kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK00] (IRQs 3 4
5 6 7 9 10 *11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK01] (IRQs 3 4
5 6 7 *9 10 11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK02] (IRQs 3 4
5 6 7 9 *10 11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK03] (IRQs 3 4
5 6 7 9 10 11 12 15) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK04] (IRQs 3 4
5 6 7 9 10 *11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK05] (IRQs 3 4
5 6 7 *9 10 11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK06] (IRQs 3 4
5 6 7 9 *10 11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK07] (IRQs 3 4
5 6 7 9 10 11 12 15) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK12] (IRQs 3 4
5 6 7 *9 10 11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK13] (IRQs 3 4
5 6 7 9 *10 11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK14] (IRQs 3 4
5 6 7 9 10 11 12 15) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK16] (IRQs 3 4
5 6 7 9 10 *11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK17] (IRQs 3 4
5 6 7 9 10 *11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK20] (IRQs 3 4
5 6 7 9 *10 11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK23] (IRQs 3 4
5 6 7 *9 10 11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK26] (IRQs 3 4
5 6 7 9 10 11 12 15) *14
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [LK27] (IRQs 3 4
5 6 7 9 10 *11 12 15)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP00] (IRQs 16)
*0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP01] (IRQs 17)
*0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP02] (IRQs 18)
*0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP03] (IRQs 19)
*0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP04] (IRQs 16)
*0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP05] (IRQs 17)
*0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP06] (IRQs 18)
*0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP07] (IRQs 19)
*0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP12] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP13] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP14] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP16] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP17] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP20] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP23] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP26] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP27] (IRQs 20
21 22 23) *0, disabled.
Nov  8 16:04:27 foo kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Nov  8 16:04:27 foo kernel: pnp: PnP ACPI init
Nov  8 16:04:27 foo kernel: pnp: PnP ACPI: found 10 devices
Nov  8 16:04:27 foo kernel: usbcore: registered new driver usbfs
Nov  8 16:04:27 foo kernel: usbcore: registered new driver hub
Nov  8 16:04:27 foo kernel: PCI: Using ACPI for IRQ routing
Nov  8 16:04:27 foo kernel: PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
Nov  8 16:04:27 foo kernel: NetLabel: Initializing
Nov  8 16:04:27 foo kernel: NetLabel:  domain hash size = 128
Nov  8 16:04:27 foo kernel: NetLabel:  protocols = UNLABELED CIPSOv4
Nov  8 16:04:27 foo kernel: NetLabel:  unlabeled traffic allowed by default
Nov  8 16:04:27 foo kernel: pnp: 00:01: ioport range 0x800-0x87f has
been reserved
Nov  8 16:04:27 foo kernel: pnp: 00:01: ioport range 0x4000-0x407f
could not be reserved
Nov  8 16:04:27 foo kernel: pnp: 00:01: ioport range 0x4080-0x40ff has
been reserved
Nov  8 16:04:27 foo kernel: PCI: Bridge: 0000:00:02.0
Nov  8 16:04:27 foo kernel:   IO window: d000-dfff
Nov  8 16:04:27 foo kernel:   MEM window: dd000000-dfefffff
Nov  8 16:04:27 foo kernel:   PREFETCH window: a0000000-afffffff
Nov  8 16:04:27 foo kernel: PCI: Bridge: 0000:00:04.0
Nov  8 16:04:27 foo kernel:   IO window: disabled.
Nov  8 16:04:27 foo kernel:   MEM window: disabled.
Nov  8 16:04:27 foo kernel:   PREFETCH window: disabled.
Nov  8 16:04:27 foo kernel: PCI: Bridge: 0000:00:05.0
Nov  8 16:04:27 foo kernel:   IO window: disabled.
Nov  8 16:04:27 foo kernel:   MEM window: dcf00000-dcffffff
Nov  8 16:04:27 foo kernel:   PREFETCH window: disabled.
Nov  8 16:04:27 foo kernel: PCI: Bridge: 0000:00:0f.0
Nov  8 16:04:27 foo kernel:   IO window: c000-cfff
Nov  8 16:04:27 foo kernel:   MEM window: dce00000-dcefffff
Nov  8 16:04:27 foo kernel:   PREFETCH window: b0000000-b0ffffff
Nov  8 16:04:27 foo kernel: PCI: Bridge: 0000:00:13.0
Nov  8 16:04:27 foo kernel:   IO window: disabled.
Nov  8 16:04:27 foo kernel:   MEM window: disabled.
Nov  8 16:04:27 foo kernel:   PREFETCH window: disabled.
Nov  8 16:04:27 foo kernel: PCI: Bridge: 0000:00:18.0
Nov  8 16:04:27 foo kernel:   IO window: b000-bfff
Nov  8 16:04:27 foo kernel:   MEM window: da000000-dcdfffff
Nov  8 16:04:27 foo kernel:   PREFETCH window: b1000000-cfffffff
Nov  8 16:04:27 foo kernel: NET: Registered protocol family 2
Nov  8 16:04:27 foo kernel: IP route cache hash table entries: 32768
(order: 5, 131072 bytes)
Nov  8 16:04:27 foo kernel: TCP established hash table entries: 131072
(order: 9, 2621440 bytes)
Nov  8 16:04:27 foo kernel: TCP bind hash table entries: 65536 (order:
8, 1310720 bytes)
Nov  8 16:04:27 foo kernel: TCP: Hash tables configured (established
131072 bind 65536)
Nov  8 16:04:27 foo kernel: TCP reno registered
Nov  8 16:04:27 foo kernel: Simple Boot Flag at 0x7a set to 0x1
Nov  8 16:04:27 foo kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16ac)
Nov  8 16:04:27 foo kernel: apm: disabled - APM is not SMP safe.
Nov  8 16:04:27 foo kernel: audit: initializing netlink socket (disabled)
Nov  8 16:04:27 foo kernel: audit(1163001829.876:1): initialized
Nov  8 16:04:27 foo kernel: highmem bounce pool size: 64 pages
Nov  8 16:04:27 foo kernel: Total HugeTLB memory allocated, 0
Nov  8 16:04:27 foo kernel: VFS: Disk quotas dquot_6.5.1
Nov  8 16:04:27 foo kernel: Dquot-cache hash table entries: 1024
(order 0, 4096 bytes)
Nov  8 16:04:27 foo kernel: SELinux:  Registering netfilter hooks
Nov  8 16:04:27 foo kernel: Initializing Cryptographic API
Nov  8 16:04:27 foo kernel: ksign: Installing public key data
Nov  8 16:04:27 foo kernel: Loading keyring
Nov  8 16:04:27 foo kernel: - Added public key 8BDC589434DBC709
Nov  8 16:04:27 foo kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)
Nov  8 16:04:27 foo kernel: io scheduler noop registered
Nov  8 16:04:27 foo kernel: io scheduler anticipatory registered
Nov  8 16:04:27 foo kernel: io scheduler deadline registered
Nov  8 16:04:27 foo kernel: io scheduler cfq registered (default)
Nov  8 16:04:27 foo kernel: pcie_portdrv_probe->Dev[007e:10de] has
invalid IRQ. Check vendor BIOS
Nov  8 16:04:27 foo kernel: assign_interrupt_mode Found MSI capability
Nov  8 16:04:27 foo kernel: pcie_portdrv_probe->Dev[007e:10de] has
invalid IRQ. Check vendor BIOS
Nov  8 16:04:27 foo kernel: assign_interrupt_mode Found MSI capability
Nov  8 16:04:27 foo kernel: pcie_portdrv_probe->Dev[007e:10de] has
invalid IRQ. Check vendor BIOS
Nov  8 16:04:27 foo kernel: assign_interrupt_mode Found MSI capability
Nov  8 16:04:27 foo kernel: pcie_portdrv_probe->Dev[0376:10de] has
invalid IRQ. Check vendor BIOS
Nov  8 16:04:27 foo kernel: assign_interrupt_mode Found MSI capability
Nov  8 16:04:27 foo kernel: pcie_portdrv_probe->Dev[0377:10de] has
invalid IRQ. Check vendor BIOS
Nov  8 16:04:27 foo kernel: assign_interrupt_mode Found MSI capability
Nov  8 16:04:27 foo kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Nov  8 16:04:27 foo kernel: ACPI Exception (acpi_processor-0681):
AE_NOT_FOUND, Processor Device is not present [20060707]
Nov  8 16:04:27 foo kernel: ACPI: Getting cpuindex for acpiid 0x3
Nov  8 16:04:27 foo kernel: ACPI Exception (acpi_processor-0681):
AE_NOT_FOUND, Processor Device is not present [20060707]
Nov  8 16:04:27 foo kernel: ACPI: Getting cpuindex for acpiid 0x4
Nov  8 16:04:27 foo kernel: isapnp: Scanning for PnP cards...
Nov  8 16:04:27 foo kernel: isapnp: No Plug & Play device found
Nov  8 16:04:27 foo kernel: Real Time Clock Driver v1.12ac
Nov  8 16:04:27 foo kernel: Non-volatile memory driver v1.2
Nov  8 16:04:27 foo kernel: Linux agpgart interface v0.101 (c) Dave Jones
Nov  8 16:04:27 foo kernel: Serial: 8250/16550 driver $Revision: 1.90
$ 4 ports, IRQ sharing enabled
Nov  8 16:04:27 foo kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov  8 16:04:27 foo kernel: 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov  8 16:04:27 foo kernel: RAMDISK driver initialized: 16 RAM disks
of 16384K size 4096 blocksize
Nov  8 16:04:27 foo kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Nov  8 16:04:27 foo kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Nov  8 16:04:27 foo kernel: NFORCE-MCP55: IDE controller at PCI slot
0000:00:0d.0
Nov  8 16:04:27 foo kernel: NFORCE-MCP55: chipset revision 161
Nov  8 16:04:27 foo kernel: NFORCE-MCP55: not 100% native mode: will
probe irqs later
Nov  8 16:04:27 foo kernel: NFORCE-MCP55: 0000:00:0d.0 (rev a1)
UDMA133 controller
Nov  8 16:04:27 foo kernel:     ide0: BM-DMA at 0xecf0-0xecf7, BIOS
settings: hda:pio, hdb:pio
Nov  8 16:04:27 foo kernel: ide-floppy driver 0.99.newide
Nov  8 16:04:27 foo kernel: usbcore: registered new driver libusual
Nov  8 16:04:27 foo kernel: usbcore: registered new driver hiddev
Nov  8 16:04:27 foo kernel: usbcore: registered new driver usbhid
Nov  8 16:04:27 foo kernel: drivers/usb/input/hid-core.c: v2.6:USB HID
core driver
Nov  8 16:04:27 foo kernel: PNP: No PS/2 controller found. Probing
ports directly.
Nov  8 16:04:27 foo kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov  8 16:04:27 foo kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov  8 16:04:27 foo kernel: mice: PS/2 mouse device common for all mice
Nov  8 16:04:27 foo kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
Nov  8 16:04:27 foo kernel: md: bitmap version 4.39
Nov  8 16:04:27 foo kernel: TCP bic registered
Nov  8 16:04:27 foo kernel: Initializing IPsec netlink socket
Nov  8 16:04:27 foo kernel: NET: Registered protocol family 1
Nov  8 16:04:27 foo kernel: NET: Registered protocol family 17
Nov  8 16:04:27 foo kernel: Using IPI No-Shortcut mode
Nov  8 16:04:27 foo kernel: ACPI: (supports S0 S1 S3 S4 S5)
Nov  8 16:04:27 foo kernel: Time: tsc clocksource has been installed.
Nov  8 16:04:27 foo kernel: Freeing unused kernel memory: 244k freed
Nov  8 16:04:27 foo rpc.statd[2354]: Version 1.0.9 Starting
Nov  8 16:04:27 foo kernel: Write protecting the kernel read-only data: 385k
Nov  8 16:04:27 foo kernel: USB Universal Host Controller Interface driver v3.0
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP20] enabled at IRQ 23
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] ->
Link [AP20] -> GSI 23 (level, low) -> IRQ 225
Nov  8 16:04:27 foo kernel: ohci_hcd 0000:00:0b.0: OHCI Host Controller
Nov  8 16:04:27 foo kernel: ohci_hcd 0000:00:0b.0: new USB bus
registered, assigned bus number 1
Nov  8 16:04:27 foo kernel: ohci_hcd 0000:00:0b.0: irq 225, io mem 0xdfff8000
Nov  8 16:04:27 foo kernel: usb usb1: configuration #1 chosen from 1 choice
Nov  8 16:04:27 foo kernel: hub 1-0:1.0: USB hub found
Nov  8 16:04:27 foo kernel: hub 1-0:1.0: 10 ports detected
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP13] enabled at IRQ 22
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:00:0b.1[B] ->
Link [AP13] -> GSI 22 (level, low) -> IRQ 233
Nov  8 16:04:27 foo kernel: ehci_hcd 0000:00:0b.1: EHCI Host Controller
Nov  8 16:04:27 foo kernel: ehci_hcd 0000:00:0b.1: new USB bus
registered, assigned bus number 2
Nov  8 16:04:27 foo kernel: ehci_hcd 0000:00:0b.1: debug port 1
Nov  8 16:04:27 foo kernel: ehci_hcd 0000:00:0b.1: irq 233, io mem 0xdfff7f00
Nov  8 16:04:27 foo kernel: ehci_hcd 0000:00:0b.1: USB 2.0 started,
EHCI 1.00, driver 10 Dec 2004
Nov  8 16:04:27 foo rpc.statd[2354]: statd running as root. chown
/var/lib/nfs/statd/sm to choose different user
Nov  8 16:04:27 foo kernel: usb usb2: configuration #1 chosen from 1 choice
Nov  8 16:04:27 foo kernel: hub 2-0:1.0: USB hub found
Nov  8 16:04:27 foo kernel: hub 2-0:1.0: 10 ports detected
Nov  8 16:04:27 foo kernel: SCSI subsystem initialized
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP17] enabled at IRQ 21
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:00:0e.0[A] ->
Link [AP17] -> GSI 21 (level, low) -> IRQ 50
Nov  8 16:04:27 foo kernel: ata1: SATA max UDMA/133 cmd 0xFE00 ctl
0xFE12 bmdma 0xFEC0 irq 50
Nov  8 16:04:27 foo kernel: ata2: SATA max UDMA/133 cmd 0xFE20 ctl
0xFE32 bmdma 0xFEC8 irq 50
Nov  8 16:04:27 foo kernel: scsi0 : sata_nv
Nov  8 16:04:27 foo kernel: ata1: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Nov  8 16:04:27 foo kernel: ata1.00: ATA-7, max UDMA/133, 976773168
sectors: LBA48 NCQ (depth 0/32)
Nov  8 16:04:27 foo kernel: ata1.00: ata1: dev 0 multi count 16
Nov  8 16:04:27 foo kernel: ata1.00: configured for UDMA/133
Nov  8 16:04:27 foo kernel: scsi1 : sata_nv
Nov  8 16:04:27 foo kernel: usb 2-10: new high speed USB device using
ehci_hcd and address 3
Nov  8 16:04:27 foo kernel: usb 2-10: configuration #1 chosen from 1 choice
Nov  8 16:04:27 foo kernel: libusual: modprobe for usb-storage
succeeded, but module is not present
Nov  8 16:04:27 foo kernel: ata2: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Nov  8 16:04:27 foo kernel: ata2.00: ATA-7, max UDMA/133, 976773168
sectors: LBA48 NCQ (depth 0/32)
Nov  8 16:04:27 foo kernel: ata2.00: ata2: dev 0 multi count 16
Nov  8 16:04:27 foo kernel: ata2.00: configured for UDMA/133
Nov  8 16:04:27 foo kernel:   Vendor: ATA       Model: ST3500641AS
  Rev: 3.AD
Nov  8 16:04:27 foo kernel:   Type:   Direct-Access
  ANSI SCSI revision: 05
Nov  8 16:04:27 foo kernel: SCSI device sda: 976773168 512-byte hdwr
sectors (500108 MB)
Nov  8 16:04:27 foo kernel: sda: Write Protect is off
Nov  8 16:04:27 foo kernel: SCSI device sda: drive cache: write back
Nov  8 16:04:27 foo kernel: SCSI device sda: 976773168 512-byte hdwr
sectors (500108 MB)
Nov  8 16:04:27 foo kernel: sda: Write Protect is off
Nov  8 16:04:27 foo kernel: SCSI device sda: drive cache: write back
Nov  8 16:04:27 foo kernel:  sda: sda1 sda2 sda3
Nov  8 16:04:27 foo kernel:  sda: p3 exceeds device capacity
Nov  8 16:04:27 foo kernel: sd 0:0:0:0: Attached scsi disk sda
Nov  8 16:04:27 foo kernel:   Vendor: ATA       Model: ST3500641AS
  Rev: 3.AD
Nov  8 16:04:27 foo kernel:   Type:   Direct-Access
  ANSI SCSI revision: 05
Nov  8 16:04:27 foo kernel: SCSI device sdb: 976773168 512-byte hdwr
sectors (500108 MB)
Nov  8 16:04:27 foo kernel: sdb: Write Protect is off
Nov  8 16:04:27 foo kernel: SCSI device sdb: drive cache: write back
Nov  8 16:04:27 foo kernel: SCSI device sdb: 976773168 512-byte hdwr
sectors (500108 MB)
Nov  8 16:04:27 foo kernel: sdb: Write Protect is off
Nov  8 16:04:27 foo kernel: SCSI device sdb: drive cache: write back
Nov  8 16:04:27 foo kernel:  sdb: unknown partition table
Nov  8 16:04:27 foo kernel: sd 1:0:0:0: Attached scsi disk sdb
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP16] enabled at IRQ 20
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:00:0e.1[B] ->
Link [AP16] -> GSI 20 (level, low) -> IRQ 58
Nov  8 16:04:27 foo kernel: ata3: SATA max UDMA/133 cmd 0xFE40 ctl
0xFE52 bmdma 0xFED0 irq 58
Nov  8 16:04:27 foo kernel: ata4: SATA max UDMA/133 cmd 0xFE60 ctl
0xFE72 bmdma 0xFED8 irq 58
Nov  8 16:04:27 foo kernel: scsi2 : sata_nv
Nov  8 16:04:27 foo kernel: usb 1-3: new full speed USB device using
ohci_hcd and address 2
Nov  8 16:04:27 foo kernel: usb 1-3: configuration #1 chosen from 1 choice
Nov  8 16:04:27 foo kernel: hub 1-3:1.0: USB hub found
Nov  8 16:04:27 foo kernel: hub 1-3:1.0: 4 ports detected
Nov  8 16:04:27 foo kernel: ata3: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Nov  8 16:04:27 foo kernel: usb 1-3.1: new full speed USB device using
ohci_hcd and address 3
Nov  8 16:04:27 foo kernel: ata3.00: ATAPI, max UDMA/100
Nov  8 16:04:27 foo kernel: usb 1-3.1: configuration #1 chosen from 1 choice
Nov  8 16:04:27 foo kernel: hub 1-3.1:1.0: USB hub found
Nov  8 16:04:27 foo kernel: hub 1-3.1:1.0: 4 ports detected
Nov  8 16:04:27 foo kernel: ata3.00: configured for UDMA/100
Nov  8 16:04:27 foo kernel: scsi3 : sata_nv
Nov  8 16:04:27 foo kernel: usb 1-3.2: new low speed USB device using
ohci_hcd and address 4
Nov  8 16:04:27 foo kernel: usb 1-3.2: configuration #1 chosen from 1 choice
Nov  8 16:04:27 foo kernel: input: Belkin Components Belkin OmniView
KVM Switch as /class/input/input0
Nov  8 16:04:27 foo kernel: input: USB HID v1.00 Keyboard [Belkin
Components Belkin OmniView KVM Switch] on usb-0000:00:0b.0-3.2
Nov  8 16:04:27 foo kernel: input: Belkin Components Belkin OmniView
KVM Switch as /class/input/input1
Nov  8 16:04:27 foo kernel: input: USB HID v1.00 Mouse [Belkin
Components Belkin OmniView KVM Switch] on usb-0000:00:0b.0-3.2
Nov  8 16:04:27 foo kernel: ata4: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Nov  8 16:04:27 foo kernel: usb 1-3.1.1: new low speed USB device
using ohci_hcd and address 5
Nov  8 16:04:27 foo kernel: ata4.00: ATAPI, max UDMA/33
Nov  8 16:04:27 foo kernel: usb 1-3.1.1: configuration #1 chosen from 1 choice
Nov  8 16:04:27 foo kernel: input: Logitech USB-PS/2 Optical Mouse as
/class/input/input2
Nov  8 16:04:27 foo kernel: input: USB HID v1.10 Mouse [Logitech
USB-PS/2 Optical Mouse] on usb-0000:00:0b.0-3.1.1
Nov  8 16:04:27 foo kernel: ata4.00: configured for UDMA/33
Nov  8 16:04:27 foo kernel:   Vendor: SONY      Model: CDRWDVD CRX310S
  Rev: VDK2
Nov  8 16:04:27 foo kernel:   Type:   CD-ROM
  ANSI SCSI revision: 05
Nov  8 16:04:27 foo kernel:   Vendor: TSSTcorp  Model: DVD+-RW
TS-H553A  Rev: DE03
Nov  8 16:04:27 foo kernel:   Type:   CD-ROM
  ANSI SCSI revision: 05
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP27] enabled at IRQ 23
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:00:0e.2[C] ->
Link [AP27] -> GSI 23 (level, low) -> IRQ 225
Nov  8 16:04:27 foo kernel: ata5: SATA max UDMA/133 cmd 0xFE80 ctl
0xFE92 bmdma 0xFEF0 irq 225
Nov  8 16:04:27 foo kernel: ata6: SATA max UDMA/133 cmd 0xFEA0 ctl
0xFEB2 bmdma 0xFEF8 irq 225
Nov  8 16:04:27 foo kernel: scsi4 : sata_nv
Nov  8 16:04:27 foo kernel: ata5: SATA link down (SStatus 0 SControl 300)
Nov  8 16:04:27 foo kernel: ATA: abnormal status 0x7F on port 0xFE87
Nov  8 16:04:27 foo kernel: scsi5 : sata_nv
Nov  8 16:04:27 foo kernel: ata6: SATA link down (SStatus 0 SControl 300)
Nov  8 16:04:27 foo kernel: ATA: abnormal status 0x7F on port 0xFEA7
Nov  8 16:04:27 foo kernel: Initializing USB Mass Storage driver...
Nov  8 16:04:27 foo kernel: scsi6 : SCSI emulation for USB Mass Storage devices
Nov  8 16:04:27 foo kernel: usbcore: registered new driver usb-storage
Nov  8 16:04:27 foo kernel: USB Mass Storage support registered.
Nov  8 16:04:27 foo kernel:   Vendor: TEAC      Model: USB   HS-CF
Card  Rev: 4.00
Nov  8 16:04:27 foo kernel:   Type:   Direct-Access
  ANSI SCSI revision: 00
Nov  8 16:04:27 foo kernel: sd 6:0:0:0: Attached scsi removable disk sdc
Nov  8 16:04:27 foo kernel:   Vendor: TEAC      Model: USB   HS-xD/SM
  Rev: 4.00
Nov  8 16:04:27 foo kernel:   Type:   Direct-Access
  ANSI SCSI revision: 00
Nov  8 16:04:27 foo kernel: sd 6:0:0:1: Attached scsi removable disk sdd
Nov  8 16:04:27 foo kernel:   Vendor: TEAC      Model: USB   HS-MS
Card  Rev: 4.00
Nov  8 16:04:27 foo kernel:   Type:   Direct-Access
  ANSI SCSI revision: 00
Nov  8 16:04:27 foo kernel: sd 6:0:0:2: Attached scsi removable disk sde
Nov  8 16:04:27 foo kernel:   Vendor: TEAC      Model: USB   HS-SD
Card  Rev: 4.00
Nov  8 16:04:27 foo kernel:   Type:   Direct-Access
  ANSI SCSI revision: 00
Nov  8 16:04:27 foo kernel: sd 6:0:0:3: Attached scsi removable disk sdf
Nov  8 16:04:27 foo kernel: device-mapper: ioctl: 4.7.0-ioctl
(2006-06-24) initialised: dm-devel@redhat.com
Nov  8 16:04:27 foo kernel: kjournald starting.  Commit interval 5 seconds
Nov  8 16:04:27 foo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov  8 16:04:27 foo kernel: SELinux:  Disabled at runtime.
Nov  8 16:04:27 foo kernel: SELinux:  Unregistering netfilter hooks
Nov  8 16:04:27 foo kernel: audit(1163001845.085:2): selinux=0 auid=4294967295
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP02] enabled at IRQ 18
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:04:0a.0[A] ->
Link [AP02] -> GSI 18 (level, low) -> IRQ 66
Nov  8 16:04:27 foo kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI):
IRQ=[66]  MMIO=[dceeb800-dceebfff]  Max Packet=[2048]  IR/IT
contexts=[4/8]
Nov  8 16:04:27 foo kernel: input: PC Speaker as /class/input/input3
Nov  8 16:04:27 foo kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
Nov  8 16:04:27 foo kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
Nov  8 16:04:27 foo kernel: tg3.c:v3.65 (August 07, 2006)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP06] enabled at IRQ 18
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:03:00.0[A] ->
Link [AP06] -> GSI 18 (level, low) -> IRQ 66
Nov  8 16:04:27 foo kernel: eth0: Tigon3 [partno(BCM95751) rev 4201
PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:18:8b:13:e8:9f
Nov  8 16:04:27 foo kernel: eth0: RXcsums[1] LinkChgREG[1] MIirq[1]
ASF[0] Split[0] WireSpeed[1] TSOcap[1]
Nov  8 16:04:27 foo kernel: eth0: dma_rwctrl[76180000] dma_mask[64-bit]
Nov  8 16:04:27 foo kernel: Floppy drive(s): fd0 is 1.44M
Nov  8 16:04:27 foo kernel: FDC 0 is a post-1991 82077
Nov  8 16:04:27 foo kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Nov  8 16:04:27 foo kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Nov  8 16:04:27 foo kernel: scsi 2:0:0:0: Attached scsi generic sg2 type 5
Nov  8 16:04:27 foo kernel: scsi 3:0:0:0: Attached scsi generic sg3 type 5
Nov  8 16:04:27 foo kernel: sd 6:0:0:0: Attached scsi generic sg4 type 0
Nov  8 16:04:27 foo kernel: sd 6:0:0:1: Attached scsi generic sg5 type 0
Nov  8 16:04:27 foo kernel: sd 6:0:0:2: Attached scsi generic sg6 type 0
Nov  8 16:04:27 foo kernel: sd 6:0:0:3: Attached scsi generic sg7 type 0
Nov  8 16:04:27 foo kernel: nvidia: module license 'NVIDIA' taints kernel.
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP04] enabled at IRQ 16
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:01:00.0[A] ->
Link [AP04] -> GSI 16 (level, low) -> IRQ 74
Nov  8 16:04:27 foo kernel: PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:06:00.0[A] ->
Link [AP04] -> GSI 16 (level, low) -> IRQ 74
Nov  8 16:04:27 foo kernel: NVRM: loading NVIDIA Linux x86 Kernel
Module  1.0-8776  Mon Oct 16 21:56:04 PDT 2006
Nov  8 16:04:27 foo kernel: sr0: scsi3-mmc drive: 0x/48x writer cd/rw
xa/form2 cdda tray
Nov  8 16:04:27 foo kernel: Uniform CD-ROM driver Revision: 3.20
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt Link [AP23] enabled at IRQ 22
Nov  8 16:04:27 foo kernel: ACPI: PCI Interrupt 0000:00:0f.1[B] ->
Link [AP23] -> GSI 22 (level, low) -> IRQ 233
Nov  8 16:04:27 foo kernel: sr1: scsi3-mmc drive: 48x/48x writer cd/rw
xa/form2 cdda tray
Nov  8 16:04:27 foo kernel: hda_codec: num_steps = 0 for NID=0x17
Nov  8 16:04:27 foo last message repeated 8 times
Nov  8 16:04:27 foo kernel: lp: driver loaded but no devices found
Nov  8 16:04:27 foo kernel: NET: Registered protocol family 10
Nov  8 16:04:27 foo kernel: lo: Disabled Privacy Extensions
Nov  8 16:04:27 foo kernel: IPv6 over IPv4 tunneling driver
Nov  8 16:04:27 foo kernel: ACPI: Power Button (FF) [PWRF]
Nov  8 16:04:27 foo kernel: ACPI: Power Button (CM) [VBTN]
Nov  8 16:04:27 foo kernel: ibm_acpi: ec object not found
Nov  8 16:04:27 foo kernel: md: Autodetecting RAID arrays.
Nov  8 16:04:27 foo kernel: md: autorun ...
Nov  8 16:04:27 foo kernel: md: ... autorun DONE.
Nov  8 16:04:27 foo kernel: device-mapper: multipath: version 1.0.4 loaded
Nov  8 16:04:27 foo kernel: EXT3 FS on dm-4, internal journal
Nov  8 16:04:27 foo kernel: kjournald starting.  Commit interval 5 seconds
Nov  8 16:04:27 foo kernel: EXT3 FS on dm-1, internal journal
Nov  8 16:04:27 foo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov  8 16:04:27 foo kernel: Adding 4194296k swap on
/dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:4194296k
Nov  8 16:04:27 foo kernel: ip6_tables: (C) 2000-2006 Netfilter Core Team
Nov  8 16:04:27 foo kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Nov  8 16:04:27 foo kernel: Netfilter messages via NETLINK v0.30.
Nov  8 16:04:27 foo kernel: ip_conntrack version 2.4 (8192 buckets,
65536 max) - 228 bytes per conntrack
Nov  8 16:04:27 foo kernel: ADDRCONF(NETDEV_UP): eth0: link is not ready
Nov  8 16:04:27 foo kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Nov  8 16:04:27 foo kernel: tg3: eth0: Flow control is on for TX and on for RX.
Nov  8 16:04:27 foo kernel: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Nov  8 16:04:27 foo hcid[2410]: Bluetooth HCI daemon
Nov  8 16:04:27 foo kernel: Bluetooth: Core ver 2.10
Nov  8 16:04:27 foo kernel: NET: Registered protocol family 31
Nov  8 16:04:27 foo kernel: Bluetooth: HCI device and connection
manager initialized
Nov  8 16:04:27 foo kernel: Bluetooth: HCI socket layer initialized
Nov  8 16:04:28 foo kernel: Bluetooth: L2CAP ver 2.8
Nov  8 16:04:28 foo kernel: Bluetooth: L2CAP socket layer initialized
Nov  8 16:04:28 foo kernel: Bluetooth: RFCOMM socket layer initialized
Nov  8 16:04:28 foo kernel: Bluetooth: RFCOMM TTY layer initialized
Nov  8 16:04:28 foo kernel: Bluetooth: RFCOMM ver 1.8
Nov  8 16:04:28 foo sdpd[2416]: Bluetooth SDP daemon
Nov  8 16:04:28 foo hcid[2410]: Register path:/org/bluez fallback:1
Nov  8 16:04:28 foo pcscd: pcscdaemon.c:464:main() pcsc-lite 1.3.1 daemon ready.
Nov  8 16:04:28 foo kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Nov  8 16:04:28 foo hidd[2500]: Bluetooth HID daemon
Nov  8 16:04:28 foo automount[2520]: lookup_read_master:
lookup(nisplus): couldn't locat nis+ table auto.master
Nov  8 16:04:28 foo hpiod: 1.6.10 accepting connections at 2208...
Nov  8 16:04:30 foo ntpd[2592]: ntpd 4.2.2p1@1.1570-o Fri Aug 18
13:04:14 UTC 2006 (1)
Nov  8 16:04:30 foo ntpd[2593]: precision = 1.000 usec
Nov  8 16:04:30 foo ntpd[2593]: Listening on interface wildcard,
0.0.0.0#123 Disabled
Nov  8 16:04:30 foo ntpd[2593]: Listening on interface wildcard, ::#123 Disabled
Nov  8 16:04:30 foo ntpd[2593]: Listening on interface lo, ::1#123 Enabled
Nov  8 16:04:30 foo ntpd[2593]: Listening on interface eth0,
foo::foo:foo:foo:foo#123 Enabled
Nov  8 16:04:30 foo ntpd[2593]: Listening on interface lo, 127.0.0.1#123 Enabled
Nov  8 16:04:30 foo ntpd[2593]: Listening on interface eth0,
foo.foo.foo.foo#123 Enabled
Nov  8 16:04:30 foo ntpd[2593]: kernel time sync status 0040
Nov  8 16:04:30 foo gpm[2604]: *** info [startup.c(95)]:
Nov  8 16:04:30 foo gpm[2604]: Started gpm successfully. Entered daemon mode.
Nov  8 16:04:31 foo ntpd[2593]: frequency initialized 101.209 PPM from
/var/lib/ntp/drift
Nov  8 16:04:35 foo avahi-daemon[2714]: Found user 'avahi' (UID 70)
and group 'avahi' (GID 70).
Nov  8 16:04:35 foo avahi-daemon[2714]: Successfully dropped root privileges.
Nov  8 16:04:35 foo avahi-daemon[2714]: avahi-daemon 0.6.11 starting up.
Nov  8 16:04:35 foo avahi-daemon[2714]: WARNING: No NSS support for
mDNS detected, consider installing nss-mdns!
Nov  8 16:04:35 foo avahi-daemon[2714]: Successfully called chroot().
Nov  8 16:04:35 foo avahi-daemon[2714]: Successfully dropped remaining
capabilities.
Nov  8 16:04:35 foo avahi-daemon[2714]: No service found in /etc/avahi/services.
Nov  8 16:04:35 foo avahi-daemon[2714]: New relevant interface
eth0.IPv6 for mDNS.
Nov  8 16:04:35 foo avahi-daemon[2714]: Joining mDNS multicast group
on interface eth0.IPv6 with address fe80::218:8bff:fe13:e89f.
Nov  8 16:04:35 foo avahi-daemon[2714]: New relevant interface
eth0.IPv4 for mDNS.
Nov  8 16:04:35 foo avahi-daemon[2714]: Joining mDNS multicast group
on interface eth0.IPv4 with address 134.9.214.96.
Nov  8 16:04:35 foo avahi-daemon[2714]: Network interface enumeration completed.
Nov  8 16:04:35 foo avahi-daemon[2714]: Registering new address record
for foo::foo:foo:foo:foo on eth0.
Nov  8 16:04:35 foo avahi-daemon[2714]: Registering new address record
for foo.foo.foo.foo on eth0.
Nov  8 16:04:35 foo avahi-daemon[2714]: Registering HINFO record with
values 'I686'/'LINUX'.
Nov  8 16:04:36 foo avahi-daemon[2714]: Server startup complete. Host
name is foo.local. Local service cookie is 2813546616.
Nov  8 16:04:42 foo smartd[2836]: smartd version 5.36
[i686-redhat-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Nov  8 16:04:42 foo smartd[2836]: Home page is
http://smartmontools.sourceforge.net/
Nov  8 16:04:42 foo smartd[2836]: Opened configuration file /etc/smartd.conf
Nov  8 16:04:42 foo smartd[2836]: Configuration file /etc/smartd.conf parsed.
Nov  8 16:04:42 foo smartd[2836]: Device: /dev/sda, opened
Nov  8 16:04:42 foo smartd[2836]: Device: /dev/sda, not found in
smartd database.
Nov  8 16:04:43 foo smartd[2836]: Device: /dev/sda, is SMART capable.
Adding to "monitor" list.
Nov  8 16:04:43 foo smartd[2836]: Device: /dev/sdb, opened
Nov  8 16:04:43 foo smartd[2836]: Device: /dev/sdb, not found in
smartd database.
Nov  8 16:04:43 foo smartd[2836]: Device: /dev/sdb, is SMART capable.
Adding to "monitor" list.
Nov  8 16:04:43 foo smartd[2836]: Monitoring 2 ATA and 0 SCSI devices
Nov  8 16:04:43 foo smartd[2838]: smartd has fork()ed into background
mode. New PID=2838.
Nov  8 16:04:43 foo init: open(/dev/pts/0): No such file or directory
Nov  8 16:04:43 foo last message repeated 3 times
Nov  8 16:04:44 foo pcscd: winscard.c:219:SCardConnect() Reader E-Gate
0 0 Not Found
Nov  8 16:04:44 foo last message repeated 3 times
Nov  8 16:04:54 foo gconfd (root-3033): starting (version 2.14.0), pid
3033 user 'root'
Nov  8 16:04:54 foo gconfd (root-3033): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only
configuration source at position 0
Nov  8 16:04:54 foo gconfd (root-3033): Resolved address
"xml:readwrite:/root/.gconf" to a writable configuration source at
position 1
Nov  8 16:04:54 foo gconfd (root-3033): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only
configuration source at position 2
Nov  8 16:04:55 foo kernel: hda_codec: num_steps = 0 for NID=0x17
Nov  8 16:04:56 foo hcid[2410]: Default passkey agent (:1.7,
/org/bluez/applet) registered
Nov  8 16:04:56 foo gconfd (root-3033): Resolved address
"xml:readwrite:/root/.gconf" to a writable configuration source at
position 0
Nov  8 16:04:56 foo pcscd: winscard.c:219:SCardConnect() Reader E-Gate
0 0 Not Found
Nov  8 16:04:56 foo last message repeated 4 times
Nov  8 16:05:07 foo kernel: hda_codec: num_steps = 0 for NID=0x17
Nov  8 16:07:49 foo ntpd[2593]: synchronized to LOCAL(0), stratum 10
Nov  8 16:07:49 foo ntpd[2593]: kernel time sync enabled 0001
Nov  8 16:08:54 foo ntpd[2593]: synchronized to 193.120.142.71, stratum 1
Nov  8 16:21:54 foo Installed: yum-versionlock.noarch 1.0.1-1.fc6
Nov  8 16:21:54 foo Installed: yum-kernel-module.noarch 1.0.1-1.fc6
Nov  8 16:21:54 foo Installed: yum-tsflags.noarch 1.0.1-1.fc6
Nov  8 16:21:54 foo Installed: yum-priorities.noarch 1.0.1-1.fc6
Nov  8 16:21:54 foo Installed: yum-downloadonly.noarch 1.0.1-1.fc6
Nov  8 16:21:55 foo Installed: yum-protectbase.noarch 1.0.1-1.fc6
Nov  8 16:21:55 foo Installed: yum-skip-broken.noarch 1.0.1-1.fc6
Nov  8 16:21:55 foo Installed: yum-updateonboot.noarch 1.0.1-1.fc6
Nov  8 16:21:55 foo Installed: yum-allowdowngrade.noarch 1.0.1-1.fc6
Nov  8 16:21:55 foo Installed: yum-fedorakmod.noarch 1.0.1-1.fc6
Nov  8 16:21:55 foo Installed: yum-changelog.noarch 1.0.1-1.fc6
Nov  8 16:21:56 foo Installed: yum-utils.noarch 1.0.1-1.fc6
Nov  8 16:21:56 foo Installed: yum-fastestmirror.noarch 1.0.1-1.fc6
Nov  8 16:29:22 foo ntpd[2593]: time reset -0.484751 s
Nov  8 16:33:11 foo ntpd[2593]: synchronized to LOCAL(0), stratum 10
Nov  8 16:34:15 foo ntpd[2593]: synchronized to 193.120.142.71, stratum 1
Nov  8 16:47:16 foo kernel: usb 1-3.1: USB disconnect, address 3
Nov  8 16:47:16 foo kernel: usb 1-3.1.1: USB disconnect, address 5
Nov  8 16:48:44 foo kernel: usb 1-3.1: new full speed USB device using
ohci_hcd and address 6
Nov  8 16:48:45 foo kernel: usb 1-3.1: configuration #1 chosen from 1 choice
Nov  8 16:48:45 foo kernel: hub 1-3.1:1.0: USB hub found
Nov  8 16:48:45 foo kernel: hub 1-3.1:1.0: 4 ports detected
Nov  8 16:48:45 foo kernel: usb 1-3.1.1: new low speed USB device
using ohci_hcd and address 7
Nov  8 16:48:45 foo kernel: usb 1-3.1.1: configuration #1 chosen from 1 choice
Nov  8 16:48:45 foo kernel: input: Logitech USB-PS/2 Optical Mouse as
/class/input/input4
Nov  8 16:48:45 foo kernel: input: USB HID v1.10 Mouse [Logitech
USB-PS/2 Optical Mouse] on usb-0000:00:0b.0-3.1.1
Nov  8 16:50:56 foo kernel: usb 1-3.1: USB disconnect, address 6
Nov  8 16:50:56 foo kernel: usb 1-3.1.1: USB disconnect, address 7
Nov  8 17:07:55 foo kernel: ata3.00: qc timeout (cmd 0xa0)
Nov  8 17:07:55 foo kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Nov  8 17:07:55 foo kernel: ata3.00: tag 0 cmd 0xa0 Emask 0x5 stat
0x51 err 0x20 (timeout)
Nov  8 17:07:55 foo kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Nov  8 17:07:55 foo kernel: ata4.00: tag 0 cmd 0xa0 Emask 0x4 stat
0x40 err 0x0 (timeout)
Nov  8 17:07:55 foo kernel: ata3: soft resetting port
Nov  8 17:07:56 foo kernel: ata3: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Nov  8 17:07:56 foo kernel: ata4: soft resetting port
Nov  8 17:07:56 foo kernel: ata4: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Nov  8 17:08:26 foo kernel: ata3.00: qc timeout (cmd 0xa1)
Nov  8 17:08:26 foo kernel: ata3.00: failed to IDENTIFY (I/O error,
err_mask=0x4)
Nov  8 17:08:26 foo kernel: ata3.00: revalidation failed (errno=-5)
Nov  8 17:08:26 foo kernel: ata3: failed to recover some devices,
retrying in 5 secs
Nov  8 17:08:26 foo kernel: ata4.00: qc timeout (cmd 0xa1)
Nov  8 17:08:26 foo kernel: ata4.00: failed to IDENTIFY (I/O error,
err_mask=0x4)
Nov  8 17:08:26 foo kernel: ata4.00: revalidation failed (errno=-5)
Nov  8 17:08:26 foo kernel: ata4: failed to recover some devices,
retrying in 5 secs
Nov  8 17:08:31 foo kernel: ata3: hard resetting port
Nov  8 17:08:31 foo kernel: ata4: hard resetting port
Nov  8 17:08:31 foo kernel: ata3: SRST failed (status 0xFF)
Nov  8 17:08:31 foo kernel: ata3: SRST failed (err_mask=0x100)
Nov  8 17:08:31 foo kernel: ata3: follow-up softreset failed, retrying in 5 secs
Nov  8 17:08:31 foo kernel: ata4: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Nov  8 17:08:36 foo kernel: ata3: hard resetting port
Nov  8 17:08:37 foo kernel: ata3: SRST failed (status 0xFF)
Nov  8 17:08:37 foo kernel: ata3: SRST failed (err_mask=0x100)
Nov  8 17:08:37 foo kernel: ata3: follow-up softreset failed, retrying in 5 secs
Nov  8 17:08:42 foo kernel: ata3: hard resetting port
Nov  8 17:08:42 foo kernel: ata3: SRST failed (status 0xFF)
Nov  8 17:08:42 foo kernel: ata3: SRST failed (err_mask=0x100)
Nov  8 17:08:42 foo kernel: ata3: reset failed, giving up
Nov  8 17:08:42 foo kernel: ata3.00: disabled
Nov  8 17:08:42 foo kernel: ata3: EH complete
Nov  8 17:09:02 foo kernel: ata4.00: qc timeout (cmd 0xa1)
Nov  8 17:09:02 foo kernel: ata4.00: failed to IDENTIFY (I/O error,
err_mask=0x4)
Nov  8 17:09:02 foo kernel: ata4.00: revalidation failed (errno=-5)
Nov  8 17:09:02 foo kernel: ata4: failed to recover some devices,
retrying in 5 secs
Nov  8 17:09:07 foo kernel: ata4: hard resetting port
Nov  8 17:09:07 foo kernel: ata4: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Nov  8 17:09:37 foo kernel: ata4.00: qc timeout (cmd 0xa1)
Nov  8 17:09:37 foo kernel: ata4.00: failed to IDENTIFY (I/O error,
err_mask=0x4)
Nov  8 17:09:37 foo kernel: ata4.00: revalidation failed (errno=-5)
Nov  8 17:09:37 foo kernel: ata4.00: disabled
Nov  8 17:09:38 foo kernel: ata4: EH complete
Nov  8 17:10:03 foo kernel: usb 1-3.1: new full speed USB device using
ohci_hcd and address 8
Nov  8 17:10:03 foo kernel: usb 1-3.1: configuration #1 chosen from 1 choice
Nov  8 17:10:03 foo kernel: hub 1-3.1:1.0: USB hub found
Nov  8 17:10:03 foo kernel: hub 1-3.1:1.0: 4 ports detected
Nov  8 17:10:04 foo kernel: usb 1-3.1.1: new low speed USB device
using ohci_hcd and address 9
Nov  8 17:10:04 foo kernel: usb 1-3.1.1: configuration #1 chosen from 1 choice
Nov  8 17:10:04 foo kernel: input: Logitech USB-PS/2 Optical Mouse as
/class/input/input5
Nov  8 17:10:04 foo kernel: input: USB HID v1.10 Mouse [Logitech
USB-PS/2 Optical Mouse] on usb-0000:00:0b.0-3.1.1
Nov  8 19:47:22 foo kernel: usb 2-10: reset high speed USB device
using ehci_hcd and address 3
Nov  8 19:47:33 foo kernel: usb 2-10: device not accepting address 3, error -110
Nov  8 19:47:33 foo kernel: usb 2-10: reset high speed USB device
using ehci_hcd and address 3
Nov  8 19:47:45 foo kernel: usb 2-10: device not accepting address 3, error -110
Nov  8 19:47:45 foo kernel: usb 2-10: reset high speed USB device
using ehci_hcd and address 3
Nov  8 19:47:55 foo kernel: usb 2-10: device not accepting address 3, error -110
Nov  8 19:47:55 foo kernel: usb 2-10: reset high speed USB device
using ehci_hcd and address 3
Nov  8 19:48:06 foo kernel: usb 2-10: device not accepting address 3, error -110
Nov  8 19:48:06 foo kernel: sd 6:0:0:2: scsi: Device offlined - not
ready after error recovery
Nov  8 19:48:06 foo kernel: usb 2-10: USB disconnect, address 3
Nov  8 19:48:06 foo kernel: sdd : READ CAPACITY failed.
Nov  8 19:48:06 foo kernel: sdd : status=0, message=00, host=7, driver=00
Nov  8 19:48:06 foo kernel: sdd : sense not available.
Nov  8 19:48:06 foo kernel: sdd: Write Protect is off
Nov  8 19:48:06 foo kernel: sdd: assuming drive cache: write through
Nov  8 19:48:06 foo kernel: sdd : READ CAPACITY failed.
Nov  8 19:48:06 foo kernel: sdd : status=0, message=00, host=7, driver=00
Nov  8 19:48:06 foo kernel: sdd : sense not available.
Nov  8 19:48:06 foo kernel: sdd: Write Protect is off
Nov  8 19:48:06 foo kernel: sdd: assuming drive cache: write through
Nov  8 19:48:06 foo kernel:  sdd:<3>Buffer I/O error on device sdd,
logical block 0
Nov  8 19:48:06 foo kernel: Buffer I/O error on device sdd, logical block 0
Nov  8 19:48:06 foo kernel: Buffer I/O error on device sdd, logical block 0
Nov  8 19:48:06 foo kernel:  unable to read partition table
Nov  8 19:48:06 foo kernel: scsi 6:0:0:0: rejecting I/O to dead device
Nov  8 19:48:06 foo last message repeated 3 times
Nov  8 19:48:06 foo kernel: sdc : READ CAPACITY failed.
Nov  8 19:48:06 foo kernel: sdc : status=0, message=00, host=1, driver=00
Nov  8 19:48:06 foo kernel: sdc : sense not available.
Nov  8 19:48:06 foo kernel: scsi 6:0:0:0: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: sdc: Write Protect is off
Nov  8 19:48:06 foo kernel: sdc: assuming drive cache: write through
Nov  8 19:48:06 foo kernel: scsi 6:0:0:0: rejecting I/O to dead device
Nov  8 19:48:06 foo last message repeated 4 times
Nov  8 19:48:06 foo kernel: sdc : READ CAPACITY failed.
Nov  8 19:48:06 foo kernel: sdc : status=0, message=00, host=1, driver=00
Nov  8 19:48:06 foo kernel: sdc : sense not available.
Nov  8 19:48:06 foo kernel: scsi 6:0:0:0: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: sdc: Write Protect is off
Nov  8 19:48:06 foo kernel: sdc: assuming drive cache: write through
Nov  8 19:48:06 foo kernel:  sdc:<3>scsi 6:0:0:0: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: Buffer I/O error on device sdc, logical block 0
Nov  8 19:48:06 foo kernel: scsi 6:0:0:0: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: Buffer I/O error on device sdc, logical block 0
Nov  8 19:48:06 foo kernel: scsi 6:0:0:0: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: Buffer I/O error on device sdc, logical block 0
Nov  8 19:48:06 foo kernel:  unable to read partition table
Nov  8 19:48:06 foo kernel: scsi 6:0:0:0: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: scsi 6:0:0:3: rejecting I/O to dead device
Nov  8 19:48:06 foo last message repeated 3 times
Nov  8 19:48:06 foo kernel: sdf : READ CAPACITY failed.
Nov  8 19:48:06 foo kernel: sdf : status=0, message=00, host=1, driver=00
Nov  8 19:48:06 foo kernel: sdf : sense not available.
Nov  8 19:48:06 foo kernel: scsi 6:0:0:3: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: sdf: Write Protect is off
Nov  8 19:48:06 foo kernel: sdf: assuming drive cache: write through
Nov  8 19:48:06 foo kernel: scsi 6:0:0:3: rejecting I/O to dead device
Nov  8 19:48:06 foo last message repeated 4 times
Nov  8 19:48:06 foo kernel: sdf : READ CAPACITY failed.
Nov  8 19:48:06 foo kernel: sdf : status=0, message=00, host=1, driver=00
Nov  8 19:48:06 foo kernel: sdf : sense not available.
Nov  8 19:48:06 foo kernel: scsi 6:0:0:3: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: sdf: Write Protect is off
Nov  8 19:48:06 foo kernel: sdf: assuming drive cache: write through
Nov  8 19:48:06 foo kernel:  sdf:<3>scsi 6:0:0:3: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: Buffer I/O error on device sdf, logical block 0
Nov  8 19:48:06 foo kernel: scsi 6:0:0:3: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: Buffer I/O error on device sdf, logical block 0
Nov  8 19:48:06 foo kernel: scsi 6:0:0:3: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: Buffer I/O error on device sdf, logical block 0
Nov  8 19:48:06 foo kernel:  unable to read partition table
Nov  8 19:48:06 foo kernel: scsi 6:0:0:3: rejecting I/O to dead device
Nov  8 19:48:06 foo kernel: usb 2-10: new high speed USB device using
ehci_hcd and address 4
Nov  8 19:48:17 foo kernel: usb 2-10: device not accepting address 4, error -110
Nov  8 19:48:18 foo kernel: usb 2-10: new high speed USB device using
ehci_hcd and address 5
Nov  8 19:48:29 foo kernel: usb 2-10: device not accepting address 5, error -110
Nov  8 19:48:29 foo kernel: usb 2-10: new high speed USB device using
ehci_hcd and address 6
Nov  8 19:48:40 foo kernel: usb 2-10: device not accepting address 6, error -110
Nov  8 19:48:40 foo kernel: usb 2-10: new high speed USB device using
ehci_hcd and address 7
Nov  8 19:48:50 foo kernel: usb 2-10: device not accepting address 7, error -110
