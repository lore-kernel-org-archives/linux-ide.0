From: Gavin Cameron <gavin@gavsworld.net>
Subject: Re: libata problems
Date: Mon, 18 Aug 2008 23:03:03 +0100
Message-ID: <48A9F197.4080706@gavsworld.net>
References: <4880BDCD.4030104@gavsworld.net> <4892CDED.6080302@kernel.org> <4898BD4F.90709@gavsworld.net> <4898F11D.1080902@kernel.org> <4899EE03.3060204@gavsworld.net> <48A2AA73.6010901@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010206070405070005070702"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pih-relay05.plus.net ([212.159.14.18]:49291 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777AbYHRWDL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Aug 2008 18:03:11 -0400
In-Reply-To: <48A2AA73.6010901@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010206070405070005070702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks again for following up on this and sorry for the delay in 
responding as I've not been at home for about a week.

Anyway, I did as you ask ...

Tejun Heo wrote:
> (please don't drop linux-ide, use reply-to-all)
> 
> Gavin Cameron wrote:
>> Tejun Heo wrote:
>>> Hmmm... looks like configuration went well but media presence polling is
>>> causing the problem.  "hal-disable-polling /dev/sr0" will disable the
>>> polling.  Can you please do that and see whether the drive is usable?
>> [root@picard ~]# hal-disable-polling --device /dev/sr0
>> Polling for drive /dev/sr0 have been disabled. The fdi file written was
>>
>> /etc/hal/fdi/information/media-check-disable-storage_model_DVD_A__DH20A3P.fdi
> 
> Okay.
> 
>> Inserted CD into drive: drive light came on for about 20 seconds, but
>> nothing happened.
>>
>> Checked /var/log/messages and nothing there.
>>
>> Left it sitting there for 5 minutes or so and checked /var/log/messages
>> again and still nothing there.
> 
> As media presence polling is disabled, the system won't notice whether
> the media has changed or not.


I re-enabled hal on the CD drive by changing the file:
/etc/hal/fdi/information/media-check-disable-storage_model_DVD_A__DH20A3P.fdi
so that it read:
<merge key="storage.media_check_enabled" type="bool">true</merge>


> 
>> Mounted the CD as root:
>> [root@picard ~]# mkdir /mnt/cdrom
>> [root@picard ~]# mount -t iso9660 /dev/sr0 /mnt/cdrom/
>> mount: block device /dev/sr0 is write-protected, mounting read-only
>>
>> The command took about 1 minute to complete. I was then able to browse
>> the CD, however each change of directory took approximately 10 seconds
>> to read.
> 
> Hmmm...
> 
>> I then ejected the CD:
>> [root@picard ~]# eject /dev/sr0
>>
>> again, this took about 20 seconds to eject the CD.
>>
>> After the eject, still nothing in /var/log/messages.
>>
>> Tried inserting and ejecting another couple of times.
>>
>> I verified that the CD was readable in my external CD drive and then put
>> the CD back into the main drive and started writing up the results so far.
>>
>> As I've been typing, the drive has been spinning up and down several
>> times and this time when I checked /var/log/messages I found what is
>> attached.
>>
>> Is there anything else I can provide in order for you to find the problem?
> 
> Can you please try kernel parameter "libata.force=2.00:udma33" and then
> "libata.force=2.00:pio4"?  Depending on which distro you're on and
> whether libata is built into the kernel or not, you'll need to use
> different method to actually get the parameter passed to libata.
> 
> Thanks.
> 

List of modules currently loaded are in the attached file.

You'll find the attached /var/log/messages output from both experiments. 
What I ended up doing (not sure if it's right, but I can't see any error 
messages) was to add the lines to /etc/stsctl.conf which appears to be 
the way that Fedora 9 takes care of parameters like that. I've also 
attached that file too. However, I didn't see any file called 
/proc/sys/libata/force so I'm not entirely sure that it worked. Perhaps 
I need "kernel." or something before libata? (I'm not a kernel 
developer, so forgive my lack of knowledge on this matter)

What happened both times was that the disc was read initially ok - I'm 
sure I recall it doing this before, but only if a CD is inserted very 
quickly after booting up and loggin on.

Anyway, when I removed the CD and waited a while before inserting it 
again, the same thing happened as before.

Both experiments were with kernel 2.6.25.14 which is the latest one on 
the Fedora 9 distribution. I chose this as 2.6.26.1 didn't do anything 
different last time, but it also didn't have a lot of modules that my 
machine requires.

Anyway, I eagerly await your response.

Best regards,
Gavin.

--------------010206070405070005070702
Content-Type: text/plain;
 name="messages-2.6.25.14-force_pio4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages-2.6.25.14-force_pio4.txt"

Aug 18 22:04:19 picard kernel: imklog 3.18.1, log source = /proc/kmsg started.
Aug 18 22:04:19 picard kernel: Initializing cgroup subsys cpuset
Aug 18 22:04:19 picard kernel: Linux version 2.6.25.14-108.fc9.x86_64 (mockbuild@) (gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC) ) #1 SMP Mon Aug 4 13:46:35 EDT 2008
Aug 18 22:04:19 picard kernel: Command line: ro root=/dev/sda5 rhgb quiet pci=noacpi
Aug 18 22:04:19 picard kernel: BIOS-provided physical RAM map:
Aug 18 22:04:19 picard kernel: BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 18 22:04:19 picard kernel: BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 18 22:04:19 picard kernel: BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Aug 18 22:04:19 picard kernel: BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
Aug 18 22:04:19 picard kernel: BIOS-e820: 000000007ffb0000 - 000000007ffbe000 (ACPI data)
Aug 18 22:04:19 picard kernel: BIOS-e820: 000000007ffbe000 - 000000007ffe0000 (ACPI NVS)
Aug 18 22:04:19 picard kernel: BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
Aug 18 22:04:19 picard kernel: BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 18 22:04:19 picard kernel: BIOS-e820: 00000000fecc0000 - 00000000fecc1000 (reserved)
Aug 18 22:04:19 picard kernel: BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
Aug 18 22:04:19 picard kernel: end_pfn_map = 1048576
Aug 18 22:04:19 picard kernel: DMI present.
Aug 18 22:04:19 picard kernel: ACPI: RSDP 000FA960, 0024 (r2 ACPIAM)
Aug 18 22:04:19 picard kernel: ACPI: XSDT 7FFB0100, 0054 (r1 A_M_I_ OEMXSDT   2000821 MSFT       97)
Aug 18 22:04:19 picard kernel: ACPI: FACP 7FFB0290, 00F4 (r3 A_M_I_ OEMFACP   2000821 MSFT       97)
Aug 18 22:04:19 picard kernel: ACPI: DSDT 7FFB05C0, 4E3F (r1  A0498 A0498000        0 INTL 20060113)
Aug 18 22:04:19 picard kernel: ACPI: FACS 7FFBE000, 0040
Aug 18 22:04:19 picard kernel: ACPI: APIC 7FFB0390, 0068 (r1 A_M_I_ OEMAPIC   2000821 MSFT       97)
Aug 18 22:04:19 picard kernel: ACPI: MCFG 7FFB0400, 003C (r1 A_M_I_ OEMMCFG   2000821 MSFT       97)
Aug 18 22:04:19 picard kernel: ACPI: OEMB 7FFBE040, 0060 (r1 A_M_I_ AMI_OEM   2000821 MSFT       97)
Aug 18 22:04:19 picard kernel: ACPI: HPET 7FFB5400, 0038 (r1 A_M_I_ OEMHPET   2000821 MSFT       97)
Aug 18 22:04:19 picard kernel: ACPI: SSDT 7FFB5440, 030E (r1 A_M_I_ POWERNOW        1 AMD         1)
Aug 18 22:04:19 picard kernel: Scanning NUMA topology in Northbridge 24
Aug 18 22:04:19 picard kernel: No NUMA configuration found
Aug 18 22:04:19 picard kernel: Faking a node at 0000000000000000-000000007ffb0000
Aug 18 22:04:19 picard kernel: Bootmem setup node 0 0000000000000000-000000007ffb0000
Aug 18 22:04:19 picard kernel:  NODE_DATA [000000000000c000 - 0000000000013fff]
Aug 18 22:04:19 picard kernel:  bootmap [0000000000014000 -  0000000000023ff7] pages 10
Aug 18 22:04:19 picard kernel: early res: 0 [0-fff] BIOS data page
Aug 18 22:04:19 picard kernel: early res: 1 [6000-7fff] SMP_TRAMPOLINE
Aug 18 22:04:19 picard kernel: early res: 2 [200000-75223b] TEXT DATA BSS
Aug 18 22:04:19 picard kernel: early res: 3 [37d18000-37fef5c6] RAMDISK
Aug 18 22:04:19 picard kernel: early res: 4 [9fc00-a0bff] EBDA
Aug 18 22:04:19 picard kernel: early res: 5 [8000-bfff] PGTABLE
Aug 18 22:04:19 picard kernel: Zone PFN ranges:
Aug 18 22:04:19 picard kernel:  DMA             0 ->     4096
Aug 18 22:04:19 picard kernel:  DMA32        4096 ->  1048576
Aug 18 22:04:19 picard kernel:  Normal    1048576 ->  1048576
Aug 18 22:04:19 picard kernel: Movable zone start PFN for each node
Aug 18 22:04:19 picard kernel: early_node_map[2] active PFN ranges
Aug 18 22:04:19 picard kernel:    0:        0 ->      159
Aug 18 22:04:19 picard kernel:    0:      256 ->   524208
Aug 18 22:04:19 picard kernel: Detected use of extended apic ids on hypertransport bus
Aug 18 22:04:19 picard kernel: ACPI: PM-Timer IO Port: 0x808
Aug 18 22:04:19 picard kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Aug 18 22:04:19 picard kernel: Processor #0 (Bootup-CPU)
Aug 18 22:04:19 picard kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Aug 18 22:04:19 picard kernel: Processor #1
Aug 18 22:04:19 picard kernel: ACPI: HPET id: 0x11068201 base: 0xfed00000
Aug 18 22:04:19 picard kernel: Using ACPI for processor (LAPIC) configuration information
Aug 18 22:04:19 picard kernel: Intel MultiProcessor Specification v1.4
Aug 18 22:04:19 picard kernel: MPTABLE: OEM ID: TEMPLATE MPTABLE: Product ID:  MPTABLE: APIC at: 0xFEE00000
Aug 18 22:04:19 picard kernel: I/O APIC #2 at 0xFEC00000.
Aug 18 22:04:19 picard kernel: I/O APIC #3 at 0xFECC0000.
Aug 18 22:04:19 picard kernel: Setting APIC routing to flat
Aug 18 22:04:19 picard kernel: Processors: 2
Aug 18 22:04:19 picard kernel: PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
Aug 18 22:04:19 picard kernel: PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
Aug 18 22:04:19 picard kernel: PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
Aug 18 22:04:19 picard kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Aug 18 22:04:19 picard kernel: SMP: Allowing 2 CPUs, 0 hotplug CPUs
Aug 18 22:04:19 picard kernel: PERCPU: Allocating 42688 bytes of per cpu data
Aug 18 22:04:19 picard kernel: Built 1 zonelists in Node order, mobility grouping on.  Total pages: 515573
Aug 18 22:04:19 picard kernel: Policy zone: DMA32
Aug 18 22:04:19 picard kernel: Kernel command line: ro root=/dev/sda5 rhgb quiet pci=noacpi
Aug 18 22:04:19 picard kernel: Initializing CPU#0
Aug 18 22:04:19 picard kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Aug 18 22:04:19 picard kernel: Extended CMOS year: 2000
Aug 18 22:04:19 picard kernel: TSC calibrated against PM_TIMER
Aug 18 22:04:19 picard kernel: Marking TSC unstable due to TSCs unsynchronized
Aug 18 22:04:19 picard kernel: time.c: Detected 2999.648 MHz processor.
Aug 18 22:04:19 picard kernel: Console: colour VGA+ 80x25
Aug 18 22:04:19 picard kernel: console [tty0] enabled
Aug 18 22:04:19 picard kernel: Checking aperture...
Aug 18 22:04:19 picard kernel: Node 0: aperture @ 17b8000000 size 32 MB
Aug 18 22:04:19 picard kernel: Aperture beyond 4GB. Ignoring.
Aug 18 22:04:19 picard kernel: No AGP bridge found
Aug 18 22:04:19 picard kernel: Memory: 2059016k/2096832k available (2629k kernel code, 37428k reserved, 1382k data, 352k init)
Aug 18 22:04:19 picard kernel: SLUB: Genslabs=13, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Aug 18 22:04:19 picard kernel: Calibrating delay using timer specific routine.. 6001.72 BogoMIPS (lpj=3000861)
Aug 18 22:04:19 picard kernel: Security Framework initialized
Aug 18 22:04:19 picard kernel: SELinux:  Initializing.
Aug 18 22:04:19 picard kernel: selinux_register_security:  Registering secondary module capability
Aug 18 22:04:19 picard kernel: Capability LSM initialized as secondary
Aug 18 22:04:19 picard kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Aug 18 22:04:19 picard kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Aug 18 22:04:19 picard kernel: Mount-cache hash table entries: 256
Aug 18 22:04:19 picard kernel: Initializing cgroup subsys ns
Aug 18 22:04:19 picard kernel: Initializing cgroup subsys cpuacct
Aug 18 22:04:19 picard kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 18 22:04:19 picard kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Aug 18 22:04:19 picard kernel: CPU 0/0 -> Node 0
Aug 18 22:04:19 picard kernel: CPU: Physical Processor ID: 0
Aug 18 22:04:19 picard kernel: CPU: Processor Core ID: 0
Aug 18 22:04:19 picard kernel: ACPI: Core revision 20070126
Aug 18 22:04:19 picard kernel: ACPI: setting ELCR to 0e28 (from 0c28)
Aug 18 22:04:19 picard kernel: Using local APIC timer interrupts.
Aug 18 22:04:19 picard kernel: Detected 12.498 MHz APIC timer.
Aug 18 22:04:19 picard kernel: Booting processor 1/2 APIC 0x1
Aug 18 22:04:19 picard kernel: Initializing CPU#1
Aug 18 22:04:19 picard kernel: Calibrating delay using timer specific routine.. 5999.16 BogoMIPS (lpj=2999583)
Aug 18 22:04:19 picard kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 18 22:04:19 picard kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Aug 18 22:04:19 picard kernel: CPU 1/1 -> Node 0
Aug 18 22:04:19 picard kernel: CPU: Physical Processor ID: 0
Aug 18 22:04:19 picard kernel: CPU: Processor Core ID: 1
Aug 18 22:04:19 picard kernel: AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ stepping 03
Aug 18 22:04:19 picard kernel: Brought up 2 CPUs
Aug 18 22:04:19 picard kernel: net_namespace: 1016 bytes
Aug 18 22:04:19 picard kernel: Time: 21:03:43  Date: 08/18/08
Aug 18 22:04:19 picard kernel: NET: Registered protocol family 16
Aug 18 22:04:19 picard kernel: No dock devices found.
Aug 18 22:04:19 picard kernel: ACPI: bus type pci registered
Aug 18 22:04:19 picard kernel: PCI: Using configuration type 1
Aug 18 22:04:19 picard kernel: ACPI: Interpreter enabled
Aug 18 22:04:19 picard kernel: ACPI: (supports S0 S1 S3 S4 S5)
Aug 18 22:04:19 picard kernel: ACPI: Using PIC for interrupt routing
Aug 18 22:04:19 picard kernel: ACPI: Error attaching device data
Aug 18 22:04:19 picard kernel: ACPI: Error attaching device data
Aug 18 22:04:19 picard kernel: ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  A5, should be 98 [20070126]
Aug 18 22:04:19 picard kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 18 22:04:19 picard kernel: pnp: PnP ACPI init
Aug 18 22:04:19 picard kernel: ACPI: bus type pnp registered
Aug 18 22:04:19 picard kernel: pnp: PnP ACPI: found 17 devices
Aug 18 22:04:19 picard kernel: ACPI: ACPI bus type pnp unregistered
Aug 18 22:04:19 picard kernel: usbcore: registered new interface driver usbfs
Aug 18 22:04:19 picard kernel: usbcore: registered new interface driver hub
Aug 18 22:04:19 picard kernel: usbcore: registered new device driver usb
Aug 18 22:04:19 picard kernel: PCI: Probing PCI hardware
Aug 18 22:04:19 picard kernel: PCI: Transparent bridge - 0000:00:13.1
Aug 18 22:04:19 picard kernel: PCI: Using IRQ router default [1106/3337] at 0000:00:11.0
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 27
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:03.0[A] -> IRQ 31
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:03.1[B] -> IRQ 35
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:03.2[C] -> IRQ 39
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:03.3[D] -> IRQ 43
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:10.0[A] -> IRQ 20
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:10.1[B] -> IRQ 22
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:10.2[C] -> IRQ 21
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:10.3[D] -> IRQ 23
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:00:10.4[C] -> IRQ 21
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 24
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:04:00.0[A] -> IRQ 36
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:80:01.0[A] -> IRQ 17
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:07:06.0[A] -> IRQ 16
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:07:07.0[A] -> IRQ 17
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:07:07.1[B] -> IRQ 18
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:07:07.2[C] -> IRQ 19
Aug 18 22:04:19 picard kernel: PCI->APIC IRQ transform: 0000:07:08.0[A] -> IRQ 18
Aug 18 22:04:19 picard kernel: NetLabel: Initializing
Aug 18 22:04:19 picard kernel: NetLabel:  domain hash size = 128
Aug 18 22:04:19 picard kernel: NetLabel:  protocols = UNLABELED CIPSOv4
Aug 18 22:04:19 picard kernel: NetLabel:  unlabeled traffic allowed by default
Aug 18 22:04:19 picard kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Aug 18 22:04:19 picard kernel: hpet0: 3 32-bit timers, 14318180 Hz
Aug 18 22:04:19 picard kernel: ACPI: RTC can wake from S4
Aug 18 22:04:19 picard kernel: system 00:06: ioport range 0xc00-0xc0f has been reserved
Aug 18 22:04:19 picard kernel: system 00:06: ioport range 0xd00-0xd0f has been reserved
Aug 18 22:04:19 picard kernel: system 00:06: ioport range 0xa20-0xa2f has been reserved
Aug 18 22:04:19 picard kernel: system 00:06: ioport range 0xa30-0xa3f has been reserved
Aug 18 22:04:19 picard kernel: system 00:08: ioport range 0x3e0-0x3e7 has been reserved
Aug 18 22:04:19 picard kernel: system 00:08: ioport range 0x4d0-0x4d1 has been reserved
Aug 18 22:04:19 picard kernel: system 00:08: ioport range 0x800-0x87f has been reserved
Aug 18 22:04:19 picard kernel: system 00:08: ioport range 0x400-0x41f has been reserved
Aug 18 22:04:19 picard kernel: system 00:0b: iomem range 0xfec00000-0xfec00fff could not be reserved
Aug 18 22:04:19 picard kernel: system 00:0b: iomem range 0xfee00000-0xfee00fff could not be reserved
Aug 18 22:04:19 picard kernel: system 00:0f: iomem range 0xe0000000-0xefffffff has been reserved
Aug 18 22:04:19 picard kernel: system 00:10: iomem range 0x0-0x9ffff could not be reserved
Aug 18 22:04:19 picard kernel: system 00:10: iomem range 0xc0000-0xcffff has been reserved
Aug 18 22:04:19 picard kernel: system 00:10: iomem range 0xe0000-0xfffff could not be reserved
Aug 18 22:04:19 picard kernel: system 00:10: iomem range 0x100000-0x7fffffff could not be reserved
Aug 18 22:04:19 picard kernel: system 00:10: iomem range 0xff380000-0xffffffff could not be reserved
Aug 18 22:04:19 picard kernel: PCI: Bridge: 0000:00:01.0
Aug 18 22:04:19 picard kernel:  IO window: disabled.
Aug 18 22:04:19 picard kernel:  MEM window: disabled.
Aug 18 22:04:19 picard kernel:  PREFETCH window: disabled.
Aug 18 22:04:19 picard kernel: PCI: Bridge: 0000:00:02.0
Aug 18 22:04:19 picard kernel:  IO window: d000-dfff
Aug 18 22:04:19 picard kernel:  MEM window: 0xf9000000-0xfb4fffff
Aug 18 22:04:19 picard kernel:  PREFETCH window: 0x00000000d0000000-0x00000000dfffffff
Aug 18 22:04:19 picard kernel: PCI: Bridge: 0000:00:03.0
Aug 18 22:04:19 picard kernel:  IO window: disabled.
Aug 18 22:04:19 picard kernel:  MEM window: disabled.
Aug 18 22:04:19 picard kernel:  PREFETCH window: 0x00000000f5f00000-0x00000000f5ffffff
Aug 18 22:04:19 picard kernel: PCI: Bridge: 0000:00:03.1
Aug 18 22:04:19 picard kernel:  IO window: disabled.
Aug 18 22:04:19 picard kernel:  MEM window: disabled.
Aug 18 22:04:19 picard kernel:  PREFETCH window: 0x00000000f5e00000-0x00000000f5efffff
Aug 18 22:04:19 picard kernel: PCI: Bridge: 0000:00:03.2
Aug 18 22:04:19 picard kernel:  IO window: disabled.
Aug 18 22:04:19 picard kernel:  MEM window: 0xfb500000-0xfb5fffff
Aug 18 22:04:19 picard kernel:  PREFETCH window: disabled.
Aug 18 22:04:19 picard kernel: PCI: Bridge: 0000:00:03.3
Aug 18 22:04:19 picard kernel:  IO window: disabled.
Aug 18 22:04:19 picard kernel:  MEM window: disabled.
Aug 18 22:04:19 picard kernel:  PREFETCH window: 0x00000000f5d00000-0x00000000f5dfffff
Aug 18 22:04:19 picard kernel: PCI: Bridge: 0000:00:13.0
Aug 18 22:04:19 picard kernel:  IO window: disabled.
Aug 18 22:04:19 picard kernel:  MEM window: 0xfbf00000-0xfbffffff
Aug 18 22:04:19 picard kernel:  PREFETCH window: disabled.
Aug 18 22:04:19 picard kernel: PCI: Bus 8, cardbus bridge: 0000:07:06.0
Aug 18 22:04:19 picard kernel:  IO window: 0x0000e000-0x0000e0ff
Aug 18 22:04:19 picard kernel:  IO window: 0x0000e400-0x0000e4ff
Aug 18 22:04:19 picard kernel:  PREFETCH window: 0x88000000-0x8bffffff
Aug 18 22:04:19 picard kernel:  MEM window: 0x8c000000-0x8fffffff
Aug 18 22:04:19 picard kernel: PCI: Bridge: 0000:00:13.1
Aug 18 22:04:19 picard kernel:  IO window: e000-efff
Aug 18 22:04:19 picard kernel:  MEM window: 0xfb600000-0xfbefffff
Aug 18 22:04:19 picard kernel:  PREFETCH window: 0x00000000f6000000-0x00000000f7ffffff
Aug 18 22:04:19 picard kernel: NET: Registered protocol family 2
Aug 18 22:04:19 picard kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Aug 18 22:04:19 picard kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Aug 18 22:04:19 picard kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Aug 18 22:04:19 picard kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug 18 22:04:19 picard kernel: TCP reno registered
Aug 18 22:04:19 picard kernel: checking if image is initramfs... it is
Aug 18 22:04:19 picard kernel: Freeing initrd memory: 2909k freed
Aug 18 22:04:19 picard kernel: audit: initializing netlink socket (disabled)
Aug 18 22:04:19 picard kernel: type=2000 audit(1219093423.336:1): initialized
Aug 18 22:04:19 picard kernel: Total HugeTLB memory allocated, 0
Aug 18 22:04:19 picard kernel: VFS: Disk quotas dquot_6.5.1
Aug 18 22:04:19 picard kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Aug 18 22:04:19 picard kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
Aug 18 22:04:19 picard kernel: io scheduler noop registered
Aug 18 22:04:19 picard kernel: io scheduler anticipatory registered
Aug 18 22:04:19 picard kernel: io scheduler deadline registered
Aug 18 22:04:19 picard kernel: io scheduler cfq registered (default)
Aug 18 22:04:19 picard kernel: pci 0000:00:00.0: MSI quirk detected; MSI disabled
Aug 18 22:04:19 picard kernel: PCI: VIA PCI bridge detected. Disabling DAC.
Aug 18 22:04:19 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 22:04:19 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 22:04:19 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 22:04:19 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 22:04:19 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 22:04:19 picard kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Aug 18 22:04:19 picard kernel: ACPI: ACPI0007:00 is registered as cooling_device0
Aug 18 22:04:19 picard kernel: ACPI: Processor [P001] (supports 16 throttling states)
Aug 18 22:04:19 picard kernel: ACPI: ACPI0007:01 is registered as cooling_device1
Aug 18 22:04:19 picard kernel: Non-volatile memory driver v1.2
Aug 18 22:04:19 picard kernel: Linux agpgart interface v0.103
Aug 18 22:04:19 picard kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Aug 18 22:04:19 picard kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 18 22:04:19 picard kernel: 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 18 22:04:19 picard kernel: brd: module loaded
Aug 18 22:04:19 picard kernel: input: Macintosh mouse button emulation as /devices/virtual/input/input0
Aug 18 22:04:19 picard kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Aug 18 22:04:19 picard kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 18 22:04:19 picard kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 18 22:04:19 picard kernel: mice: PS/2 mouse device common for all mice
Aug 18 22:04:19 picard kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
Aug 18 22:04:19 picard kernel: rtc_cmos 00:0a: rtc core: registered rtc_cmos as rtc0
Aug 18 22:04:19 picard kernel: rtc0: alarms up to one year, y3k
Aug 18 22:04:19 picard kernel: cpuidle: using governor ladder
Aug 18 22:04:19 picard kernel: cpuidle: using governor menu
Aug 18 22:04:19 picard kernel: usbcore: registered new interface driver hiddev
Aug 18 22:04:19 picard kernel: usbcore: registered new interface driver usbhid
Aug 18 22:04:19 picard kernel: drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Aug 18 22:04:19 picard kernel: TCP cubic registered
Aug 18 22:04:19 picard kernel: Initializing XFRM netlink socket
Aug 18 22:04:19 picard kernel: NET: Registered protocol family 1
Aug 18 22:04:19 picard kernel: NET: Registered protocol family 17
Aug 18 22:04:19 picard kernel: registered taskstats version 1
Aug 18 22:04:19 picard kernel:  Magic number: 4:107:96
Aug 18 22:04:19 picard kernel: Freeing unused kernel memory: 352k freed
Aug 18 22:04:19 picard kernel: Write protecting the kernel read-only data: 1112k
Aug 18 22:04:19 picard kernel: ehci_hcd 0000:00:10.4: EHCI Host Controller
Aug 18 22:04:19 picard kernel: ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
Aug 18 22:04:19 picard kernel: ehci_hcd 0000:00:10.4: irq 21, io mem 0xf8fffc00
Aug 18 22:04:19 picard kernel: ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Aug 18 22:04:19 picard kernel: usb usb1: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: hub 1-0:1.0: USB hub found
Aug 18 22:04:19 picard kernel: hub 1-0:1.0: 8 ports detected
Aug 18 22:04:19 picard kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Aug 18 22:04:19 picard kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 22:04:19 picard kernel: usb usb1: Product: EHCI Host Controller
Aug 18 22:04:19 picard kernel: usb usb1: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 ehci_hcd
Aug 18 22:04:19 picard kernel: usb usb1: SerialNumber: 0000:00:10.4
Aug 18 22:04:19 picard kernel: ehci_hcd 0000:07:07.2: EHCI Host Controller
Aug 18 22:04:19 picard kernel: ehci_hcd 0000:07:07.2: new USB bus registered, assigned bus number 2
Aug 18 22:04:19 picard kernel: ehci_hcd 0000:07:07.2: irq 19, io mem 0xfb6ffc00
Aug 18 22:04:19 picard kernel: ehci_hcd 0000:07:07.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Aug 18 22:04:19 picard kernel: usb usb2: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: hub 2-0:1.0: USB hub found
Aug 18 22:04:19 picard kernel: hub 2-0:1.0: 5 ports detected
Aug 18 22:04:19 picard kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
Aug 18 22:04:19 picard kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 22:04:19 picard kernel: usb usb2: Product: EHCI Host Controller
Aug 18 22:04:19 picard kernel: usb usb2: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 ehci_hcd
Aug 18 22:04:19 picard kernel: usb usb2: SerialNumber: 0000:07:07.2
Aug 18 22:04:19 picard kernel: ohci_hcd 0000:07:07.0: OHCI Host Controller
Aug 18 22:04:19 picard kernel: ohci_hcd 0000:07:07.0: new USB bus registered, assigned bus number 3
Aug 18 22:04:19 picard kernel: ohci_hcd 0000:07:07.0: irq 17, io mem 0xfb6fd000
Aug 18 22:04:19 picard kernel: usb usb3: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: hub 3-0:1.0: USB hub found
Aug 18 22:04:19 picard kernel: hub 3-0:1.0: 3 ports detected
Aug 18 22:04:19 picard kernel: hub 1-0:1.0: unable to enumerate USB device on port 2
Aug 18 22:04:19 picard kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 22:04:19 picard kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 22:04:19 picard kernel: usb usb3: Product: OHCI Host Controller
Aug 18 22:04:19 picard kernel: usb usb3: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 ohci_hcd
Aug 18 22:04:19 picard kernel: usb usb3: SerialNumber: 0000:07:07.0
Aug 18 22:04:19 picard kernel: ohci_hcd 0000:07:07.1: OHCI Host Controller
Aug 18 22:04:19 picard kernel: ohci_hcd 0000:07:07.1: new USB bus registered, assigned bus number 4
Aug 18 22:04:19 picard kernel: ohci_hcd 0000:07:07.1: irq 18, io mem 0xfb6fe000
Aug 18 22:04:19 picard kernel: input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
Aug 18 22:04:19 picard kernel: usb usb4: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: hub 4-0:1.0: USB hub found
Aug 18 22:04:19 picard kernel: hub 4-0:1.0: 2 ports detected
Aug 18 22:04:19 picard kernel: usb 1-6: new high speed USB device using ehci_hcd and address 3
Aug 18 22:04:19 picard kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 22:04:19 picard kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 22:04:19 picard kernel: usb usb4: Product: OHCI Host Controller
Aug 18 22:04:19 picard kernel: usb usb4: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 ohci_hcd
Aug 18 22:04:19 picard kernel: usb usb4: SerialNumber: 0000:07:07.1
Aug 18 22:04:19 picard kernel: USB Universal Host Controller Interface driver v3.0
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 5
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.0: irq 20, io base 0x0000c480
Aug 18 22:04:19 picard kernel: usb usb5: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: hub 5-0:1.0: USB hub found
Aug 18 22:04:19 picard kernel: hub 5-0:1.0: 2 ports detected
Aug 18 22:04:19 picard kernel: usb 1-6: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: usb 1-6: New USB device found, idVendor=152e, idProduct=2507
Aug 18 22:04:19 picard kernel: usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Aug 18 22:04:19 picard kernel: usb 1-6: Product: Super Multi Rewriter
Aug 18 22:04:19 picard kernel: usb 1-6: Manufacturer: HLDS Inc.
Aug 18 22:04:19 picard kernel: usb 1-6: SerialNumber: P01070317095617
Aug 18 22:04:19 picard kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 22:04:19 picard kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 22:04:19 picard kernel: usb usb5: Product: UHCI Host Controller
Aug 18 22:04:19 picard kernel: usb usb5: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 uhci_hcd
Aug 18 22:04:19 picard kernel: usb usb5: SerialNumber: 0000:00:10.0
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 6
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.1: irq 22, io base 0x0000c800
Aug 18 22:04:19 picard kernel: usb usb6: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: hub 6-0:1.0: USB hub found
Aug 18 22:04:19 picard kernel: hub 6-0:1.0: 2 ports detected
Aug 18 22:04:19 picard kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 22:04:19 picard kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 22:04:19 picard kernel: usb usb6: Product: UHCI Host Controller
Aug 18 22:04:19 picard kernel: usb usb6: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 uhci_hcd
Aug 18 22:04:19 picard kernel: usb usb6: SerialNumber: 0000:00:10.1
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 7
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c880
Aug 18 22:04:19 picard kernel: usb usb7: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: hub 7-0:1.0: USB hub found
Aug 18 22:04:19 picard kernel: hub 7-0:1.0: 2 ports detected
Aug 18 22:04:19 picard kernel: usb 1-7: new high speed USB device using ehci_hcd and address 4
Aug 18 22:04:19 picard kernel: usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 22:04:19 picard kernel: usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 22:04:19 picard kernel: usb usb7: Product: UHCI Host Controller
Aug 18 22:04:19 picard kernel: usb usb7: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 uhci_hcd
Aug 18 22:04:19 picard kernel: usb usb7: SerialNumber: 0000:00:10.2
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.3: UHCI Host Controller
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 8
Aug 18 22:04:19 picard kernel: uhci_hcd 0000:00:10.3: irq 23, io base 0x0000cc00
Aug 18 22:04:19 picard kernel: usb usb8: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: hub 8-0:1.0: USB hub found
Aug 18 22:04:19 picard kernel: hub 8-0:1.0: 2 ports detected
Aug 18 22:04:19 picard kernel: usb 1-7: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: usb 1-7: New USB device found, idVendor=05e3, idProduct=070e
Aug 18 22:04:19 picard kernel: usb 1-7: New USB device strings: Mfr=3, Product=4, SerialNumber=5
Aug 18 22:04:19 picard kernel: usb 1-7: Product: USB Reader
Aug 18 22:04:19 picard kernel: usb 1-7: Manufacturer: Genesys
Aug 18 22:04:19 picard kernel: usb 1-7: SerialNumber: 000000459031
Aug 18 22:04:19 picard kernel: usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 22:04:19 picard kernel: usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 22:04:19 picard kernel: usb usb8: Product: UHCI Host Controller
Aug 18 22:04:19 picard kernel: usb usb8: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 uhci_hcd
Aug 18 22:04:19 picard kernel: usb usb8: SerialNumber: 0000:00:10.3
Aug 18 22:04:19 picard kernel: SCSI subsystem initialized
Aug 18 22:04:19 picard kernel: Driver 'sd' needs updating - please use bus_type methods
Aug 18 22:04:19 picard kernel: scsi0 : pata_via
Aug 18 22:04:19 picard kernel: scsi1 : pata_via
Aug 18 22:04:19 picard kernel: ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
Aug 18 22:04:19 picard kernel: ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
Aug 18 22:04:19 picard kernel: ata1.00: ATA-7: Hitachi HDS721616PLAT80, P22OA8BA, max UDMA/133
Aug 18 22:04:19 picard kernel: ata1.00: 312581808 sectors, multi 16: LBA48 
Aug 18 22:04:19 picard kernel: ata1.01: ATA-7: Maxtor 6L200P0, BAH41G10, max UDMA/133
Aug 18 22:04:19 picard kernel: ata1.01: 398297088 sectors, multi 16: LBA48 
Aug 18 22:04:19 picard kernel: ata1.00: configured for UDMA/133
Aug 18 22:04:19 picard kernel: ata1.01: configured for UDMA/133
Aug 18 22:04:19 picard kernel: usb 2-5: new high speed USB device using ehci_hcd and address 2
Aug 18 22:04:19 picard kernel: usb 2-5: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: usb 2-5: New USB device found, idVendor=04b8, idProduct=011e
Aug 18 22:04:19 picard kernel: usb 2-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 18 22:04:19 picard kernel: usb 2-5: Product: EPSON Scanner
Aug 18 22:04:19 picard kernel: usb 2-5: Manufacturer: EPSON
Aug 18 22:04:19 picard kernel: ata2.00: ATAPI: ATAPI   DVD A  DH20A3P, XY12, max UDMA/66
Aug 18 22:04:19 picard kernel: usb 5-2: new full speed USB device using uhci_hcd and address 2
Aug 18 22:04:19 picard kernel: ata2.00: configured for UDMA/66
Aug 18 22:04:19 picard kernel: scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72161 P22O PQ: 0 ANSI: 5
Aug 18 22:04:19 picard kernel: sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
Aug 18 22:04:19 picard kernel: sd 0:0:0:0: [sda] Write Protect is off
Aug 18 22:04:19 picard kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 18 22:04:19 picard kernel: sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
Aug 18 22:04:19 picard kernel: sd 0:0:0:0: [sda] Write Protect is off
Aug 18 22:04:19 picard kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 18 22:04:19 picard kernel: sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Aug 18 22:04:19 picard kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Aug 18 22:04:19 picard kernel: scsi 0:0:1:0: Direct-Access     ATA      Maxtor 6L200P0   BAH4 PQ: 0 ANSI: 5
Aug 18 22:04:19 picard kernel: sd 0:0:1:0: [sdb] 398297088 512-byte hardware sectors (203928 MB)
Aug 18 22:04:19 picard kernel: sd 0:0:1:0: [sdb] Write Protect is off
Aug 18 22:04:19 picard kernel: sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 18 22:04:19 picard kernel: sd 0:0:1:0: [sdb] 398297088 512-byte hardware sectors (203928 MB)
Aug 18 22:04:19 picard kernel: sd 0:0:1:0: [sdb] Write Protect is off
Aug 18 22:04:19 picard kernel: sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 18 22:04:19 picard kernel: sdb: sdb1 sdb2
Aug 18 22:04:19 picard kernel: sd 0:0:1:0: [sdb] Attached SCSI disk
Aug 18 22:04:19 picard kernel: scsi 1:0:0:0: CD-ROM            ATAPI    DVD A  DH20A3P   XY12 PQ: 0 ANSI: 5
Aug 18 22:04:19 picard kernel: usb 5-2: configuration #1 chosen from 1 choice
Aug 18 22:04:19 picard kernel: usb 5-2: New USB device found, idVendor=046d, idProduct=08b2
Aug 18 22:04:19 picard kernel: usb 5-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Aug 18 22:04:19 picard kernel: kjournald starting.  Commit interval 5 seconds
Aug 18 22:04:19 picard kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 18 22:04:19 picard kernel: SELinux:  Disabled at runtime.
Aug 18 22:04:19 picard kernel: type=1404 audit(1219093431.296:2): selinux=0 auid=4294967295 ses=4294967295
Aug 18 22:04:19 picard kernel: Floppy drive(s): fd0 is 1.44M
Aug 18 22:04:19 picard kernel: Driver 'sr' needs updating - please use bus_type methods
Aug 18 22:04:19 picard kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Aug 18 22:04:19 picard kernel: sd 0:0:1:0: Attached scsi generic sg1 type 0
Aug 18 22:04:19 picard kernel: sr 1:0:0:0: Attached scsi generic sg2 type 5
Aug 18 22:04:19 picard kernel: FDC 0 is a post-1991 82077
Aug 18 22:04:19 picard kernel: sr0: scsi3-mmc drive: 48x/12x writer dvd-ram cd/rw xa/form2 cdda tray
Aug 18 22:04:19 picard kernel: Uniform CD-ROM driver Revision: 3.20
Aug 18 22:04:19 picard kernel: parport_pc 00:05: reported by Plug and Play ACPI
Aug 18 22:04:19 picard kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
Aug 18 22:04:19 picard kernel: input: PC Speaker as /devices/platform/pcspkr/input/input3
Aug 18 22:04:19 picard kernel: input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
Aug 18 22:04:19 picard kernel: ACPI: Power Button (FF) [PWRF]
Aug 18 22:04:19 picard kernel: input: Sleep Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input5
Aug 18 22:04:19 picard kernel: ACPI: Sleep Button (CM) [SLPB]
Aug 18 22:04:19 picard kernel: input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input6
Aug 18 22:04:19 picard kernel: ACPI: Power Button (CM) [PWRB]
Aug 18 22:04:19 picard kernel: ppdev: user-space parallel port driver
Aug 18 22:04:19 picard kernel: ath_hal: module license 'Proprietary' taints kernel.
Aug 18 22:04:19 picard kernel: ath_hal: 0.9.18.0 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413, RF5413)
Aug 18 22:04:19 picard kernel: wlan: 0.9.4
Aug 18 22:04:19 picard kernel: atl1 0000:04:00.0: version 2.0.7
Aug 18 22:04:19 picard kernel: Initializing USB Mass Storage driver...
Aug 18 22:04:19 picard kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Aug 18 22:04:19 picard kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Aug 18 22:04:19 picard kernel: usbcore: registered new interface driver usb-storage
Aug 18 22:04:19 picard kernel: USB Mass Storage support registered.
Aug 18 22:04:19 picard kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Aug 18 22:04:19 picard kernel: Linux video capture interface: v2.00
Aug 18 22:04:19 picard kernel: Yenta: CardBus bridge found at 0000:07:06.0 [0000:0000]
Aug 18 22:04:19 picard kernel: ath_pci: 0.9.4
Aug 18 22:04:19 picard kernel: Yenta: ISA IRQ mask 0x0000, PCI irq 16
Aug 18 22:04:19 picard kernel: Socket status: 30000006
Aug 18 22:04:19 picard kernel: Yenta: Raising subordinate bus# of parent bus (#07) from #08 to #0b
Aug 18 22:04:19 picard kernel: pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
Aug 18 22:04:19 picard kernel: pcmcia: parent PCI bridge Memory window: 0xfb600000 - 0xfbefffff
Aug 18 22:04:19 picard kernel: pcmcia: parent PCI bridge Memory window: 0xf6000000 - 0xf7ffffff
Aug 18 22:04:19 picard kernel: pwc: Philips webcam module version 10.0.13 loaded.
Aug 18 22:04:19 picard kernel: pwc: Supports Philips PCA645/646, PCVC675/680/690, PCVC720[40]/730/740/750 & PCVC830/840.
Aug 18 22:04:19 picard kernel: pwc: Also supports the Askey VC010, various Logitech Quickcams, Samsung MPC-C10 and MPC-C30,
Aug 18 22:04:19 picard kernel: pwc: the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
Aug 18 22:04:19 picard kernel: pwc: Logitech QuickCam 4000 Pro USB webcam detected.
Aug 18 22:04:19 picard kernel: pwc: Registered as /dev/video0.
Aug 18 22:04:19 picard kernel: usbcore: registered new interface driver Philips webcam
Aug 18 22:04:19 picard kernel: ath_rate_sample: 1.2 (0.9.4)
Aug 18 22:04:19 picard kernel: wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
Aug 18 22:04:19 picard kernel: wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Aug 18 22:04:19 picard kernel: wifi0: turboG rates: 6Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Aug 18 22:04:19 picard kernel: wifi0: H/W encryption support: WEP AES AES_CCM TKIP
Aug 18 22:04:19 picard kernel: wifi0: mac 7.9 phy 4.5 radio 5.6
Aug 18 22:04:19 picard kernel: wifi0: Use hw queue 1 for WME_AC_BE traffic
Aug 18 22:04:19 picard kernel: wifi0: Use hw queue 0 for WME_AC_BK traffic
Aug 18 22:04:19 picard kernel: wifi0: Use hw queue 2 for WME_AC_VI traffic
Aug 18 22:04:19 picard kernel: wifi0: Use hw queue 3 for WME_AC_VO traffic
Aug 18 22:04:19 picard kernel: wifi0: Use hw queue 8 for CAB traffic
Aug 18 22:04:19 picard kernel: wifi0: Use hw queue 9 for beacons
Aug 18 22:04:19 picard kernel: wifi0: Atheros 5212: mem=0xfb6e0000, irq=18
Aug 18 22:04:19 picard kernel: NVRM: loading NVIDIA UNIX x86_64 Kernel Module  173.14.12  Thu Jul 17 18:10:24 PDT 2008
Aug 18 22:04:19 picard kernel: ALSA sound/usb/usbaudio.c:2798: 2:2:1: add audio endpoint 0x84
Aug 18 22:04:19 picard kernel: ALSA sound/usb/usbaudio.c:2798: 2:2:2: add audio endpoint 0x84
Aug 18 22:04:19 picard kernel: ALSA sound/usb/usbaudio.c:2798: 2:2:3: add audio endpoint 0x84
Aug 18 22:04:19 picard kernel: ALSA sound/usb/usbaudio.c:2798: 2:2:4: add audio endpoint 0x84
Aug 18 22:04:19 picard kernel: ALSA sound/usb/usbmixer.c:988: [2] FU [Mic Capture Switch] ch = 1, val = 0/1/1
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_intel.c:1810: chipset global capabilities = 0x4401
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_intel.c:749: codec_mask = 0x1
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:2236: hda_codec: model '3stack-660-digout' is selected for config 1043:81e7 (ASUS)
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Volume, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Center Playback Volume, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave LFE Playback Volume, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Side Playback Volume, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Headphone Playback Volume, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Volume, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Volume, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Line-Out Playback Volume, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Switch, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Center Playback Switch, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave LFE Playback Switch, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Side Playback Switch, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Switch, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Switch, skipped
Aug 18 22:04:19 picard kernel: ALSA sound/usb/usbmixer.c:405: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x201, type = 4, data = 0x0/0x5
Aug 18 22:04:19 picard kernel: ALSA sound/usb/usbmixer.c:988: [2] FU [Mic Capture Volume] ch = 1, val = 7680/15360/2560
Aug 18 22:04:19 picard kernel: usbcore: registered new interface driver snd-usb-audio
Aug 18 22:04:19 picard kernel: scsi 3:0:0:0: Direct-Access     Generic  STORAGE DEVICE   9325 PQ: 0 ANSI: 0
Aug 18 22:04:19 picard kernel: scsi 3:0:0:1: Direct-Access     Generic  STORAGE DEVICE   9325 PQ: 0 ANSI: 0
Aug 18 22:04:19 picard kernel: scsi 2:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-E40L  SE02 PQ: 0 ANSI: 0
Aug 18 22:04:19 picard kernel: sr1: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Aug 18 22:04:19 picard kernel: sr 2:0:0:0: Attached scsi generic sg3 type 5
Aug 18 22:04:19 picard kernel: sd 3:0:0:0: [sdc] Attached SCSI removable disk
Aug 18 22:04:19 picard kernel: sd 3:0:0:0: Attached scsi generic sg4 type 0
Aug 18 22:04:19 picard kernel: sd 3:0:0:1: [sdd] Attached SCSI removable disk
Aug 18 22:04:19 picard kernel: sd 3:0:0:1: Attached scsi generic sg5 type 0
Aug 18 22:04:19 picard kernel: device-mapper: uevent: version 1.0.3
Aug 18 22:04:19 picard kernel: device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
Aug 18 22:04:19 picard kernel: device-mapper: multipath: version 1.0.5 loaded
Aug 18 22:04:19 picard kernel: EXT3 FS on sda5, internal journal
Aug 18 22:04:19 picard kernel: kjournald starting.  Commit interval 5 seconds
Aug 18 22:04:19 picard kernel: EXT3 FS on sdb1, internal journal
Aug 18 22:04:19 picard kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 18 22:04:19 picard kernel: kjournald starting.  Commit interval 5 seconds
Aug 18 22:04:19 picard kernel: EXT3 FS on sda3, internal journal
Aug 18 22:04:19 picard kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 18 22:04:19 picard kernel: Adding 7799516k swap on /dev/sda6.  Priority:-1 extents:1 across:7799516k
Aug 18 22:04:19 picard kernel: Adding 7727256k swap on /dev/sdb2.  Priority:-2 extents:1 across:7727256k
Aug 18 22:04:19 picard kernel: powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ processors (2 cpu cores) (version 2.20.00)
Aug 18 22:04:19 picard kernel: powernow-k8:    0 : fid 0x16 (3000 MHz), vid 0x6
Aug 18 22:04:19 picard kernel: powernow-k8:    1 : fid 0x14 (2800 MHz), vid 0x8
Aug 18 22:04:19 picard kernel: powernow-k8:    2 : fid 0x12 (2600 MHz), vid 0xa
Aug 18 22:04:19 picard kernel: powernow-k8:    3 : fid 0x10 (2400 MHz), vid 0xc
Aug 18 22:04:19 picard kernel: powernow-k8:    4 : fid 0xe (2200 MHz), vid 0xe
Aug 18 22:04:19 picard kernel: powernow-k8:    5 : fid 0xc (2000 MHz), vid 0x10
Aug 18 22:04:19 picard kernel: powernow-k8:    6 : fid 0xa (1800 MHz), vid 0x10
Aug 18 22:04:19 picard kernel: powernow-k8:    7 : fid 0x2 (1000 MHz), vid 0x12
Aug 18 22:04:19 picard kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Aug 18 22:04:19 picard kernel: nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Aug 18 22:04:19 picard kernel: Clocksource tsc unstable (delta = -241117618 ns)
Aug 18 22:04:19 picard kernel: atl1 0000:04:00.0: Unable to enable MSI: -22
Aug 18 22:04:19 picard kernel: atl1 0000:04:00.0: eth0 link is up 1000 Mbps full duplex
Aug 18 22:04:19 picard rsyslogd: [origin software="rsyslogd" swVersion="3.18.1" x-pid="2148" x-info="http://www.rsyslog.com"] restart
Aug 18 22:04:20 picard rpc.statd[2194]: Version 1.1.2 Starting
Aug 18 22:04:20 picard kernel: RPC: Registered udp transport module.
Aug 18 22:04:20 picard kernel: RPC: Registered tcp transport module.
Aug 18 22:04:21 picard kernel: warning: `dbus-daemon' uses deprecated v2 capabilities in a way that may be insecure.
Aug 18 22:04:21 picard kernel: fuse init (API version 7.9)
Aug 18 22:04:21 picard pcscd: pcscdaemon.c:507:main() pcsc-lite 1.4.4 daemon ready.
Aug 18 22:04:21 picard acpid: starting up
Aug 18 22:04:23 picard acpid: client connected from 2404[68:68]
Aug 18 22:04:24 picard kernel: it87: Found IT8712F chip at 0xd00, revision 8
Aug 18 22:04:24 picard kernel: it87: in3 is VCC (+5V)
Aug 18 22:04:25 picard hcid[2495]: Bluetooth HCI daemon
Aug 18 22:04:25 picard kernel: Bluetooth: Core ver 2.11
Aug 18 22:04:25 picard kernel: NET: Registered protocol family 31
Aug 18 22:04:25 picard kernel: Bluetooth: HCI device and connection manager initialized
Aug 18 22:04:25 picard kernel: Bluetooth: HCI socket layer initialized
Aug 18 22:04:25 picard hcid[2495]: Parsing /etc/bluetooth/main.conf failed: No such file or directory
Aug 18 22:04:25 picard hcid[2495]: Starting SDP server
Aug 18 22:04:25 picard kernel: Bluetooth: L2CAP ver 2.9
Aug 18 22:04:25 picard kernel: Bluetooth: L2CAP socket layer initialized
Aug 18 22:04:25 picard kernel: Bluetooth: RFCOMM socket layer initialized
Aug 18 22:04:25 picard kernel: Bluetooth: RFCOMM TTY layer initialized
Aug 18 22:04:25 picard kernel: Bluetooth: RFCOMM ver 1.8
Aug 18 22:04:25 picard hcid[2495]: Registered manager path:/org/bluez/serial
Aug 18 22:04:25 picard hcid[2495]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
Aug 18 22:04:25 picard hcid[2495]: Registered input manager path:/org/bluez/input
Aug 18 22:04:25 picard kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Aug 18 22:04:25 picard kernel: Bluetooth: BNEP filters: protocol multicast
Aug 18 22:04:25 picard kernel: Bridge firewalling registered
Aug 18 22:04:25 picard hcid[2495]: bridge pan0 created
Aug 18 22:04:25 picard kernel: pan0: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
Aug 18 22:04:25 picard hcid[2495]: Registered manager path:/org/bluez/network
Aug 18 22:04:25 picard hcid[2495]: Registered server path:/org/bluez/network/nap
Aug 18 22:04:25 picard hcid[2495]: Registered server path:/org/bluez/network/gn
Aug 18 22:04:25 picard hcid[2495]: Registered server path:/org/bluez/network/panu
Aug 18 22:04:25 picard hcid[2495]: Unix socket created: 17
Aug 18 22:04:25 picard hcid[2495]: Registered manager path:/org/bluez/audio
Aug 18 22:04:28 picard ntpdate[2580]: step time server 66.187.233.4 offset 0.259479 sec
Aug 18 22:04:28 picard ntpd[2590]: ntpd 4.2.4p4@1.1520-o Mon Jul 28 11:13:24 UTC 2008 (1)
Aug 18 22:04:28 picard ntpd[2591]: precision = 0.838 usec
Aug 18 22:04:28 picard ntpd[2591]: Listening on interface #0 wildcard, 0.0.0.0#123 Disabled
Aug 18 22:04:28 picard ntpd[2591]: Listening on interface #1 lo, 127.0.0.1#123 Enabled
Aug 18 22:04:28 picard ntpd[2591]: Listening on interface #2 eth0, 192.168.2.10#123 Enabled
Aug 18 22:04:28 picard ntpd[2591]: Listening on interface #3 ath0, 192.168.1.10#123 Enabled
Aug 18 22:04:28 picard ntpd[2591]: kernel time sync status 0040
Aug 18 22:04:28 picard ntpd[2591]: frequency initialized 17.091 PPM from /var/lib/ntp/drift
Aug 18 22:04:28 picard ntpd[2591]: getaddrinfo: "::1" invalid host address, ignored
Aug 18 22:04:28 picard kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug 18 22:04:28 picard kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Aug 18 22:04:28 picard kernel: NFSD: starting 90-second grace period
Aug 18 22:04:30 picard dhcpd: Internet Systems Consortium DHCP Server 4.0.0
Aug 18 22:04:30 picard dhcpd: Copyright 2004-2007 Internet Systems Consortium.
Aug 18 22:04:30 picard dhcpd: All rights reserved.
Aug 18 22:04:30 picard dhcpd: For info, please visit http://www.isc.org/sw/dhcp/
Aug 18 22:04:30 picard dhcpd: Warning: subnet 192.168.2.0/24 overlaps subnet 192.168.2.0/24
Aug 18 22:04:30 picard dhcpd: Not searching LDAP since ldap-server, ldap-port and ldap-base-dn were not specified in the config file
Aug 18 22:04:30 picard dhcpd: Wrote 0 deleted host decls to leases file.
Aug 18 22:04:30 picard dhcpd: Wrote 0 new dynamic host decls to leases file.
Aug 18 22:04:30 picard dhcpd: Wrote 2 leases to leases file.
Aug 18 22:04:30 picard dhcpd: 
Aug 18 22:04:30 picard dhcpd: No subnet declaration for ath0 (192.168.1.10).
Aug 18 22:04:30 picard dhcpd: ** Ignoring requests on ath0.  If this is not what
Aug 18 22:04:30 picard dhcpd:    you want, please write a subnet declaration
Aug 18 22:04:30 picard dhcpd:    in your dhcpd.conf file for the network segment
Aug 18 22:04:30 picard dhcpd:    to which interface ath0 is attached. **
Aug 18 22:04:30 picard dhcpd: 
Aug 18 22:04:30 picard dhcpd: Listening on LPF/eth0/00:1b:fc:19:88:0a/192.168.2.0/24
Aug 18 22:04:30 picard dhcpd: Sending on   LPF/eth0/00:1b:fc:19:88:0a/192.168.2.0/24
Aug 18 22:04:30 picard dhcpd: Sending on   Socket/fallback/fallback-net
Aug 18 22:04:38 picard avahi-daemon[2924]: Found user 'avahi' (UID 498) and group 'avahi' (GID 494).
Aug 18 22:04:38 picard avahi-daemon[2924]: Successfully dropped root privileges.
Aug 18 22:04:38 picard avahi-daemon[2924]: avahi-daemon 0.6.22 starting up.
Aug 18 22:04:38 picard avahi-daemon[2924]: WARNING: No NSS support for mDNS detected, consider installing nss-mdns!
Aug 18 22:04:38 picard avahi-daemon[2924]: Successfully called chroot().
Aug 18 22:04:38 picard avahi-daemon[2924]: Successfully dropped remaining capabilities.
Aug 18 22:04:38 picard avahi-daemon[2924]: Loading service file /services/ssh.service.
Aug 18 22:04:38 picard avahi-daemon[2924]: Joining mDNS multicast group on interface ath0.IPv4 with address 192.168.1.10.
Aug 18 22:04:38 picard avahi-daemon[2924]: New relevant interface ath0.IPv4 for mDNS.
Aug 18 22:04:38 picard avahi-daemon[2924]: Joining mDNS multicast group on interface eth0.IPv4 with address 192.168.2.10.
Aug 18 22:04:38 picard avahi-daemon[2924]: New relevant interface eth0.IPv4 for mDNS.
Aug 18 22:04:38 picard avahi-daemon[2924]: Network interface enumeration completed.
Aug 18 22:04:38 picard avahi-daemon[2924]: Registering new address record for 192.168.1.10 on ath0.IPv4.
Aug 18 22:04:38 picard avahi-daemon[2924]: Registering new address record for 192.168.2.10 on eth0.IPv4.
Aug 18 22:04:38 picard avahi-daemon[2924]: Registering HINFO record with values 'X86_64'/'LINUX'.
Aug 18 22:04:39 picard avahi-daemon[2924]: Server startup complete. Host name is picard.local. Local service cookie is 943138859.
Aug 18 22:04:39 picard cupsd[2933]: *** WARNING *** The program 'cupsd' uses the Apple Bonjour compatibility layer of Avahi.
Aug 18 22:04:39 picard cupsd[2933]: *** WARNING *** Please fix your application to use the native API of Avahi!
Aug 18 22:04:39 picard cupsd[2933]: *** WARNING *** For more information see <http://0pointer.de/avahi-compat?s=libdns_sd&e=cupsd>
Aug 18 22:04:40 picard kernel: lp0: using parport0 (interrupt-driven).
Aug 18 22:04:40 picard kernel: lp0: console ready
Aug 18 22:04:40 picard avahi-daemon[2924]: Service "picard" (/services/ssh.service) successfully established.
Aug 18 22:04:43 picard smartd[3001]: smartd version 5.38 [x86_64-redhat-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Aug 18 22:04:43 picard smartd[3001]: Home page is http://smartmontools.sourceforge.net/#012
Aug 18 22:04:43 picard smartd[3001]: Opened configuration file /etc/smartd.conf
Aug 18 22:04:43 picard smartd[3001]: Configuration file /etc/smartd.conf parsed.
Aug 18 22:04:43 picard smartd[3001]: Device: /dev/sdb, opened
Aug 18 22:04:43 picard smartd[3001]: Device: /dev/sdb, found in smartd database.
Aug 18 22:04:43 picard smartd[3001]: Device: /dev/sdb, is SMART capable. Adding to "monitor" list.
Aug 18 22:04:43 picard smartd[3001]: Device: /dev/sda, opened
Aug 18 22:04:43 picard smartd[3001]: Device: /dev/sda, found in smartd database.
Aug 18 22:04:44 picard smartd[3001]: Device: /dev/sda, is SMART capable. Adding to "monitor" list.
Aug 18 22:04:44 picard smartd[3001]: Monitoring 2 ATA and 0 SCSI devices
Aug 18 22:04:44 picard smartd[3003]: smartd has fork()ed into background mode. New PID=3003.
Aug 18 22:04:46 picard acpid: client connected from 3089[0:0]
Aug 18 22:04:47 picard acpid: client connected from 3089[0:0]
Aug 18 22:04:50 picard gconfd (gdm-3139): starting (version 2.22.0), pid 3139 user 'gdm'
Aug 18 22:04:50 picard gconfd (gdm-3139): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Aug 18 22:04:50 picard gconfd (gdm-3139): Resolved address "xml:readonly:/etc/gconf/gconf.xml.system" to a read-only configuration source at position 1
Aug 18 22:04:50 picard gconfd (gdm-3139): Resolved address "xml:readonly:/var/lib/gdm/.gconf.mandatory" to a read-only configuration source at position 2
Aug 18 22:04:50 picard gconfd (gdm-3139): Resolved address "xml:readwrite:/var/lib/gdm/.gconf" to a writable configuration source at position 3
Aug 18 22:04:50 picard gconfd (gdm-3139): Resolved address "xml:readonly:/etc/gconf/gconf.xml.system" to a read-only configuration source at position 4
Aug 18 22:04:50 picard gconfd (gdm-3139): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 5
Aug 18 22:04:53 picard pulseaudio[3181]: polkit.c: Cannot set UID on session object.
Aug 18 22:04:53 picard pulseaudio[3181]: main.c: Called SUID root and real-time/high-priority scheduling was requested in the configuration. However, we lack the necessary priviliges:
Aug 18 22:04:53 picard pulseaudio[3181]: main.c: We are not in group 'pulse-rt' and PolicyKit refuse to grant us priviliges. Dropping SUID again.
Aug 18 22:04:53 picard pulseaudio[3181]: main.c: For enabling real-time scheduling please acquire the appropriate PolicyKit priviliges, or become a member of 'pulse-rt', or increase the RLIMIT_NICE/RLIMIT_RTPRIO resource limits for this user.
Aug 18 22:04:53 picard pulseaudio[3181]: main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted
Aug 18 22:04:53 picard pulseaudio[3181]: main.c: setrlimit(RLIMIT_RTPRIO, (9, 9)) failed: Operation not permitted
Aug 18 22:04:54 picard kernel: hda-intel: Invalid position buffer, using LPIB read method instead.
Aug 18 22:04:54 picard kernel: ALSA sound/usb/usbaudio.c:1353: setting usb interface 2:1
Aug 18 22:04:54 picard pulseaudio[3181]: alsa-util.c: Device hw:0 doesn't support 2 channels, changed to 1.
Aug 18 22:04:54 picard gconfd (gdm-3139): Error setting value for `/apps/gnome-screensaver/power_management_delay': Can't overwrite existing read-only value: Value for `/apps/gnome-screensaver/power_management_delay' set in a read-only source at the front of your configuration path
Aug 18 22:04:54 picard gconfd (gdm-3139): Error setting value for `/apps/gnome-screensaver/power_management_delay': Can't overwrite existing read-only value: Value for `/apps/gnome-screensaver/power_management_delay' set in a read-only source at the front of your configuration path
Aug 18 22:05:21 picard gconfd (gdm-3139): Exiting
Aug 18 22:05:21 picard gconfd (gavin-3390): starting (version 2.22.0), pid 3390 user 'gavin'
Aug 18 22:05:21 picard gconfd (gavin-3390): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Aug 18 22:05:21 picard gconfd (gavin-3390): Resolved address "xml:readwrite:/home/gavin/.gconf" to a writable configuration source at position 1
Aug 18 22:05:21 picard gconfd (gavin-3390): Resolved address "xml:readonly:/etc/gconf/gconf.xml.system" to a read-only configuration source at position 2
Aug 18 22:05:21 picard gconfd (gavin-3390): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Aug 18 22:05:23 picard pulseaudio[3460]: main.c: Called SUID root and real-time/high-priority scheduling was requested in the configuration. However, we lack the necessary priviliges:
Aug 18 22:05:23 picard pulseaudio[3460]: main.c: We are not in group 'pulse-rt' and PolicyKit refuse to grant us priviliges. Dropping SUID again.
Aug 18 22:05:23 picard pulseaudio[3460]: main.c: For enabling real-time scheduling please acquire the appropriate PolicyKit priviliges, or become a member of 'pulse-rt', or increase the RLIMIT_NICE/RLIMIT_RTPRIO resource limits for this user.
Aug 18 22:05:23 picard pulseaudio[3460]: pid.c: Stale PID file, overwriting.
Aug 18 22:05:23 picard pulseaudio[3460]: main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted
Aug 18 22:05:23 picard pulseaudio[3460]: main.c: setrlimit(RLIMIT_RTPRIO, (9, 9)) failed: Operation not permitted
Aug 18 22:05:23 picard kernel: ALSA sound/usb/usbaudio.c:1353: setting usb interface 2:1
Aug 18 22:05:23 picard pulseaudio[3460]: alsa-util.c: Device hw:0 doesn't support 2 channels, changed to 1.
Aug 18 22:05:24 picard gconfd (gavin-3390): Resolved address "xml:readwrite:/home/gavin/.gconf" to a writable configuration source at position 0
Aug 18 22:05:27 picard pulseaudio[3460]: module-x11-xsmp.c: X11 session manager not running.
Aug 18 22:05:27 picard pulseaudio[3460]: module.c: Failed to load  module "module-x11-xsmp" (argument: ""): initialization failed.
Aug 18 22:05:27 picard hcid[2495]: Default passkey agent (:1.38, /org/bluez/passkey) registered
Aug 18 22:05:27 picard hcid[2495]: Default authorization agent (:1.38, /org/bluez/auth) registered
Aug 18 22:05:31 picard ntfs-3g[3605]: Version 1.2712 integrated FUSE 27
Aug 18 22:05:31 picard ntfs-3g[3605]: Mounted /dev/sda2 (Read-Write, label "STUFF", NTFS 3.1)
Aug 18 22:05:31 picard ntfs-3g[3605]: Cmdline options: rw,nosuid,nodev,uhelper=hal,locale=en_GB.utf8
Aug 18 22:05:31 picard ntfs-3g[3605]: Mount options: rw,nosuid,nodev,uhelper=hal,silent,allow_other,nonempty,relatime,fsname=/dev/sda2,blkdev,blksize=512
Aug 18 22:05:31 picard hald: mounted /dev/sda2 on behalf of uid 500
Aug 18 22:05:32 picard ntfs-3g[3611]: Version 1.2712 integrated FUSE 27
Aug 18 22:05:32 picard ntfs-3g[3611]: Mounted /dev/sda1 (Read-Write, label "WINDOWS", NTFS 3.1)
Aug 18 22:05:32 picard ntfs-3g[3611]: Cmdline options: rw,nosuid,nodev,uhelper=hal,locale=en_GB.utf8
Aug 18 22:05:32 picard ntfs-3g[3611]: Mount options: rw,nosuid,nodev,uhelper=hal,silent,allow_other,nonempty,relatime,fsname=/dev/sda1,blkdev,blksize=4096
Aug 18 22:05:32 picard hald: mounted /dev/sda1 on behalf of uid 500
Aug 18 22:06:35 picard hald: mounted /dev/sr0 on behalf of uid 500
Aug 18 22:06:35 picard gnome-keyring-daemon[3399]: adding removable location: volume_label_Top_Touch at /media/Top-Touch
Aug 18 22:06:55 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:06:55 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:06:55 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:06:55 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:06:55 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:06:55 picard kernel: ata2: soft resetting link
Aug 18 22:06:55 picard kernel: ata2.00: configured for UDMA/66
Aug 18 22:06:55 picard kernel: ata2: EH complete
Aug 18 22:07:15 picard hald: unmounted /dev/sr0 from '/media/Top-Touch' on behalf of uid 500
Aug 18 22:07:15 picard gnome-keyring-daemon[3399]: removing removable location: volume_label_Top_Touch
Aug 18 22:08:47 picard ntpd[2591]: synchronized to 66.187.233.4, stratum 1
Aug 18 22:08:47 picard ntpd[2591]: kernel time sync status change 0001
Aug 18 22:15:19 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:15:19 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:15:19 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:15:19 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:15:19 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:15:19 picard kernel: ata2: soft resetting link
Aug 18 22:15:19 picard kernel: ata2.00: configured for UDMA/66
Aug 18 22:15:19 picard kernel: ata2: EH complete
Aug 18 22:23:00 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:23:00 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:23:00 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:23:00 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:23:00 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:23:00 picard kernel: ata2: soft resetting link
Aug 18 22:23:01 picard kernel: ata2.00: configured for UDMA/66
Aug 18 22:23:01 picard kernel: ata2: EH complete
Aug 18 22:23:23 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:23:23 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:23:23 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:23:23 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 22:23:23 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 22:23:23 picard kernel: ata2: soft resetting link
Aug 18 22:23:24 picard kernel: ata2.00: configured for UDMA/66
Aug 18 22:23:24 picard kernel: ata2: EH complete
Aug 18 22:25:43 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:25:43 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:25:43 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:25:43 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:25:43 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:25:43 picard kernel: ata2: soft resetting link
Aug 18 22:25:44 picard kernel: ata2.00: configured for UDMA/66
Aug 18 22:25:44 picard kernel: ata2: EH complete
Aug 18 22:26:39 picard kernel: ata2.00: limiting speed to UDMA/44:PIO4
Aug 18 22:26:39 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:26:39 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:26:39 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:26:39 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:26:39 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:26:39 picard kernel: ata2: soft resetting link
Aug 18 22:26:40 picard kernel: ata2.00: configured for UDMA/44
Aug 18 22:26:40 picard kernel: ata2: EH complete
Aug 18 22:28:36 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:28:36 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:28:36 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:28:36 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 22:28:36 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 22:28:36 picard kernel: ata2: soft resetting link
Aug 18 22:28:37 picard kernel: ata2.00: configured for UDMA/44
Aug 18 22:28:37 picard kernel: ata2: EH complete
Aug 18 22:29:52 picard kernel: ata2.00: limiting speed to UDMA/33:PIO4
Aug 18 22:29:52 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:29:52 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:29:52 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:29:52 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 22:29:52 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 22:29:52 picard kernel: ata2: soft resetting link
Aug 18 22:29:53 picard kernel: ata2.00: configured for UDMA/33
Aug 18 22:29:53 picard kernel: ata2: EH complete
Aug 18 22:30:27 picard kernel: ata2.00: limiting speed to PIO4
Aug 18 22:30:27 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:30:27 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:30:27 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:30:27 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:30:27 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:30:27 picard kernel: ata2: soft resetting link
Aug 18 22:30:28 picard kernel: ata2.00: configured for PIO4
Aug 18 22:30:28 picard kernel: ata2: EH complete
Aug 18 22:31:08 picard kernel: ata2.00: limiting speed to PIO3
Aug 18 22:31:08 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:31:08 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:31:08 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:31:08 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 22:31:08 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 22:31:08 picard kernel: ata2: soft resetting link
Aug 18 22:31:09 picard kernel: ata2.00: configured for PIO3
Aug 18 22:31:09 picard kernel: ata2: EH complete
Aug 18 22:32:43 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:32:43 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:32:43 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:32:43 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:32:43 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:32:43 picard kernel: ata2: soft resetting link
Aug 18 22:32:44 picard kernel: ata2.00: configured for PIO3
Aug 18 22:32:44 picard kernel: ata2: EH complete
Aug 18 22:33:29 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:33:29 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:33:29 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:33:29 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:33:29 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:33:29 picard kernel: ata2: soft resetting link
Aug 18 22:33:29 picard kernel: ata2.00: configured for PIO3
Aug 18 22:33:29 picard kernel: ata2: EH complete
Aug 18 22:35:15 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:35:15 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:35:15 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:35:15 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:35:15 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:35:15 picard kernel: ata2: soft resetting link
Aug 18 22:35:15 picard kernel: ata2.00: configured for PIO3
Aug 18 22:35:15 picard kernel: ata2: EH complete
Aug 18 22:35:50 picard kernel: ata2.00: limiting speed to PIO0
Aug 18 22:35:50 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:35:50 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:35:50 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:35:50 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:35:50 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:35:50 picard kernel: ata2: soft resetting link
Aug 18 22:35:50 picard kernel: ata2.00: configured for PIO0
Aug 18 22:35:50 picard kernel: ata2: EH complete
Aug 18 22:37:23 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:37:23 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:37:23 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:37:23 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 22:37:23 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 22:37:23 picard kernel: ata2: soft resetting link
Aug 18 22:37:24 picard kernel: ata2.00: configured for PIO0
Aug 18 22:37:24 picard kernel: ata2: EH complete
Aug 18 22:38:38 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:38:38 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:38:38 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:38:38 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:38:38 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:38:38 picard kernel: ata2: soft resetting link
Aug 18 22:38:38 picard kernel: ata2.00: configured for PIO0
Aug 18 22:38:38 picard kernel: ata2: EH complete
Aug 18 22:38:56 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 22:38:56 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 22:38:56 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 22:38:56 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 22:38:56 picard kernel: ata2.00: status: { DRDY }
Aug 18 22:38:56 picard kernel: ata2: soft resetting link
Aug 18 22:38:56 picard kernel: ata2.00: configured for PIO0
Aug 18 22:38:56 picard kernel: ata2: EH complete

--------------010206070405070005070702
Content-Type: text/plain;
 name="messages-2.6.25.14-force_udma33.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages-2.6.25.14-force_udma33.txt"

Aug 18 21:27:54 picard kernel: imklog 3.18.1, log source = /proc/kmsg started.
Aug 18 21:27:54 picard kernel: Initializing cgroup subsys cpuset
Aug 18 21:27:54 picard kernel: Linux version 2.6.25.14-108.fc9.x86_64 (mockbuild@) (gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC) ) #1 SMP Mon Aug 4 13:46:35 EDT 2008
Aug 18 21:27:54 picard kernel: Command line: ro root=/dev/sda5 rhgb quiet pci=noacpi
Aug 18 21:27:54 picard kernel: BIOS-provided physical RAM map:
Aug 18 21:27:54 picard kernel: BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 18 21:27:54 picard kernel: BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 18 21:27:54 picard kernel: BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Aug 18 21:27:54 picard kernel: BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
Aug 18 21:27:54 picard kernel: BIOS-e820: 000000007ffb0000 - 000000007ffbe000 (ACPI data)
Aug 18 21:27:54 picard kernel: BIOS-e820: 000000007ffbe000 - 000000007ffe0000 (ACPI NVS)
Aug 18 21:27:54 picard kernel: BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
Aug 18 21:27:54 picard kernel: BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 18 21:27:54 picard kernel: BIOS-e820: 00000000fecc0000 - 00000000fecc1000 (reserved)
Aug 18 21:27:54 picard kernel: BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
Aug 18 21:27:54 picard kernel: end_pfn_map = 1048576
Aug 18 21:27:54 picard kernel: DMI present.
Aug 18 21:27:54 picard kernel: ACPI: RSDP 000FA960, 0024 (r2 ACPIAM)
Aug 18 21:27:54 picard kernel: ACPI: XSDT 7FFB0100, 0054 (r1 A_M_I_ OEMXSDT   2000821 MSFT       97)
Aug 18 21:27:54 picard kernel: ACPI: FACP 7FFB0290, 00F4 (r3 A_M_I_ OEMFACP   2000821 MSFT       97)
Aug 18 21:27:54 picard kernel: ACPI: DSDT 7FFB05C0, 4E3F (r1  A0498 A0498000        0 INTL 20060113)
Aug 18 21:27:54 picard kernel: ACPI: FACS 7FFBE000, 0040
Aug 18 21:27:54 picard kernel: ACPI: APIC 7FFB0390, 0068 (r1 A_M_I_ OEMAPIC   2000821 MSFT       97)
Aug 18 21:27:54 picard kernel: ACPI: MCFG 7FFB0400, 003C (r1 A_M_I_ OEMMCFG   2000821 MSFT       97)
Aug 18 21:27:54 picard kernel: ACPI: OEMB 7FFBE040, 0060 (r1 A_M_I_ AMI_OEM   2000821 MSFT       97)
Aug 18 21:27:54 picard kernel: ACPI: HPET 7FFB5400, 0038 (r1 A_M_I_ OEMHPET   2000821 MSFT       97)
Aug 18 21:27:54 picard kernel: ACPI: SSDT 7FFB5440, 030E (r1 A_M_I_ POWERNOW        1 AMD         1)
Aug 18 21:27:54 picard kernel: Scanning NUMA topology in Northbridge 24
Aug 18 21:27:54 picard kernel: No NUMA configuration found
Aug 18 21:27:54 picard kernel: Faking a node at 0000000000000000-000000007ffb0000
Aug 18 21:27:54 picard kernel: Bootmem setup node 0 0000000000000000-000000007ffb0000
Aug 18 21:27:54 picard kernel:  NODE_DATA [000000000000c000 - 0000000000013fff]
Aug 18 21:27:54 picard kernel:  bootmap [0000000000014000 -  0000000000023ff7] pages 10
Aug 18 21:27:54 picard kernel: early res: 0 [0-fff] BIOS data page
Aug 18 21:27:54 picard kernel: early res: 1 [6000-7fff] SMP_TRAMPOLINE
Aug 18 21:27:54 picard kernel: early res: 2 [200000-75223b] TEXT DATA BSS
Aug 18 21:27:54 picard kernel: early res: 3 [37d18000-37fef5c6] RAMDISK
Aug 18 21:27:54 picard kernel: early res: 4 [9fc00-a0bff] EBDA
Aug 18 21:27:54 picard kernel: early res: 5 [8000-bfff] PGTABLE
Aug 18 21:27:54 picard kernel: Zone PFN ranges:
Aug 18 21:27:54 picard kernel:  DMA             0 ->     4096
Aug 18 21:27:54 picard kernel:  DMA32        4096 ->  1048576
Aug 18 21:27:54 picard kernel:  Normal    1048576 ->  1048576
Aug 18 21:27:54 picard kernel: Movable zone start PFN for each node
Aug 18 21:27:54 picard kernel: early_node_map[2] active PFN ranges
Aug 18 21:27:54 picard kernel:    0:        0 ->      159
Aug 18 21:27:54 picard kernel:    0:      256 ->   524208
Aug 18 21:27:54 picard kernel: Detected use of extended apic ids on hypertransport bus
Aug 18 21:27:54 picard kernel: ACPI: PM-Timer IO Port: 0x808
Aug 18 21:27:54 picard kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Aug 18 21:27:54 picard kernel: Processor #0 (Bootup-CPU)
Aug 18 21:27:54 picard kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Aug 18 21:27:54 picard kernel: Processor #1
Aug 18 21:27:54 picard kernel: ACPI: HPET id: 0x11068201 base: 0xfed00000
Aug 18 21:27:54 picard kernel: Using ACPI for processor (LAPIC) configuration information
Aug 18 21:27:54 picard kernel: Intel MultiProcessor Specification v1.4
Aug 18 21:27:54 picard kernel: MPTABLE: OEM ID: TEMPLATE MPTABLE: Product ID:  MPTABLE: APIC at: 0xFEE00000
Aug 18 21:27:54 picard kernel: I/O APIC #2 at 0xFEC00000.
Aug 18 21:27:54 picard kernel: I/O APIC #3 at 0xFECC0000.
Aug 18 21:27:54 picard kernel: Setting APIC routing to flat
Aug 18 21:27:54 picard kernel: Processors: 2
Aug 18 21:27:54 picard kernel: PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
Aug 18 21:27:54 picard kernel: PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
Aug 18 21:27:54 picard kernel: PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
Aug 18 21:27:54 picard kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Aug 18 21:27:54 picard kernel: SMP: Allowing 2 CPUs, 0 hotplug CPUs
Aug 18 21:27:54 picard kernel: PERCPU: Allocating 42688 bytes of per cpu data
Aug 18 21:27:54 picard kernel: Built 1 zonelists in Node order, mobility grouping on.  Total pages: 515573
Aug 18 21:27:54 picard kernel: Policy zone: DMA32
Aug 18 21:27:54 picard kernel: Kernel command line: ro root=/dev/sda5 rhgb quiet pci=noacpi
Aug 18 21:27:54 picard kernel: Initializing CPU#0
Aug 18 21:27:54 picard kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Aug 18 21:27:54 picard kernel: Extended CMOS year: 2000
Aug 18 21:27:54 picard kernel: TSC calibrated against PM_TIMER
Aug 18 21:27:54 picard kernel: Marking TSC unstable due to TSCs unsynchronized
Aug 18 21:27:54 picard kernel: time.c: Detected 2999.658 MHz processor.
Aug 18 21:27:54 picard kernel: Console: colour VGA+ 80x25
Aug 18 21:27:54 picard kernel: console [tty0] enabled
Aug 18 21:27:54 picard kernel: Checking aperture...
Aug 18 21:27:54 picard kernel: Node 0: aperture @ 17b8000000 size 32 MB
Aug 18 21:27:54 picard kernel: Aperture beyond 4GB. Ignoring.
Aug 18 21:27:54 picard kernel: No AGP bridge found
Aug 18 21:27:54 picard kernel: Memory: 2059016k/2096832k available (2629k kernel code, 37428k reserved, 1382k data, 352k init)
Aug 18 21:27:54 picard kernel: SLUB: Genslabs=13, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Aug 18 21:27:54 picard kernel: Calibrating delay using timer specific routine.. 6001.80 BogoMIPS (lpj=3000904)
Aug 18 21:27:54 picard kernel: Security Framework initialized
Aug 18 21:27:54 picard kernel: SELinux:  Initializing.
Aug 18 21:27:54 picard kernel: selinux_register_security:  Registering secondary module capability
Aug 18 21:27:54 picard kernel: Capability LSM initialized as secondary
Aug 18 21:27:54 picard kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Aug 18 21:27:54 picard kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Aug 18 21:27:54 picard kernel: Mount-cache hash table entries: 256
Aug 18 21:27:54 picard kernel: Initializing cgroup subsys ns
Aug 18 21:27:54 picard kernel: Initializing cgroup subsys cpuacct
Aug 18 21:27:54 picard kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 18 21:27:54 picard kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Aug 18 21:27:54 picard kernel: CPU 0/0 -> Node 0
Aug 18 21:27:54 picard kernel: CPU: Physical Processor ID: 0
Aug 18 21:27:54 picard kernel: CPU: Processor Core ID: 0
Aug 18 21:27:54 picard kernel: ACPI: Core revision 20070126
Aug 18 21:27:54 picard kernel: ACPI: setting ELCR to 0e28 (from 0c28)
Aug 18 21:27:54 picard kernel: Using local APIC timer interrupts.
Aug 18 21:27:54 picard kernel: Detected 12.498 MHz APIC timer.
Aug 18 21:27:54 picard kernel: Booting processor 1/2 APIC 0x1
Aug 18 21:27:54 picard kernel: Initializing CPU#1
Aug 18 21:27:54 picard kernel: Calibrating delay using timer specific routine.. 5999.16 BogoMIPS (lpj=2999584)
Aug 18 21:27:54 picard kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 18 21:27:54 picard kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Aug 18 21:27:54 picard kernel: CPU 1/1 -> Node 0
Aug 18 21:27:54 picard kernel: CPU: Physical Processor ID: 0
Aug 18 21:27:54 picard kernel: CPU: Processor Core ID: 1
Aug 18 21:27:54 picard kernel: AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ stepping 03
Aug 18 21:27:54 picard kernel: Brought up 2 CPUs
Aug 18 21:27:54 picard kernel: net_namespace: 1016 bytes
Aug 18 21:27:54 picard kernel: Time: 20:27:18  Date: 08/18/08
Aug 18 21:27:54 picard kernel: NET: Registered protocol family 16
Aug 18 21:27:54 picard kernel: No dock devices found.
Aug 18 21:27:54 picard kernel: ACPI: bus type pci registered
Aug 18 21:27:54 picard kernel: PCI: Using configuration type 1
Aug 18 21:27:54 picard kernel: ACPI: Interpreter enabled
Aug 18 21:27:54 picard kernel: ACPI: (supports S0 S1 S3 S4 S5)
Aug 18 21:27:54 picard kernel: ACPI: Using PIC for interrupt routing
Aug 18 21:27:54 picard kernel: ACPI: Error attaching device data
Aug 18 21:27:54 picard kernel: ACPI: Error attaching device data
Aug 18 21:27:54 picard kernel: ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  A5, should be 98 [20070126]
Aug 18 21:27:54 picard kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 18 21:27:54 picard kernel: pnp: PnP ACPI init
Aug 18 21:27:54 picard kernel: ACPI: bus type pnp registered
Aug 18 21:27:54 picard kernel: pnp: PnP ACPI: found 17 devices
Aug 18 21:27:54 picard kernel: ACPI: ACPI bus type pnp unregistered
Aug 18 21:27:54 picard kernel: usbcore: registered new interface driver usbfs
Aug 18 21:27:54 picard kernel: usbcore: registered new interface driver hub
Aug 18 21:27:54 picard kernel: usbcore: registered new device driver usb
Aug 18 21:27:54 picard kernel: PCI: Probing PCI hardware
Aug 18 21:27:54 picard kernel: PCI: Transparent bridge - 0000:00:13.1
Aug 18 21:27:54 picard kernel: PCI: Using IRQ router default [1106/3337] at 0000:00:11.0
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 27
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:03.0[A] -> IRQ 31
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:03.1[B] -> IRQ 35
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:03.2[C] -> IRQ 39
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:03.3[D] -> IRQ 43
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:10.0[A] -> IRQ 20
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:10.1[B] -> IRQ 22
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:10.2[C] -> IRQ 21
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:10.3[D] -> IRQ 23
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:00:10.4[C] -> IRQ 21
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 24
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:04:00.0[A] -> IRQ 36
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:80:01.0[A] -> IRQ 17
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:07:06.0[A] -> IRQ 16
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:07:07.0[A] -> IRQ 17
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:07:07.1[B] -> IRQ 18
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:07:07.2[C] -> IRQ 19
Aug 18 21:27:54 picard kernel: PCI->APIC IRQ transform: 0000:07:08.0[A] -> IRQ 18
Aug 18 21:27:54 picard kernel: NetLabel: Initializing
Aug 18 21:27:54 picard kernel: NetLabel:  domain hash size = 128
Aug 18 21:27:54 picard kernel: NetLabel:  protocols = UNLABELED CIPSOv4
Aug 18 21:27:54 picard kernel: NetLabel:  unlabeled traffic allowed by default
Aug 18 21:27:54 picard kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Aug 18 21:27:54 picard kernel: hpet0: 3 32-bit timers, 14318180 Hz
Aug 18 21:27:54 picard kernel: ACPI: RTC can wake from S4
Aug 18 21:27:54 picard kernel: system 00:06: ioport range 0xc00-0xc0f has been reserved
Aug 18 21:27:54 picard kernel: system 00:06: ioport range 0xd00-0xd0f has been reserved
Aug 18 21:27:54 picard kernel: system 00:06: ioport range 0xa20-0xa2f has been reserved
Aug 18 21:27:54 picard kernel: system 00:06: ioport range 0xa30-0xa3f has been reserved
Aug 18 21:27:54 picard kernel: system 00:08: ioport range 0x3e0-0x3e7 has been reserved
Aug 18 21:27:54 picard kernel: system 00:08: ioport range 0x4d0-0x4d1 has been reserved
Aug 18 21:27:54 picard kernel: system 00:08: ioport range 0x800-0x87f has been reserved
Aug 18 21:27:54 picard kernel: system 00:08: ioport range 0x400-0x41f has been reserved
Aug 18 21:27:54 picard kernel: system 00:0b: iomem range 0xfec00000-0xfec00fff could not be reserved
Aug 18 21:27:54 picard kernel: system 00:0b: iomem range 0xfee00000-0xfee00fff could not be reserved
Aug 18 21:27:54 picard kernel: system 00:0f: iomem range 0xe0000000-0xefffffff has been reserved
Aug 18 21:27:54 picard kernel: system 00:10: iomem range 0x0-0x9ffff could not be reserved
Aug 18 21:27:54 picard kernel: system 00:10: iomem range 0xc0000-0xcffff has been reserved
Aug 18 21:27:54 picard kernel: system 00:10: iomem range 0xe0000-0xfffff could not be reserved
Aug 18 21:27:54 picard kernel: system 00:10: iomem range 0x100000-0x7fffffff could not be reserved
Aug 18 21:27:54 picard kernel: system 00:10: iomem range 0xff380000-0xffffffff could not be reserved
Aug 18 21:27:54 picard kernel: PCI: Bridge: 0000:00:01.0
Aug 18 21:27:54 picard kernel:  IO window: disabled.
Aug 18 21:27:54 picard kernel:  MEM window: disabled.
Aug 18 21:27:54 picard kernel:  PREFETCH window: disabled.
Aug 18 21:27:54 picard kernel: PCI: Bridge: 0000:00:02.0
Aug 18 21:27:54 picard kernel:  IO window: d000-dfff
Aug 18 21:27:54 picard kernel:  MEM window: 0xf9000000-0xfb4fffff
Aug 18 21:27:54 picard kernel:  PREFETCH window: 0x00000000d0000000-0x00000000dfffffff
Aug 18 21:27:54 picard kernel: PCI: Bridge: 0000:00:03.0
Aug 18 21:27:54 picard kernel:  IO window: disabled.
Aug 18 21:27:54 picard kernel:  MEM window: disabled.
Aug 18 21:27:54 picard kernel:  PREFETCH window: 0x00000000f5f00000-0x00000000f5ffffff
Aug 18 21:27:54 picard kernel: PCI: Bridge: 0000:00:03.1
Aug 18 21:27:54 picard kernel:  IO window: disabled.
Aug 18 21:27:54 picard kernel:  MEM window: disabled.
Aug 18 21:27:54 picard kernel:  PREFETCH window: 0x00000000f5e00000-0x00000000f5efffff
Aug 18 21:27:54 picard kernel: PCI: Bridge: 0000:00:03.2
Aug 18 21:27:54 picard kernel:  IO window: disabled.
Aug 18 21:27:54 picard kernel:  MEM window: 0xfb500000-0xfb5fffff
Aug 18 21:27:54 picard kernel:  PREFETCH window: disabled.
Aug 18 21:27:54 picard kernel: PCI: Bridge: 0000:00:03.3
Aug 18 21:27:54 picard kernel:  IO window: disabled.
Aug 18 21:27:54 picard kernel:  MEM window: disabled.
Aug 18 21:27:54 picard kernel:  PREFETCH window: 0x00000000f5d00000-0x00000000f5dfffff
Aug 18 21:27:54 picard kernel: PCI: Bridge: 0000:00:13.0
Aug 18 21:27:54 picard kernel:  IO window: disabled.
Aug 18 21:27:54 picard kernel:  MEM window: 0xfbf00000-0xfbffffff
Aug 18 21:27:54 picard kernel:  PREFETCH window: disabled.
Aug 18 21:27:54 picard kernel: PCI: Bus 8, cardbus bridge: 0000:07:06.0
Aug 18 21:27:54 picard kernel:  IO window: 0x0000e000-0x0000e0ff
Aug 18 21:27:54 picard kernel:  IO window: 0x0000e400-0x0000e4ff
Aug 18 21:27:54 picard kernel:  PREFETCH window: 0x88000000-0x8bffffff
Aug 18 21:27:54 picard kernel:  MEM window: 0x8c000000-0x8fffffff
Aug 18 21:27:54 picard kernel: PCI: Bridge: 0000:00:13.1
Aug 18 21:27:54 picard kernel:  IO window: e000-efff
Aug 18 21:27:54 picard kernel:  MEM window: 0xfb600000-0xfbefffff
Aug 18 21:27:54 picard kernel:  PREFETCH window: 0x00000000f6000000-0x00000000f7ffffff
Aug 18 21:27:54 picard kernel: NET: Registered protocol family 2
Aug 18 21:27:54 picard kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Aug 18 21:27:54 picard kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Aug 18 21:27:54 picard kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Aug 18 21:27:54 picard kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug 18 21:27:54 picard kernel: TCP reno registered
Aug 18 21:27:54 picard kernel: checking if image is initramfs... it is
Aug 18 21:27:54 picard kernel: Freeing initrd memory: 2909k freed
Aug 18 21:27:54 picard kernel: audit: initializing netlink socket (disabled)
Aug 18 21:27:54 picard kernel: type=2000 audit(1219091238.338:1): initialized
Aug 18 21:27:54 picard kernel: Total HugeTLB memory allocated, 0
Aug 18 21:27:54 picard kernel: VFS: Disk quotas dquot_6.5.1
Aug 18 21:27:54 picard kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Aug 18 21:27:54 picard kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
Aug 18 21:27:54 picard kernel: io scheduler noop registered
Aug 18 21:27:54 picard kernel: io scheduler anticipatory registered
Aug 18 21:27:54 picard kernel: io scheduler deadline registered
Aug 18 21:27:54 picard kernel: io scheduler cfq registered (default)
Aug 18 21:27:54 picard kernel: pci 0000:00:00.0: MSI quirk detected; MSI disabled
Aug 18 21:27:54 picard kernel: PCI: VIA PCI bridge detected. Disabling DAC.
Aug 18 21:27:54 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 21:27:54 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 21:27:54 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 21:27:54 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 21:27:54 picard kernel: assign_interrupt_mode Found MSI capability
Aug 18 21:27:54 picard kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Aug 18 21:27:54 picard kernel: ACPI: ACPI0007:00 is registered as cooling_device0
Aug 18 21:27:54 picard kernel: ACPI: Processor [P001] (supports 16 throttling states)
Aug 18 21:27:54 picard kernel: ACPI: ACPI0007:01 is registered as cooling_device1
Aug 18 21:27:54 picard kernel: Non-volatile memory driver v1.2
Aug 18 21:27:54 picard kernel: Linux agpgart interface v0.103
Aug 18 21:27:54 picard kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Aug 18 21:27:54 picard kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 18 21:27:54 picard kernel: 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 18 21:27:54 picard kernel: brd: module loaded
Aug 18 21:27:54 picard kernel: input: Macintosh mouse button emulation as /devices/virtual/input/input0
Aug 18 21:27:54 picard kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Aug 18 21:27:54 picard kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 18 21:27:54 picard kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 18 21:27:54 picard kernel: mice: PS/2 mouse device common for all mice
Aug 18 21:27:54 picard kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
Aug 18 21:27:54 picard kernel: rtc_cmos 00:0a: rtc core: registered rtc_cmos as rtc0
Aug 18 21:27:54 picard kernel: rtc0: alarms up to one year, y3k
Aug 18 21:27:54 picard kernel: cpuidle: using governor ladder
Aug 18 21:27:54 picard kernel: cpuidle: using governor menu
Aug 18 21:27:54 picard kernel: usbcore: registered new interface driver hiddev
Aug 18 21:27:54 picard kernel: usbcore: registered new interface driver usbhid
Aug 18 21:27:54 picard kernel: drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Aug 18 21:27:54 picard kernel: TCP cubic registered
Aug 18 21:27:54 picard kernel: Initializing XFRM netlink socket
Aug 18 21:27:54 picard kernel: NET: Registered protocol family 1
Aug 18 21:27:54 picard kernel: NET: Registered protocol family 17
Aug 18 21:27:54 picard kernel: registered taskstats version 1
Aug 18 21:27:54 picard kernel:  Magic number: 4:413:498
Aug 18 21:27:54 picard kernel: Freeing unused kernel memory: 352k freed
Aug 18 21:27:54 picard kernel: Write protecting the kernel read-only data: 1112k
Aug 18 21:27:54 picard kernel: ehci_hcd 0000:00:10.4: EHCI Host Controller
Aug 18 21:27:54 picard kernel: ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
Aug 18 21:27:54 picard kernel: ehci_hcd 0000:00:10.4: irq 21, io mem 0xf8fffc00
Aug 18 21:27:54 picard kernel: ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Aug 18 21:27:54 picard kernel: usb usb1: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: hub 1-0:1.0: USB hub found
Aug 18 21:27:54 picard kernel: hub 1-0:1.0: 8 ports detected
Aug 18 21:27:54 picard kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Aug 18 21:27:54 picard kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 21:27:54 picard kernel: usb usb1: Product: EHCI Host Controller
Aug 18 21:27:54 picard kernel: usb usb1: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 ehci_hcd
Aug 18 21:27:54 picard kernel: usb usb1: SerialNumber: 0000:00:10.4
Aug 18 21:27:54 picard kernel: ehci_hcd 0000:07:07.2: EHCI Host Controller
Aug 18 21:27:54 picard kernel: ehci_hcd 0000:07:07.2: new USB bus registered, assigned bus number 2
Aug 18 21:27:54 picard kernel: ehci_hcd 0000:07:07.2: irq 19, io mem 0xfb6ffc00
Aug 18 21:27:54 picard kernel: ehci_hcd 0000:07:07.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Aug 18 21:27:54 picard kernel: usb usb2: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: hub 2-0:1.0: USB hub found
Aug 18 21:27:54 picard kernel: hub 2-0:1.0: 5 ports detected
Aug 18 21:27:54 picard kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
Aug 18 21:27:54 picard kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 21:27:54 picard kernel: usb usb2: Product: EHCI Host Controller
Aug 18 21:27:54 picard kernel: usb usb2: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 ehci_hcd
Aug 18 21:27:54 picard kernel: usb usb2: SerialNumber: 0000:07:07.2
Aug 18 21:27:54 picard kernel: ohci_hcd 0000:07:07.0: OHCI Host Controller
Aug 18 21:27:54 picard kernel: ohci_hcd 0000:07:07.0: new USB bus registered, assigned bus number 3
Aug 18 21:27:54 picard kernel: ohci_hcd 0000:07:07.0: irq 17, io mem 0xfb6fd000
Aug 18 21:27:54 picard kernel: usb usb3: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: hub 3-0:1.0: USB hub found
Aug 18 21:27:54 picard kernel: hub 3-0:1.0: 3 ports detected
Aug 18 21:27:54 picard kernel: hub 1-0:1.0: unable to enumerate USB device on port 2
Aug 18 21:27:54 picard kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 21:27:54 picard kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 21:27:54 picard kernel: usb usb3: Product: OHCI Host Controller
Aug 18 21:27:54 picard kernel: usb usb3: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 ohci_hcd
Aug 18 21:27:54 picard kernel: usb usb3: SerialNumber: 0000:07:07.0
Aug 18 21:27:54 picard kernel: ohci_hcd 0000:07:07.1: OHCI Host Controller
Aug 18 21:27:54 picard kernel: ohci_hcd 0000:07:07.1: new USB bus registered, assigned bus number 4
Aug 18 21:27:54 picard kernel: ohci_hcd 0000:07:07.1: irq 18, io mem 0xfb6fe000
Aug 18 21:27:54 picard kernel: input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
Aug 18 21:27:54 picard kernel: usb usb4: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: hub 4-0:1.0: USB hub found
Aug 18 21:27:54 picard kernel: hub 4-0:1.0: 2 ports detected
Aug 18 21:27:54 picard kernel: usb 1-6: new high speed USB device using ehci_hcd and address 3
Aug 18 21:27:54 picard kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 21:27:54 picard kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 21:27:54 picard kernel: usb usb4: Product: OHCI Host Controller
Aug 18 21:27:54 picard kernel: usb usb4: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 ohci_hcd
Aug 18 21:27:54 picard kernel: usb usb4: SerialNumber: 0000:07:07.1
Aug 18 21:27:54 picard kernel: USB Universal Host Controller Interface driver v3.0
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 5
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.0: irq 20, io base 0x0000c480
Aug 18 21:27:54 picard kernel: usb usb5: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: hub 5-0:1.0: USB hub found
Aug 18 21:27:54 picard kernel: hub 5-0:1.0: 2 ports detected
Aug 18 21:27:54 picard kernel: usb 1-6: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: usb 1-6: New USB device found, idVendor=152e, idProduct=2507
Aug 18 21:27:54 picard kernel: usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Aug 18 21:27:54 picard kernel: usb 1-6: Product: Super Multi Rewriter
Aug 18 21:27:54 picard kernel: usb 1-6: Manufacturer: HLDS Inc.
Aug 18 21:27:54 picard kernel: usb 1-6: SerialNumber: P01070317095617
Aug 18 21:27:54 picard kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 21:27:54 picard kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 21:27:54 picard kernel: usb usb5: Product: UHCI Host Controller
Aug 18 21:27:54 picard kernel: usb usb5: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 uhci_hcd
Aug 18 21:27:54 picard kernel: usb usb5: SerialNumber: 0000:00:10.0
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 6
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.1: irq 22, io base 0x0000c800
Aug 18 21:27:54 picard kernel: usb usb6: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: hub 6-0:1.0: USB hub found
Aug 18 21:27:54 picard kernel: hub 6-0:1.0: 2 ports detected
Aug 18 21:27:54 picard kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 21:27:54 picard kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 21:27:54 picard kernel: usb usb6: Product: UHCI Host Controller
Aug 18 21:27:54 picard kernel: usb usb6: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 uhci_hcd
Aug 18 21:27:54 picard kernel: usb usb6: SerialNumber: 0000:00:10.1
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 7
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c880
Aug 18 21:27:54 picard kernel: usb usb7: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: hub 7-0:1.0: USB hub found
Aug 18 21:27:54 picard kernel: hub 7-0:1.0: 2 ports detected
Aug 18 21:27:54 picard kernel: usb 1-7: new high speed USB device using ehci_hcd and address 4
Aug 18 21:27:54 picard kernel: usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 21:27:54 picard kernel: usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 21:27:54 picard kernel: usb usb7: Product: UHCI Host Controller
Aug 18 21:27:54 picard kernel: usb usb7: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 uhci_hcd
Aug 18 21:27:54 picard kernel: usb usb7: SerialNumber: 0000:00:10.2
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.3: UHCI Host Controller
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 8
Aug 18 21:27:54 picard kernel: uhci_hcd 0000:00:10.3: irq 23, io base 0x0000cc00
Aug 18 21:27:54 picard kernel: usb usb8: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: hub 8-0:1.0: USB hub found
Aug 18 21:27:54 picard kernel: hub 8-0:1.0: 2 ports detected
Aug 18 21:27:54 picard kernel: usb 1-7: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: usb 1-7: New USB device found, idVendor=05e3, idProduct=070e
Aug 18 21:27:54 picard kernel: usb 1-7: New USB device strings: Mfr=3, Product=4, SerialNumber=5
Aug 18 21:27:54 picard kernel: usb 1-7: Product: USB Reader
Aug 18 21:27:54 picard kernel: usb 1-7: Manufacturer: Genesys
Aug 18 21:27:54 picard kernel: usb 1-7: SerialNumber: 000000459031
Aug 18 21:27:54 picard kernel: usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
Aug 18 21:27:54 picard kernel: usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Aug 18 21:27:54 picard kernel: usb usb8: Product: UHCI Host Controller
Aug 18 21:27:54 picard kernel: usb usb8: Manufacturer: Linux 2.6.25.14-108.fc9.x86_64 uhci_hcd
Aug 18 21:27:54 picard kernel: usb usb8: SerialNumber: 0000:00:10.3
Aug 18 21:27:54 picard kernel: SCSI subsystem initialized
Aug 18 21:27:54 picard kernel: Driver 'sd' needs updating - please use bus_type methods
Aug 18 21:27:54 picard kernel: scsi0 : pata_via
Aug 18 21:27:54 picard kernel: scsi1 : pata_via
Aug 18 21:27:54 picard kernel: ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
Aug 18 21:27:54 picard kernel: ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
Aug 18 21:27:54 picard kernel: ata1.00: ATA-7: Hitachi HDS721616PLAT80, P22OA8BA, max UDMA/133
Aug 18 21:27:54 picard kernel: ata1.00: 312581808 sectors, multi 16: LBA48 
Aug 18 21:27:54 picard kernel: ata1.01: ATA-7: Maxtor 6L200P0, BAH41G10, max UDMA/133
Aug 18 21:27:54 picard kernel: ata1.01: 398297088 sectors, multi 16: LBA48 
Aug 18 21:27:54 picard kernel: ata1.00: configured for UDMA/133
Aug 18 21:27:54 picard kernel: ata1.01: configured for UDMA/133
Aug 18 21:27:54 picard kernel: usb 2-5: new high speed USB device using ehci_hcd and address 2
Aug 18 21:27:54 picard kernel: usb 2-5: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: usb 2-5: New USB device found, idVendor=04b8, idProduct=011e
Aug 18 21:27:54 picard kernel: usb 2-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Aug 18 21:27:54 picard kernel: usb 2-5: Product: EPSON Scanner
Aug 18 21:27:54 picard kernel: usb 2-5: Manufacturer: EPSON
Aug 18 21:27:54 picard kernel: ata2.00: ATAPI: ATAPI   DVD A  DH20A3P, XY12, max UDMA/66
Aug 18 21:27:54 picard kernel: usb 5-2: new full speed USB device using uhci_hcd and address 2
Aug 18 21:27:54 picard kernel: ata2.00: configured for UDMA/66
Aug 18 21:27:54 picard kernel: scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72161 P22O PQ: 0 ANSI: 5
Aug 18 21:27:54 picard kernel: sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
Aug 18 21:27:54 picard kernel: sd 0:0:0:0: [sda] Write Protect is off
Aug 18 21:27:54 picard kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 18 21:27:54 picard kernel: sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
Aug 18 21:27:54 picard kernel: sd 0:0:0:0: [sda] Write Protect is off
Aug 18 21:27:54 picard kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 18 21:27:54 picard kernel: sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Aug 18 21:27:54 picard kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Aug 18 21:27:54 picard kernel: scsi 0:0:1:0: Direct-Access     ATA      Maxtor 6L200P0   BAH4 PQ: 0 ANSI: 5
Aug 18 21:27:54 picard kernel: sd 0:0:1:0: [sdb] 398297088 512-byte hardware sectors (203928 MB)
Aug 18 21:27:54 picard kernel: sd 0:0:1:0: [sdb] Write Protect is off
Aug 18 21:27:54 picard kernel: sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 18 21:27:54 picard kernel: sd 0:0:1:0: [sdb] 398297088 512-byte hardware sectors (203928 MB)
Aug 18 21:27:54 picard kernel: sd 0:0:1:0: [sdb] Write Protect is off
Aug 18 21:27:54 picard kernel: sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 18 21:27:54 picard kernel: sdb: sdb1 sdb2
Aug 18 21:27:54 picard kernel: sd 0:0:1:0: [sdb] Attached SCSI disk
Aug 18 21:27:54 picard kernel: scsi 1:0:0:0: CD-ROM            ATAPI    DVD A  DH20A3P   XY12 PQ: 0 ANSI: 5
Aug 18 21:27:54 picard kernel: usb 5-2: configuration #1 chosen from 1 choice
Aug 18 21:27:54 picard kernel: usb 5-2: New USB device found, idVendor=046d, idProduct=08b2
Aug 18 21:27:54 picard kernel: usb 5-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Aug 18 21:27:54 picard kernel: kjournald starting.  Commit interval 5 seconds
Aug 18 21:27:54 picard kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 18 21:27:54 picard kernel: SELinux:  Disabled at runtime.
Aug 18 21:27:54 picard kernel: type=1404 audit(1219091246.363:2): selinux=0 auid=4294967295 ses=4294967295
Aug 18 21:27:54 picard kernel: Floppy drive(s): fd0 is 1.44M
Aug 18 21:27:54 picard kernel: FDC 0 is a post-1991 82077
Aug 18 21:27:54 picard kernel: input: PC Speaker as /devices/platform/pcspkr/input/input3
Aug 18 21:27:54 picard kernel: ath_hal: module license 'Proprietary' taints kernel.
Aug 18 21:27:54 picard kernel: ath_hal: 0.9.18.0 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413, RF5413)
Aug 18 21:27:54 picard kernel: parport_pc 00:05: reported by Plug and Play ACPI
Aug 18 21:27:54 picard kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
Aug 18 21:27:54 picard kernel: wlan: 0.9.4
Aug 18 21:27:54 picard kernel: input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
Aug 18 21:27:54 picard kernel: ACPI: Power Button (FF) [PWRF]
Aug 18 21:27:54 picard kernel: input: Sleep Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input5
Aug 18 21:27:54 picard kernel: ACPI: Sleep Button (CM) [SLPB]
Aug 18 21:27:54 picard kernel: input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input6
Aug 18 21:27:54 picard kernel: ACPI: Power Button (CM) [PWRB]
Aug 18 21:27:54 picard kernel: Yenta: CardBus bridge found at 0000:07:06.0 [0000:0000]
Aug 18 21:27:54 picard kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Aug 18 21:27:54 picard kernel: sd 0:0:1:0: Attached scsi generic sg1 type 0
Aug 18 21:27:54 picard kernel: scsi 1:0:0:0: Attached scsi generic sg2 type 5
Aug 18 21:27:54 picard kernel: Driver 'sr' needs updating - please use bus_type methods
Aug 18 21:27:54 picard kernel: sr0: scsi3-mmc drive: 48x/12x writer dvd-ram cd/rw xa/form2 cdda tray
Aug 18 21:27:54 picard kernel: Uniform CD-ROM driver Revision: 3.20
Aug 18 21:27:54 picard kernel: ppdev: user-space parallel port driver
Aug 18 21:27:54 picard kernel: Yenta: ISA IRQ mask 0x0000, PCI irq 16
Aug 18 21:27:54 picard kernel: Socket status: 30000006
Aug 18 21:27:54 picard kernel: Yenta: Raising subordinate bus# of parent bus (#07) from #08 to #0b
Aug 18 21:27:54 picard kernel: pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
Aug 18 21:27:54 picard kernel: pcmcia: parent PCI bridge Memory window: 0xfb600000 - 0xfbefffff
Aug 18 21:27:54 picard kernel: pcmcia: parent PCI bridge Memory window: 0xf6000000 - 0xf7ffffff
Aug 18 21:27:54 picard kernel: Linux video capture interface: v2.00
Aug 18 21:27:54 picard kernel: Initializing USB Mass Storage driver...
Aug 18 21:27:54 picard kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Aug 18 21:27:54 picard kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Aug 18 21:27:54 picard kernel: usbcore: registered new interface driver usb-storage
Aug 18 21:27:54 picard kernel: USB Mass Storage support registered.
Aug 18 21:27:54 picard kernel: atl1 0000:04:00.0: version 2.0.7
Aug 18 21:27:54 picard kernel: ath_pci: 0.9.4
Aug 18 21:27:54 picard kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Aug 18 21:27:54 picard kernel: pwc: Philips webcam module version 10.0.13 loaded.
Aug 18 21:27:54 picard kernel: pwc: Supports Philips PCA645/646, PCVC675/680/690, PCVC720[40]/730/740/750 & PCVC830/840.
Aug 18 21:27:54 picard kernel: pwc: Also supports the Askey VC010, various Logitech Quickcams, Samsung MPC-C10 and MPC-C30,
Aug 18 21:27:54 picard kernel: pwc: the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
Aug 18 21:27:54 picard kernel: pwc: Logitech QuickCam 4000 Pro USB webcam detected.
Aug 18 21:27:54 picard kernel: pwc: Registered as /dev/video0.
Aug 18 21:27:54 picard kernel: usbcore: registered new interface driver Philips webcam
Aug 18 21:27:54 picard kernel: ath_rate_sample: 1.2 (0.9.4)
Aug 18 21:27:54 picard kernel: wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
Aug 18 21:27:54 picard kernel: wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Aug 18 21:27:54 picard kernel: wifi0: turboG rates: 6Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Aug 18 21:27:54 picard kernel: wifi0: H/W encryption support: WEP AES AES_CCM TKIP
Aug 18 21:27:54 picard kernel: wifi0: mac 7.9 phy 4.5 radio 5.6
Aug 18 21:27:54 picard kernel: wifi0: Use hw queue 1 for WME_AC_BE traffic
Aug 18 21:27:54 picard kernel: wifi0: Use hw queue 0 for WME_AC_BK traffic
Aug 18 21:27:54 picard kernel: wifi0: Use hw queue 2 for WME_AC_VI traffic
Aug 18 21:27:54 picard kernel: wifi0: Use hw queue 3 for WME_AC_VO traffic
Aug 18 21:27:54 picard kernel: wifi0: Use hw queue 8 for CAB traffic
Aug 18 21:27:54 picard kernel: wifi0: Use hw queue 9 for beacons
Aug 18 21:27:54 picard kernel: ALSA sound/usb/usbaudio.c:2798: 2:2:1: add audio endpoint 0x84
Aug 18 21:27:54 picard kernel: ALSA sound/usb/usbaudio.c:2798: 2:2:2: add audio endpoint 0x84
Aug 18 21:27:54 picard kernel: ALSA sound/usb/usbaudio.c:2798: 2:2:3: add audio endpoint 0x84
Aug 18 21:27:54 picard kernel: ALSA sound/usb/usbaudio.c:2798: 2:2:4: add audio endpoint 0x84
Aug 18 21:27:54 picard kernel: ALSA sound/usb/usbmixer.c:988: [2] FU [Mic Capture Switch] ch = 1, val = 0/1/1
Aug 18 21:27:54 picard kernel: wifi0: Atheros 5212: mem=0xfb6e0000, irq=18
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_intel.c:1810: chipset global capabilities = 0x4401
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_intel.c:749: codec_mask = 0x1
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:2236: hda_codec: model '3stack-660-digout' is selected for config 1043:81e7 (ASUS)
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Volume, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Center Playback Volume, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave LFE Playback Volume, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Side Playback Volume, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Headphone Playback Volume, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Volume, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Volume, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Line-Out Playback Volume, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Switch, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Center Playback Switch, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave LFE Playback Switch, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Side Playback Switch, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback Switch, skipped
Aug 18 21:27:54 picard kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback Switch, skipped
Aug 18 21:27:54 picard kernel: NVRM: loading NVIDIA UNIX x86_64 Kernel Module  173.14.12  Thu Jul 17 18:10:24 PDT 2008
Aug 18 21:27:54 picard kernel: ALSA sound/usb/usbmixer.c:405: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x201, type = 4, data = 0x0/0x5
Aug 18 21:27:54 picard kernel: ALSA sound/usb/usbmixer.c:988: [2] FU [Mic Capture Volume] ch = 1, val = 7680/15360/2560
Aug 18 21:27:54 picard kernel: usbcore: registered new interface driver snd-usb-audio
Aug 18 21:27:54 picard kernel: scsi 3:0:0:0: Direct-Access     Generic  STORAGE DEVICE   9325 PQ: 0 ANSI: 0
Aug 18 21:27:54 picard kernel: scsi 3:0:0:1: Direct-Access     Generic  STORAGE DEVICE   9325 PQ: 0 ANSI: 0
Aug 18 21:27:54 picard kernel: scsi 2:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-E40L  SE02 PQ: 0 ANSI: 0
Aug 18 21:27:54 picard kernel: sr1: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Aug 18 21:27:54 picard kernel: sr 2:0:0:0: Attached scsi generic sg3 type 5
Aug 18 21:27:54 picard kernel: sd 3:0:0:0: [sdc] Attached SCSI removable disk
Aug 18 21:27:54 picard kernel: sd 3:0:0:0: Attached scsi generic sg4 type 0
Aug 18 21:27:54 picard kernel: sd 3:0:0:1: [sdd] Attached SCSI removable disk
Aug 18 21:27:54 picard kernel: sd 3:0:0:1: Attached scsi generic sg5 type 0
Aug 18 21:27:54 picard kernel: device-mapper: uevent: version 1.0.3
Aug 18 21:27:54 picard kernel: device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
Aug 18 21:27:54 picard kernel: device-mapper: multipath: version 1.0.5 loaded
Aug 18 21:27:54 picard kernel: EXT3 FS on sda5, internal journal
Aug 18 21:27:54 picard kernel: kjournald starting.  Commit interval 5 seconds
Aug 18 21:27:54 picard kernel: EXT3 FS on sdb1, internal journal
Aug 18 21:27:54 picard kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 18 21:27:54 picard kernel: kjournald starting.  Commit interval 5 seconds
Aug 18 21:27:54 picard kernel: EXT3 FS on sda3, internal journal
Aug 18 21:27:54 picard kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 18 21:27:54 picard kernel: Adding 7799516k swap on /dev/sda6.  Priority:-1 extents:1 across:7799516k
Aug 18 21:27:54 picard kernel: Adding 7727256k swap on /dev/sdb2.  Priority:-2 extents:1 across:7727256k
Aug 18 21:27:54 picard kernel: powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 6000+ processors (2 cpu cores) (version 2.20.00)
Aug 18 21:27:54 picard kernel: powernow-k8:    0 : fid 0x16 (3000 MHz), vid 0x6
Aug 18 21:27:54 picard kernel: powernow-k8:    1 : fid 0x14 (2800 MHz), vid 0x8
Aug 18 21:27:54 picard kernel: powernow-k8:    2 : fid 0x12 (2600 MHz), vid 0xa
Aug 18 21:27:54 picard kernel: powernow-k8:    3 : fid 0x10 (2400 MHz), vid 0xc
Aug 18 21:27:54 picard kernel: powernow-k8:    4 : fid 0xe (2200 MHz), vid 0xe
Aug 18 21:27:54 picard kernel: powernow-k8:    5 : fid 0xc (2000 MHz), vid 0x10
Aug 18 21:27:54 picard kernel: powernow-k8:    6 : fid 0xa (1800 MHz), vid 0x10
Aug 18 21:27:54 picard kernel: powernow-k8:    7 : fid 0x2 (1000 MHz), vid 0x12
Aug 18 21:27:54 picard kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Aug 18 21:27:54 picard kernel: nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Aug 18 21:27:54 picard kernel: Clocksource tsc unstable (delta = -237784940 ns)
Aug 18 21:27:54 picard kernel: atl1 0000:04:00.0: Unable to enable MSI: -22
Aug 18 21:27:54 picard kernel: atl1 0000:04:00.0: eth0 link is up 1000 Mbps full duplex
Aug 18 21:27:54 picard rsyslogd: [origin software="rsyslogd" swVersion="3.18.1" x-pid="2151" x-info="http://www.rsyslog.com"] restart
Aug 18 21:27:55 picard rpc.statd[2197]: Version 1.1.2 Starting
Aug 18 21:27:55 picard kernel: RPC: Registered udp transport module.
Aug 18 21:27:55 picard kernel: RPC: Registered tcp transport module.
Aug 18 21:27:56 picard kernel: warning: `dbus-daemon' uses deprecated v2 capabilities in a way that may be insecure.
Aug 18 21:27:56 picard kernel: fuse init (API version 7.9)
Aug 18 21:27:56 picard pcscd: pcscdaemon.c:507:main() pcsc-lite 1.4.4 daemon ready.
Aug 18 21:27:56 picard acpid: starting up
Aug 18 21:27:58 picard acpid: client connected from 2408[68:68]
Aug 18 21:27:59 picard kernel: it87: Found IT8712F chip at 0xd00, revision 8
Aug 18 21:27:59 picard kernel: it87: in3 is VCC (+5V)
Aug 18 21:28:00 picard hcid[2499]: Bluetooth HCI daemon
Aug 18 21:28:00 picard kernel: Bluetooth: Core ver 2.11
Aug 18 21:28:00 picard kernel: NET: Registered protocol family 31
Aug 18 21:28:00 picard kernel: Bluetooth: HCI device and connection manager initialized
Aug 18 21:28:00 picard kernel: Bluetooth: HCI socket layer initialized
Aug 18 21:28:00 picard hcid[2499]: Parsing /etc/bluetooth/main.conf failed: No such file or directory
Aug 18 21:28:00 picard hcid[2499]: Starting SDP server
Aug 18 21:28:00 picard kernel: Bluetooth: L2CAP ver 2.9
Aug 18 21:28:00 picard kernel: Bluetooth: L2CAP socket layer initialized
Aug 18 21:28:00 picard kernel: Bluetooth: RFCOMM socket layer initialized
Aug 18 21:28:00 picard kernel: Bluetooth: RFCOMM TTY layer initialized
Aug 18 21:28:00 picard kernel: Bluetooth: RFCOMM ver 1.8
Aug 18 21:28:00 picard hcid[2499]: Registered manager path:/org/bluez/serial
Aug 18 21:28:00 picard hcid[2499]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
Aug 18 21:28:00 picard hcid[2499]: Registered input manager path:/org/bluez/input
Aug 18 21:28:00 picard kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Aug 18 21:28:00 picard kernel: Bluetooth: BNEP filters: protocol multicast
Aug 18 21:28:00 picard kernel: Bridge firewalling registered
Aug 18 21:28:00 picard kernel: pan0: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
Aug 18 21:28:00 picard hcid[2499]: bridge pan0 created
Aug 18 21:28:00 picard hcid[2499]: Registered manager path:/org/bluez/network
Aug 18 21:28:00 picard hcid[2499]: Registered server path:/org/bluez/network/nap
Aug 18 21:28:00 picard hcid[2499]: Registered server path:/org/bluez/network/gn
Aug 18 21:28:00 picard hcid[2499]: Registered server path:/org/bluez/network/panu
Aug 18 21:28:00 picard hcid[2499]: Unix socket created: 17
Aug 18 21:28:00 picard hcid[2499]: Registered manager path:/org/bluez/audio
Aug 18 21:28:03 picard ntpdate[2582]: step time server 66.187.233.4 offset 0.409093 sec
Aug 18 21:28:03 picard ntpd[2592]: ntpd 4.2.4p4@1.1520-o Mon Jul 28 11:13:24 UTC 2008 (1)
Aug 18 21:28:03 picard ntpd[2593]: precision = 0.908 usec
Aug 18 21:28:03 picard ntpd[2593]: Listening on interface #0 wildcard, 0.0.0.0#123 Disabled
Aug 18 21:28:03 picard ntpd[2593]: Listening on interface #1 lo, 127.0.0.1#123 Enabled
Aug 18 21:28:03 picard ntpd[2593]: Listening on interface #2 eth0, 192.168.2.10#123 Enabled
Aug 18 21:28:03 picard ntpd[2593]: Listening on interface #3 ath0, 192.168.1.10#123 Enabled
Aug 18 21:28:03 picard ntpd[2593]: kernel time sync status 0040
Aug 18 21:28:03 picard ntpd[2593]: frequency initialized 17.068 PPM from /var/lib/ntp/drift
Aug 18 21:28:03 picard ntpd[2593]: getaddrinfo: "::1" invalid host address, ignored
Aug 18 21:28:03 picard kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug 18 21:28:03 picard kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Aug 18 21:28:03 picard kernel: NFSD: starting 90-second grace period
Aug 18 21:28:05 picard dhcpd: Internet Systems Consortium DHCP Server 4.0.0
Aug 18 21:28:05 picard dhcpd: Copyright 2004-2007 Internet Systems Consortium.
Aug 18 21:28:05 picard dhcpd: All rights reserved.
Aug 18 21:28:05 picard dhcpd: For info, please visit http://www.isc.org/sw/dhcp/
Aug 18 21:28:05 picard dhcpd: Warning: subnet 192.168.2.0/24 overlaps subnet 192.168.2.0/24
Aug 18 21:28:05 picard dhcpd: Not searching LDAP since ldap-server, ldap-port and ldap-base-dn were not specified in the config file
Aug 18 21:28:05 picard dhcpd: Wrote 0 deleted host decls to leases file.
Aug 18 21:28:05 picard dhcpd: Wrote 0 new dynamic host decls to leases file.
Aug 18 21:28:05 picard dhcpd: Wrote 2 leases to leases file.
Aug 18 21:28:05 picard dhcpd: 
Aug 18 21:28:05 picard dhcpd: No subnet declaration for ath0 (192.168.1.10).
Aug 18 21:28:05 picard dhcpd: ** Ignoring requests on ath0.  If this is not what
Aug 18 21:28:05 picard dhcpd:    you want, please write a subnet declaration
Aug 18 21:28:05 picard dhcpd:    in your dhcpd.conf file for the network segment
Aug 18 21:28:05 picard dhcpd:    to which interface ath0 is attached. **
Aug 18 21:28:05 picard dhcpd: 
Aug 18 21:28:05 picard dhcpd: Listening on LPF/eth0/00:1b:fc:19:88:0a/192.168.2.0/24
Aug 18 21:28:05 picard dhcpd: Sending on   LPF/eth0/00:1b:fc:19:88:0a/192.168.2.0/24
Aug 18 21:28:05 picard dhcpd: Sending on   Socket/fallback/fallback-net
Aug 18 21:28:13 picard avahi-daemon[2926]: Found user 'avahi' (UID 498) and group 'avahi' (GID 494).
Aug 18 21:28:13 picard avahi-daemon[2926]: Successfully dropped root privileges.
Aug 18 21:28:13 picard avahi-daemon[2926]: avahi-daemon 0.6.22 starting up.
Aug 18 21:28:13 picard avahi-daemon[2926]: WARNING: No NSS support for mDNS detected, consider installing nss-mdns!
Aug 18 21:28:13 picard avahi-daemon[2926]: Successfully called chroot().
Aug 18 21:28:13 picard avahi-daemon[2926]: Successfully dropped remaining capabilities.
Aug 18 21:28:13 picard avahi-daemon[2926]: Loading service file /services/ssh.service.
Aug 18 21:28:13 picard avahi-daemon[2926]: Joining mDNS multicast group on interface ath0.IPv4 with address 192.168.1.10.
Aug 18 21:28:13 picard avahi-daemon[2926]: New relevant interface ath0.IPv4 for mDNS.
Aug 18 21:28:13 picard avahi-daemon[2926]: Joining mDNS multicast group on interface eth0.IPv4 with address 192.168.2.10.
Aug 18 21:28:13 picard avahi-daemon[2926]: New relevant interface eth0.IPv4 for mDNS.
Aug 18 21:28:13 picard avahi-daemon[2926]: Network interface enumeration completed.
Aug 18 21:28:13 picard avahi-daemon[2926]: Registering new address record for 192.168.1.10 on ath0.IPv4.
Aug 18 21:28:13 picard avahi-daemon[2926]: Registering new address record for 192.168.2.10 on eth0.IPv4.
Aug 18 21:28:13 picard avahi-daemon[2926]: Registering HINFO record with values 'X86_64'/'LINUX'.
Aug 18 21:28:14 picard avahi-daemon[2926]: Server startup complete. Host name is picard.local. Local service cookie is 4004474882.
Aug 18 21:28:14 picard cupsd[2935]: *** WARNING *** The program 'cupsd' uses the Apple Bonjour compatibility layer of Avahi.
Aug 18 21:28:14 picard cupsd[2935]: *** WARNING *** Please fix your application to use the native API of Avahi!
Aug 18 21:28:14 picard cupsd[2935]: *** WARNING *** For more information see <http://0pointer.de/avahi-compat?s=libdns_sd&e=cupsd>
Aug 18 21:28:15 picard kernel: lp0: using parport0 (interrupt-driven).
Aug 18 21:28:15 picard kernel: lp0: console ready
Aug 18 21:28:15 picard avahi-daemon[2926]: Service "picard" (/services/ssh.service) successfully established.
Aug 18 21:28:17 picard smartd[3003]: smartd version 5.38 [x86_64-redhat-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Aug 18 21:28:17 picard smartd[3003]: Home page is http://smartmontools.sourceforge.net/#012
Aug 18 21:28:17 picard smartd[3003]: Opened configuration file /etc/smartd.conf
Aug 18 21:28:17 picard smartd[3003]: Configuration file /etc/smartd.conf parsed.
Aug 18 21:28:17 picard smartd[3003]: Device: /dev/sdb, opened
Aug 18 21:28:17 picard smartd[3003]: Device: /dev/sdb, found in smartd database.
Aug 18 21:28:18 picard smartd[3003]: Device: /dev/sdb, is SMART capable. Adding to "monitor" list.
Aug 18 21:28:18 picard smartd[3003]: Device: /dev/sda, opened
Aug 18 21:28:18 picard smartd[3003]: Device: /dev/sda, found in smartd database.
Aug 18 21:28:18 picard smartd[3003]: Device: /dev/sda, is SMART capable. Adding to "monitor" list.
Aug 18 21:28:18 picard smartd[3003]: Monitoring 2 ATA and 0 SCSI devices
Aug 18 21:28:19 picard smartd[3005]: smartd has fork()ed into background mode. New PID=3005.
Aug 18 21:28:21 picard acpid: client connected from 3090[0:0]
Aug 18 21:28:22 picard acpid: client connected from 3090[0:0]
Aug 18 21:28:25 picard gconfd (gdm-3140): starting (version 2.22.0), pid 3140 user 'gdm'
Aug 18 21:28:25 picard gconfd (gdm-3140): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Aug 18 21:28:25 picard gconfd (gdm-3140): Resolved address "xml:readonly:/etc/gconf/gconf.xml.system" to a read-only configuration source at position 1
Aug 18 21:28:25 picard gconfd (gdm-3140): Resolved address "xml:readonly:/var/lib/gdm/.gconf.mandatory" to a read-only configuration source at position 2
Aug 18 21:28:25 picard gconfd (gdm-3140): Resolved address "xml:readwrite:/var/lib/gdm/.gconf" to a writable configuration source at position 3
Aug 18 21:28:25 picard gconfd (gdm-3140): Resolved address "xml:readonly:/etc/gconf/gconf.xml.system" to a read-only configuration source at position 4
Aug 18 21:28:25 picard gconfd (gdm-3140): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 5
Aug 18 21:28:29 picard pulseaudio[3181]: polkit.c: Cannot set UID on session object.
Aug 18 21:28:29 picard pulseaudio[3181]: main.c: Called SUID root and real-time/high-priority scheduling was requested in the configuration. However, we lack the necessary priviliges:
Aug 18 21:28:29 picard pulseaudio[3181]: main.c: We are not in group 'pulse-rt' and PolicyKit refuse to grant us priviliges. Dropping SUID again.
Aug 18 21:28:29 picard pulseaudio[3181]: main.c: For enabling real-time scheduling please acquire the appropriate PolicyKit priviliges, or become a member of 'pulse-rt', or increase the RLIMIT_NICE/RLIMIT_RTPRIO resource limits for this user.
Aug 18 21:28:29 picard pulseaudio[3181]: main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted
Aug 18 21:28:29 picard pulseaudio[3181]: main.c: setrlimit(RLIMIT_RTPRIO, (9, 9)) failed: Operation not permitted
Aug 18 21:28:29 picard kernel: hda-intel: Invalid position buffer, using LPIB read method instead.
Aug 18 21:28:29 picard gconfd (gdm-3140): Error setting value for `/apps/gnome-screensaver/power_management_delay': Can't overwrite existing read-only value: Value for `/apps/gnome-screensaver/power_management_delay' set in a read-only source at the front of your configuration path
Aug 18 21:28:29 picard gconfd (gdm-3140): Error setting value for `/apps/gnome-screensaver/power_management_delay': Can't overwrite existing read-only value: Value for `/apps/gnome-screensaver/power_management_delay' set in a read-only source at the front of your configuration path
Aug 18 21:28:29 picard kernel: ALSA sound/usb/usbaudio.c:1353: setting usb interface 2:1
Aug 18 21:28:29 picard pulseaudio[3181]: alsa-util.c: Device hw:0 doesn't support 2 channels, changed to 1.
Aug 18 21:30:20 picard gconfd (gdm-3140): Exiting
Aug 18 21:30:20 picard gconfd (gavin-3332): starting (version 2.22.0), pid 3332 user 'gavin'
Aug 18 21:30:20 picard gconfd (gavin-3332): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Aug 18 21:30:20 picard gconfd (gavin-3332): Resolved address "xml:readwrite:/home/gavin/.gconf" to a writable configuration source at position 1
Aug 18 21:30:20 picard gconfd (gavin-3332): Resolved address "xml:readonly:/etc/gconf/gconf.xml.system" to a read-only configuration source at position 2
Aug 18 21:30:20 picard gconfd (gavin-3332): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Aug 18 21:30:22 picard pulseaudio[3404]: main.c: Called SUID root and real-time/high-priority scheduling was requested in the configuration. However, we lack the necessary priviliges:
Aug 18 21:30:22 picard pulseaudio[3404]: main.c: We are not in group 'pulse-rt' and PolicyKit refuse to grant us priviliges. Dropping SUID again.
Aug 18 21:30:22 picard pulseaudio[3404]: main.c: For enabling real-time scheduling please acquire the appropriate PolicyKit priviliges, or become a member of 'pulse-rt', or increase the RLIMIT_NICE/RLIMIT_RTPRIO resource limits for this user.
Aug 18 21:30:22 picard pulseaudio[3404]: pid.c: Stale PID file, overwriting.
Aug 18 21:30:22 picard pulseaudio[3404]: main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted
Aug 18 21:30:22 picard pulseaudio[3404]: main.c: setrlimit(RLIMIT_RTPRIO, (9, 9)) failed: Operation not permitted
Aug 18 21:30:22 picard kernel: ALSA sound/usb/usbaudio.c:1353: setting usb interface 2:1
Aug 18 21:30:22 picard pulseaudio[3404]: alsa-util.c: Device hw:0 doesn't support 2 channels, changed to 1.
Aug 18 21:30:24 picard gconfd (gavin-3332): Resolved address "xml:readwrite:/home/gavin/.gconf" to a writable configuration source at position 0
Aug 18 21:30:25 picard pulseaudio[3404]: module-x11-xsmp.c: X11 session manager not running.
Aug 18 21:30:25 picard pulseaudio[3404]: module.c: Failed to load  module "module-x11-xsmp" (argument: ""): initialization failed.
Aug 18 21:30:25 picard hcid[2499]: Default passkey agent (:1.37, /org/bluez/passkey) registered
Aug 18 21:30:25 picard hcid[2499]: Default authorization agent (:1.37, /org/bluez/auth) registered
Aug 18 21:30:32 picard ntfs-3g[3568]: Version 1.2712 integrated FUSE 27
Aug 18 21:30:32 picard ntfs-3g[3568]: Mounted /dev/sda2 (Read-Write, label "STUFF", NTFS 3.1)
Aug 18 21:30:32 picard ntfs-3g[3568]: Cmdline options: rw,nosuid,nodev,uhelper=hal,locale=en_GB.utf8
Aug 18 21:30:32 picard ntfs-3g[3568]: Mount options: rw,nosuid,nodev,uhelper=hal,silent,allow_other,nonempty,relatime,fsname=/dev/sda2,blkdev,blksize=512
Aug 18 21:30:32 picard hald: mounted /dev/sda2 on behalf of uid 500
Aug 18 21:30:32 picard ntfs-3g[3574]: Version 1.2712 integrated FUSE 27
Aug 18 21:30:32 picard ntfs-3g[3574]: Mounted /dev/sda1 (Read-Write, label "WINDOWS", NTFS 3.1)
Aug 18 21:30:32 picard ntfs-3g[3574]: Cmdline options: rw,nosuid,nodev,uhelper=hal,locale=en_GB.utf8
Aug 18 21:30:32 picard ntfs-3g[3574]: Mount options: rw,nosuid,nodev,uhelper=hal,silent,allow_other,nonempty,relatime,fsname=/dev/sda1,blkdev,blksize=4096
Aug 18 21:30:32 picard hald: mounted /dev/sda1 on behalf of uid 500
Aug 18 21:32:23 picard ntpd[2593]: synchronized to 209.132.176.4, stratum 1
Aug 18 21:32:23 picard ntpd[2593]: kernel time sync status change 0001
Aug 18 21:34:54 picard hald: mounted /dev/sr0 on behalf of uid 500
Aug 18 21:34:54 picard gnome-keyring-daemon[3343]: adding removable location: volume_label_Top_Touch at /media/Top-Touch
Aug 18 21:35:45 picard hald: unmounted /dev/sr0 from '/media/Top-Touch' on behalf of uid 500
Aug 18 21:35:45 picard gnome-keyring-daemon[3343]: removing removable location: volume_label_Top_Touch
Aug 18 21:37:45 picard ntpd[2593]: synchronized to 66.187.233.4, stratum 1
Aug 18 21:38:50 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:38:50 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:38:50 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:38:50 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 21:38:50 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 21:38:50 picard kernel: ata2: soft resetting link
Aug 18 21:38:51 picard kernel: ata2.00: configured for UDMA/66
Aug 18 21:38:51 picard kernel: ata2: EH complete
Aug 18 21:39:02 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:39:02 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:39:02 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:39:02 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 21:39:02 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 21:39:02 picard kernel: ata2: soft resetting link
Aug 18 21:39:03 picard kernel: ata2.00: configured for UDMA/66
Aug 18 21:39:03 picard kernel: ata2: EH complete
Aug 18 21:40:49 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:40:49 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:40:49 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:40:49 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 21:40:49 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 21:40:49 picard kernel: ata2: soft resetting link
Aug 18 21:40:49 picard kernel: ata2.00: configured for UDMA/66
Aug 18 21:40:49 picard kernel: ata2: EH complete
Aug 18 21:41:54 picard kernel: ata2.00: limiting speed to UDMA/44:PIO4
Aug 18 21:41:54 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:41:54 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:41:54 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:41:54 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:41:54 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:41:54 picard kernel: ata2: soft resetting link
Aug 18 21:41:54 picard kernel: ata2.00: configured for UDMA/44
Aug 18 21:41:54 picard kernel: ata2: EH complete
Aug 18 21:42:17 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:42:17 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:42:17 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:42:17 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:42:17 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:42:17 picard kernel: ata2: soft resetting link
Aug 18 21:42:17 picard kernel: ata2.00: configured for UDMA/44
Aug 18 21:42:17 picard kernel: ata2: EH complete
Aug 18 21:42:29 picard kernel: ata2.00: limiting speed to UDMA/33:PIO4
Aug 18 21:42:29 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:42:29 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:42:29 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:42:29 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:42:29 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:42:29 picard kernel: ata2: soft resetting link
Aug 18 21:42:29 picard kernel: ata2.00: configured for UDMA/33
Aug 18 21:42:29 picard kernel: ata2: EH complete
Aug 18 21:45:21 picard kernel: ata2.00: limiting speed to PIO4
Aug 18 21:45:21 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:45:21 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:45:21 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:45:21 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 21:45:21 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 21:45:21 picard kernel: ata2: soft resetting link
Aug 18 21:45:21 picard kernel: ata2.00: configured for PIO4
Aug 18 21:45:21 picard kernel: ata2: EH complete
Aug 18 21:46:42 picard kernel: ata2.00: limiting speed to PIO3
Aug 18 21:46:42 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:46:42 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:46:42 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:46:42 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:46:42 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:46:42 picard kernel: ata2: soft resetting link
Aug 18 21:46:42 picard kernel: ata2.00: configured for PIO3
Aug 18 21:46:42 picard kernel: ata2: EH complete
Aug 18 21:46:59 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:46:59 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:46:59 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:46:59 picard kernel:         res 58/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x6 (timeout)
Aug 18 21:46:59 picard kernel: ata2.00: status: { DRDY DRQ }
Aug 18 21:46:59 picard kernel: ata2: soft resetting link
Aug 18 21:46:59 picard kernel: ata2.00: configured for PIO3
Aug 18 21:46:59 picard kernel: ata2: EH complete
Aug 18 21:52:40 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:52:40 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:52:40 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:52:40 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:52:40 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:52:40 picard kernel: ata2: soft resetting link
Aug 18 21:52:40 picard kernel: ata2.00: configured for PIO3
Aug 18 21:52:40 picard kernel: ata2: EH complete
Aug 18 21:55:20 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:55:20 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:55:20 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:55:20 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:55:20 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:55:20 picard kernel: ata2: soft resetting link
Aug 18 21:55:21 picard kernel: ata2.00: configured for PIO3
Aug 18 21:55:21 picard kernel: ata2: EH complete
Aug 18 21:55:43 picard kernel: ata2.00: limiting speed to PIO0
Aug 18 21:55:43 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:55:43 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:55:43 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:55:43 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:55:43 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:55:43 picard kernel: ata2: soft resetting link
Aug 18 21:55:44 picard kernel: ata2.00: configured for PIO0
Aug 18 21:55:44 picard kernel: ata2: EH complete
Aug 18 21:55:59 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:55:59 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:55:59 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:55:59 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:55:59 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:55:59 picard kernel: ata2: soft resetting link
Aug 18 21:56:00 picard kernel: ata2.00: configured for PIO0
Aug 18 21:56:00 picard kernel: ata2: EH complete
Aug 18 21:56:28 picard kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 18 21:56:28 picard kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug 18 21:56:28 picard kernel:         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
Aug 18 21:56:28 picard kernel:         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 18 21:56:28 picard kernel: ata2.00: status: { DRDY }
Aug 18 21:56:28 picard kernel: ata2: soft resetting link
Aug 18 21:56:29 picard kernel: ata2.00: configured for PIO0
Aug 18 21:56:29 picard kernel: ata2: EH complete

--------------010206070405070005070702
Content-Type: text/plain;
 name="sysctl.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysctl.conf"

# Kernel sysctl configuration file for Red Hat Linux
#
# For binary values, 0 is disabled, 1 is enabled.  See sysctl(8) and
# sysctl.conf(5) for more details.

# Controls IP packet forwarding
net.ipv4.ip_forward = 1

# Controls source route verification
net.ipv4.conf.default.rp_filter = 1

# Do not accept source routing
net.ipv4.conf.default.accept_source_route = 0

# Controls the System Request debugging functionality of the kernel
kernel.sysrq = 0

# Controls whether core dumps will append the PID to the core filename.
# Useful for debugging multi-threaded applications.
kernel.core_uses_pid = 1

# Controls the use of TCP syncookies
net.ipv4.tcp_syncookies = 1

# Experiment from the libata guys to get my DVD drive working
libata.force = 2.00:pio4

--------------010206070405070005070702
Content-Type: text/plain;
 name="lsmod.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod.txt"

[root@picard ~]# lsmod
Module                  Size  Used by
nls_utf8               10368  0 
lp                     19300  2 
nfsd                  250728  17 
lockd                  71376  2 nfsd
nfs_acl                11392  1 nfsd
auth_rpcgss            50576  1 nfsd
exportfs               12672  1 nfsd
bridge                 59304  0 
bnep                   21632  2 
rfcomm                 44448  4 
l2cap                  29312  16 bnep,rfcomm
bluetooth              59044  5 bnep,rfcomm,l2cap
it87                   31512  0 
hwmon_vid              11008  1 it87
fuse                   51008  7 
sunrpc                185000  13 nfsd,lockd,nfs_acl,auth_rpcgss
wlan_wep               14464  1 
nf_conntrack_netbios_ns    11008  0 
ipt_REJECT             11776  2 
xt_tcpudp              11648  20 
xt_state               10752  22 
iptable_filter         11392  1 
ipt_MASQUERADE         11392  1 
iptable_nat            14608  1 
nf_nat                 25752  2 ipt_MASQUERADE,iptable_nat
nf_conntrack_ipv4      17416  25 iptable_nat,nf_nat
nf_conntrack           64528  6 nf_conntrack_netbios_ns,xt_state,ipt_MASQUERADE,iptable_nat,nf_nat,nf_conntrack_ipv4
ip_tables              25232  2 iptable_filter,iptable_nat
x_tables               26248  6 ipt_REJECT,xt_tcpudp,xt_state,ipt_MASQUERADE,iptable_nat,ip_tables
cpufreq_ondemand       15760  1 
powernow_k8            23812  1 
freq_table             13440  2 cpufreq_ondemand,powernow_k8
dm_mirror              32004  0 
dm_multipath           24976  0 
dm_mod                 62104  2 dm_mirror,dm_multipath
snd_hda_intel         457780  3 
snd_seq_dummy          11524  0 
snd_usb_audio         100608  1 
snd_seq_oss            39232  0 
snd_seq_midi_event     15104  1 snd_seq_oss
snd_seq                61840  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
wlan_scan_sta          20224  1 
snd_pcm_oss            52096  0 
ath_rate_sample        19712  1 
pwc                    90528  0 
nvidia               8108656  34 
snd_mixer_oss          23296  1 snd_pcm_oss
snd_pcm                86024  3 snd_hda_intel,snd_usb_audio,snd_pcm_oss
snd_usb_lib            24960  1 snd_usb_audio
ath_pci                97200  0 
snd_rawmidi            30336  1 snd_usb_lib
snd_timer              29584  2 snd_seq,snd_pcm
k8temp                 13056  0 
compat_ioctl32         16512  1 pwc
snd_page_alloc         16912  2 snd_hda_intel,snd_pcm
yenta_socket           32140  1 
videodev               39808  2 pwc,compat_ioctl32
snd_seq_device         15508  4 snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi
shpchp                 38428  0 
hwmon                  11064  2 it87,k8temp
usb_storage            95136  0 
atl1                   39180  0 
wlan                  196080  5 wlan_wep,wlan_scan_sta,ath_rate_sample,ath_pci
ath_hal               224368  3 ath_rate_sample,ath_pci
snd_hwdep              16520  2 snd_hda_intel,snd_usb_audio
button                 15776  0 
pcspkr                 11136  0 
ppdev                  15624  0 
parport_pc             33816  1 
parport                42784  3 lp,ppdev,parport_pc
i2c_viapro             16536  0 
i2c_core               28448  2 nvidia,i2c_viapro
rsrc_nonstatic         18176  1 yenta_socket
v4l1_compat            20100  1 videodev
mii                    13184  1 atl1
snd                    66808  21 snd_hda_intel,snd_seq_dummy,snd_usb_audio,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_usb_lib,snd_rawmidi,snd_timer,snd_seq_device,snd_hwdep
soundcore              14864  1 snd
sg                     40528  0 
sr_mod                 23732  1 
floppy                 66152  0 
cdrom                  40616  1 sr_mod
ata_generic            14724  0 
pata_acpi              13952  0 
pata_via               17796  8 
libata                149664  3 ata_generic,pata_acpi,pata_via
sd_mod                 33200  9 
scsi_mod              150360  5 usb_storage,sg,sr_mod,libata,sd_mod
ext3                  129808  3 
jbd                    53032  1 ext3
mbcache                15876  1 ext3
uhci_hcd               29984  0 
ohci_hcd               29060  0 
ehci_hcd               40460  0 
[root@picard ~]# 

--------------010206070405070005070702--
