From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: Sata 4726 Testing
Date: Thu, 10 Jan 2008 20:19:38 -0500
Message-ID: <4786C42A.10403@shaw.ca>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com>
 <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com>
 <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com>
 <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com>
 <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca>
 <47859D1A.8010006@gmail.com> <47855F02.3010407@shaw.ca>
 <4785BD03.10809@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------020808050009060708060708
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:56040 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbYAKG1x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 01:27:53 -0500
Received: from pd4mr3so.prod.shaw.ca
 (pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUG00L7GV8CQN40@l-daemon> for linux-ide@vger.kernel.org; Thu,
 10 Jan 2008 23:26:37 -0700 (MST)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
 by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUG0074YV8CJQ30@pd4mr3so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Thu, 10 Jan 2008 23:26:37 -0700 (MST)
Received: from [192.168.0.2] ([70.76.194.32])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUG00AJ4V85NC30@l-daemon> for linux-ide@vger.kernel.org; Thu,
 10 Jan 2008 23:26:36 -0700 (MST)
In-reply-to: <4785BD03.10809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020808050009060708060708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

For the regular power on detected, are you referring to cold/warm
booting the system and verifying initialization or only power cycling
the 4726?

Here are my test results, TestingRoutine.txt is the procedure I followed
and test results obtained. If I missed something, please let me know.

>From what I could find, the problem with ata1.03 not being detected is
consistent with the port. In my testing, I moved the last drive to the
5th port on the 4726 and the problem carried through. The issue seemed
to only occur when the 4726 was powered on/off, not when it was
unplugged and re-plugged with the power on.

If I have some time on the weekend, I will do a test routine of several
hot un-plugs / re-plugs of the 4726 and see what happens.

Thanks


Tejun Heo wrote:
> Hello,
>
> Andrew Ryder wrote:
>   
>> This might be of interest.. I had turned the drive off for about 20
>> minutes, then turned it back on. ata1.03 is now partially there, it is
>> recognized as a device, but of 0MB in size.
>>
>> All of this is done with the 4726 turned on..
>>
>> Bootlog11.txt -> I unplugged the 4726, waited 10 seconds, and plugged it
>> into the second port on the 3124. All 4 drives are there.
>>
>> Bootlog12.txt -> I unplugged the 4726 again, waited 10 seconds, plugged
>> it back into the first (original) port, and ata1.03 is back..
>>
>> Bootlog13.txt -> I powered the 4726 off, waited 10 seconds, turned it
>> back on. The same drive is missing now.
>>
>> Bootlog14.txt -> I unplugged, waited 10 seconds, and re-plugged the 4726
>> into the same port (first eSATA port) and now ata1.03 is recognized and
>> accessible.
>>
>> I'll make sure to turn on the timestamping for you tomorrow. Would want
>> me to redo this testing so you can have the timestamps also?
>>     
>
> Please swap the third and fourth drive and see whether the problem moves
> with the drive or stays with the port.  Also, please verify regular
> powered on detection (array up and running before detection begins)
> always works.  4726 is very quirky (it ate up a LOT of development /
> testing time) and I guess we'll have to accept some brokenness.
>
> Thanks.
>
>   


--------------020808050009060708060708
Content-Type: text/plain;
 name="1_Bootup.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1_Bootup.log"

[    0.000000] Linux version 2.6.24-rc7 (root@BigMouth) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.1)) #2 Thu Jan 10 12:53:51 EST 2008
[    0.000000] Command line: root=/dev/sda3
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff30000 (usable)
[    0.000000]  BIOS-e820: 000000007ff30000 - 000000007ff40000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff40000 - 000000007fff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 524080) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP 000FA850, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT 7FF30000, 0030 (r1 A M I  OEMRSDT   6000517 MSFT       97)
[    0.000000] ACPI: FACP 7FF30200, 0081 (r1 A M I  OEMFACP   6000517 MSFT       97)
[    0.000000] ACPI: DSDT 7FF303F0, 38EA (r1  SK8V_ SK8V_033       33 MSFT  100000D)
[    0.000000] ACPI: FACS 7FF40000, 0040
[    0.000000] ACPI: APIC 7FF30390, 0052 (r1 A M I  OEMAPIC   6000517 MSFT       97)
[    0.000000] ACPI: OEMB 7FF40040, 003F (r1 A M I  OEMBIOS   6000517 MSFT       97)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 524080) 1 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   524080
[    0.000000] On node 0 totalpages: 523983
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 964 pages reserved
[    0.000000]   DMA zone: 2979 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7109 pages used for memmap
[    0.000000]   DMA32 zone: 512875 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7ff80000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 515854
[    0.000000] Kernel command line: root=/dev/sda3
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[   40.969694] time.c: Detected 1802.299 MHz processor.
[   40.972096] Console: colour VGA+ 80x25
[   40.972100] console [tty0] enabled
[   40.976164] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   40.978256] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   40.978631] Checking aperture...
[   40.978685] CPU 0: aperture @ f8000000 size 64 MB
[   40.998433] Memory: 2059876k/2096320k available (2288k kernel code, 35684k reserved, 1034k data, 192k init)
[   41.075660] Calibrating delay using timer specific routine.. 3608.83 BogoMIPS (lpj=7217669)
[   41.075816] Mount-cache hash table entries: 256
[   41.075979] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   41.076037] CPU: L2 Cache: 1024K (64 bytes/line)
[   41.076101] CPU: AMD Opteron(tm) Processor 144 stepping 0a
[   41.076245] ACPI: Core revision 20070126
[   41.118998] Using local APIC timer interrupts.
[   41.174522] APIC timer calibration result 12515970
[   41.174524] Detected 12.515 MHz APIC timer.
[   41.174709] net_namespace: 120 bytes
[   41.175136] NET: Registered protocol family 16
[   41.175327] ACPI: bus type pci registered
[   41.175387] PCI: Using configuration type 1
[   41.177528] ACPI: EC: Look up EC in DSDT
[   41.181044] ACPI: Interpreter enabled
[   41.181097] ACPI: (supports S0 S1 S3 S5)
[   41.181310] ACPI: Using IOAPIC for interrupt routing
[   41.188091] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   41.188829] PCI: enabled onboard AC97/MC97 devices
[   41.189130] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   41.195690] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
[   41.196214] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
[   41.196734] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
[   41.197255] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 15)
[   41.197776] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.198382] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.199003] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.199610] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.200213] Linux Plug and Play Support v0.97 (c) Adam Belay
[   41.200290] pnp: PnP ACPI init
[   41.200347] ACPI: bus type pnp registered
[   41.203725] pnp: PnP ACPI: found 14 devices
[   41.203778] ACPI: ACPI bus type pnp unregistered
[   41.203979] SCSI subsystem initialized
[   41.204120] PCI: Using ACPI for IRQ routing
[   41.204175] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   41.204249] PCI: Cannot allocate resource region 0 of device 0000:00:00.0
[   41.214633] agpgart: Detected AGP bridge 0
[   41.218144] agpgart: AGP aperture is 64M @ 0xf8000000
[   41.218581] Time: tsc clocksource has been installed.
[   41.226616] system 00:09: ioport range 0x295-0x296 has been reserved
[   41.226674] system 00:09: ioport range 0x3e1-0x3e7 has been reserved
[   41.226731] system 00:09: ioport range 0x4d0-0x4d1 has been reserved
[   41.226789] system 00:09: ioport range 0x800-0x87f has been reserved
[   41.226846] system 00:09: ioport range 0x400-0x41f has been reserved
[   41.226908] system 00:0a: iomem range 0xfec00000-0xfec00fff has been reserved
[   41.226966] system 00:0a: iomem range 0xfee00000-0xfee00fff could not be reserved
[   41.227034] system 00:0a: iomem range 0xfff80000-0xffffffff could not be reserved
[   41.227107] system 00:0d: iomem range 0x0-0x9ffff could not be reserved
[   41.227165] system 00:0d: iomem range 0xc0000-0xdffff has been reserved
[   41.227222] system 00:0d: iomem range 0xe0000-0xfffff could not be reserved
[   41.227280] system 00:0d: iomem range 0x100000-0x7ffeffff could not be reserved
[   41.227348] system 00:0d: iomem range 0x0-0x0 could not be reserved
[   41.227743] PCI: Bridge: 0000:00:01.0
[   41.227796]   IO window: a000-afff
[   41.227850]   MEM window: fc500000-fcafffff
[   41.227905]   PREFETCH window: b3e00000-f3dfffff
[   41.227977] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   41.228001] NET: Registered protocol family 2
[   41.262623] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   41.263229] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   41.265781] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   41.266183] TCP: Hash tables configured (established 262144 bind 65536)
[   41.266240] TCP reno registered
[   41.275236] audit: initializing netlink socket (disabled)
[   41.275299] audit(1200010171.256:1): initialized
[   41.275619] io scheduler noop registered
[   41.275672] io scheduler anticipatory registered (default)
[   41.275728] io scheduler deadline registered
[   41.275788] io scheduler cfq registered
[   41.275846] PCI: VIA PCI bridge detected. Disabling DAC.
[   41.276369] Boot video device is 0000:01:00.0
[   41.278423] Real Time Clock Driver v1.12ac
[   41.278538] Linux agpgart interface v0.102
[   41.278601] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   41.278762] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   41.278907] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   41.279557] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   41.279859] loop: module loaded
[   41.279916] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   41.279973] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   41.280077] VIA8237SATA: IDE controller (0x1106:0x3149 rev 0x80) at  PCI slot 0000:00:0f.0
[   41.280160] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
[   41.280277] VIA8237SATA: 100% native mode on irq 20
[   41.280335]     ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
[   41.280484]     ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:pio
[   41.280631] Probing IDE interface ide2...
[   41.846391] Probing IDE interface ide3...
[   42.414221] VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at  PCI slot 0000:00:0f.1
[   42.414300] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
[   42.414408] VP_IDE: not 100% native mode: will probe irqs later
[   42.414470] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
[   42.414540]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
[   42.414689]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
[   42.414835] Probing IDE interface ide0...
[   42.830192] hdb: Maxtor 4G160J8, ATA DISK drive
[   43.166089] hda: ST3200822A, ATA DISK drive
[   43.166186] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   43.166420] hda: UDMA/100 mode selected
[   43.166765] hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   43.166873] hdb: UDMA/133 mode selected
[   43.167065] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   43.167217] Probing IDE interface ide1...
[   44.085810] hdd: ASUS DVD-E616P2, ATAPI CD/DVD-ROM drive
[   44.869573] hdc: ASUS DRW-0402P/D, ATAPI CD/DVD-ROM drive
[   44.869745] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   44.869812] hdc: UDMA/33 mode selected
[   44.869958] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   44.870173] hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
[   44.870241] hdd: UDMA/33 mode selected
[   44.870547] ide1 at 0x170-0x177,0x376 on irq 15
[   44.870782] Probing IDE interface ide2...
[   45.437300] Probing IDE interface ide3...
[   46.005149] hda: max request size: 512KiB
[   46.005765] hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
[   46.006048] hda: cache flushes supported
[   46.006124]  hda: hda1 hda2
[   46.014366] hdb: max request size: 512KiB
[   46.021424] hdb: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63
[   46.021567] hdb: cache flushes not supported
[   46.021636]  hdb: hdb1
[   46.039769] hdc: ATAPI 47X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache
[   46.040052] Uniform CD-ROM driver Revision: 3.20
[   47.333079] hdd: ATAPI 48X DVD-ROM drive, 512kB Cache
[   47.344447] ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
[   52.555145] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   52.555148]         <Adaptec 29160N Ultra160 SCSI adapter>
[   52.555149]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   52.555151] 
[   52.559077] scsi 0:0:0:0: Direct-Access     SEAGATE  ST318452LW       0004 PQ: 0 ANSI: 3
[   52.559151] scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
[   52.559250]  target0:0:0: Beginning Domain Validation
[   52.567382]  target0:0:0: wide asynchronous
[   52.573563]  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
[   52.584331]  target0:0:0: Ending Domain Validation
[   53.106892] scsi 0:0:3:0: CD-ROM            YAMAHA   CRW8824S         1.00 PQ: 0 ANSI: 2
[   53.106967]  target0:0:3: Beginning Domain Validation
[   53.121395]  target0:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
[   53.129117]  target0:0:3: Domain Validation skipping write tests
[   53.129172]  target0:0:3: Ending Domain Validation
[   55.949167] Driver 'sd' needs updating - please use bus_type methods
[   55.950059] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   55.951240] sd 0:0:0:0: [sda] Write Protect is off
[   55.951295] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   55.952978] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   55.953844] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   55.955026] sd 0:0:0:0: [sda] Write Protect is off
[   55.955080] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   55.956788] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   55.956857]  sda: sda1 sda2 sda3
[   55.964432] sd 0:0:0:0: [sda] Attached SCSI disk
[   55.964494] Driver 'sr' needs updating - please use bus_type methods
[   55.998683] sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
[   55.998783] sr 0:0:3:0: Attached scsi CD-ROM sr0
[   55.998850] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   55.999269] serio: i8042 KBD port at 0x60,0x64 irq 1
[   55.999325] serio: i8042 AUX port at 0x60,0x64 irq 12
[   55.999488] mice: PS/2 mouse device common for all mice
[   56.029540] input: AT Translated Set 2 keyboard as /class/input/input0
[   56.057155] TCP cubic registered
[   56.057213] NET: Registered protocol family 1
[   56.057277] NET: Registered protocol family 17
[   56.057364] NET: Registered protocol family 33
[   56.057557] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   56.453038] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[   56.581620] ReiserFS: sda3: found reiserfs format "3.6" with standard journal
[   56.581683] ReiserFS: sda3: using ordered data mode
[   56.584649] ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   56.586266] ReiserFS: sda3: checking transaction log (sda3)
[   56.612710] ReiserFS: sda3: Using r5 hash to sort names
[   56.612791] VFS: Mounted root (reiserfs filesystem) readonly.
[   56.612861] Freeing unused kernel memory: 192k freed
[   58.830733] libata version 3.00 loaded.
[   58.834566] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   58.834589] sr 0:0:3:0: Attached scsi generic sg1 type 5
[   58.835842] ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
[   58.917293] usbcore: registered new interface driver usbfs
[   58.917324] usbcore: registered new interface driver hub
[   58.936252] usbcore: registered new device driver usb
[   58.937137] USB Universal Host Controller Interface driver v3.0
[   59.068441] input: Power Button (FF) as /class/input/input2
[   59.113197] ACPI: Power Button (FF) [PWRF]
[   59.113284] input: Power Button (CM) as /class/input/input3
[   59.115827] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fd400000-fd4007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   59.143952] ACPI: Power Button (CM) [PWRB]
[   59.144030] input: Sleep Button (CM) as /class/input/input4
[   59.159999] sata_sil24 0000:00:0c.0: version 1.1
[   59.160021] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   59.160374] PCI: Disallowing DAC for device 0000:00:0c.0
[   59.169193] ACPI: Sleep Button (CM) [SLPB]
[   59.174774] scsi1 : sata_sil24
[   59.191103] scsi2 : sata_sil24
[   59.205468] scsi3 : sata_sil24
[   59.231501] scsi4 : sata_sil24
[   59.231570] ata1: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
[   59.231574] ata2: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[   59.231578] ata3: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[   59.231581] ata4: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[   59.880531] input: PC Speaker as /class/input/input5
[   60.027104] Floppy drive(s): fd0 is 1.44M
[   60.044905] FDC 0 is a post-1991 82077
[   60.047130] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   60.047248] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   60.428849] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
[   61.428460] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   61.428605] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[   61.428797] ata1.00: hard resetting link
[   61.748518] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   61.748524] ata1.01: hard resetting link
[   62.068415] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.068418] ata1.02: hard resetting link
[   62.388321] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.388323] ata1.03: hard resetting link
[   62.708223] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.708226] ata1.04: hard resetting link
[   63.028129] ata1.04: SATA link down (SStatus 0 SControl 320)
[   63.028136] ata1.05: hard resetting link
[   63.348026] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   63.348029] ata1.06: hard resetting link
[   63.667932] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   63.668978] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[   63.668981] ata1.00: 586072368 sectors, multi 16: LBA48 
[   63.668983] ata1.00: applying bridge limits
[   63.670120] ata1.00: configured for UDMA/100
[   63.671146] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[   63.671149] ata1.01: 586072368 sectors, multi 0: LBA48 
[   63.671151] ata1.01: applying bridge limits
[   63.672287] ata1.01: configured for UDMA/100
[   63.716356] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   63.716358] ata1.02: 586072368 sectors, multi 0: LBA48 
[   63.716360] ata1.02: applying bridge limits
[   63.782803] ata1.02: configured for UDMA/100
[   63.826318] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   63.826321] ata1.03: 586072368 sectors, multi 0: LBA48 
[   63.826323] ata1.03: applying bridge limits
[   63.884593] ata1.03: configured for UDMA/100
[   63.884662] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[   63.884665] ata1.05: 640 sectors, multi 1: LBA 
[   63.884671] ata1.05: device is on DMA blacklist, disabling DMA
[   63.884759] ata1.05: configured for PIO4
[   63.884799] ata1: EH complete
[   65.963083] ata2: SATA link down (SStatus 0 SControl 0)
[   68.042452] ata3: SATA link down (SStatus 0 SControl 0)
[   70.121822] ata4: SATA link down (SStatus 0 SControl 0)
[   70.121936] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.122351] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.122362] sd 1:0:0:0: [sdb] Write Protect is off
[   70.122365] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.122377] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.122423] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.122430] sd 1:0:0:0: [sdb] Write Protect is off
[   70.122432] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.122443] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.122448]  sdb: sdb1
[   70.125719] sd 1:0:0:0: [sdb] Attached SCSI disk
[   70.125755] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   70.126207] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.126477] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.126485] sd 1:1:0:0: [sdc] Write Protect is off
[   70.126487] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.126499] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.126528] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.126535] sd 1:1:0:0: [sdc] Write Protect is off
[   70.126538] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.126549] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.126551]  sdc: sdc1
[   70.139869] sd 1:1:0:0: [sdc] Attached SCSI disk
[   70.139900] sd 1:1:0:0: Attached scsi generic sg3 type 0
[   70.140370] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.140431] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.140439] sd 1:2:0:0: [sdd] Write Protect is off
[   70.140441] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.140452] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.140482] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.140489] sd 1:2:0:0: [sdd] Write Protect is off
[   70.140491] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.140502] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.140504]  sdd: sdd1
[   70.159621] sd 1:2:0:0: [sdd] Attached SCSI disk
[   70.159653] sd 1:2:0:0: Attached scsi generic sg4 type 0
[   70.159699] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.159756] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.159764] sd 1:3:0:0: [sde] Write Protect is off
[   70.159766] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.159777] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.160524] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.160532] sd 1:3:0:0: [sde] Write Protect is off
[   70.160534] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.160545] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.160548]  sde: sde1
[   70.176524] sd 1:3:0:0: [sde] Attached SCSI disk
[   70.176556] sd 1:3:0:0: Attached scsi generic sg5 type 0
[   70.176602] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.176661] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.176668] sd 1:5:0:0: [sdf] Write Protect is off
[   70.176670] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.176681] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.176710] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.176717] sd 1:5:0:0: [sdf] Write Protect is off
[   70.176719] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.176731] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.176733]  sdf: unknown partition table
[   70.177579] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.177611] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.177788] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.177802] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.177992] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[   70.178021] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.178162] usb usb1: configuration #1 chosen from 1 choice
[   70.178188] hub 1-0:1.0: USB hub found
[   70.178196] hub 1-0:1.0: 2 ports detected
[   70.281899] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   70.281913] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   70.281938] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[   70.281961] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   70.282085] usb usb2: configuration #1 chosen from 1 choice
[   70.282111] hub 2-0:1.0: USB hub found
[   70.282119] hub 2-0:1.0: 2 ports detected
[   70.385877] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   70.385890] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   70.385918] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[   70.385941] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   70.386059] usb usb3: configuration #1 chosen from 1 choice
[   70.386084] hub 3-0:1.0: USB hub found
[   70.386091] hub 3-0:1.0: 2 ports detected
[   70.489843] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   70.489857] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   70.489882] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[   70.489905] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   70.490022] usb usb4: configuration #1 chosen from 1 choice
[   70.490047] hub 4-0:1.0: USB hub found
[   70.490055] hub 4-0:1.0: 2 ports detected
[   70.593880] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   70.594063] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   70.594122] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
[   70.594171] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   70.605694] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   70.605812] usb usb5: configuration #1 chosen from 1 choice
[   70.605838] hub 5-0:1.0: USB hub found
[   70.605847] hub 5-0:1.0: 8 ports detected
[   70.709842] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   70.712088] Audigy2 value: Special config.
[   72.299598] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   72.299603] Copyright (c) 1999-2006 Intel Corporation.
[   72.299645] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   72.299650] PCI: Disallowing DAC for device 0000:00:0e.0
[   72.558679] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   72.734178] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   72.890022] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   72.890034] ReiserFS: hdb1: using ordered data mode
[   72.929121] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   72.930477] ReiserFS: hdb1: checking transaction log (hdb1)
[   73.047880] ReiserFS: hdb1: Using r5 hash to sort names
[   73.096394] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   73.096405] ReiserFS: hda2: using ordered data mode
[   73.101224] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   73.102630] ReiserFS: hda2: checking transaction log (hda2)
[   73.165531] ReiserFS: hda2: Using r5 hash to sort names
[   79.014996] hda: UDMA/100 mode selected
[   79.018892] hdb: UDMA/133 mode selected
[   79.073585] hdc: UDMA/33 mode selected
[   79.091357] hdd: UDMA/33 mode selected
[   81.606735] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   85.836882] w83627hf: Found W83697HF chip at 0x290

--------------020808050009060708060708
Content-Type: text/plain;
 name="2_PowerOnOffTwice.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2_PowerOnOffTwice.log"

55(auto-tune) selected PIO4
[   43.166420] hda: UDMA/100 mode selected
[   43.166765] hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   43.166873] hdb: UDMA/133 mode selected
[   43.167065] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   43.167217] Probing IDE interface ide1...
[   44.085810] hdd: ASUS DVD-E616P2, ATAPI CD/DVD-ROM drive
[   44.869573] hdc: ASUS DRW-0402P/D, ATAPI CD/DVD-ROM drive
[   44.869745] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   44.869812] hdc: UDMA/33 mode selected
[   44.869958] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   44.870173] hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
[   44.870241] hdd: UDMA/33 mode selected
[   44.870547] ide1 at 0x170-0x177,0x376 on irq 15
[   44.870782] Probing IDE interface ide2...
[   45.437300] Probing IDE interface ide3...
[   46.005149] hda: max request size: 512KiB
[   46.005765] hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
[   46.006048] hda: cache flushes supported
[   46.006124]  hda: hda1 hda2
[   46.014366] hdb: max request size: 512KiB
[   46.021424] hdb: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63
[   46.021567] hdb: cache flushes not supported
[   46.021636]  hdb: hdb1
[   46.039769] hdc: ATAPI 47X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache
[   46.040052] Uniform CD-ROM driver Revision: 3.20
[   47.333079] hdd: ATAPI 48X DVD-ROM drive, 512kB Cache
[   47.344447] ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
[   52.555145] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   52.555148]         <Adaptec 29160N Ultra160 SCSI adapter>
[   52.555149]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   52.555151] 
[   52.559077] scsi 0:0:0:0: Direct-Access     SEAGATE  ST318452LW       0004 PQ: 0 ANSI: 3
[   52.559151] scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
[   52.559250]  target0:0:0: Beginning Domain Validation
[   52.567382]  target0:0:0: wide asynchronous
[   52.573563]  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
[   52.584331]  target0:0:0: Ending Domain Validation
[   53.106892] scsi 0:0:3:0: CD-ROM            YAMAHA   CRW8824S         1.00 PQ: 0 ANSI: 2
[   53.106967]  target0:0:3: Beginning Domain Validation
[   53.121395]  target0:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
[   53.129117]  target0:0:3: Domain Validation skipping write tests
[   53.129172]  target0:0:3: Ending Domain Validation
[   55.949167] Driver 'sd' needs updating - please use bus_type methods
[   55.950059] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   55.951240] sd 0:0:0:0: [sda] Write Protect is off
[   55.951295] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   55.952978] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   55.953844] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   55.955026] sd 0:0:0:0: [sda] Write Protect is off
[   55.955080] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   55.956788] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   55.956857]  sda: sda1 sda2 sda3
[   55.964432] sd 0:0:0:0: [sda] Attached SCSI disk
[   55.964494] Driver 'sr' needs updating - please use bus_type methods
[   55.998683] sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
[   55.998783] sr 0:0:3:0: Attached scsi CD-ROM sr0
[   55.998850] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   55.999269] serio: i8042 KBD port at 0x60,0x64 irq 1
[   55.999325] serio: i8042 AUX port at 0x60,0x64 irq 12
[   55.999488] mice: PS/2 mouse device common for all mice
[   56.029540] input: AT Translated Set 2 keyboard as /class/input/input0
[   56.057155] TCP cubic registered
[   56.057213] NET: Registered protocol family 1
[   56.057277] NET: Registered protocol family 17
[   56.057364] NET: Registered protocol family 33
[   56.057557] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   56.453038] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[   56.581620] ReiserFS: sda3: found reiserfs format "3.6" with standard journal
[   56.581683] ReiserFS: sda3: using ordered data mode
[   56.584649] ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   56.586266] ReiserFS: sda3: checking transaction log (sda3)
[   56.612710] ReiserFS: sda3: Using r5 hash to sort names
[   56.612791] VFS: Mounted root (reiserfs filesystem) readonly.
[   56.612861] Freeing unused kernel memory: 192k freed
[   58.830733] libata version 3.00 loaded.
[   58.834566] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   58.834589] sr 0:0:3:0: Attached scsi generic sg1 type 5
[   58.835842] ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
[   58.917293] usbcore: registered new interface driver usbfs
[   58.917324] usbcore: registered new interface driver hub
[   58.936252] usbcore: registered new device driver usb
[   58.937137] USB Universal Host Controller Interface driver v3.0
[   59.068441] input: Power Button (FF) as /class/input/input2
[   59.113197] ACPI: Power Button (FF) [PWRF]
[   59.113284] input: Power Button (CM) as /class/input/input3
[   59.115827] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fd400000-fd4007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   59.143952] ACPI: Power Button (CM) [PWRB]
[   59.144030] input: Sleep Button (CM) as /class/input/input4
[   59.159999] sata_sil24 0000:00:0c.0: version 1.1
[   59.160021] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   59.160374] PCI: Disallowing DAC for device 0000:00:0c.0
[   59.169193] ACPI: Sleep Button (CM) [SLPB]
[   59.174774] scsi1 : sata_sil24
[   59.191103] scsi2 : sata_sil24
[   59.205468] scsi3 : sata_sil24
[   59.231501] scsi4 : sata_sil24
[   59.231570] ata1: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
[   59.231574] ata2: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[   59.231578] ata3: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[   59.231581] ata4: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[   59.880531] input: PC Speaker as /class/input/input5
[   60.027104] Floppy drive(s): fd0 is 1.44M
[   60.044905] FDC 0 is a post-1991 82077
[   60.047130] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   60.047248] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   60.428849] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
[   61.428460] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   61.428605] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[   61.428797] ata1.00: hard resetting link
[   61.748518] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   61.748524] ata1.01: hard resetting link
[   62.068415] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.068418] ata1.02: hard resetting link
[   62.388321] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.388323] ata1.03: hard resetting link
[   62.708223] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.708226] ata1.04: hard resetting link
[   63.028129] ata1.04: SATA link down (SStatus 0 SControl 320)
[   63.028136] ata1.05: hard resetting link
[   63.348026] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   63.348029] ata1.06: hard resetting link
[   63.667932] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   63.668978] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[   63.668981] ata1.00: 586072368 sectors, multi 16: LBA48 
[   63.668983] ata1.00: applying bridge limits
[   63.670120] ata1.00: configured for UDMA/100
[   63.671146] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[   63.671149] ata1.01: 586072368 sectors, multi 0: LBA48 
[   63.671151] ata1.01: applying bridge limits
[   63.672287] ata1.01: configured for UDMA/100
[   63.716356] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   63.716358] ata1.02: 586072368 sectors, multi 0: LBA48 
[   63.716360] ata1.02: applying bridge limits
[   63.782803] ata1.02: configured for UDMA/100
[   63.826318] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   63.826321] ata1.03: 586072368 sectors, multi 0: LBA48 
[   63.826323] ata1.03: applying bridge limits
[   63.884593] ata1.03: configured for UDMA/100
[   63.884662] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[   63.884665] ata1.05: 640 sectors, multi 1: LBA 
[   63.884671] ata1.05: device is on DMA blacklist, disabling DMA
[   63.884759] ata1.05: configured for PIO4
[   63.884799] ata1: EH complete
[   65.963083] ata2: SATA link down (SStatus 0 SControl 0)
[   68.042452] ata3: SATA link down (SStatus 0 SControl 0)
[   70.121822] ata4: SATA link down (SStatus 0 SControl 0)
[   70.121936] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.122351] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.122362] sd 1:0:0:0: [sdb] Write Protect is off
[   70.122365] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.122377] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.122423] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.122430] sd 1:0:0:0: [sdb] Write Protect is off
[   70.122432] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.122443] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.122448]  sdb: sdb1
[   70.125719] sd 1:0:0:0: [sdb] Attached SCSI disk
[   70.125755] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   70.126207] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.126477] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.126485] sd 1:1:0:0: [sdc] Write Protect is off
[   70.126487] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.126499] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.126528] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.126535] sd 1:1:0:0: [sdc] Write Protect is off
[   70.126538] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.126549] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.126551]  sdc: sdc1
[   70.139869] sd 1:1:0:0: [sdc] Attached SCSI disk
[   70.139900] sd 1:1:0:0: Attached scsi generic sg3 type 0
[   70.140370] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.140431] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.140439] sd 1:2:0:0: [sdd] Write Protect is off
[   70.140441] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.140452] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.140482] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.140489] sd 1:2:0:0: [sdd] Write Protect is off
[   70.140491] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.140502] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.140504]  sdd: sdd1
[   70.159621] sd 1:2:0:0: [sdd] Attached SCSI disk
[   70.159653] sd 1:2:0:0: Attached scsi generic sg4 type 0
[   70.159699] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.159756] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.159764] sd 1:3:0:0: [sde] Write Protect is off
[   70.159766] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.159777] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.160524] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.160532] sd 1:3:0:0: [sde] Write Protect is off
[   70.160534] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.160545] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.160548]  sde: sde1
[   70.176524] sd 1:3:0:0: [sde] Attached SCSI disk
[   70.176556] sd 1:3:0:0: Attached scsi generic sg5 type 0
[   70.176602] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.176661] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.176668] sd 1:5:0:0: [sdf] Write Protect is off
[   70.176670] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.176681] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.176710] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.176717] sd 1:5:0:0: [sdf] Write Protect is off
[   70.176719] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.176731] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.176733]  sdf: unknown partition table
[   70.177579] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.177611] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.177788] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.177802] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.177992] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[   70.178021] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.178162] usb usb1: configuration #1 chosen from 1 choice
[   70.178188] hub 1-0:1.0: USB hub found
[   70.178196] hub 1-0:1.0: 2 ports detected
[   70.281899] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   70.281913] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   70.281938] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[   70.281961] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   70.282085] usb usb2: configuration #1 chosen from 1 choice
[   70.282111] hub 2-0:1.0: USB hub found
[   70.282119] hub 2-0:1.0: 2 ports detected
[   70.385877] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   70.385890] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   70.385918] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[   70.385941] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   70.386059] usb usb3: configuration #1 chosen from 1 choice
[   70.386084] hub 3-0:1.0: USB hub found
[   70.386091] hub 3-0:1.0: 2 ports detected
[   70.489843] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   70.489857] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   70.489882] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[   70.489905] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   70.490022] usb usb4: configuration #1 chosen from 1 choice
[   70.490047] hub 4-0:1.0: USB hub found
[   70.490055] hub 4-0:1.0: 2 ports detected
[   70.593880] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   70.594063] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   70.594122] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
[   70.594171] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   70.605694] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   70.605812] usb usb5: configuration #1 chosen from 1 choice
[   70.605838] hub 5-0:1.0: USB hub found
[   70.605847] hub 5-0:1.0: 8 ports detected
[   70.709842] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   70.712088] Audigy2 value: Special config.
[   72.299598] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   72.299603] Copyright (c) 1999-2006 Intel Corporation.
[   72.299645] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   72.299650] PCI: Disallowing DAC for device 0000:00:0e.0
[   72.558679] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   72.734178] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   72.890022] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   72.890034] ReiserFS: hdb1: using ordered data mode
[   72.929121] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   72.930477] ReiserFS: hdb1: checking transaction log (hdb1)
[   73.047880] ReiserFS: hdb1: Using r5 hash to sort names
[   73.096394] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   73.096405] ReiserFS: hda2: using ordered data mode
[   73.101224] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   73.102630] ReiserFS: hda2: checking transaction log (hda2)
[   73.165531] ReiserFS: hda2: Using r5 hash to sort names
[   79.014996] hda: UDMA/100 mode selected
[   79.018892] hdb: UDMA/133 mode selected
[   79.073585] hdc: UDMA/33 mode selected
[   79.091357] hdd: UDMA/33 mode selected
[   81.606735] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   85.836882] w83627hf: Found W83697HF chip at 0x290
[  209.524283] ata1.00: failed to read SCR 1 (Emask=0x40)
[  209.524288] ata1.01: failed to read SCR 1 (Emask=0x40)
[  209.524291] ata1.02: failed to read SCR 1 (Emask=0x40)
[  209.524294] ata1.03: failed to read SCR 1 (Emask=0x40)
[  209.524296] ata1.04: failed to read SCR 1 (Emask=0x40)
[  209.524299] ata1.05: failed to read SCR 1 (Emask=0x40)
[  209.524301] ata1.06: failed to read SCR 1 (Emask=0x40)
[  209.524305] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  209.524308] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  209.524311] ata1: SError: { 10B8B }
[  209.524316] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524320] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524325] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524329] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524333] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524338] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524342] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524349] ata1.15: hard resetting link
[  214.617980] ata1.15: SATA link down (SStatus 1 SControl 0)
[  214.869897] ata1.15: qc timeout (cmd 0xe4)
[  214.869905] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  214.869908] ata1.15: PMP revalidation failed (errno=-5)
[  214.869910] ata1.15: retrying hardreset in 5 secs
[  219.872379] ata1.15: hard resetting link
[  224.966839] ata1.15: SATA link down (SStatus 1 SControl 0)
[  225.173188] ata1.15: failed to read PMP GSCR[0] (Emask=0x100)
[  225.173191] ata1.15: PMP revalidation failed (errno=-5)
[  225.173194] ata1.15: limiting SATA link speed to 1.5 Gbps
[  225.173197] ata1.15: retrying hardreset in 5 secs
[  230.173255] ata1.15: hard resetting link
[  232.372597] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  232.372805] ata1.00: hard resetting link
[  232.692677] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  232.692680] ata1.01: hard resetting link
[  233.012579] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  233.012583] ata1.02: hard resetting link
[  233.332482] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  233.332485] ata1.03: hard resetting link
[  233.652385] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  233.652388] ata1.04: hard resetting link
[  233.972289] ata1.04: SATA link down (SStatus 0 SControl 310)
[  233.972292] ata1.05: hard resetting link
[  234.292189] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  234.292192] ata1.06: hard resetting link
[  234.612092] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  234.614276] ata1.00: configured for UDMA/100
[  234.616463] ata1.01: configured for UDMA/100
[  234.719921] ata1.02: configured for UDMA/100
[  234.821531] ata1.03: configured for UDMA/100
[  234.821636] ata1.05: device is on DMA blacklist, disabling DMA
[  234.821741] ata1.05: configured for PIO4
[  234.821953] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  234.821956] ata1.15: irq_stat 0x00800080, device exchanged
[  234.822220] ata1: EH complete
[  234.822245] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  234.822256] sd 1:0:0:0: [sdb] Write Protect is off
[  234.822259] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  234.822271] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822285] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  234.822292] sd 1:1:0:0: [sdc] Write Protect is off
[  234.822295] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  234.822305] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822318] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  234.822325] sd 1:2:0:0: [sdd] Write Protect is off
[  234.822328] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  234.822339] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822353] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  234.822361] sd 1:3:0:0: [sde] Write Protect is off
[  234.822363] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  234.822375] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822388] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  234.822396] sd 1:5:0:0: [sdf] Write Protect is off
[  234.822399] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  234.822410] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  234.822423] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  234.822431] sd 1:0:0:0: [sdb] Write Protect is off
[  234.822434] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  234.822445] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822458] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  234.822465] sd 1:1:0:0: [sdc] Write Protect is off
[  234.822468] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  234.822479] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822492] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  234.822500] sd 1:2:0:0: [sdd] Write Protect is off
[  234.822503] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  234.822514] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822527] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  234.822534] sd 1:3:0:0: [sde] Write Protect is off
[  234.822537] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  234.822549] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822561] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  234.822569] sd 1:5:0:0: [sdf] Write Protect is off
[  234.822571] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  234.822583] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  396.287513] ata1.00: failed to read SCR 1 (Emask=0x40)
[  396.287519] ata1.01: failed to read SCR 1 (Emask=0x40)
[  396.287522] ata1.02: failed to read SCR 1 (Emask=0x40)
[  396.287525] ata1.03: failed to read SCR 1 (Emask=0x40)
[  396.287528] ata1.04: failed to read SCR 1 (Emask=0x40)
[  396.287531] ata1.05: failed to read SCR 1 (Emask=0x40)
[  396.287534] ata1.06: failed to read SCR 1 (Emask=0x40)
[  396.287539] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  396.287542] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  396.287546] ata1: SError: { 10B8B }
[  396.287551] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287557] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287562] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287567] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287572] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287577] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287582] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287590] ata1.15: hard resetting link
[  401.381322] ata1.15: SATA link down (SStatus 1 SControl 10)
[  401.633240] ata1.15: qc timeout (cmd 0xe4)
[  401.633248] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  401.633251] ata1.15: PMP revalidation failed (errno=-5)
[  401.633254] ata1.15: retrying hardreset in 5 secs
[  406.635722] ata1.15: hard resetting link
[  411.730181] ata1.15: SATA link down (SStatus 1 SControl 10)
[  411.982099] ata1.15: qc timeout (cmd 0xe4)
[  411.982107] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  411.982110] ata1.15: PMP revalidation failed (errno=-5)
[  411.982113] ata1.15: retrying hardreset in 5 secs
[  416.984582] ata1.15: hard resetting link
[  419.183924] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  419.184128] ata1.00: hard resetting link
[  419.504005] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  419.504009] ata1.01: hard resetting link
[  419.823907] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  419.823911] ata1.02: hard resetting link
[  420.143811] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  420.143815] ata1.03: hard resetting link
[  420.463713] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  420.463717] ata1.04: hard resetting link
[  420.783616] ata1.04: SATA link down (SStatus 0 SControl 310)
[  420.783619] ata1.05: hard resetting link
[  421.103516] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  421.103520] ata1.06: hard resetting link
[  421.423426] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  421.423538] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423542] ata1.00: revalidation failed (errno=-5)
[  421.423672] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423675] ata1.01: revalidation failed (errno=-5)
[  421.423804] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423808] ata1.02: revalidation failed (errno=-5)
[  421.423936] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423940] ata1.03: revalidation failed (errno=-5)
[  421.424077] ata1.05: device is on DMA blacklist, disabling DMA
[  421.424192] ata1.05: configured for PIO4
[  421.424195] ata1: failed to recover some devices, retrying in 5 secs
[  426.425719] ata1.00: hard resetting link
[  426.745807] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  426.745811] ata1.01: hard resetting link
[  427.065709] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.065713] ata1.02: hard resetting link
[  427.385613] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.385617] ata1.03: hard resetting link
[  427.705517] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.707726] ata1.00: configured for UDMA/100
[  427.709957] ata1.01: configured for UDMA/100
[  427.813721] ata1.02: configured for UDMA/100
[  427.813822] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  427.813826] ata1.03: revalidation failed (errno=-5)
[  427.813829] ata1: failed to recover some devices, retrying in 5 secs
[  432.815779] ata1.03: hard resetting link
[  433.135867] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  433.135974] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  433.135977] ata1.03: revalidation failed (errno=-5)
[  433.135980] ata1.03: disabled
[  433.639529] ata1.03: hard resetting link
[  433.959617] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  433.959672] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  433.959676] ata1: failed to recover some devices, retrying in 5 secs
[  438.961914] ata1.03: hard resetting link
[  439.282004] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  439.282059] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  439.282062] ata1: failed to recover some devices, retrying in 5 secs
[  444.284300] ata1.03: hard resetting link
[  444.604390] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  444.604446] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  444.604450] ata1: failed to recover some devices, retrying in 5 secs
[  449.606691] ata1.03: hard resetting link
[  449.926776] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  449.927130] ata1: EH complete
[  449.927174] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  449.927186] sd 1:0:0:0: [sdb] Write Protect is off
[  449.927189] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  449.927202] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927218] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  449.927226] sd 1:1:0:0: [sdc] Write Protect is off
[  449.927229] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  449.927240] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927254] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  449.927262] sd 1:2:0:0: [sdd] Write Protect is off
[  449.927264] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  449.927276] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927289] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  449.927297] sd 1:5:0:0: [sdf] Write Protect is off
[  449.927299] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  449.927395] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  449.927408] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  449.927416] sd 1:0:0:0: [sdb] Write Protect is off
[  449.927419] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  449.927430] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927442] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  449.927450] sd 1:1:0:0: [sdc] Write Protect is off
[  449.927453] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  449.927464] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927477] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  449.927484] sd 1:2:0:0: [sdd] Write Protect is off
[  449.927487] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  449.927498] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927511] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  449.927518] sd 1:5:0:0: [sdf] Write Protect is off
[  449.927521] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  449.927532] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  449.927538] ata1.03: detaching (SCSI 1:3:0:0)
[  449.927717] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  449.928940] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  449.928945] sd 1:3:0:0: [sde] Stopping disk
[  449.928950] sd 1:3:0:0: [sde] START_STOP FAILED
[  449.928953] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00

--------------020808050009060708060708
Content-Type: text/plain;
 name="3_PlugUnplug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3_PlugUnplug.txt"

f8 (irq = 3) is a 16550A
[   60.047248] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   60.428849] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
[   61.428460] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   61.428605] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[   61.428797] ata1.00: hard resetting link
[   61.748518] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   61.748524] ata1.01: hard resetting link
[   62.068415] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.068418] ata1.02: hard resetting link
[   62.388321] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.388323] ata1.03: hard resetting link
[   62.708223] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.708226] ata1.04: hard resetting link
[   63.028129] ata1.04: SATA link down (SStatus 0 SControl 320)
[   63.028136] ata1.05: hard resetting link
[   63.348026] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   63.348029] ata1.06: hard resetting link
[   63.667932] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   63.668978] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[   63.668981] ata1.00: 586072368 sectors, multi 16: LBA48 
[   63.668983] ata1.00: applying bridge limits
[   63.670120] ata1.00: configured for UDMA/100
[   63.671146] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[   63.671149] ata1.01: 586072368 sectors, multi 0: LBA48 
[   63.671151] ata1.01: applying bridge limits
[   63.672287] ata1.01: configured for UDMA/100
[   63.716356] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   63.716358] ata1.02: 586072368 sectors, multi 0: LBA48 
[   63.716360] ata1.02: applying bridge limits
[   63.782803] ata1.02: configured for UDMA/100
[   63.826318] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   63.826321] ata1.03: 586072368 sectors, multi 0: LBA48 
[   63.826323] ata1.03: applying bridge limits
[   63.884593] ata1.03: configured for UDMA/100
[   63.884662] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[   63.884665] ata1.05: 640 sectors, multi 1: LBA 
[   63.884671] ata1.05: device is on DMA blacklist, disabling DMA
[   63.884759] ata1.05: configured for PIO4
[   63.884799] ata1: EH complete
[   65.963083] ata2: SATA link down (SStatus 0 SControl 0)
[   68.042452] ata3: SATA link down (SStatus 0 SControl 0)
[   70.121822] ata4: SATA link down (SStatus 0 SControl 0)
[   70.121936] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.122351] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.122362] sd 1:0:0:0: [sdb] Write Protect is off
[   70.122365] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.122377] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.122423] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.122430] sd 1:0:0:0: [sdb] Write Protect is off
[   70.122432] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.122443] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.122448]  sdb: sdb1
[   70.125719] sd 1:0:0:0: [sdb] Attached SCSI disk
[   70.125755] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   70.126207] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.126477] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.126485] sd 1:1:0:0: [sdc] Write Protect is off
[   70.126487] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.126499] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.126528] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.126535] sd 1:1:0:0: [sdc] Write Protect is off
[   70.126538] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.126549] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.126551]  sdc: sdc1
[   70.139869] sd 1:1:0:0: [sdc] Attached SCSI disk
[   70.139900] sd 1:1:0:0: Attached scsi generic sg3 type 0
[   70.140370] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.140431] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.140439] sd 1:2:0:0: [sdd] Write Protect is off
[   70.140441] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.140452] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.140482] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.140489] sd 1:2:0:0: [sdd] Write Protect is off
[   70.140491] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.140502] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.140504]  sdd: sdd1
[   70.159621] sd 1:2:0:0: [sdd] Attached SCSI disk
[   70.159653] sd 1:2:0:0: Attached scsi generic sg4 type 0
[   70.159699] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.159756] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.159764] sd 1:3:0:0: [sde] Write Protect is off
[   70.159766] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.159777] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.160524] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.160532] sd 1:3:0:0: [sde] Write Protect is off
[   70.160534] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.160545] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.160548]  sde: sde1
[   70.176524] sd 1:3:0:0: [sde] Attached SCSI disk
[   70.176556] sd 1:3:0:0: Attached scsi generic sg5 type 0
[   70.176602] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.176661] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.176668] sd 1:5:0:0: [sdf] Write Protect is off
[   70.176670] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.176681] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.176710] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.176717] sd 1:5:0:0: [sdf] Write Protect is off
[   70.176719] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.176731] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.176733]  sdf: unknown partition table
[   70.177579] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.177611] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.177788] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.177802] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.177992] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[   70.178021] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.178162] usb usb1: configuration #1 chosen from 1 choice
[   70.178188] hub 1-0:1.0: USB hub found
[   70.178196] hub 1-0:1.0: 2 ports detected
[   70.281899] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   70.281913] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   70.281938] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[   70.281961] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   70.282085] usb usb2: configuration #1 chosen from 1 choice
[   70.282111] hub 2-0:1.0: USB hub found
[   70.282119] hub 2-0:1.0: 2 ports detected
[   70.385877] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   70.385890] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   70.385918] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[   70.385941] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   70.386059] usb usb3: configuration #1 chosen from 1 choice
[   70.386084] hub 3-0:1.0: USB hub found
[   70.386091] hub 3-0:1.0: 2 ports detected
[   70.489843] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   70.489857] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   70.489882] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[   70.489905] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   70.490022] usb usb4: configuration #1 chosen from 1 choice
[   70.490047] hub 4-0:1.0: USB hub found
[   70.490055] hub 4-0:1.0: 2 ports detected
[   70.593880] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   70.594063] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   70.594122] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
[   70.594171] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   70.605694] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   70.605812] usb usb5: configuration #1 chosen from 1 choice
[   70.605838] hub 5-0:1.0: USB hub found
[   70.605847] hub 5-0:1.0: 8 ports detected
[   70.709842] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   70.712088] Audigy2 value: Special config.
[   72.299598] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   72.299603] Copyright (c) 1999-2006 Intel Corporation.
[   72.299645] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   72.299650] PCI: Disallowing DAC for device 0000:00:0e.0
[   72.558679] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   72.734178] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   72.890022] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   72.890034] ReiserFS: hdb1: using ordered data mode
[   72.929121] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   72.930477] ReiserFS: hdb1: checking transaction log (hdb1)
[   73.047880] ReiserFS: hdb1: Using r5 hash to sort names
[   73.096394] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   73.096405] ReiserFS: hda2: using ordered data mode
[   73.101224] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   73.102630] ReiserFS: hda2: checking transaction log (hda2)
[   73.165531] ReiserFS: hda2: Using r5 hash to sort names
[   79.014996] hda: UDMA/100 mode selected
[   79.018892] hdb: UDMA/133 mode selected
[   79.073585] hdc: UDMA/33 mode selected
[   79.091357] hdd: UDMA/33 mode selected
[   81.606735] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   85.836882] w83627hf: Found W83697HF chip at 0x290
[  209.524283] ata1.00: failed to read SCR 1 (Emask=0x40)
[  209.524288] ata1.01: failed to read SCR 1 (Emask=0x40)
[  209.524291] ata1.02: failed to read SCR 1 (Emask=0x40)
[  209.524294] ata1.03: failed to read SCR 1 (Emask=0x40)
[  209.524296] ata1.04: failed to read SCR 1 (Emask=0x40)
[  209.524299] ata1.05: failed to read SCR 1 (Emask=0x40)
[  209.524301] ata1.06: failed to read SCR 1 (Emask=0x40)
[  209.524305] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  209.524308] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  209.524311] ata1: SError: { 10B8B }
[  209.524316] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524320] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524325] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524329] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524333] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524338] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524342] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  209.524349] ata1.15: hard resetting link
[  214.617980] ata1.15: SATA link down (SStatus 1 SControl 0)
[  214.869897] ata1.15: qc timeout (cmd 0xe4)
[  214.869905] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  214.869908] ata1.15: PMP revalidation failed (errno=-5)
[  214.869910] ata1.15: retrying hardreset in 5 secs
[  219.872379] ata1.15: hard resetting link
[  224.966839] ata1.15: SATA link down (SStatus 1 SControl 0)
[  225.173188] ata1.15: failed to read PMP GSCR[0] (Emask=0x100)
[  225.173191] ata1.15: PMP revalidation failed (errno=-5)
[  225.173194] ata1.15: limiting SATA link speed to 1.5 Gbps
[  225.173197] ata1.15: retrying hardreset in 5 secs
[  230.173255] ata1.15: hard resetting link
[  232.372597] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  232.372805] ata1.00: hard resetting link
[  232.692677] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  232.692680] ata1.01: hard resetting link
[  233.012579] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  233.012583] ata1.02: hard resetting link
[  233.332482] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  233.332485] ata1.03: hard resetting link
[  233.652385] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  233.652388] ata1.04: hard resetting link
[  233.972289] ata1.04: SATA link down (SStatus 0 SControl 310)
[  233.972292] ata1.05: hard resetting link
[  234.292189] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  234.292192] ata1.06: hard resetting link
[  234.612092] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  234.614276] ata1.00: configured for UDMA/100
[  234.616463] ata1.01: configured for UDMA/100
[  234.719921] ata1.02: configured for UDMA/100
[  234.821531] ata1.03: configured for UDMA/100
[  234.821636] ata1.05: device is on DMA blacklist, disabling DMA
[  234.821741] ata1.05: configured for PIO4
[  234.821953] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  234.821956] ata1.15: irq_stat 0x00800080, device exchanged
[  234.822220] ata1: EH complete
[  234.822245] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  234.822256] sd 1:0:0:0: [sdb] Write Protect is off
[  234.822259] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  234.822271] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822285] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  234.822292] sd 1:1:0:0: [sdc] Write Protect is off
[  234.822295] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  234.822305] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822318] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  234.822325] sd 1:2:0:0: [sdd] Write Protect is off
[  234.822328] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  234.822339] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822353] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  234.822361] sd 1:3:0:0: [sde] Write Protect is off
[  234.822363] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  234.822375] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822388] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  234.822396] sd 1:5:0:0: [sdf] Write Protect is off
[  234.822399] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  234.822410] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  234.822423] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  234.822431] sd 1:0:0:0: [sdb] Write Protect is off
[  234.822434] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  234.822445] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822458] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  234.822465] sd 1:1:0:0: [sdc] Write Protect is off
[  234.822468] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  234.822479] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822492] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  234.822500] sd 1:2:0:0: [sdd] Write Protect is off
[  234.822503] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  234.822514] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822527] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  234.822534] sd 1:3:0:0: [sde] Write Protect is off
[  234.822537] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  234.822549] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822561] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  234.822569] sd 1:5:0:0: [sdf] Write Protect is off
[  234.822571] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  234.822583] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  396.287513] ata1.00: failed to read SCR 1 (Emask=0x40)
[  396.287519] ata1.01: failed to read SCR 1 (Emask=0x40)
[  396.287522] ata1.02: failed to read SCR 1 (Emask=0x40)
[  396.287525] ata1.03: failed to read SCR 1 (Emask=0x40)
[  396.287528] ata1.04: failed to read SCR 1 (Emask=0x40)
[  396.287531] ata1.05: failed to read SCR 1 (Emask=0x40)
[  396.287534] ata1.06: failed to read SCR 1 (Emask=0x40)
[  396.287539] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  396.287542] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  396.287546] ata1: SError: { 10B8B }
[  396.287551] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287557] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287562] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287567] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287572] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287577] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287582] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287590] ata1.15: hard resetting link
[  401.381322] ata1.15: SATA link down (SStatus 1 SControl 10)
[  401.633240] ata1.15: qc timeout (cmd 0xe4)
[  401.633248] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  401.633251] ata1.15: PMP revalidation failed (errno=-5)
[  401.633254] ata1.15: retrying hardreset in 5 secs
[  406.635722] ata1.15: hard resetting link
[  411.730181] ata1.15: SATA link down (SStatus 1 SControl 10)
[  411.982099] ata1.15: qc timeout (cmd 0xe4)
[  411.982107] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  411.982110] ata1.15: PMP revalidation failed (errno=-5)
[  411.982113] ata1.15: retrying hardreset in 5 secs
[  416.984582] ata1.15: hard resetting link
[  419.183924] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  419.184128] ata1.00: hard resetting link
[  419.504005] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  419.504009] ata1.01: hard resetting link
[  419.823907] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  419.823911] ata1.02: hard resetting link
[  420.143811] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  420.143815] ata1.03: hard resetting link
[  420.463713] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  420.463717] ata1.04: hard resetting link
[  420.783616] ata1.04: SATA link down (SStatus 0 SControl 310)
[  420.783619] ata1.05: hard resetting link
[  421.103516] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  421.103520] ata1.06: hard resetting link
[  421.423426] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  421.423538] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423542] ata1.00: revalidation failed (errno=-5)
[  421.423672] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423675] ata1.01: revalidation failed (errno=-5)
[  421.423804] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423808] ata1.02: revalidation failed (errno=-5)
[  421.423936] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423940] ata1.03: revalidation failed (errno=-5)
[  421.424077] ata1.05: device is on DMA blacklist, disabling DMA
[  421.424192] ata1.05: configured for PIO4
[  421.424195] ata1: failed to recover some devices, retrying in 5 secs
[  426.425719] ata1.00: hard resetting link
[  426.745807] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  426.745811] ata1.01: hard resetting link
[  427.065709] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.065713] ata1.02: hard resetting link
[  427.385613] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.385617] ata1.03: hard resetting link
[  427.705517] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.707726] ata1.00: configured for UDMA/100
[  427.709957] ata1.01: configured for UDMA/100
[  427.813721] ata1.02: configured for UDMA/100
[  427.813822] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  427.813826] ata1.03: revalidation failed (errno=-5)
[  427.813829] ata1: failed to recover some devices, retrying in 5 secs
[  432.815779] ata1.03: hard resetting link
[  433.135867] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  433.135974] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  433.135977] ata1.03: revalidation failed (errno=-5)
[  433.135980] ata1.03: disabled
[  433.639529] ata1.03: hard resetting link
[  433.959617] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  433.959672] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  433.959676] ata1: failed to recover some devices, retrying in 5 secs
[  438.961914] ata1.03: hard resetting link
[  439.282004] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  439.282059] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  439.282062] ata1: failed to recover some devices, retrying in 5 secs
[  444.284300] ata1.03: hard resetting link
[  444.604390] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  444.604446] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  444.604450] ata1: failed to recover some devices, retrying in 5 secs
[  449.606691] ata1.03: hard resetting link
[  449.926776] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  449.927130] ata1: EH complete
[  449.927174] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  449.927186] sd 1:0:0:0: [sdb] Write Protect is off
[  449.927189] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  449.927202] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927218] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  449.927226] sd 1:1:0:0: [sdc] Write Protect is off
[  449.927229] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  449.927240] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927254] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  449.927262] sd 1:2:0:0: [sdd] Write Protect is off
[  449.927264] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  449.927276] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927289] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  449.927297] sd 1:5:0:0: [sdf] Write Protect is off
[  449.927299] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  449.927395] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  449.927408] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  449.927416] sd 1:0:0:0: [sdb] Write Protect is off
[  449.927419] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  449.927430] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927442] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  449.927450] sd 1:1:0:0: [sdc] Write Protect is off
[  449.927453] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  449.927464] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927477] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  449.927484] sd 1:2:0:0: [sdd] Write Protect is off
[  449.927487] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  449.927498] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927511] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  449.927518] sd 1:5:0:0: [sdf] Write Protect is off
[  449.927521] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  449.927532] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  449.927538] ata1.03: detaching (SCSI 1:3:0:0)
[  449.927717] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  449.928940] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  449.928945] sd 1:3:0:0: [sde] Stopping disk
[  449.928950] sd 1:3:0:0: [sde] START_STOP FAILED
[  449.928953] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  617.297502] ata1.15: limiting speed to UDMA7:PIO5
[  617.297509] ata1.00: failed to read SCR 1 (Emask=0x40)
[  617.297512] ata1.01: failed to read SCR 1 (Emask=0x40)
[  617.297515] ata1.02: failed to read SCR 1 (Emask=0x40)
[  617.297518] ata1.03: failed to read SCR 1 (Emask=0x40)
[  617.297521] ata1.04: failed to read SCR 1 (Emask=0x40)
[  617.297524] ata1.05: failed to read SCR 1 (Emask=0x40)
[  617.297527] ata1.06: failed to read SCR 1 (Emask=0x40)
[  617.297531] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  617.297535] ata1.15: irq_stat 0x01940090, PHY RDY changed
[  617.297539] ata1: SError: { 10B8B }
[  617.297543] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297549] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297554] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297559] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297564] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297569] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297574] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297582] ata1.15: hard resetting link
[  622.390270] ata1.15: SATA link down (SStatus 1 SControl 10)
[  622.642187] ata1.15: qc timeout (cmd 0xe4)
[  622.642196] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  622.642199] ata1.15: PMP revalidation failed (errno=-5)
[  622.642202] ata1.15: retrying hardreset in 5 secs
[  627.644669] ata1.15: hard resetting link
[  632.739129] ata1.15: SATA link down (SStatus 1 SControl 10)
[  632.991047] ata1.15: qc timeout (cmd 0xe4)
[  632.991055] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  632.991058] ata1.15: PMP revalidation failed (errno=-5)
[  632.991061] ata1.15: retrying hardreset in 5 secs
[  637.993529] ata1.15: hard resetting link
[  640.192871] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  640.193076] ata1.00: hard resetting link
[  640.512952] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  640.512956] ata1.01: hard resetting link
[  640.832853] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  640.832857] ata1.02: hard resetting link
[  641.152758] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  641.152762] ata1.03: hard resetting link
[  641.472660] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  641.472664] ata1.04: hard resetting link
[  641.792562] ata1.04: SATA link down (SStatus 0 SControl 310)
[  641.792565] ata1.05: hard resetting link
[  642.112464] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  642.112468] ata1.06: hard resetting link
[  642.432369] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  642.434609] ata1.00: configured for UDMA/100
[  642.436783] ata1.01: configured for UDMA/100
[  642.548979] ata1.02: configured for UDMA/100
[  642.597737] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[  642.597741] ata1.03: 586072368 sectors, multi 0: LBA48 
[  642.597744] ata1.03: applying bridge limits
[  642.656013] ata1.03: configured for UDMA/100
[  642.656121] ata1.05: device is on DMA blacklist, disabling DMA
[  642.656227] ata1.05: configured for PIO4
[  642.656497] ata1: EH complete
[  642.656522] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  642.656534] sd 1:0:0:0: [sdb] Write Protect is off
[  642.656537] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  642.656550] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656564] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  642.656572] sd 1:1:0:0: [sdc] Write Protect is off
[  642.656575] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  642.656586] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656600] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  642.656608] sd 1:2:0:0: [sdd] Write Protect is off
[  642.656610] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  642.656622] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656635] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  642.656643] sd 1:5:0:0: [sdf] Write Protect is off
[  642.656646] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  642.656657] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  642.656670] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  642.656677] sd 1:0:0:0: [sdb] Write Protect is off
[  642.656680] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  642.656692] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656704] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  642.656712] sd 1:1:0:0: [sdc] Write Protect is off
[  642.656715] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  642.656726] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656738] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  642.656746] sd 1:2:0:0: [sdd] Write Protect is off
[  642.656749] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  642.656760] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656773] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  642.656780] sd 1:5:0:0: [sdf] Write Protect is off
[  642.656783] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  642.656794] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  642.656866] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[  642.657321] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  642.657330] sd 1:3:0:0: [sde] Write Protect is off
[  642.657333] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  642.657345] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.657389] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  642.657796] sd 1:3:0:0: [sde] Write Protect is off
[  642.657799] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  642.657815] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.657819]  sde: sde1
[  642.695754] sd 1:3:0:0: [sde] Attached SCSI disk
[  642.695803] sd 1:3:0:0: Attached scsi generic sg5 type 0

--------------020808050009060708060708
Content-Type: text/plain;
 name="4_PowerOnOffTwice.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4_PowerOnOffTwice.log"

[sdf] 640 512-byte hardware sectors (0 MB)
[  234.822396] sd 1:5:0:0: [sdf] Write Protect is off
[  234.822399] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  234.822410] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  234.822423] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  234.822431] sd 1:0:0:0: [sdb] Write Protect is off
[  234.822434] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  234.822445] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822458] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  234.822465] sd 1:1:0:0: [sdc] Write Protect is off
[  234.822468] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  234.822479] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822492] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  234.822500] sd 1:2:0:0: [sdd] Write Protect is off
[  234.822503] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  234.822514] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822527] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  234.822534] sd 1:3:0:0: [sde] Write Protect is off
[  234.822537] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  234.822549] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  234.822561] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  234.822569] sd 1:5:0:0: [sdf] Write Protect is off
[  234.822571] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  234.822583] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  396.287513] ata1.00: failed to read SCR 1 (Emask=0x40)
[  396.287519] ata1.01: failed to read SCR 1 (Emask=0x40)
[  396.287522] ata1.02: failed to read SCR 1 (Emask=0x40)
[  396.287525] ata1.03: failed to read SCR 1 (Emask=0x40)
[  396.287528] ata1.04: failed to read SCR 1 (Emask=0x40)
[  396.287531] ata1.05: failed to read SCR 1 (Emask=0x40)
[  396.287534] ata1.06: failed to read SCR 1 (Emask=0x40)
[  396.287539] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  396.287542] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  396.287546] ata1: SError: { 10B8B }
[  396.287551] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287557] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287562] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287567] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287572] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287577] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287582] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  396.287590] ata1.15: hard resetting link
[  401.381322] ata1.15: SATA link down (SStatus 1 SControl 10)
[  401.633240] ata1.15: qc timeout (cmd 0xe4)
[  401.633248] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  401.633251] ata1.15: PMP revalidation failed (errno=-5)
[  401.633254] ata1.15: retrying hardreset in 5 secs
[  406.635722] ata1.15: hard resetting link
[  411.730181] ata1.15: SATA link down (SStatus 1 SControl 10)
[  411.982099] ata1.15: qc timeout (cmd 0xe4)
[  411.982107] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  411.982110] ata1.15: PMP revalidation failed (errno=-5)
[  411.982113] ata1.15: retrying hardreset in 5 secs
[  416.984582] ata1.15: hard resetting link
[  419.183924] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  419.184128] ata1.00: hard resetting link
[  419.504005] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  419.504009] ata1.01: hard resetting link
[  419.823907] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  419.823911] ata1.02: hard resetting link
[  420.143811] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  420.143815] ata1.03: hard resetting link
[  420.463713] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  420.463717] ata1.04: hard resetting link
[  420.783616] ata1.04: SATA link down (SStatus 0 SControl 310)
[  420.783619] ata1.05: hard resetting link
[  421.103516] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  421.103520] ata1.06: hard resetting link
[  421.423426] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  421.423538] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423542] ata1.00: revalidation failed (errno=-5)
[  421.423672] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423675] ata1.01: revalidation failed (errno=-5)
[  421.423804] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423808] ata1.02: revalidation failed (errno=-5)
[  421.423936] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  421.423940] ata1.03: revalidation failed (errno=-5)
[  421.424077] ata1.05: device is on DMA blacklist, disabling DMA
[  421.424192] ata1.05: configured for PIO4
[  421.424195] ata1: failed to recover some devices, retrying in 5 secs
[  426.425719] ata1.00: hard resetting link
[  426.745807] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  426.745811] ata1.01: hard resetting link
[  427.065709] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.065713] ata1.02: hard resetting link
[  427.385613] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.385617] ata1.03: hard resetting link
[  427.705517] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  427.707726] ata1.00: configured for UDMA/100
[  427.709957] ata1.01: configured for UDMA/100
[  427.813721] ata1.02: configured for UDMA/100
[  427.813822] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  427.813826] ata1.03: revalidation failed (errno=-5)
[  427.813829] ata1: failed to recover some devices, retrying in 5 secs
[  432.815779] ata1.03: hard resetting link
[  433.135867] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  433.135974] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  433.135977] ata1.03: revalidation failed (errno=-5)
[  433.135980] ata1.03: disabled
[  433.639529] ata1.03: hard resetting link
[  433.959617] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  433.959672] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  433.959676] ata1: failed to recover some devices, retrying in 5 secs
[  438.961914] ata1.03: hard resetting link
[  439.282004] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  439.282059] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  439.282062] ata1: failed to recover some devices, retrying in 5 secs
[  444.284300] ata1.03: hard resetting link
[  444.604390] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  444.604446] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  444.604450] ata1: failed to recover some devices, retrying in 5 secs
[  449.606691] ata1.03: hard resetting link
[  449.926776] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  449.927130] ata1: EH complete
[  449.927174] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  449.927186] sd 1:0:0:0: [sdb] Write Protect is off
[  449.927189] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  449.927202] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927218] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  449.927226] sd 1:1:0:0: [sdc] Write Protect is off
[  449.927229] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  449.927240] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927254] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  449.927262] sd 1:2:0:0: [sdd] Write Protect is off
[  449.927264] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  449.927276] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927289] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  449.927297] sd 1:5:0:0: [sdf] Write Protect is off
[  449.927299] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  449.927395] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  449.927408] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  449.927416] sd 1:0:0:0: [sdb] Write Protect is off
[  449.927419] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  449.927430] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927442] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  449.927450] sd 1:1:0:0: [sdc] Write Protect is off
[  449.927453] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  449.927464] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927477] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  449.927484] sd 1:2:0:0: [sdd] Write Protect is off
[  449.927487] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  449.927498] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927511] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  449.927518] sd 1:5:0:0: [sdf] Write Protect is off
[  449.927521] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  449.927532] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  449.927538] ata1.03: detaching (SCSI 1:3:0:0)
[  449.927717] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  449.928940] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  449.928945] sd 1:3:0:0: [sde] Stopping disk
[  449.928950] sd 1:3:0:0: [sde] START_STOP FAILED
[  449.928953] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  617.297502] ata1.15: limiting speed to UDMA7:PIO5
[  617.297509] ata1.00: failed to read SCR 1 (Emask=0x40)
[  617.297512] ata1.01: failed to read SCR 1 (Emask=0x40)
[  617.297515] ata1.02: failed to read SCR 1 (Emask=0x40)
[  617.297518] ata1.03: failed to read SCR 1 (Emask=0x40)
[  617.297521] ata1.04: failed to read SCR 1 (Emask=0x40)
[  617.297524] ata1.05: failed to read SCR 1 (Emask=0x40)
[  617.297527] ata1.06: failed to read SCR 1 (Emask=0x40)
[  617.297531] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  617.297535] ata1.15: irq_stat 0x01940090, PHY RDY changed
[  617.297539] ata1: SError: { 10B8B }
[  617.297543] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297549] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297554] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297559] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297564] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297569] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297574] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297582] ata1.15: hard resetting link
[  622.390270] ata1.15: SATA link down (SStatus 1 SControl 10)
[  622.642187] ata1.15: qc timeout (cmd 0xe4)
[  622.642196] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  622.642199] ata1.15: PMP revalidation failed (errno=-5)
[  622.642202] ata1.15: retrying hardreset in 5 secs
[  627.644669] ata1.15: hard resetting link
[  632.739129] ata1.15: SATA link down (SStatus 1 SControl 10)
[  632.991047] ata1.15: qc timeout (cmd 0xe4)
[  632.991055] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  632.991058] ata1.15: PMP revalidation failed (errno=-5)
[  632.991061] ata1.15: retrying hardreset in 5 secs
[  637.993529] ata1.15: hard resetting link
[  640.192871] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  640.193076] ata1.00: hard resetting link
[  640.512952] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  640.512956] ata1.01: hard resetting link
[  640.832853] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  640.832857] ata1.02: hard resetting link
[  641.152758] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  641.152762] ata1.03: hard resetting link
[  641.472660] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  641.472664] ata1.04: hard resetting link
[  641.792562] ata1.04: SATA link down (SStatus 0 SControl 310)
[  641.792565] ata1.05: hard resetting link
[  642.112464] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  642.112468] ata1.06: hard resetting link
[  642.432369] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  642.434609] ata1.00: configured for UDMA/100
[  642.436783] ata1.01: configured for UDMA/100
[  642.548979] ata1.02: configured for UDMA/100
[  642.597737] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[  642.597741] ata1.03: 586072368 sectors, multi 0: LBA48 
[  642.597744] ata1.03: applying bridge limits
[  642.656013] ata1.03: configured for UDMA/100
[  642.656121] ata1.05: device is on DMA blacklist, disabling DMA
[  642.656227] ata1.05: configured for PIO4
[  642.656497] ata1: EH complete
[  642.656522] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  642.656534] sd 1:0:0:0: [sdb] Write Protect is off
[  642.656537] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  642.656550] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656564] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  642.656572] sd 1:1:0:0: [sdc] Write Protect is off
[  642.656575] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  642.656586] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656600] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  642.656608] sd 1:2:0:0: [sdd] Write Protect is off
[  642.656610] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  642.656622] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656635] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  642.656643] sd 1:5:0:0: [sdf] Write Protect is off
[  642.656646] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  642.656657] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  642.656670] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  642.656677] sd 1:0:0:0: [sdb] Write Protect is off
[  642.656680] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  642.656692] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656704] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  642.656712] sd 1:1:0:0: [sdc] Write Protect is off
[  642.656715] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  642.656726] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656738] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  642.656746] sd 1:2:0:0: [sdd] Write Protect is off
[  642.656749] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  642.656760] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656773] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  642.656780] sd 1:5:0:0: [sdf] Write Protect is off
[  642.656783] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  642.656794] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  642.656866] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[  642.657321] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  642.657330] sd 1:3:0:0: [sde] Write Protect is off
[  642.657333] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  642.657345] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.657389] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  642.657796] sd 1:3:0:0: [sde] Write Protect is off
[  642.657799] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  642.657815] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.657819]  sde: sde1
[  642.695754] sd 1:3:0:0: [sde] Attached SCSI disk
[  642.695803] sd 1:3:0:0: Attached scsi generic sg5 type 0
[  810.992367] ata1.00: failed to read SCR 1 (Emask=0x40)
[  810.992373] ata1.01: failed to read SCR 1 (Emask=0x40)
[  810.992376] ata1.02: failed to read SCR 1 (Emask=0x40)
[  810.992379] ata1.03: failed to read SCR 1 (Emask=0x40)
[  810.992382] ata1.04: failed to read SCR 1 (Emask=0x40)
[  810.992385] ata1.05: failed to read SCR 1 (Emask=0x40)
[  810.992388] ata1.06: failed to read SCR 1 (Emask=0x40)
[  810.992393] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  810.992396] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  810.992400] ata1: SError: { 10B8B }
[  810.992405] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992410] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992415] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992421] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992426] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992431] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992436] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992444] ata1.15: hard resetting link
[  816.083507] ata1.15: SATA link down (SStatus 1 SControl 10)
[  816.335424] ata1.15: qc timeout (cmd 0xe4)
[  816.335432] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  816.335435] ata1.15: PMP revalidation failed (errno=-5)
[  816.335438] ata1.15: retrying hardreset in 5 secs
[  821.337906] ata1.15: hard resetting link
[  826.432365] ata1.15: SATA link down (SStatus 1 SControl 10)
[  826.684283] ata1.15: qc timeout (cmd 0xe4)
[  826.684290] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  826.684293] ata1.15: PMP revalidation failed (errno=-5)
[  826.684297] ata1.15: retrying hardreset in 5 secs
[  831.686765] ata1.15: hard resetting link
[  833.886108] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  833.886312] ata1.00: hard resetting link
[  834.206188] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  834.206192] ata1.01: hard resetting link
[  834.526091] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  834.526095] ata1.02: hard resetting link
[  834.845993] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  834.845997] ata1.03: hard resetting link
[  835.165897] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  835.165901] ata1.04: hard resetting link
[  835.485800] ata1.04: SATA link down (SStatus 0 SControl 310)
[  835.485804] ata1.05: hard resetting link
[  835.805701] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  835.805704] ata1.06: hard resetting link
[  836.125608] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  836.125738] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  836.125742] ata1.00: revalidation failed (errno=-5)
[  836.125871] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  836.125875] ata1.01: revalidation failed (errno=-5)
[  836.126004] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  836.126007] ata1.02: revalidation failed (errno=-5)
[  836.126136] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  836.126140] ata1.03: revalidation failed (errno=-5)
[  836.126277] ata1.05: device is on DMA blacklist, disabling DMA
[  836.126394] ata1.05: configured for PIO4
[  836.126397] ata1: failed to recover some devices, retrying in 5 secs
[  841.127902] ata1.00: hard resetting link
[  841.447991] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  841.447995] ata1.01: hard resetting link
[  841.767894] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  841.767898] ata1.02: hard resetting link
[  842.087796] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  842.087800] ata1.03: hard resetting link
[  842.407699] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  842.409866] ata1.00: configured for UDMA/100
[  842.412082] ata1.01: configured for UDMA/100
[  842.516615] ata1.02: configured for UDMA/100
[  842.516722] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  842.516726] ata1.03: revalidation failed (errno=-5)
[  842.516729] ata1: failed to recover some devices, retrying in 5 secs
[  847.517963] ata1.03: hard resetting link
[  847.838051] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  847.838156] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  847.838160] ata1.03: revalidation failed (errno=-5)
[  847.838163] ata1.03: disabled
[  848.341712] ata1.03: hard resetting link
[  848.661801] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  848.661856] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  848.661859] ata1: failed to recover some devices, retrying in 5 secs
[  853.664098] ata1.03: hard resetting link
[  853.984187] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  853.984243] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  853.984246] ata1: failed to recover some devices, retrying in 5 secs
[  858.986483] ata1.03: hard resetting link
[  859.306572] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  859.306628] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  859.306631] ata1: failed to recover some devices, retrying in 5 secs
[  864.308868] ata1.03: hard resetting link
[  864.628957] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  864.629240] ata1: EH complete
[  864.629267] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  864.629278] sd 1:0:0:0: [sdb] Write Protect is off
[  864.629282] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  864.629294] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629309] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  864.629317] sd 1:1:0:0: [sdc] Write Protect is off
[  864.629320] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  864.629331] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629345] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  864.629352] sd 1:2:0:0: [sdd] Write Protect is off
[  864.629355] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  864.629367] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629380] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  864.629387] sd 1:5:0:0: [sdf] Write Protect is off
[  864.629390] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  864.629401] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  864.629414] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  864.629422] sd 1:0:0:0: [sdb] Write Protect is off
[  864.629425] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  864.629436] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629448] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  864.629456] sd 1:1:0:0: [sdc] Write Protect is off
[  864.629458] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  864.629470] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629482] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  864.629489] sd 1:2:0:0: [sdd] Write Protect is off
[  864.629492] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  864.629503] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629516] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  864.629523] sd 1:5:0:0: [sdf] Write Protect is off
[  864.629526] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  864.629537] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  864.629542] ata1.03: detaching (SCSI 1:3:0:0)
[  864.629721] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  864.630109] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  864.630113] sd 1:3:0:0: [sde] Stopping disk
[  864.630119] sd 1:3:0:0: [sde] START_STOP FAILED
[  864.630121] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[ 1232.464873] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1232.464879] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1232.464882] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1232.464885] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1232.464888] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1232.464891] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1232.464894] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1232.464899] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1232.464902] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1232.464906] ata1: SError: { 10B8B }
[ 1232.464911] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464916] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464921] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464926] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464931] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464936] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464942] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464949] ata1.15: hard resetting link
[ 1237.555650] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1237.807567] ata1.15: qc timeout (cmd 0xe4)
[ 1237.807575] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1237.807579] ata1.15: PMP revalidation failed (errno=-5)
[ 1237.807582] ata1.15: retrying hardreset in 5 secs
[ 1242.810049] ata1.15: hard resetting link
[ 1247.904509] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1248.156427] ata1.15: qc timeout (cmd 0xe4)
[ 1248.156435] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1248.156438] ata1.15: PMP revalidation failed (errno=-5)
[ 1248.156441] ata1.15: retrying hardreset in 5 secs
[ 1253.158910] ata1.15: hard resetting link
[ 1255.358253] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1255.358461] ata1.00: hard resetting link
[ 1255.678334] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1255.678338] ata1.01: hard resetting link
[ 1255.998235] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1255.998239] ata1.02: hard resetting link
[ 1256.318139] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1256.318143] ata1.03: hard resetting link
[ 1256.638042] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1256.638046] ata1.04: hard resetting link
[ 1256.957945] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1256.957948] ata1.05: hard resetting link
[ 1257.277845] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1257.277849] ata1.06: hard resetting link
[ 1257.597748] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1257.597864] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.597868] ata1.00: revalidation failed (errno=-5)
[ 1257.597997] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.598001] ata1.01: revalidation failed (errno=-5)
[ 1257.598129] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.598132] ata1.02: revalidation failed (errno=-5)
[ 1257.618319] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.618471] ata1.05: device is on DMA blacklist, disabling DMA
[ 1257.618624] ata1.05: configured for PIO4
[ 1257.618627] ata1: failed to recover some devices, retrying in 5 secs
[ 1262.620040] ata1.00: hard resetting link
[ 1262.940128] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1262.940132] ata1.01: hard resetting link
[ 1263.260032] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.260036] ata1.02: hard resetting link
[ 1263.579935] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.579939] ata1.03: hard resetting link
[ 1263.899837] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.902118] ata1.00: configured for UDMA/100
[ 1263.904377] ata1.01: configured for UDMA/100
[ 1264.006169] ata1.02: configured for UDMA/100
[ 1264.006262] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1264.006266] ata1: failed to recover some devices, retrying in 5 secs
[ 1269.006103] ata1.03: hard resetting link
[ 1269.326192] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1269.326294] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1269.326298] ata1: failed to recover some devices, retrying in 5 secs
[ 1274.328494] ata1.03: hard resetting link
[ 1274.648577] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1274.648860] ata1: EH complete
[ 1274.648888] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648900] sd 1:0:0:0: [sdb] Write Protect is off
[ 1274.648904] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1274.648917] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.648933] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648941] sd 1:1:0:0: [sdc] Write Protect is off
[ 1274.648944] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1274.648955] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.648969] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648976] sd 1:2:0:0: [sdd] Write Protect is off
[ 1274.648979] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1274.648991] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649004] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1274.649012] sd 1:5:0:0: [sdf] Write Protect is off
[ 1274.649014] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1274.649026] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649039] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649047] sd 1:0:0:0: [sdb] Write Protect is off
[ 1274.649049] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1274.649061] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649073] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649081] sd 1:1:0:0: [sdc] Write Protect is off
[ 1274.649084] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1274.649095] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649108] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649115] sd 1:2:0:0: [sdd] Write Protect is off
[ 1274.649118] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1274.649129] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649142] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1274.649149] sd 1:5:0:0: [sdf] Write Protect is off
[ 1274.649152] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1274.649164] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

--------------020808050009060708060708
Content-Type: text/plain;
 name="5_DriveSwap.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="5_DriveSwap.log"

8 512-byte hardware sectors (300069 MB)
[  449.927450] sd 1:1:0:0: [sdc] Write Protect is off
[  449.927453] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  449.927464] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927477] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  449.927484] sd 1:2:0:0: [sdd] Write Protect is off
[  449.927487] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  449.927498] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  449.927511] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  449.927518] sd 1:5:0:0: [sdf] Write Protect is off
[  449.927521] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  449.927532] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  449.927538] ata1.03: detaching (SCSI 1:3:0:0)
[  449.927717] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  449.928940] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  449.928945] sd 1:3:0:0: [sde] Stopping disk
[  449.928950] sd 1:3:0:0: [sde] START_STOP FAILED
[  449.928953] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  617.297502] ata1.15: limiting speed to UDMA7:PIO5
[  617.297509] ata1.00: failed to read SCR 1 (Emask=0x40)
[  617.297512] ata1.01: failed to read SCR 1 (Emask=0x40)
[  617.297515] ata1.02: failed to read SCR 1 (Emask=0x40)
[  617.297518] ata1.03: failed to read SCR 1 (Emask=0x40)
[  617.297521] ata1.04: failed to read SCR 1 (Emask=0x40)
[  617.297524] ata1.05: failed to read SCR 1 (Emask=0x40)
[  617.297527] ata1.06: failed to read SCR 1 (Emask=0x40)
[  617.297531] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  617.297535] ata1.15: irq_stat 0x01940090, PHY RDY changed
[  617.297539] ata1: SError: { 10B8B }
[  617.297543] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297549] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297554] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297559] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297564] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297569] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297574] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  617.297582] ata1.15: hard resetting link
[  622.390270] ata1.15: SATA link down (SStatus 1 SControl 10)
[  622.642187] ata1.15: qc timeout (cmd 0xe4)
[  622.642196] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  622.642199] ata1.15: PMP revalidation failed (errno=-5)
[  622.642202] ata1.15: retrying hardreset in 5 secs
[  627.644669] ata1.15: hard resetting link
[  632.739129] ata1.15: SATA link down (SStatus 1 SControl 10)
[  632.991047] ata1.15: qc timeout (cmd 0xe4)
[  632.991055] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  632.991058] ata1.15: PMP revalidation failed (errno=-5)
[  632.991061] ata1.15: retrying hardreset in 5 secs
[  637.993529] ata1.15: hard resetting link
[  640.192871] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  640.193076] ata1.00: hard resetting link
[  640.512952] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  640.512956] ata1.01: hard resetting link
[  640.832853] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  640.832857] ata1.02: hard resetting link
[  641.152758] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  641.152762] ata1.03: hard resetting link
[  641.472660] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  641.472664] ata1.04: hard resetting link
[  641.792562] ata1.04: SATA link down (SStatus 0 SControl 310)
[  641.792565] ata1.05: hard resetting link
[  642.112464] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  642.112468] ata1.06: hard resetting link
[  642.432369] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  642.434609] ata1.00: configured for UDMA/100
[  642.436783] ata1.01: configured for UDMA/100
[  642.548979] ata1.02: configured for UDMA/100
[  642.597737] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[  642.597741] ata1.03: 586072368 sectors, multi 0: LBA48 
[  642.597744] ata1.03: applying bridge limits
[  642.656013] ata1.03: configured for UDMA/100
[  642.656121] ata1.05: device is on DMA blacklist, disabling DMA
[  642.656227] ata1.05: configured for PIO4
[  642.656497] ata1: EH complete
[  642.656522] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  642.656534] sd 1:0:0:0: [sdb] Write Protect is off
[  642.656537] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  642.656550] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656564] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  642.656572] sd 1:1:0:0: [sdc] Write Protect is off
[  642.656575] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  642.656586] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656600] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  642.656608] sd 1:2:0:0: [sdd] Write Protect is off
[  642.656610] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  642.656622] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656635] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  642.656643] sd 1:5:0:0: [sdf] Write Protect is off
[  642.656646] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  642.656657] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  642.656670] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  642.656677] sd 1:0:0:0: [sdb] Write Protect is off
[  642.656680] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  642.656692] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656704] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  642.656712] sd 1:1:0:0: [sdc] Write Protect is off
[  642.656715] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  642.656726] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656738] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  642.656746] sd 1:2:0:0: [sdd] Write Protect is off
[  642.656749] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  642.656760] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.656773] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  642.656780] sd 1:5:0:0: [sdf] Write Protect is off
[  642.656783] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  642.656794] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  642.656866] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[  642.657321] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  642.657330] sd 1:3:0:0: [sde] Write Protect is off
[  642.657333] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  642.657345] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.657389] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  642.657796] sd 1:3:0:0: [sde] Write Protect is off
[  642.657799] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  642.657815] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  642.657819]  sde: sde1
[  642.695754] sd 1:3:0:0: [sde] Attached SCSI disk
[  642.695803] sd 1:3:0:0: Attached scsi generic sg5 type 0
[  810.992367] ata1.00: failed to read SCR 1 (Emask=0x40)
[  810.992373] ata1.01: failed to read SCR 1 (Emask=0x40)
[  810.992376] ata1.02: failed to read SCR 1 (Emask=0x40)
[  810.992379] ata1.03: failed to read SCR 1 (Emask=0x40)
[  810.992382] ata1.04: failed to read SCR 1 (Emask=0x40)
[  810.992385] ata1.05: failed to read SCR 1 (Emask=0x40)
[  810.992388] ata1.06: failed to read SCR 1 (Emask=0x40)
[  810.992393] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  810.992396] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  810.992400] ata1: SError: { 10B8B }
[  810.992405] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992410] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992415] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992421] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992426] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992431] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992436] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  810.992444] ata1.15: hard resetting link
[  816.083507] ata1.15: SATA link down (SStatus 1 SControl 10)
[  816.335424] ata1.15: qc timeout (cmd 0xe4)
[  816.335432] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  816.335435] ata1.15: PMP revalidation failed (errno=-5)
[  816.335438] ata1.15: retrying hardreset in 5 secs
[  821.337906] ata1.15: hard resetting link
[  826.432365] ata1.15: SATA link down (SStatus 1 SControl 10)
[  826.684283] ata1.15: qc timeout (cmd 0xe4)
[  826.684290] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  826.684293] ata1.15: PMP revalidation failed (errno=-5)
[  826.684297] ata1.15: retrying hardreset in 5 secs
[  831.686765] ata1.15: hard resetting link
[  833.886108] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  833.886312] ata1.00: hard resetting link
[  834.206188] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  834.206192] ata1.01: hard resetting link
[  834.526091] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  834.526095] ata1.02: hard resetting link
[  834.845993] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  834.845997] ata1.03: hard resetting link
[  835.165897] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  835.165901] ata1.04: hard resetting link
[  835.485800] ata1.04: SATA link down (SStatus 0 SControl 310)
[  835.485804] ata1.05: hard resetting link
[  835.805701] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  835.805704] ata1.06: hard resetting link
[  836.125608] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  836.125738] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  836.125742] ata1.00: revalidation failed (errno=-5)
[  836.125871] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  836.125875] ata1.01: revalidation failed (errno=-5)
[  836.126004] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  836.126007] ata1.02: revalidation failed (errno=-5)
[  836.126136] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  836.126140] ata1.03: revalidation failed (errno=-5)
[  836.126277] ata1.05: device is on DMA blacklist, disabling DMA
[  836.126394] ata1.05: configured for PIO4
[  836.126397] ata1: failed to recover some devices, retrying in 5 secs
[  841.127902] ata1.00: hard resetting link
[  841.447991] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  841.447995] ata1.01: hard resetting link
[  841.767894] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  841.767898] ata1.02: hard resetting link
[  842.087796] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  842.087800] ata1.03: hard resetting link
[  842.407699] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  842.409866] ata1.00: configured for UDMA/100
[  842.412082] ata1.01: configured for UDMA/100
[  842.516615] ata1.02: configured for UDMA/100
[  842.516722] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  842.516726] ata1.03: revalidation failed (errno=-5)
[  842.516729] ata1: failed to recover some devices, retrying in 5 secs
[  847.517963] ata1.03: hard resetting link
[  847.838051] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  847.838156] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  847.838160] ata1.03: revalidation failed (errno=-5)
[  847.838163] ata1.03: disabled
[  848.341712] ata1.03: hard resetting link
[  848.661801] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  848.661856] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  848.661859] ata1: failed to recover some devices, retrying in 5 secs
[  853.664098] ata1.03: hard resetting link
[  853.984187] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  853.984243] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  853.984246] ata1: failed to recover some devices, retrying in 5 secs
[  858.986483] ata1.03: hard resetting link
[  859.306572] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  859.306628] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[  859.306631] ata1: failed to recover some devices, retrying in 5 secs
[  864.308868] ata1.03: hard resetting link
[  864.628957] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  864.629240] ata1: EH complete
[  864.629267] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  864.629278] sd 1:0:0:0: [sdb] Write Protect is off
[  864.629282] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  864.629294] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629309] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  864.629317] sd 1:1:0:0: [sdc] Write Protect is off
[  864.629320] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  864.629331] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629345] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  864.629352] sd 1:2:0:0: [sdd] Write Protect is off
[  864.629355] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  864.629367] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629380] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  864.629387] sd 1:5:0:0: [sdf] Write Protect is off
[  864.629390] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  864.629401] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  864.629414] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  864.629422] sd 1:0:0:0: [sdb] Write Protect is off
[  864.629425] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  864.629436] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629448] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  864.629456] sd 1:1:0:0: [sdc] Write Protect is off
[  864.629458] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  864.629470] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629482] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  864.629489] sd 1:2:0:0: [sdd] Write Protect is off
[  864.629492] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  864.629503] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629516] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  864.629523] sd 1:5:0:0: [sdf] Write Protect is off
[  864.629526] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  864.629537] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  864.629542] ata1.03: detaching (SCSI 1:3:0:0)
[  864.629721] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  864.630109] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  864.630113] sd 1:3:0:0: [sde] Stopping disk
[  864.630119] sd 1:3:0:0: [sde] START_STOP FAILED
[  864.630121] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[ 1232.464873] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1232.464879] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1232.464882] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1232.464885] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1232.464888] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1232.464891] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1232.464894] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1232.464899] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1232.464902] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1232.464906] ata1: SError: { 10B8B }
[ 1232.464911] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464916] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464921] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464926] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464931] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464936] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464942] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464949] ata1.15: hard resetting link
[ 1237.555650] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1237.807567] ata1.15: qc timeout (cmd 0xe4)
[ 1237.807575] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1237.807579] ata1.15: PMP revalidation failed (errno=-5)
[ 1237.807582] ata1.15: retrying hardreset in 5 secs
[ 1242.810049] ata1.15: hard resetting link
[ 1247.904509] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1248.156427] ata1.15: qc timeout (cmd 0xe4)
[ 1248.156435] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1248.156438] ata1.15: PMP revalidation failed (errno=-5)
[ 1248.156441] ata1.15: retrying hardreset in 5 secs
[ 1253.158910] ata1.15: hard resetting link
[ 1255.358253] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1255.358461] ata1.00: hard resetting link
[ 1255.678334] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1255.678338] ata1.01: hard resetting link
[ 1255.998235] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1255.998239] ata1.02: hard resetting link
[ 1256.318139] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1256.318143] ata1.03: hard resetting link
[ 1256.638042] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1256.638046] ata1.04: hard resetting link
[ 1256.957945] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1256.957948] ata1.05: hard resetting link
[ 1257.277845] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1257.277849] ata1.06: hard resetting link
[ 1257.597748] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1257.597864] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.597868] ata1.00: revalidation failed (errno=-5)
[ 1257.597997] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.598001] ata1.01: revalidation failed (errno=-5)
[ 1257.598129] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.598132] ata1.02: revalidation failed (errno=-5)
[ 1257.618319] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.618471] ata1.05: device is on DMA blacklist, disabling DMA
[ 1257.618624] ata1.05: configured for PIO4
[ 1257.618627] ata1: failed to recover some devices, retrying in 5 secs
[ 1262.620040] ata1.00: hard resetting link
[ 1262.940128] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1262.940132] ata1.01: hard resetting link
[ 1263.260032] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.260036] ata1.02: hard resetting link
[ 1263.579935] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.579939] ata1.03: hard resetting link
[ 1263.899837] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.902118] ata1.00: configured for UDMA/100
[ 1263.904377] ata1.01: configured for UDMA/100
[ 1264.006169] ata1.02: configured for UDMA/100
[ 1264.006262] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1264.006266] ata1: failed to recover some devices, retrying in 5 secs
[ 1269.006103] ata1.03: hard resetting link
[ 1269.326192] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1269.326294] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1269.326298] ata1: failed to recover some devices, retrying in 5 secs
[ 1274.328494] ata1.03: hard resetting link
[ 1274.648577] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1274.648860] ata1: EH complete
[ 1274.648888] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648900] sd 1:0:0:0: [sdb] Write Protect is off
[ 1274.648904] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1274.648917] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.648933] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648941] sd 1:1:0:0: [sdc] Write Protect is off
[ 1274.648944] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1274.648955] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.648969] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648976] sd 1:2:0:0: [sdd] Write Protect is off
[ 1274.648979] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1274.648991] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649004] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1274.649012] sd 1:5:0:0: [sdf] Write Protect is off
[ 1274.649014] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1274.649026] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649039] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649047] sd 1:0:0:0: [sdb] Write Protect is off
[ 1274.649049] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1274.649061] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649073] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649081] sd 1:1:0:0: [sdc] Write Protect is off
[ 1274.649084] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1274.649095] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649108] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649115] sd 1:2:0:0: [sdd] Write Protect is off
[ 1274.649118] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1274.649129] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649142] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1274.649149] sd 1:5:0:0: [sdf] Write Protect is off
[ 1274.649152] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1274.649164] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1568.422342] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1568.422348] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1568.422351] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1568.422354] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1568.422357] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1568.422360] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1568.422363] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1568.422368] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1568.422371] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1568.422375] ata1: SError: { 10B8B }
[ 1568.422380] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422385] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422390] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422396] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422401] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422406] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422411] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422418] ata1.15: hard resetting link
[ 1573.513729] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1573.765647] ata1.15: qc timeout (cmd 0xe4)
[ 1573.765655] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1573.765658] ata1.15: PMP revalidation failed (errno=-5)
[ 1573.765661] ata1.15: retrying hardreset in 5 secs
[ 1578.768128] ata1.15: hard resetting link
[ 1583.862588] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1584.114506] ata1.15: qc timeout (cmd 0xe4)
[ 1584.114513] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1584.114516] ata1.15: PMP revalidation failed (errno=-5)
[ 1584.114520] ata1.15: retrying hardreset in 5 secs
[ 1589.116988] ata1.15: hard resetting link
[ 1594.211450] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1594.463368] ata1.15: qc timeout (cmd 0xe4)
[ 1594.463375] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1594.463378] ata1.15: PMP revalidation failed (errno=-5)
[ 1594.463382] ata1.15: retrying hardreset in 5 secs
[ 1599.465849] ata1.15: hard resetting link
[ 1604.560308] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1604.812227] ata1.15: qc timeout (cmd 0xe4)
[ 1604.812234] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1604.812237] ata1.15: PMP revalidation failed (errno=-5)
[ 1604.812241] ata1.15: retrying hardreset in 5 secs
[ 1609.814709] ata1.15: hard resetting link
[ 1612.741831] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1612.742041] ata1.00: hard resetting link
[ 1613.061909] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1613.061913] ata1.01: hard resetting link
[ 1613.381812] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1613.381816] ata1.02: hard resetting link
[ 1613.701716] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1613.701720] ata1.03: hard resetting link
[ 1614.021621] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1614.021624] ata1.04: hard resetting link
[ 1614.341521] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1614.341524] ata1.05: hard resetting link
[ 1614.661422] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1614.661426] ata1.06: hard resetting link
[ 1614.981331] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1614.981438] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981442] ata1.00: revalidation failed (errno=-5)
[ 1614.981572] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981575] ata1.01: revalidation failed (errno=-5)
[ 1614.981703] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981706] ata1.02: revalidation failed (errno=-5)
[ 1615.001891] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1615.002073] ata1.05: device is on DMA blacklist, disabling DMA
[ 1615.002229] ata1.05: configured for PIO4
[ 1615.002232] ata1: failed to recover some devices, retrying in 5 secs
[ 1620.003619] ata1.00: hard resetting link
[ 1620.323706] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.323710] ata1.01: hard resetting link
[ 1620.643612] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.643616] ata1.02: hard resetting link
[ 1620.963513] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.963517] ata1.03: hard resetting link
[ 1621.283416] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1621.285731] ata1.00: configured for UDMA/100
[ 1621.287984] ata1.01: configured for UDMA/100
[ 1621.289160] ata1.02: serial number mismatch '            3NF1H4DW' != '            3NF1JSWM'
[ 1621.289165] ata1.02: revalidation failed (errno=-19)
[ 1621.289287] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1621.289290] ata1: failed to recover some devices, retrying in 5 secs
[ 1626.289712] ata1.02: hard resetting link
[ 1626.609800] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1626.609804] ata1.03: hard resetting link
[ 1626.929703] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1626.930885] ata1.02: serial number mismatch '            3NF1H4DW' != '            3NF1JSWM'
[ 1626.930889] ata1.02: revalidation failed (errno=-19)
[ 1626.930892] ata1.02: disabled
[ 1626.931064] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1626.931068] ata1: failed to recover some devices, retrying in 5 secs
[ 1631.932005] ata1.02: hard resetting link
[ 1632.252089] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1632.252094] ata1.03: hard resetting link
[ 1632.571990] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1632.619011] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[ 1632.619015] ata1.02: 586072368 sectors, multi 0: LBA48 
[ 1632.619019] ata1.02: applying bridge limits
[ 1632.677283] ata1.02: configured for UDMA/100
[ 1632.677559] ata1: EH complete
[ 1632.677586] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677598] sd 1:0:0:0: [sdb] Write Protect is off
[ 1632.677602] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1632.677615] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677630] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677638] sd 1:1:0:0: [sdc] Write Protect is off
[ 1632.677641] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1632.677652] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677666] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1632.677674] sd 1:5:0:0: [sdf] Write Protect is off
[ 1632.677677] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1632.677688] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677701] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677708] sd 1:0:0:0: [sdb] Write Protect is off
[ 1632.677711] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1632.677722] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677735] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677742] sd 1:1:0:0: [sdc] Write Protect is off
[ 1632.677745] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1632.677756] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677769] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1632.677776] sd 1:5:0:0: [sdf] Write Protect is off
[ 1632.677779] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1632.677790] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677796] ata1.02: detaching (SCSI 1:2:0:0)
[ 1632.677972] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[ 1632.701650] sd 1:2:0:0: [sdd] Stopping disk
[ 1632.701883] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 1632.701973] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.701993] sd 1:2:0:0: [sdd] Write Protect is off
[ 1632.701997] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1632.702148] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.702209] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.702227] sd 1:2:0:0: [sdd] Write Protect is off
[ 1632.702230] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1632.702257] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.702261]  sdd: sdd1
[ 1633.333656] sd 1:2:0:0: [sdd] Attached SCSI disk
[ 1633.333704] sd 1:2:0:0: Attached scsi generic sg4 type 0

--------------020808050009060708060708
Content-Type: text/plain;
 name="6_PowerOnOffTwice.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="6_PowerOnOffTwice.log"

secs
[  864.308868] ata1.03: hard resetting link
[  864.628957] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  864.629240] ata1: EH complete
[  864.629267] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  864.629278] sd 1:0:0:0: [sdb] Write Protect is off
[  864.629282] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  864.629294] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629309] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  864.629317] sd 1:1:0:0: [sdc] Write Protect is off
[  864.629320] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  864.629331] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629345] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  864.629352] sd 1:2:0:0: [sdd] Write Protect is off
[  864.629355] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  864.629367] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629380] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  864.629387] sd 1:5:0:0: [sdf] Write Protect is off
[  864.629390] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  864.629401] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  864.629414] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  864.629422] sd 1:0:0:0: [sdb] Write Protect is off
[  864.629425] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  864.629436] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629448] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  864.629456] sd 1:1:0:0: [sdc] Write Protect is off
[  864.629458] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  864.629470] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629482] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  864.629489] sd 1:2:0:0: [sdd] Write Protect is off
[  864.629492] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  864.629503] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  864.629516] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  864.629523] sd 1:5:0:0: [sdf] Write Protect is off
[  864.629526] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  864.629537] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  864.629542] ata1.03: detaching (SCSI 1:3:0:0)
[  864.629721] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  864.630109] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  864.630113] sd 1:3:0:0: [sde] Stopping disk
[  864.630119] sd 1:3:0:0: [sde] START_STOP FAILED
[  864.630121] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[ 1232.464873] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1232.464879] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1232.464882] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1232.464885] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1232.464888] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1232.464891] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1232.464894] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1232.464899] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1232.464902] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1232.464906] ata1: SError: { 10B8B }
[ 1232.464911] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464916] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464921] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464926] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464931] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464936] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464942] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1232.464949] ata1.15: hard resetting link
[ 1237.555650] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1237.807567] ata1.15: qc timeout (cmd 0xe4)
[ 1237.807575] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1237.807579] ata1.15: PMP revalidation failed (errno=-5)
[ 1237.807582] ata1.15: retrying hardreset in 5 secs
[ 1242.810049] ata1.15: hard resetting link
[ 1247.904509] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1248.156427] ata1.15: qc timeout (cmd 0xe4)
[ 1248.156435] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1248.156438] ata1.15: PMP revalidation failed (errno=-5)
[ 1248.156441] ata1.15: retrying hardreset in 5 secs
[ 1253.158910] ata1.15: hard resetting link
[ 1255.358253] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1255.358461] ata1.00: hard resetting link
[ 1255.678334] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1255.678338] ata1.01: hard resetting link
[ 1255.998235] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1255.998239] ata1.02: hard resetting link
[ 1256.318139] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1256.318143] ata1.03: hard resetting link
[ 1256.638042] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1256.638046] ata1.04: hard resetting link
[ 1256.957945] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1256.957948] ata1.05: hard resetting link
[ 1257.277845] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1257.277849] ata1.06: hard resetting link
[ 1257.597748] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1257.597864] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.597868] ata1.00: revalidation failed (errno=-5)
[ 1257.597997] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.598001] ata1.01: revalidation failed (errno=-5)
[ 1257.598129] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.598132] ata1.02: revalidation failed (errno=-5)
[ 1257.618319] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1257.618471] ata1.05: device is on DMA blacklist, disabling DMA
[ 1257.618624] ata1.05: configured for PIO4
[ 1257.618627] ata1: failed to recover some devices, retrying in 5 secs
[ 1262.620040] ata1.00: hard resetting link
[ 1262.940128] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1262.940132] ata1.01: hard resetting link
[ 1263.260032] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.260036] ata1.02: hard resetting link
[ 1263.579935] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.579939] ata1.03: hard resetting link
[ 1263.899837] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.902118] ata1.00: configured for UDMA/100
[ 1263.904377] ata1.01: configured for UDMA/100
[ 1264.006169] ata1.02: configured for UDMA/100
[ 1264.006262] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1264.006266] ata1: failed to recover some devices, retrying in 5 secs
[ 1269.006103] ata1.03: hard resetting link
[ 1269.326192] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1269.326294] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1269.326298] ata1: failed to recover some devices, retrying in 5 secs
[ 1274.328494] ata1.03: hard resetting link
[ 1274.648577] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1274.648860] ata1: EH complete
[ 1274.648888] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648900] sd 1:0:0:0: [sdb] Write Protect is off
[ 1274.648904] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1274.648917] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.648933] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648941] sd 1:1:0:0: [sdc] Write Protect is off
[ 1274.648944] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1274.648955] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.648969] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648976] sd 1:2:0:0: [sdd] Write Protect is off
[ 1274.648979] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1274.648991] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649004] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1274.649012] sd 1:5:0:0: [sdf] Write Protect is off
[ 1274.649014] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1274.649026] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649039] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649047] sd 1:0:0:0: [sdb] Write Protect is off
[ 1274.649049] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1274.649061] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649073] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649081] sd 1:1:0:0: [sdc] Write Protect is off
[ 1274.649084] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1274.649095] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649108] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649115] sd 1:2:0:0: [sdd] Write Protect is off
[ 1274.649118] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1274.649129] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649142] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1274.649149] sd 1:5:0:0: [sdf] Write Protect is off
[ 1274.649152] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1274.649164] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1568.422342] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1568.422348] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1568.422351] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1568.422354] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1568.422357] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1568.422360] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1568.422363] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1568.422368] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1568.422371] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1568.422375] ata1: SError: { 10B8B }
[ 1568.422380] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422385] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422390] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422396] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422401] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422406] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422411] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422418] ata1.15: hard resetting link
[ 1573.513729] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1573.765647] ata1.15: qc timeout (cmd 0xe4)
[ 1573.765655] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1573.765658] ata1.15: PMP revalidation failed (errno=-5)
[ 1573.765661] ata1.15: retrying hardreset in 5 secs
[ 1578.768128] ata1.15: hard resetting link
[ 1583.862588] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1584.114506] ata1.15: qc timeout (cmd 0xe4)
[ 1584.114513] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1584.114516] ata1.15: PMP revalidation failed (errno=-5)
[ 1584.114520] ata1.15: retrying hardreset in 5 secs
[ 1589.116988] ata1.15: hard resetting link
[ 1594.211450] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1594.463368] ata1.15: qc timeout (cmd 0xe4)
[ 1594.463375] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1594.463378] ata1.15: PMP revalidation failed (errno=-5)
[ 1594.463382] ata1.15: retrying hardreset in 5 secs
[ 1599.465849] ata1.15: hard resetting link
[ 1604.560308] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1604.812227] ata1.15: qc timeout (cmd 0xe4)
[ 1604.812234] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1604.812237] ata1.15: PMP revalidation failed (errno=-5)
[ 1604.812241] ata1.15: retrying hardreset in 5 secs
[ 1609.814709] ata1.15: hard resetting link
[ 1612.741831] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1612.742041] ata1.00: hard resetting link
[ 1613.061909] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1613.061913] ata1.01: hard resetting link
[ 1613.381812] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1613.381816] ata1.02: hard resetting link
[ 1613.701716] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1613.701720] ata1.03: hard resetting link
[ 1614.021621] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1614.021624] ata1.04: hard resetting link
[ 1614.341521] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1614.341524] ata1.05: hard resetting link
[ 1614.661422] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1614.661426] ata1.06: hard resetting link
[ 1614.981331] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1614.981438] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981442] ata1.00: revalidation failed (errno=-5)
[ 1614.981572] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981575] ata1.01: revalidation failed (errno=-5)
[ 1614.981703] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981706] ata1.02: revalidation failed (errno=-5)
[ 1615.001891] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1615.002073] ata1.05: device is on DMA blacklist, disabling DMA
[ 1615.002229] ata1.05: configured for PIO4
[ 1615.002232] ata1: failed to recover some devices, retrying in 5 secs
[ 1620.003619] ata1.00: hard resetting link
[ 1620.323706] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.323710] ata1.01: hard resetting link
[ 1620.643612] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.643616] ata1.02: hard resetting link
[ 1620.963513] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.963517] ata1.03: hard resetting link
[ 1621.283416] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1621.285731] ata1.00: configured for UDMA/100
[ 1621.287984] ata1.01: configured for UDMA/100
[ 1621.289160] ata1.02: serial number mismatch '            3NF1H4DW' != '            3NF1JSWM'
[ 1621.289165] ata1.02: revalidation failed (errno=-19)
[ 1621.289287] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1621.289290] ata1: failed to recover some devices, retrying in 5 secs
[ 1626.289712] ata1.02: hard resetting link
[ 1626.609800] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1626.609804] ata1.03: hard resetting link
[ 1626.929703] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1626.930885] ata1.02: serial number mismatch '            3NF1H4DW' != '            3NF1JSWM'
[ 1626.930889] ata1.02: revalidation failed (errno=-19)
[ 1626.930892] ata1.02: disabled
[ 1626.931064] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1626.931068] ata1: failed to recover some devices, retrying in 5 secs
[ 1631.932005] ata1.02: hard resetting link
[ 1632.252089] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1632.252094] ata1.03: hard resetting link
[ 1632.571990] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1632.619011] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[ 1632.619015] ata1.02: 586072368 sectors, multi 0: LBA48 
[ 1632.619019] ata1.02: applying bridge limits
[ 1632.677283] ata1.02: configured for UDMA/100
[ 1632.677559] ata1: EH complete
[ 1632.677586] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677598] sd 1:0:0:0: [sdb] Write Protect is off
[ 1632.677602] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1632.677615] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677630] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677638] sd 1:1:0:0: [sdc] Write Protect is off
[ 1632.677641] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1632.677652] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677666] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1632.677674] sd 1:5:0:0: [sdf] Write Protect is off
[ 1632.677677] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1632.677688] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677701] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677708] sd 1:0:0:0: [sdb] Write Protect is off
[ 1632.677711] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1632.677722] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677735] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677742] sd 1:1:0:0: [sdc] Write Protect is off
[ 1632.677745] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1632.677756] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677769] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1632.677776] sd 1:5:0:0: [sdf] Write Protect is off
[ 1632.677779] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1632.677790] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677796] ata1.02: detaching (SCSI 1:2:0:0)
[ 1632.677972] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[ 1632.701650] sd 1:2:0:0: [sdd] Stopping disk
[ 1632.701883] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 1632.701973] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.701993] sd 1:2:0:0: [sdd] Write Protect is off
[ 1632.701997] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1632.702148] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.702209] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.702227] sd 1:2:0:0: [sdd] Write Protect is off
[ 1632.702230] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1632.702257] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.702261]  sdd: sdd1
[ 1633.333656] sd 1:2:0:0: [sdd] Attached SCSI disk
[ 1633.333704] sd 1:2:0:0: Attached scsi generic sg4 type 0
[ 1768.255041] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1768.255047] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1768.255050] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1768.255053] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1768.255056] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1768.255059] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1768.255062] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1768.255066] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1768.255070] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1768.255074] ata1: SError: { 10B8B }
[ 1768.255078] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255084] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255089] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255094] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255099] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255104] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255110] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255117] ata1.15: hard resetting link
[ 1773.349102] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1773.601020] ata1.15: qc timeout (cmd 0xe4)
[ 1773.601028] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1773.601031] ata1.15: PMP revalidation failed (errno=-5)
[ 1773.601034] ata1.15: retrying hardreset in 5 secs
[ 1778.603503] ata1.15: hard resetting link
[ 1783.697963] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1783.949880] ata1.15: qc timeout (cmd 0xe4)
[ 1783.949888] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1783.949891] ata1.15: PMP revalidation failed (errno=-5)
[ 1783.949894] ata1.15: retrying hardreset in 5 secs
[ 1788.952363] ata1.15: hard resetting link
[ 1791.151705] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1791.151910] ata1.00: hard resetting link
[ 1791.471785] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1791.471789] ata1.01: hard resetting link
[ 1791.791689] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1791.791693] ata1.02: hard resetting link
[ 1792.111591] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1792.111595] ata1.03: hard resetting link
[ 1792.431493] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1792.431497] ata1.04: hard resetting link
[ 1792.751397] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1792.751400] ata1.05: hard resetting link
[ 1793.071297] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1793.071300] ata1.06: hard resetting link
[ 1793.391206] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1793.393501] ata1.00: configured for UDMA/100
[ 1793.395703] ata1.01: configured for UDMA/100
[ 1793.395805] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1793.395809] ata1.02: revalidation failed (errno=-5)
[ 1793.415996] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1793.416141] ata1.05: device is on DMA blacklist, disabling DMA
[ 1793.416285] ata1.05: configured for PIO4
[ 1793.416288] ata1: failed to recover some devices, retrying in 5 secs
[ 1798.417497] ata1.02: hard resetting link
[ 1798.737581] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1798.737585] ata1.03: hard resetting link
[ 1799.057481] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1799.165478] ata1.02: configured for UDMA/100
[ 1799.165534] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1799.165538] ata1: failed to recover some devices, retrying in 5 secs
[ 1804.167747] ata1.03: hard resetting link
[ 1804.487836] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1804.487893] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1804.487897] ata1: failed to recover some devices, retrying in 5 secs
[ 1809.490138] ata1.03: hard resetting link
[ 1809.810221] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1809.810543] ata1: EH complete
[ 1809.810584] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810596] sd 1:0:0:0: [sdb] Write Protect is off
[ 1809.810599] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1809.810612] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810628] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810636] sd 1:1:0:0: [sdc] Write Protect is off
[ 1809.810639] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1809.810650] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810664] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810672] sd 1:2:0:0: [sdd] Write Protect is off
[ 1809.810675] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1809.810686] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810699] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1809.810707] sd 1:5:0:0: [sdf] Write Protect is off
[ 1809.810710] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1809.810721] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810734] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810742] sd 1:0:0:0: [sdb] Write Protect is off
[ 1809.810744] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1809.810756] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810768] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810775] sd 1:1:0:0: [sdc] Write Protect is off
[ 1809.810778] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1809.810789] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810802] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810809] sd 1:2:0:0: [sdd] Write Protect is off
[ 1809.810812] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1809.810823] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810931] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1809.810939] sd 1:5:0:0: [sdf] Write Protect is off
[ 1809.810941] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1809.810953] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1962.834896] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1962.834903] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1962.834906] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1962.834909] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1962.834912] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1962.834915] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1962.834918] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1962.834923] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1962.834926] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1962.834930] ata1: SError: { 10B8B }
[ 1962.834935] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834940] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834945] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834950] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834955] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834961] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834966] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834973] ata1.15: hard resetting link
[ 1967.926071] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1968.177988] ata1.15: qc timeout (cmd 0xe4)
[ 1968.177996] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1968.177999] ata1.15: PMP revalidation failed (errno=-5)
[ 1968.178002] ata1.15: retrying hardreset in 5 secs
[ 1973.180470] ata1.15: hard resetting link
[ 1978.082992] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1978.083197] ata1.00: hard resetting link
[ 1978.403072] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1978.403076] ata1.01: hard resetting link
[ 1978.722976] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1978.722980] ata1.02: hard resetting link
[ 1979.042879] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1979.042883] ata1.03: hard resetting link
[ 1979.362782] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1979.362786] ata1.04: hard resetting link
[ 1979.682683] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1979.682687] ata1.05: hard resetting link
[ 1980.002584] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1980.002588] ata1.06: hard resetting link
[ 1980.322487] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1980.322604] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322608] ata1.00: revalidation failed (errno=-5)
[ 1980.322739] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322743] ata1.01: revalidation failed (errno=-5)
[ 1980.322872] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322875] ata1.02: revalidation failed (errno=-5)
[ 1980.343060] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.343210] ata1.05: device is on DMA blacklist, disabling DMA
[ 1980.343365] ata1.05: configured for PIO4
[ 1980.343369] ata1: failed to recover some devices, retrying in 5 secs
[ 1985.344781] ata1.00: hard resetting link
[ 1985.664869] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1985.664873] ata1.01: hard resetting link
[ 1985.984773] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1985.984777] ata1.02: hard resetting link
[ 1986.304675] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1986.304679] ata1.03: hard resetting link
[ 1986.624578] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1986.626801] ata1.00: configured for UDMA/100
[ 1986.629042] ata1.01: configured for UDMA/100
[ 1986.733022] ata1.02: configured for UDMA/100
[ 1986.733121] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1986.733125] ata1: failed to recover some devices, retrying in 5 secs
[ 1991.734842] ata1.03: hard resetting link
[ 1992.054930] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1992.055059] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1992.055063] ata1: failed to recover some devices, retrying in 5 secs
[ 1997.057228] ata1.03: hard resetting link
[ 1997.377315] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1997.377599] ata1: EH complete
[ 1997.377625] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377637] sd 1:0:0:0: [sdb] Write Protect is off
[ 1997.377640] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1997.377653] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377668] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377676] sd 1:1:0:0: [sdc] Write Protect is off
[ 1997.377679] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1997.377690] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377704] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377712] sd 1:2:0:0: [sdd] Write Protect is off
[ 1997.377715] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1997.377726] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377740] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1997.377748] sd 1:5:0:0: [sdf] Write Protect is off
[ 1997.377750] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1997.377762] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377775] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377782] sd 1:0:0:0: [sdb] Write Protect is off
[ 1997.377785] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1997.377796] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377809] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377816] sd 1:1:0:0: [sdc] Write Protect is off
[ 1997.377819] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1997.377830] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377843] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377850] sd 1:2:0:0: [sdd] Write Protect is off
[ 1997.377853] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1997.377865] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377877] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1997.377884] sd 1:5:0:0: [sdf] Write Protect is off
[ 1997.377887] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1997.377899] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

--------------020808050009060708060708
Content-Type: text/plain;
 name="7_PlugUnplug.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="7_PlugUnplug.log"

nk up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.260036] ata1.02: hard resetting link
[ 1263.579935] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.579939] ata1.03: hard resetting link
[ 1263.899837] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1263.902118] ata1.00: configured for UDMA/100
[ 1263.904377] ata1.01: configured for UDMA/100
[ 1264.006169] ata1.02: configured for UDMA/100
[ 1264.006262] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1264.006266] ata1: failed to recover some devices, retrying in 5 secs
[ 1269.006103] ata1.03: hard resetting link
[ 1269.326192] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1269.326294] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1269.326298] ata1: failed to recover some devices, retrying in 5 secs
[ 1274.328494] ata1.03: hard resetting link
[ 1274.648577] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1274.648860] ata1: EH complete
[ 1274.648888] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648900] sd 1:0:0:0: [sdb] Write Protect is off
[ 1274.648904] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1274.648917] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.648933] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648941] sd 1:1:0:0: [sdc] Write Protect is off
[ 1274.648944] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1274.648955] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.648969] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.648976] sd 1:2:0:0: [sdd] Write Protect is off
[ 1274.648979] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1274.648991] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649004] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1274.649012] sd 1:5:0:0: [sdf] Write Protect is off
[ 1274.649014] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1274.649026] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649039] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649047] sd 1:0:0:0: [sdb] Write Protect is off
[ 1274.649049] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1274.649061] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649073] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649081] sd 1:1:0:0: [sdc] Write Protect is off
[ 1274.649084] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1274.649095] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649108] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1274.649115] sd 1:2:0:0: [sdd] Write Protect is off
[ 1274.649118] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1274.649129] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1274.649142] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1274.649149] sd 1:5:0:0: [sdf] Write Protect is off
[ 1274.649152] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1274.649164] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1568.422342] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1568.422348] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1568.422351] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1568.422354] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1568.422357] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1568.422360] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1568.422363] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1568.422368] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1568.422371] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1568.422375] ata1: SError: { 10B8B }
[ 1568.422380] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422385] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422390] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422396] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422401] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422406] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422411] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1568.422418] ata1.15: hard resetting link
[ 1573.513729] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1573.765647] ata1.15: qc timeout (cmd 0xe4)
[ 1573.765655] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1573.765658] ata1.15: PMP revalidation failed (errno=-5)
[ 1573.765661] ata1.15: retrying hardreset in 5 secs
[ 1578.768128] ata1.15: hard resetting link
[ 1583.862588] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1584.114506] ata1.15: qc timeout (cmd 0xe4)
[ 1584.114513] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1584.114516] ata1.15: PMP revalidation failed (errno=-5)
[ 1584.114520] ata1.15: retrying hardreset in 5 secs
[ 1589.116988] ata1.15: hard resetting link
[ 1594.211450] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1594.463368] ata1.15: qc timeout (cmd 0xe4)
[ 1594.463375] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1594.463378] ata1.15: PMP revalidation failed (errno=-5)
[ 1594.463382] ata1.15: retrying hardreset in 5 secs
[ 1599.465849] ata1.15: hard resetting link
[ 1604.560308] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1604.812227] ata1.15: qc timeout (cmd 0xe4)
[ 1604.812234] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1604.812237] ata1.15: PMP revalidation failed (errno=-5)
[ 1604.812241] ata1.15: retrying hardreset in 5 secs
[ 1609.814709] ata1.15: hard resetting link
[ 1612.741831] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1612.742041] ata1.00: hard resetting link
[ 1613.061909] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1613.061913] ata1.01: hard resetting link
[ 1613.381812] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1613.381816] ata1.02: hard resetting link
[ 1613.701716] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1613.701720] ata1.03: hard resetting link
[ 1614.021621] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1614.021624] ata1.04: hard resetting link
[ 1614.341521] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1614.341524] ata1.05: hard resetting link
[ 1614.661422] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1614.661426] ata1.06: hard resetting link
[ 1614.981331] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1614.981438] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981442] ata1.00: revalidation failed (errno=-5)
[ 1614.981572] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981575] ata1.01: revalidation failed (errno=-5)
[ 1614.981703] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1614.981706] ata1.02: revalidation failed (errno=-5)
[ 1615.001891] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1615.002073] ata1.05: device is on DMA blacklist, disabling DMA
[ 1615.002229] ata1.05: configured for PIO4
[ 1615.002232] ata1: failed to recover some devices, retrying in 5 secs
[ 1620.003619] ata1.00: hard resetting link
[ 1620.323706] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.323710] ata1.01: hard resetting link
[ 1620.643612] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.643616] ata1.02: hard resetting link
[ 1620.963513] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1620.963517] ata1.03: hard resetting link
[ 1621.283416] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1621.285731] ata1.00: configured for UDMA/100
[ 1621.287984] ata1.01: configured for UDMA/100
[ 1621.289160] ata1.02: serial number mismatch '            3NF1H4DW' != '            3NF1JSWM'
[ 1621.289165] ata1.02: revalidation failed (errno=-19)
[ 1621.289287] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1621.289290] ata1: failed to recover some devices, retrying in 5 secs
[ 1626.289712] ata1.02: hard resetting link
[ 1626.609800] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1626.609804] ata1.03: hard resetting link
[ 1626.929703] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1626.930885] ata1.02: serial number mismatch '            3NF1H4DW' != '            3NF1JSWM'
[ 1626.930889] ata1.02: revalidation failed (errno=-19)
[ 1626.930892] ata1.02: disabled
[ 1626.931064] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1626.931068] ata1: failed to recover some devices, retrying in 5 secs
[ 1631.932005] ata1.02: hard resetting link
[ 1632.252089] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1632.252094] ata1.03: hard resetting link
[ 1632.571990] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1632.619011] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[ 1632.619015] ata1.02: 586072368 sectors, multi 0: LBA48 
[ 1632.619019] ata1.02: applying bridge limits
[ 1632.677283] ata1.02: configured for UDMA/100
[ 1632.677559] ata1: EH complete
[ 1632.677586] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677598] sd 1:0:0:0: [sdb] Write Protect is off
[ 1632.677602] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1632.677615] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677630] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677638] sd 1:1:0:0: [sdc] Write Protect is off
[ 1632.677641] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1632.677652] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677666] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1632.677674] sd 1:5:0:0: [sdf] Write Protect is off
[ 1632.677677] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1632.677688] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677701] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677708] sd 1:0:0:0: [sdb] Write Protect is off
[ 1632.677711] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1632.677722] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677735] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.677742] sd 1:1:0:0: [sdc] Write Protect is off
[ 1632.677745] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1632.677756] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677769] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1632.677776] sd 1:5:0:0: [sdf] Write Protect is off
[ 1632.677779] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1632.677790] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.677796] ata1.02: detaching (SCSI 1:2:0:0)
[ 1632.677972] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[ 1632.701650] sd 1:2:0:0: [sdd] Stopping disk
[ 1632.701883] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 1632.701973] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.701993] sd 1:2:0:0: [sdd] Write Protect is off
[ 1632.701997] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1632.702148] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.702209] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1632.702227] sd 1:2:0:0: [sdd] Write Protect is off
[ 1632.702230] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1632.702257] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1632.702261]  sdd: sdd1
[ 1633.333656] sd 1:2:0:0: [sdd] Attached SCSI disk
[ 1633.333704] sd 1:2:0:0: Attached scsi generic sg4 type 0
[ 1768.255041] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1768.255047] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1768.255050] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1768.255053] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1768.255056] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1768.255059] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1768.255062] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1768.255066] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1768.255070] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1768.255074] ata1: SError: { 10B8B }
[ 1768.255078] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255084] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255089] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255094] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255099] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255104] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255110] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1768.255117] ata1.15: hard resetting link
[ 1773.349102] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1773.601020] ata1.15: qc timeout (cmd 0xe4)
[ 1773.601028] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1773.601031] ata1.15: PMP revalidation failed (errno=-5)
[ 1773.601034] ata1.15: retrying hardreset in 5 secs
[ 1778.603503] ata1.15: hard resetting link
[ 1783.697963] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1783.949880] ata1.15: qc timeout (cmd 0xe4)
[ 1783.949888] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1783.949891] ata1.15: PMP revalidation failed (errno=-5)
[ 1783.949894] ata1.15: retrying hardreset in 5 secs
[ 1788.952363] ata1.15: hard resetting link
[ 1791.151705] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1791.151910] ata1.00: hard resetting link
[ 1791.471785] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1791.471789] ata1.01: hard resetting link
[ 1791.791689] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1791.791693] ata1.02: hard resetting link
[ 1792.111591] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1792.111595] ata1.03: hard resetting link
[ 1792.431493] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1792.431497] ata1.04: hard resetting link
[ 1792.751397] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1792.751400] ata1.05: hard resetting link
[ 1793.071297] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1793.071300] ata1.06: hard resetting link
[ 1793.391206] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1793.393501] ata1.00: configured for UDMA/100
[ 1793.395703] ata1.01: configured for UDMA/100
[ 1793.395805] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1793.395809] ata1.02: revalidation failed (errno=-5)
[ 1793.415996] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1793.416141] ata1.05: device is on DMA blacklist, disabling DMA
[ 1793.416285] ata1.05: configured for PIO4
[ 1793.416288] ata1: failed to recover some devices, retrying in 5 secs
[ 1798.417497] ata1.02: hard resetting link
[ 1798.737581] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1798.737585] ata1.03: hard resetting link
[ 1799.057481] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1799.165478] ata1.02: configured for UDMA/100
[ 1799.165534] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1799.165538] ata1: failed to recover some devices, retrying in 5 secs
[ 1804.167747] ata1.03: hard resetting link
[ 1804.487836] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1804.487893] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1804.487897] ata1: failed to recover some devices, retrying in 5 secs
[ 1809.490138] ata1.03: hard resetting link
[ 1809.810221] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1809.810543] ata1: EH complete
[ 1809.810584] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810596] sd 1:0:0:0: [sdb] Write Protect is off
[ 1809.810599] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1809.810612] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810628] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810636] sd 1:1:0:0: [sdc] Write Protect is off
[ 1809.810639] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1809.810650] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810664] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810672] sd 1:2:0:0: [sdd] Write Protect is off
[ 1809.810675] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1809.810686] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810699] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1809.810707] sd 1:5:0:0: [sdf] Write Protect is off
[ 1809.810710] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1809.810721] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810734] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810742] sd 1:0:0:0: [sdb] Write Protect is off
[ 1809.810744] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1809.810756] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810768] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810775] sd 1:1:0:0: [sdc] Write Protect is off
[ 1809.810778] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1809.810789] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810802] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810809] sd 1:2:0:0: [sdd] Write Protect is off
[ 1809.810812] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1809.810823] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810931] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1809.810939] sd 1:5:0:0: [sdf] Write Protect is off
[ 1809.810941] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1809.810953] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1962.834896] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1962.834903] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1962.834906] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1962.834909] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1962.834912] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1962.834915] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1962.834918] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1962.834923] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1962.834926] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1962.834930] ata1: SError: { 10B8B }
[ 1962.834935] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834940] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834945] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834950] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834955] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834961] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834966] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834973] ata1.15: hard resetting link
[ 1967.926071] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1968.177988] ata1.15: qc timeout (cmd 0xe4)
[ 1968.177996] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1968.177999] ata1.15: PMP revalidation failed (errno=-5)
[ 1968.178002] ata1.15: retrying hardreset in 5 secs
[ 1973.180470] ata1.15: hard resetting link
[ 1978.082992] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1978.083197] ata1.00: hard resetting link
[ 1978.403072] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1978.403076] ata1.01: hard resetting link
[ 1978.722976] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1978.722980] ata1.02: hard resetting link
[ 1979.042879] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1979.042883] ata1.03: hard resetting link
[ 1979.362782] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1979.362786] ata1.04: hard resetting link
[ 1979.682683] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1979.682687] ata1.05: hard resetting link
[ 1980.002584] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1980.002588] ata1.06: hard resetting link
[ 1980.322487] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1980.322604] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322608] ata1.00: revalidation failed (errno=-5)
[ 1980.322739] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322743] ata1.01: revalidation failed (errno=-5)
[ 1980.322872] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322875] ata1.02: revalidation failed (errno=-5)
[ 1980.343060] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.343210] ata1.05: device is on DMA blacklist, disabling DMA
[ 1980.343365] ata1.05: configured for PIO4
[ 1980.343369] ata1: failed to recover some devices, retrying in 5 secs
[ 1985.344781] ata1.00: hard resetting link
[ 1985.664869] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1985.664873] ata1.01: hard resetting link
[ 1985.984773] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1985.984777] ata1.02: hard resetting link
[ 1986.304675] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1986.304679] ata1.03: hard resetting link
[ 1986.624578] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1986.626801] ata1.00: configured for UDMA/100
[ 1986.629042] ata1.01: configured for UDMA/100
[ 1986.733022] ata1.02: configured for UDMA/100
[ 1986.733121] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1986.733125] ata1: failed to recover some devices, retrying in 5 secs
[ 1991.734842] ata1.03: hard resetting link
[ 1992.054930] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1992.055059] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1992.055063] ata1: failed to recover some devices, retrying in 5 secs
[ 1997.057228] ata1.03: hard resetting link
[ 1997.377315] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1997.377599] ata1: EH complete
[ 1997.377625] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377637] sd 1:0:0:0: [sdb] Write Protect is off
[ 1997.377640] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1997.377653] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377668] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377676] sd 1:1:0:0: [sdc] Write Protect is off
[ 1997.377679] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1997.377690] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377704] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377712] sd 1:2:0:0: [sdd] Write Protect is off
[ 1997.377715] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1997.377726] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377740] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1997.377748] sd 1:5:0:0: [sdf] Write Protect is off
[ 1997.377750] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1997.377762] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377775] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377782] sd 1:0:0:0: [sdb] Write Protect is off
[ 1997.377785] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1997.377796] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377809] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377816] sd 1:1:0:0: [sdc] Write Protect is off
[ 1997.377819] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1997.377830] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377843] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377850] sd 1:2:0:0: [sdd] Write Protect is off
[ 1997.377853] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1997.377865] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377877] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1997.377884] sd 1:5:0:0: [sdf] Write Protect is off
[ 1997.377887] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1997.377899] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2194.972229] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2194.972235] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2194.972238] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2194.972241] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2194.972244] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2194.972247] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2194.972250] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2194.972254] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2194.972258] ata1.15: irq_stat 0x01940090, PHY RDY changed
[ 2194.972262] ata1: SError: { 10B8B }
[ 2194.972267] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972272] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972277] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972282] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972287] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972292] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972298] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972306] ata1.15: hard resetting link
[ 2200.063645] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2200.315563] ata1.15: qc timeout (cmd 0xe4)
[ 2200.315571] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2200.315574] ata1.15: PMP revalidation failed (errno=-5)
[ 2200.315577] ata1.15: retrying hardreset in 5 secs
[ 2205.318045] ata1.15: hard resetting link
[ 2210.412505] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2210.664423] ata1.15: qc timeout (cmd 0xe4)
[ 2210.664430] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2210.664433] ata1.15: PMP revalidation failed (errno=-5)
[ 2210.664437] ata1.15: retrying hardreset in 5 secs
[ 2215.666905] ata1.15: hard resetting link
[ 2217.866247] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 2217.866481] ata1.00: hard resetting link
[ 2218.186327] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2218.186331] ata1.01: hard resetting link
[ 2218.506230] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2218.506234] ata1.02: hard resetting link
[ 2218.826133] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2218.826137] ata1.03: hard resetting link
[ 2219.146037] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2219.146041] ata1.04: hard resetting link
[ 2219.465939] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 2219.465943] ata1.05: hard resetting link
[ 2219.785841] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 2219.785844] ata1.06: hard resetting link
[ 2220.105744] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2220.107998] ata1.00: configured for UDMA/100
[ 2220.110200] ata1.01: configured for UDMA/100
[ 2220.212693] ata1.02: configured for UDMA/100
[ 2220.260388] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[ 2220.260392] ata1.03: 586072368 sectors, multi 0: LBA48 
[ 2220.260395] ata1.03: applying bridge limits
[ 2220.326830] ata1.03: configured for UDMA/100
[ 2220.326935] ata1.05: device is on DMA blacklist, disabling DMA
[ 2220.327039] ata1.05: configured for PIO4
[ 2220.327308] ata1: EH complete
[ 2220.327332] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327343] sd 1:0:0:0: [sdb] Write Protect is off
[ 2220.327347] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2220.327359] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327374] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327382] sd 1:1:0:0: [sdc] Write Protect is off
[ 2220.327384] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2220.327396] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327409] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327417] sd 1:2:0:0: [sdd] Write Protect is off
[ 2220.327420] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2220.327431] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327445] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2220.327452] sd 1:5:0:0: [sdf] Write Protect is off
[ 2220.327455] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2220.327467] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327479] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327487] sd 1:0:0:0: [sdb] Write Protect is off
[ 2220.327490] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2220.327501] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327513] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327521] sd 1:1:0:0: [sdc] Write Protect is off
[ 2220.327524] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2220.327535] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327548] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327555] sd 1:2:0:0: [sdd] Write Protect is off
[ 2220.327558] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2220.327569] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327582] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2220.327589] sd 1:5:0:0: [sdf] Write Protect is off
[ 2220.327592] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2220.327603] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327674] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 2220.328136] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.328145] sd 1:3:0:0: [sde] Write Protect is off
[ 2220.328148] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2220.328160] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.328204] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.328212] sd 1:3:0:0: [sde] Write Protect is off
[ 2220.328215] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2220.328622] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.328627]  sde: sde1
[ 2220.366475] sd 1:3:0:0: [sde] Attached SCSI disk
[ 2220.366525] sd 1:3:0:0: Attached scsi generic sg5 type 0

--------------020808050009060708060708
Content-Type: text/plain;
 name="8_PowerOnOffTwice.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8_PowerOnOffTwice.log"

[ 1788.952363] ata1.15: hard resetting link
[ 1791.151705] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1791.151910] ata1.00: hard resetting link
[ 1791.471785] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1791.471789] ata1.01: hard resetting link
[ 1791.791689] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1791.791693] ata1.02: hard resetting link
[ 1792.111591] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1792.111595] ata1.03: hard resetting link
[ 1792.431493] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1792.431497] ata1.04: hard resetting link
[ 1792.751397] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1792.751400] ata1.05: hard resetting link
[ 1793.071297] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1793.071300] ata1.06: hard resetting link
[ 1793.391206] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1793.393501] ata1.00: configured for UDMA/100
[ 1793.395703] ata1.01: configured for UDMA/100
[ 1793.395805] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1793.395809] ata1.02: revalidation failed (errno=-5)
[ 1793.415996] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1793.416141] ata1.05: device is on DMA blacklist, disabling DMA
[ 1793.416285] ata1.05: configured for PIO4
[ 1793.416288] ata1: failed to recover some devices, retrying in 5 secs
[ 1798.417497] ata1.02: hard resetting link
[ 1798.737581] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1798.737585] ata1.03: hard resetting link
[ 1799.057481] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1799.165478] ata1.02: configured for UDMA/100
[ 1799.165534] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1799.165538] ata1: failed to recover some devices, retrying in 5 secs
[ 1804.167747] ata1.03: hard resetting link
[ 1804.487836] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1804.487893] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1804.487897] ata1: failed to recover some devices, retrying in 5 secs
[ 1809.490138] ata1.03: hard resetting link
[ 1809.810221] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1809.810543] ata1: EH complete
[ 1809.810584] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810596] sd 1:0:0:0: [sdb] Write Protect is off
[ 1809.810599] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1809.810612] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810628] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810636] sd 1:1:0:0: [sdc] Write Protect is off
[ 1809.810639] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1809.810650] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810664] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810672] sd 1:2:0:0: [sdd] Write Protect is off
[ 1809.810675] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1809.810686] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810699] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1809.810707] sd 1:5:0:0: [sdf] Write Protect is off
[ 1809.810710] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1809.810721] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810734] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810742] sd 1:0:0:0: [sdb] Write Protect is off
[ 1809.810744] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1809.810756] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810768] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810775] sd 1:1:0:0: [sdc] Write Protect is off
[ 1809.810778] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1809.810789] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810802] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1809.810809] sd 1:2:0:0: [sdd] Write Protect is off
[ 1809.810812] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1809.810823] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1809.810931] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1809.810939] sd 1:5:0:0: [sdf] Write Protect is off
[ 1809.810941] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1809.810953] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1962.834896] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 1962.834903] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 1962.834906] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 1962.834909] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 1962.834912] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 1962.834915] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 1962.834918] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 1962.834923] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 1962.834926] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 1962.834930] ata1: SError: { 10B8B }
[ 1962.834935] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834940] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834945] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834950] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834955] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834961] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834966] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 1962.834973] ata1.15: hard resetting link
[ 1967.926071] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 1968.177988] ata1.15: qc timeout (cmd 0xe4)
[ 1968.177996] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 1968.177999] ata1.15: PMP revalidation failed (errno=-5)
[ 1968.178002] ata1.15: retrying hardreset in 5 secs
[ 1973.180470] ata1.15: hard resetting link
[ 1978.082992] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 1978.083197] ata1.00: hard resetting link
[ 1978.403072] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1978.403076] ata1.01: hard resetting link
[ 1978.722976] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1978.722980] ata1.02: hard resetting link
[ 1979.042879] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1979.042883] ata1.03: hard resetting link
[ 1979.362782] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1979.362786] ata1.04: hard resetting link
[ 1979.682683] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 1979.682687] ata1.05: hard resetting link
[ 1980.002584] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 1980.002588] ata1.06: hard resetting link
[ 1980.322487] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1980.322604] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322608] ata1.00: revalidation failed (errno=-5)
[ 1980.322739] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322743] ata1.01: revalidation failed (errno=-5)
[ 1980.322872] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.322875] ata1.02: revalidation failed (errno=-5)
[ 1980.343060] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1980.343210] ata1.05: device is on DMA blacklist, disabling DMA
[ 1980.343365] ata1.05: configured for PIO4
[ 1980.343369] ata1: failed to recover some devices, retrying in 5 secs
[ 1985.344781] ata1.00: hard resetting link
[ 1985.664869] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1985.664873] ata1.01: hard resetting link
[ 1985.984773] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1985.984777] ata1.02: hard resetting link
[ 1986.304675] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1986.304679] ata1.03: hard resetting link
[ 1986.624578] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1986.626801] ata1.00: configured for UDMA/100
[ 1986.629042] ata1.01: configured for UDMA/100
[ 1986.733022] ata1.02: configured for UDMA/100
[ 1986.733121] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1986.733125] ata1: failed to recover some devices, retrying in 5 secs
[ 1991.734842] ata1.03: hard resetting link
[ 1992.054930] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1992.055059] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1992.055063] ata1: failed to recover some devices, retrying in 5 secs
[ 1997.057228] ata1.03: hard resetting link
[ 1997.377315] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1997.377599] ata1: EH complete
[ 1997.377625] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377637] sd 1:0:0:0: [sdb] Write Protect is off
[ 1997.377640] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1997.377653] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377668] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377676] sd 1:1:0:0: [sdc] Write Protect is off
[ 1997.377679] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1997.377690] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377704] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377712] sd 1:2:0:0: [sdd] Write Protect is off
[ 1997.377715] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1997.377726] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377740] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1997.377748] sd 1:5:0:0: [sdf] Write Protect is off
[ 1997.377750] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1997.377762] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377775] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377782] sd 1:0:0:0: [sdb] Write Protect is off
[ 1997.377785] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1997.377796] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377809] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377816] sd 1:1:0:0: [sdc] Write Protect is off
[ 1997.377819] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1997.377830] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377843] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 1997.377850] sd 1:2:0:0: [sdd] Write Protect is off
[ 1997.377853] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1997.377865] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1997.377877] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 1997.377884] sd 1:5:0:0: [sdf] Write Protect is off
[ 1997.377887] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1997.377899] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2194.972229] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2194.972235] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2194.972238] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2194.972241] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2194.972244] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2194.972247] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2194.972250] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2194.972254] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2194.972258] ata1.15: irq_stat 0x01940090, PHY RDY changed
[ 2194.972262] ata1: SError: { 10B8B }
[ 2194.972267] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972272] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972277] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972282] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972287] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972292] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972298] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2194.972306] ata1.15: hard resetting link
[ 2200.063645] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2200.315563] ata1.15: qc timeout (cmd 0xe4)
[ 2200.315571] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2200.315574] ata1.15: PMP revalidation failed (errno=-5)
[ 2200.315577] ata1.15: retrying hardreset in 5 secs
[ 2205.318045] ata1.15: hard resetting link
[ 2210.412505] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2210.664423] ata1.15: qc timeout (cmd 0xe4)
[ 2210.664430] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2210.664433] ata1.15: PMP revalidation failed (errno=-5)
[ 2210.664437] ata1.15: retrying hardreset in 5 secs
[ 2215.666905] ata1.15: hard resetting link
[ 2217.866247] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 2217.866481] ata1.00: hard resetting link
[ 2218.186327] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2218.186331] ata1.01: hard resetting link
[ 2218.506230] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2218.506234] ata1.02: hard resetting link
[ 2218.826133] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2218.826137] ata1.03: hard resetting link
[ 2219.146037] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2219.146041] ata1.04: hard resetting link
[ 2219.465939] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 2219.465943] ata1.05: hard resetting link
[ 2219.785841] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 2219.785844] ata1.06: hard resetting link
[ 2220.105744] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2220.107998] ata1.00: configured for UDMA/100
[ 2220.110200] ata1.01: configured for UDMA/100
[ 2220.212693] ata1.02: configured for UDMA/100
[ 2220.260388] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[ 2220.260392] ata1.03: 586072368 sectors, multi 0: LBA48 
[ 2220.260395] ata1.03: applying bridge limits
[ 2220.326830] ata1.03: configured for UDMA/100
[ 2220.326935] ata1.05: device is on DMA blacklist, disabling DMA
[ 2220.327039] ata1.05: configured for PIO4
[ 2220.327308] ata1: EH complete
[ 2220.327332] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327343] sd 1:0:0:0: [sdb] Write Protect is off
[ 2220.327347] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2220.327359] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327374] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327382] sd 1:1:0:0: [sdc] Write Protect is off
[ 2220.327384] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2220.327396] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327409] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327417] sd 1:2:0:0: [sdd] Write Protect is off
[ 2220.327420] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2220.327431] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327445] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2220.327452] sd 1:5:0:0: [sdf] Write Protect is off
[ 2220.327455] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2220.327467] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327479] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327487] sd 1:0:0:0: [sdb] Write Protect is off
[ 2220.327490] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2220.327501] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327513] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327521] sd 1:1:0:0: [sdc] Write Protect is off
[ 2220.327524] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2220.327535] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327548] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.327555] sd 1:2:0:0: [sdd] Write Protect is off
[ 2220.327558] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2220.327569] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327582] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2220.327589] sd 1:5:0:0: [sdf] Write Protect is off
[ 2220.327592] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2220.327603] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327674] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 2220.328136] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.328145] sd 1:3:0:0: [sde] Write Protect is off
[ 2220.328148] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2220.328160] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.328204] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.328212] sd 1:3:0:0: [sde] Write Protect is off
[ 2220.328215] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2220.328622] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.328627]  sde: sde1
[ 2220.366475] sd 1:3:0:0: [sde] Attached SCSI disk
[ 2220.366525] sd 1:3:0:0: Attached scsi generic sg5 type 0
[ 2327.669606] ata1.15: limiting speed to PIO0
[ 2327.669613] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2327.669617] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2327.669620] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2327.669623] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2327.669626] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2327.669629] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2327.669632] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2327.669636] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2327.669639] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2327.669643] ata1: SError: { 10B8B }
[ 2327.669648] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669653] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669659] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669664] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669669] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669674] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669679] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669687] ata1.15: hard resetting link
[ 2332.763389] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2333.015306] ata1.15: qc timeout (cmd 0xe4)
[ 2333.015314] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2333.015318] ata1.15: PMP revalidation failed (errno=-5)
[ 2333.015321] ata1.15: retrying hardreset in 5 secs
[ 2338.017789] ata1.15: hard resetting link
[ 2343.112248] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2343.212225] ata1.15: failed to read PMP GSCR[0] (Emask=0x100)
[ 2343.212229] ata1.15: PMP revalidation failed (errno=-5)
[ 2343.212233] ata1.15: retrying hardreset in 5 secs
[ 2348.214695] ata1.15: hard resetting link
[ 2350.414038] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 2350.414247] ata1.00: hard resetting link
[ 2350.734118] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2350.734122] ata1.01: hard resetting link
[ 2351.054021] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2351.054025] ata1.02: hard resetting link
[ 2351.373925] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2351.373933] ata1.03: hard resetting link
[ 2351.693827] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2351.693831] ata1.04: hard resetting link
[ 2352.013729] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 2352.013733] ata1.05: hard resetting link
[ 2352.333630] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 2352.333634] ata1.06: hard resetting link
[ 2352.653540] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2352.655782] ata1.00: configured for UDMA/100
[ 2352.657980] ata1.01: configured for UDMA/100
[ 2352.764096] ata1.02: configured for UDMA/100
[ 2352.861654] ata1.03: configured for UDMA/100
[ 2352.861763] ata1.05: device is on DMA blacklist, disabling DMA
[ 2352.861871] ata1.05: configured for PIO4
[ 2352.862086] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[ 2352.862090] ata1.15: irq_stat 0x00800080, device exchanged
[ 2352.862360] ata1: EH complete
[ 2352.862385] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862397] sd 1:0:0:0: [sdb] Write Protect is off
[ 2352.862400] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2352.862414] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862428] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862436] sd 1:1:0:0: [sdc] Write Protect is off
[ 2352.862439] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2352.862450] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862464] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862472] sd 1:2:0:0: [sdd] Write Protect is off
[ 2352.862475] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2352.862486] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862499] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862507] sd 1:3:0:0: [sde] Write Protect is off
[ 2352.862510] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2352.862521] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862535] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2352.862542] sd 1:5:0:0: [sdf] Write Protect is off
[ 2352.862545] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2352.862557] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862569] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862577] sd 1:0:0:0: [sdb] Write Protect is off
[ 2352.862580] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2352.862591] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862604] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862611] sd 1:1:0:0: [sdc] Write Protect is off
[ 2352.862614] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2352.862626] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862638] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862646] sd 1:2:0:0: [sdd] Write Protect is off
[ 2352.862649] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2352.862660] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862673] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862680] sd 1:3:0:0: [sde] Write Protect is off
[ 2352.862683] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2352.862694] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862706] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2352.862714] sd 1:5:0:0: [sdf] Write Protect is off
[ 2352.862717] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2352.862728] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2467.824811] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2467.824817] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2467.824820] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2467.824823] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2467.824826] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2467.824829] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2467.824832] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2467.824837] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2467.824840] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2467.824844] ata1: SError: { 10B8B }
[ 2467.824849] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824854] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824859] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824864] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824870] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824875] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824880] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824887] ata1.15: hard resetting link
[ 2472.916873] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2473.168790] ata1.15: qc timeout (cmd 0xe4)
[ 2473.168799] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2473.168802] ata1.15: PMP revalidation failed (errno=-5)
[ 2473.168805] ata1.15: retrying hardreset in 5 secs
[ 2478.171271] ata1.15: hard resetting link
[ 2483.265729] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2483.517647] ata1.15: qc timeout (cmd 0xe4)
[ 2483.517655] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2483.517658] ata1.15: PMP revalidation failed (errno=-5)
[ 2483.517662] ata1.15: retrying hardreset in 5 secs
[ 2488.520130] ata1.15: hard resetting link
[ 2490.719472] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 2490.719682] ata1.00: hard resetting link
[ 2491.039551] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2491.039554] ata1.01: hard resetting link
[ 2491.359454] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.359458] ata1.02: hard resetting link
[ 2491.679359] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.679363] ata1.03: hard resetting link
[ 2491.999261] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.999265] ata1.04: hard resetting link
[ 2492.319165] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 2492.319168] ata1.05: hard resetting link
[ 2492.639066] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 2492.639070] ata1.06: hard resetting link
[ 2492.958971] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2492.961345] ata1.00: configured for UDMA/100
[ 2492.963537] ata1.01: configured for UDMA/100
[ 2492.963689] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2492.963693] ata1.02: revalidation failed (errno=-5)
[ 2492.963824] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2492.963828] ata1.03: revalidation failed (errno=-5)
[ 2492.963962] ata1.05: device is on DMA blacklist, disabling DMA
[ 2492.964068] ata1.05: configured for PIO4
[ 2492.964071] ata1: failed to recover some devices, retrying in 5 secs
[ 2497.965270] ata1.02: hard resetting link
[ 2498.285353] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2498.285358] ata1.03: hard resetting link
[ 2498.605256] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2498.710753] ata1.02: configured for UDMA/100
[ 2498.710857] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2498.710861] ata1.03: revalidation failed (errno=-5)
[ 2498.710865] ata1: failed to recover some devices, retrying in 5 secs
[ 2503.711527] ata1.03: hard resetting link
[ 2504.031610] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2504.031731] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2504.031735] ata1.03: revalidation failed (errno=-5)
[ 2504.031738] ata1.03: disabled
[ 2504.535271] ata1.03: hard resetting link
[ 2504.855360] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2504.855415] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2504.855419] ata1: failed to recover some devices, retrying in 5 secs
[ 2509.857662] ata1.03: hard resetting link
[ 2510.177746] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2510.177809] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2510.177814] ata1: failed to recover some devices, retrying in 5 secs
[ 2515.180048] ata1.03: hard resetting link
[ 2515.500132] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2515.500195] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2515.500199] ata1: failed to recover some devices, retrying in 5 secs
[ 2520.502428] ata1.03: hard resetting link
[ 2520.822515] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2520.822793] ata1: EH complete
[ 2520.822822] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822834] sd 1:0:0:0: [sdb] Write Protect is off
[ 2520.822837] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2520.822850] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822866] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822874] sd 1:1:0:0: [sdc] Write Protect is off
[ 2520.822877] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2520.822888] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822901] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822910] sd 1:2:0:0: [sdd] Write Protect is off
[ 2520.822912] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2520.822924] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822937] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2520.822944] sd 1:5:0:0: [sdf] Write Protect is off
[ 2520.822947] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2520.822959] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822971] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822979] sd 1:0:0:0: [sdb] Write Protect is off
[ 2520.822982] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2520.822993] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823005] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.823012] sd 1:1:0:0: [sdc] Write Protect is off
[ 2520.823015] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2520.823026] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823039] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.823046] sd 1:2:0:0: [sdd] Write Protect is off
[ 2520.823049] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2520.823060] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823073] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2520.823080] sd 1:5:0:0: [sdf] Write Protect is off
[ 2520.823083] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2520.823094] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823100] ata1.03: detaching (SCSI 1:3:0:0)
[ 2520.823274] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[ 2520.823738] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[ 2520.823742] sd 1:3:0:0: [sde] Stopping disk
[ 2520.824243] sd 1:3:0:0: [sde] START_STOP FAILED
[ 2520.824246] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00

--------------020808050009060708060708
Content-Type: text/plain;
 name="9_OccupyLastPMPPort.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="9_OccupyLastPMPPort.log"

5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.327674] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 2220.328136] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.328145] sd 1:3:0:0: [sde] Write Protect is off
[ 2220.328148] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2220.328160] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.328204] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2220.328212] sd 1:3:0:0: [sde] Write Protect is off
[ 2220.328215] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2220.328622] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2220.328627]  sde: sde1
[ 2220.366475] sd 1:3:0:0: [sde] Attached SCSI disk
[ 2220.366525] sd 1:3:0:0: Attached scsi generic sg5 type 0
[ 2327.669606] ata1.15: limiting speed to PIO0
[ 2327.669613] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2327.669617] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2327.669620] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2327.669623] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2327.669626] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2327.669629] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2327.669632] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2327.669636] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2327.669639] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2327.669643] ata1: SError: { 10B8B }
[ 2327.669648] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669653] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669659] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669664] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669669] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669674] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669679] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2327.669687] ata1.15: hard resetting link
[ 2332.763389] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2333.015306] ata1.15: qc timeout (cmd 0xe4)
[ 2333.015314] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2333.015318] ata1.15: PMP revalidation failed (errno=-5)
[ 2333.015321] ata1.15: retrying hardreset in 5 secs
[ 2338.017789] ata1.15: hard resetting link
[ 2343.112248] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2343.212225] ata1.15: failed to read PMP GSCR[0] (Emask=0x100)
[ 2343.212229] ata1.15: PMP revalidation failed (errno=-5)
[ 2343.212233] ata1.15: retrying hardreset in 5 secs
[ 2348.214695] ata1.15: hard resetting link
[ 2350.414038] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 2350.414247] ata1.00: hard resetting link
[ 2350.734118] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2350.734122] ata1.01: hard resetting link
[ 2351.054021] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2351.054025] ata1.02: hard resetting link
[ 2351.373925] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2351.373933] ata1.03: hard resetting link
[ 2351.693827] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2351.693831] ata1.04: hard resetting link
[ 2352.013729] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 2352.013733] ata1.05: hard resetting link
[ 2352.333630] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 2352.333634] ata1.06: hard resetting link
[ 2352.653540] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2352.655782] ata1.00: configured for UDMA/100
[ 2352.657980] ata1.01: configured for UDMA/100
[ 2352.764096] ata1.02: configured for UDMA/100
[ 2352.861654] ata1.03: configured for UDMA/100
[ 2352.861763] ata1.05: device is on DMA blacklist, disabling DMA
[ 2352.861871] ata1.05: configured for PIO4
[ 2352.862086] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[ 2352.862090] ata1.15: irq_stat 0x00800080, device exchanged
[ 2352.862360] ata1: EH complete
[ 2352.862385] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862397] sd 1:0:0:0: [sdb] Write Protect is off
[ 2352.862400] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2352.862414] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862428] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862436] sd 1:1:0:0: [sdc] Write Protect is off
[ 2352.862439] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2352.862450] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862464] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862472] sd 1:2:0:0: [sdd] Write Protect is off
[ 2352.862475] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2352.862486] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862499] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862507] sd 1:3:0:0: [sde] Write Protect is off
[ 2352.862510] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2352.862521] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862535] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2352.862542] sd 1:5:0:0: [sdf] Write Protect is off
[ 2352.862545] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2352.862557] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862569] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862577] sd 1:0:0:0: [sdb] Write Protect is off
[ 2352.862580] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2352.862591] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862604] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862611] sd 1:1:0:0: [sdc] Write Protect is off
[ 2352.862614] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2352.862626] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862638] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862646] sd 1:2:0:0: [sdd] Write Protect is off
[ 2352.862649] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2352.862660] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862673] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[ 2352.862680] sd 1:3:0:0: [sde] Write Protect is off
[ 2352.862683] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2352.862694] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2352.862706] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2352.862714] sd 1:5:0:0: [sdf] Write Protect is off
[ 2352.862717] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2352.862728] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2467.824811] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2467.824817] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2467.824820] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2467.824823] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2467.824826] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2467.824829] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2467.824832] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2467.824837] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2467.824840] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2467.824844] ata1: SError: { 10B8B }
[ 2467.824849] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824854] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824859] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824864] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824870] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824875] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824880] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824887] ata1.15: hard resetting link
[ 2472.916873] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2473.168790] ata1.15: qc timeout (cmd 0xe4)
[ 2473.168799] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2473.168802] ata1.15: PMP revalidation failed (errno=-5)
[ 2473.168805] ata1.15: retrying hardreset in 5 secs
[ 2478.171271] ata1.15: hard resetting link
[ 2483.265729] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2483.517647] ata1.15: qc timeout (cmd 0xe4)
[ 2483.517655] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2483.517658] ata1.15: PMP revalidation failed (errno=-5)
[ 2483.517662] ata1.15: retrying hardreset in 5 secs
[ 2488.520130] ata1.15: hard resetting link
[ 2490.719472] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 2490.719682] ata1.00: hard resetting link
[ 2491.039551] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2491.039554] ata1.01: hard resetting link
[ 2491.359454] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.359458] ata1.02: hard resetting link
[ 2491.679359] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.679363] ata1.03: hard resetting link
[ 2491.999261] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.999265] ata1.04: hard resetting link
[ 2492.319165] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 2492.319168] ata1.05: hard resetting link
[ 2492.639066] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 2492.639070] ata1.06: hard resetting link
[ 2492.958971] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2492.961345] ata1.00: configured for UDMA/100
[ 2492.963537] ata1.01: configured for UDMA/100
[ 2492.963689] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2492.963693] ata1.02: revalidation failed (errno=-5)
[ 2492.963824] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2492.963828] ata1.03: revalidation failed (errno=-5)
[ 2492.963962] ata1.05: device is on DMA blacklist, disabling DMA
[ 2492.964068] ata1.05: configured for PIO4
[ 2492.964071] ata1: failed to recover some devices, retrying in 5 secs
[ 2497.965270] ata1.02: hard resetting link
[ 2498.285353] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2498.285358] ata1.03: hard resetting link
[ 2498.605256] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2498.710753] ata1.02: configured for UDMA/100
[ 2498.710857] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2498.710861] ata1.03: revalidation failed (errno=-5)
[ 2498.710865] ata1: failed to recover some devices, retrying in 5 secs
[ 2503.711527] ata1.03: hard resetting link
[ 2504.031610] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2504.031731] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2504.031735] ata1.03: revalidation failed (errno=-5)
[ 2504.031738] ata1.03: disabled
[ 2504.535271] ata1.03: hard resetting link
[ 2504.855360] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2504.855415] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2504.855419] ata1: failed to recover some devices, retrying in 5 secs
[ 2509.857662] ata1.03: hard resetting link
[ 2510.177746] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2510.177809] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2510.177814] ata1: failed to recover some devices, retrying in 5 secs
[ 2515.180048] ata1.03: hard resetting link
[ 2515.500132] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2515.500195] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2515.500199] ata1: failed to recover some devices, retrying in 5 secs
[ 2520.502428] ata1.03: hard resetting link
[ 2520.822515] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2520.822793] ata1: EH complete
[ 2520.822822] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822834] sd 1:0:0:0: [sdb] Write Protect is off
[ 2520.822837] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2520.822850] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822866] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822874] sd 1:1:0:0: [sdc] Write Protect is off
[ 2520.822877] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2520.822888] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822901] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822910] sd 1:2:0:0: [sdd] Write Protect is off
[ 2520.822912] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2520.822924] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822937] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2520.822944] sd 1:5:0:0: [sdf] Write Protect is off
[ 2520.822947] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2520.822959] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822971] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822979] sd 1:0:0:0: [sdb] Write Protect is off
[ 2520.822982] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2520.822993] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823005] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.823012] sd 1:1:0:0: [sdc] Write Protect is off
[ 2520.823015] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2520.823026] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823039] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.823046] sd 1:2:0:0: [sdd] Write Protect is off
[ 2520.823049] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2520.823060] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823073] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2520.823080] sd 1:5:0:0: [sdf] Write Protect is off
[ 2520.823083] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2520.823094] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823100] ata1.03: detaching (SCSI 1:3:0:0)
[ 2520.823274] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[ 2520.823738] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[ 2520.823742] sd 1:3:0:0: [sde] Stopping disk
[ 2520.824243] sd 1:3:0:0: [sde] START_STOP FAILED
[ 2520.824246] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[ 2689.226123] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2689.226129] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2689.226132] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2689.226135] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2689.226138] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2689.226141] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2689.226144] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2689.226148] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2689.226152] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2689.226156] ata1: SError: { 10B8B }
[ 2689.226161] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226166] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226171] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226176] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226181] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226186] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226192] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226199] ata1.15: hard resetting link
[ 2694.317699] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2694.569617] ata1.15: qc timeout (cmd 0xe4)
[ 2694.569625] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2694.569628] ata1.15: PMP revalidation failed (errno=-5)
[ 2694.569631] ata1.15: retrying hardreset in 5 secs
[ 2699.572098] ata1.15: hard resetting link
[ 2704.666558] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2704.918477] ata1.15: qc timeout (cmd 0xe4)
[ 2704.918484] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2704.918487] ata1.15: PMP revalidation failed (errno=-5)
[ 2704.918491] ata1.15: retrying hardreset in 5 secs
[ 2709.920959] ata1.15: hard resetting link
[ 2715.015418] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2715.267337] ata1.15: qc timeout (cmd 0xe4)
[ 2715.267344] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2715.267347] ata1.15: PMP revalidation failed (errno=-5)
[ 2715.267351] ata1.15: retrying hardreset in 5 secs
[ 2720.269819] ata1.15: hard resetting link
[ 2725.364279] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2725.616196] ata1.15: qc timeout (cmd 0xe4)
[ 2725.616204] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2725.616207] ata1.15: PMP revalidation failed (errno=-5)
[ 2725.616210] ata1.15: retrying hardreset in 5 secs
[ 2730.618679] ata1.15: hard resetting link
[ 2735.713139] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2735.965057] ata1.15: qc timeout (cmd 0xe4)
[ 2735.965064] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2735.965067] ata1.15: PMP revalidation failed (errno=-5)
[ 2735.965070] ata1.15: failed to recover PMP after 5 tries, giving up
[ 2735.965073] ata1.15: Port Multiplier detaching
[ 2735.965081] ata1.00: disabled
[ 2735.965084] ata1.01: disabled
[ 2735.965087] ata1.02: disabled
[ 2735.965089] ata1.05: disabled
[ 2735.965092] ata1.00: disabled
[ 2735.965098] ata1: hard resetting link
[ 2739.308053] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2739.308243] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[ 2739.308453] ata1.00: hard resetting link
[ 2739.628109] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2739.628113] ata1.01: hard resetting link
[ 2739.948009] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2739.948013] ata1.02: hard resetting link
[ 2740.267914] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2740.267918] ata1.03: hard resetting link
[ 2740.587815] ata1.03: SATA link down (SStatus 0 SControl 320)
[ 2740.587819] ata1.04: hard resetting link
[ 2740.907722] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2740.907726] ata1.05: hard resetting link
[ 2741.227621] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2741.227624] ata1.06: hard resetting link
[ 2741.547525] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2741.547584] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2741.567765] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2741.587927] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2741.608087] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2741.628249] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[ 2741.628252] ata1.05: 640 sectors, multi 1: LBA 
[ 2741.628261] ata1.05: device is on DMA blacklist, disabling DMA
[ 2741.628464] ata1.05: configured for PIO4
[ 2741.628468] ata1: failed to recover some devices, retrying in 5 secs
[ 2746.629822] ata1.00: hard resetting link
[ 2746.949886] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2746.949891] ata1.01: hard resetting link
[ 2747.269789] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2747.269793] ata1.02: hard resetting link
[ 2747.589691] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2747.589695] ata1.04: hard resetting link
[ 2747.909595] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2747.910678] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[ 2747.910681] ata1.00: 586072368 sectors, multi 0: LBA48 
[ 2747.910684] ata1.00: applying bridge limits
[ 2747.911859] ata1.00: configured for UDMA/100
[ 2747.912923] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[ 2747.912926] ata1.01: 586072368 sectors, multi 0: LBA48 
[ 2747.912929] ata1.01: applying bridge limits
[ 2747.914104] ata1.01: configured for UDMA/100
[ 2747.960737] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[ 2747.960740] ata1.02: 586072368 sectors, multi 0: LBA48 
[ 2747.960743] ata1.02: applying bridge limits
[ 2748.018887] ata1.02: configured for UDMA/100
[ 2748.018981] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2748.019122] ata1.05: device is on DMA blacklist, disabling DMA
[ 2748.019288] ata1.05: configured for PIO4
[ 2748.019291] ata1: failed to recover some devices, retrying in 5 secs
[ 2753.019883] ata1.04: hard resetting link
[ 2753.339948] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2753.342229] ata1.00: configured for UDMA/100
[ 2753.344443] ata1.01: configured for UDMA/100
[ 2753.434140] ata1.02: configured for UDMA/100
[ 2753.434235] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2753.434239] ata1: failed to recover some devices, retrying in 5 secs
[ 2758.434240] ata1.04: hard resetting link
[ 2758.754305] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2758.754564] ata1: EH complete
[ 2758.754572] ata1.00: detaching (SCSI 1:0:0:0)
[ 2758.754749] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[ 2758.755045] sd 1:0:0:0: [sdb] Stopping disk
[ 2758.755191] ata1.01: detaching (SCSI 1:1:0:0)
[ 2758.755325] sd 1:1:0:0: [sdc] Synchronizing SCSI cache
[ 2758.755839] sd 1:1:0:0: [sdc] Stopping disk
[ 2758.756172] ata1.02: detaching (SCSI 1:2:0:0)
[ 2758.756322] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[ 2758.756426] sd 1:2:0:0: [sdd] Stopping disk
[ 2758.756533] ata1.05: detaching (SCSI 1:5:0:0)
[ 2758.756655] sd 1:5:0:0: [sdf] Stopping disk
[ 2758.756846] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[ 2758.756973] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2758.757000] sd 1:0:0:0: [sdb] Write Protect is off
[ 2758.757003] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2758.757032] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2758.757212] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2758.757237] sd 1:0:0:0: [sdb] Write Protect is off
[ 2758.757240] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2758.757267] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2758.757273]  sdb: sdb1
[ 2759.435145] sd 1:0:0:0: [sdb] Attached SCSI disk
[ 2759.435193] sd 1:0:0:0: Attached scsi generic sg2 type 0
[ 2759.435522] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[ 2759.435611] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2759.435632] sd 1:1:0:0: [sdc] Write Protect is off
[ 2759.435636] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2759.435665] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2759.435719] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2759.435737] sd 1:1:0:0: [sdc] Write Protect is off
[ 2759.435740] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2759.435767] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2759.435771]  sdc: sdc1
[ 2760.545669] sd 1:1:0:0: [sdc] Attached SCSI disk
[ 2760.545717] sd 1:1:0:0: Attached scsi generic sg3 type 0
[ 2760.545995] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 2760.546083] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2760.546104] sd 1:2:0:0: [sdd] Write Protect is off
[ 2760.546108] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2760.546137] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2760.546191] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2760.546208] sd 1:2:0:0: [sdd] Write Protect is off
[ 2760.546211] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2760.546239] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2760.546243]  sdd: sdd1
[ 2761.907801] sd 1:2:0:0: [sdd] Attached SCSI disk
[ 2761.907850] sd 1:2:0:0: Attached scsi generic sg4 type 0
[ 2761.908125] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[ 2761.908216] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 2761.908238] sd 1:5:0:0: [sde] Write Protect is off
[ 2761.908241] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2761.908271] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2761.908323] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 2761.908340] sd 1:5:0:0: [sde] Write Protect is off
[ 2761.908343] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2761.908371] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2761.908374]  sde: unknown partition table
[ 2761.908705] sd 1:5:0:0: [sde] Attached SCSI disk
[ 2761.908740] sd 1:5:0:0: Attached scsi generic sg5 type 0
[ 2998.839318] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2998.839324] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2998.839327] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2998.839330] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2998.839333] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2998.839336] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2998.839339] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2998.839343] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2998.839347] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2998.839351] ata1: SError: { 10B8B }
[ 2998.839356] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839361] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839366] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839371] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839376] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839382] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839387] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839394] ata1.15: hard resetting link
[ 3003.931768] ata1.15: SATA link down (SStatus 1 SControl 0)
[ 3004.183686] ata1.15: qc timeout (cmd 0xe4)
[ 3004.183694] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 3004.183697] ata1.15: PMP revalidation failed (errno=-5)
[ 3004.183700] ata1.15: retrying hardreset in 5 secs
[ 3009.186168] ata1.15: hard resetting link
[ 3014.280627] ata1.15: SATA link down (SStatus 1 SControl 0)
[ 3014.532545] ata1.15: qc timeout (cmd 0xe4)
[ 3014.532553] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 3014.532556] ata1.15: PMP revalidation failed (errno=-5)
[ 3014.532560] ata1.15: limiting SATA link speed to 1.5 Gbps
[ 3014.532563] ata1.15: retrying hardreset in 5 secs
[ 3019.535029] ata1.15: hard resetting link
[ 3021.734370] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 3021.734603] ata1.00: hard resetting link
[ 3022.054452] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3022.054456] ata1.01: hard resetting link
[ 3022.374353] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3022.374357] ata1.02: hard resetting link
[ 3022.694255] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3022.694259] ata1.03: hard resetting link
[ 3023.014158] ata1.03: SATA link down (SStatus 0 SControl 310)
[ 3023.014161] ata1.04: hard resetting link
[ 3023.334063] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3023.334067] ata1.05: hard resetting link
[ 3023.653963] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 3023.653967] ata1.06: hard resetting link
[ 3023.973871] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3023.976070] ata1.00: configured for UDMA/100
[ 3023.978246] ata1.01: configured for UDMA/100
[ 3024.074973] ata1.02: configured for UDMA/100
[ 3024.075027] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3024.075194] ata1.05: device is on DMA blacklist, disabling DMA
[ 3024.075300] ata1.05: configured for PIO4
[ 3024.075303] ata1: failed to recover some devices, retrying in 5 secs
[ 3029.076135] ata1.04: hard resetting link
[ 3029.396222] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3029.396279] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3029.396282] ata1: failed to recover some devices, retrying in 5 secs
[ 3034.398519] ata1.04: hard resetting link
[ 3034.718607] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3034.718663] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3034.718666] ata1: failed to recover some devices, retrying in 5 secs
[ 3039.720910] ata1.04: hard resetting link
[ 3040.040995] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3040.041276] ata1: EH complete
[ 3040.041304] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041316] sd 1:0:0:0: [sdb] Write Protect is off
[ 3040.041319] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3040.041332] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041348] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041356] sd 1:1:0:0: [sdc] Write Protect is off
[ 3040.041359] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3040.041370] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041383] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041391] sd 1:2:0:0: [sdd] Write Protect is off
[ 3040.041394] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 3040.041405] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041418] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 3040.041426] sd 1:5:0:0: [sde] Write Protect is off
[ 3040.041429] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 3040.041440] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041453] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041460] sd 1:0:0:0: [sdb] Write Protect is off
[ 3040.041463] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3040.041474] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041487] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041494] sd 1:1:0:0: [sdc] Write Protect is off
[ 3040.041497] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3040.041508] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041520] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041528] sd 1:2:0:0: [sdd] Write Protect is off
[ 3040.041531] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 3040.041542] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041554] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 3040.041562] sd 1:5:0:0: [sde] Write Protect is off
[ 3040.041564] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 3040.041672] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

--------------020808050009060708060708
Content-Type: text/plain;
 name="10_PlugUnplug.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10_PlugUnplug.log"

esn't support DPO or FUA
[ 2352.862706] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2352.862714] sd 1:5:0:0: [sdf] Write Protect is off
[ 2352.862717] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2352.862728] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2467.824811] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2467.824817] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2467.824820] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2467.824823] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2467.824826] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2467.824829] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2467.824832] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2467.824837] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2467.824840] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2467.824844] ata1: SError: { 10B8B }
[ 2467.824849] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824854] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824859] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824864] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824870] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824875] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824880] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2467.824887] ata1.15: hard resetting link
[ 2472.916873] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2473.168790] ata1.15: qc timeout (cmd 0xe4)
[ 2473.168799] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2473.168802] ata1.15: PMP revalidation failed (errno=-5)
[ 2473.168805] ata1.15: retrying hardreset in 5 secs
[ 2478.171271] ata1.15: hard resetting link
[ 2483.265729] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2483.517647] ata1.15: qc timeout (cmd 0xe4)
[ 2483.517655] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2483.517658] ata1.15: PMP revalidation failed (errno=-5)
[ 2483.517662] ata1.15: retrying hardreset in 5 secs
[ 2488.520130] ata1.15: hard resetting link
[ 2490.719472] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 2490.719682] ata1.00: hard resetting link
[ 2491.039551] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2491.039554] ata1.01: hard resetting link
[ 2491.359454] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.359458] ata1.02: hard resetting link
[ 2491.679359] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.679363] ata1.03: hard resetting link
[ 2491.999261] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2491.999265] ata1.04: hard resetting link
[ 2492.319165] ata1.04: SATA link down (SStatus 0 SControl 310)
[ 2492.319168] ata1.05: hard resetting link
[ 2492.639066] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 2492.639070] ata1.06: hard resetting link
[ 2492.958971] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2492.961345] ata1.00: configured for UDMA/100
[ 2492.963537] ata1.01: configured for UDMA/100
[ 2492.963689] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2492.963693] ata1.02: revalidation failed (errno=-5)
[ 2492.963824] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2492.963828] ata1.03: revalidation failed (errno=-5)
[ 2492.963962] ata1.05: device is on DMA blacklist, disabling DMA
[ 2492.964068] ata1.05: configured for PIO4
[ 2492.964071] ata1: failed to recover some devices, retrying in 5 secs
[ 2497.965270] ata1.02: hard resetting link
[ 2498.285353] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2498.285358] ata1.03: hard resetting link
[ 2498.605256] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2498.710753] ata1.02: configured for UDMA/100
[ 2498.710857] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2498.710861] ata1.03: revalidation failed (errno=-5)
[ 2498.710865] ata1: failed to recover some devices, retrying in 5 secs
[ 2503.711527] ata1.03: hard resetting link
[ 2504.031610] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2504.031731] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2504.031735] ata1.03: revalidation failed (errno=-5)
[ 2504.031738] ata1.03: disabled
[ 2504.535271] ata1.03: hard resetting link
[ 2504.855360] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2504.855415] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2504.855419] ata1: failed to recover some devices, retrying in 5 secs
[ 2509.857662] ata1.03: hard resetting link
[ 2510.177746] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2510.177809] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2510.177814] ata1: failed to recover some devices, retrying in 5 secs
[ 2515.180048] ata1.03: hard resetting link
[ 2515.500132] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2515.500195] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2515.500199] ata1: failed to recover some devices, retrying in 5 secs
[ 2520.502428] ata1.03: hard resetting link
[ 2520.822515] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2520.822793] ata1: EH complete
[ 2520.822822] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822834] sd 1:0:0:0: [sdb] Write Protect is off
[ 2520.822837] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2520.822850] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822866] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822874] sd 1:1:0:0: [sdc] Write Protect is off
[ 2520.822877] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2520.822888] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822901] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822910] sd 1:2:0:0: [sdd] Write Protect is off
[ 2520.822912] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2520.822924] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822937] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2520.822944] sd 1:5:0:0: [sdf] Write Protect is off
[ 2520.822947] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2520.822959] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.822971] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.822979] sd 1:0:0:0: [sdb] Write Protect is off
[ 2520.822982] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2520.822993] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823005] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.823012] sd 1:1:0:0: [sdc] Write Protect is off
[ 2520.823015] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2520.823026] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823039] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2520.823046] sd 1:2:0:0: [sdd] Write Protect is off
[ 2520.823049] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2520.823060] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823073] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[ 2520.823080] sd 1:5:0:0: [sdf] Write Protect is off
[ 2520.823083] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 2520.823094] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2520.823100] ata1.03: detaching (SCSI 1:3:0:0)
[ 2520.823274] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[ 2520.823738] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[ 2520.823742] sd 1:3:0:0: [sde] Stopping disk
[ 2520.824243] sd 1:3:0:0: [sde] START_STOP FAILED
[ 2520.824246] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[ 2689.226123] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2689.226129] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2689.226132] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2689.226135] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2689.226138] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2689.226141] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2689.226144] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2689.226148] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2689.226152] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2689.226156] ata1: SError: { 10B8B }
[ 2689.226161] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226166] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226171] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226176] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226181] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226186] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226192] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2689.226199] ata1.15: hard resetting link
[ 2694.317699] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2694.569617] ata1.15: qc timeout (cmd 0xe4)
[ 2694.569625] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2694.569628] ata1.15: PMP revalidation failed (errno=-5)
[ 2694.569631] ata1.15: retrying hardreset in 5 secs
[ 2699.572098] ata1.15: hard resetting link
[ 2704.666558] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2704.918477] ata1.15: qc timeout (cmd 0xe4)
[ 2704.918484] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2704.918487] ata1.15: PMP revalidation failed (errno=-5)
[ 2704.918491] ata1.15: retrying hardreset in 5 secs
[ 2709.920959] ata1.15: hard resetting link
[ 2715.015418] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2715.267337] ata1.15: qc timeout (cmd 0xe4)
[ 2715.267344] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2715.267347] ata1.15: PMP revalidation failed (errno=-5)
[ 2715.267351] ata1.15: retrying hardreset in 5 secs
[ 2720.269819] ata1.15: hard resetting link
[ 2725.364279] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2725.616196] ata1.15: qc timeout (cmd 0xe4)
[ 2725.616204] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2725.616207] ata1.15: PMP revalidation failed (errno=-5)
[ 2725.616210] ata1.15: retrying hardreset in 5 secs
[ 2730.618679] ata1.15: hard resetting link
[ 2735.713139] ata1.15: SATA link down (SStatus 1 SControl 10)
[ 2735.965057] ata1.15: qc timeout (cmd 0xe4)
[ 2735.965064] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 2735.965067] ata1.15: PMP revalidation failed (errno=-5)
[ 2735.965070] ata1.15: failed to recover PMP after 5 tries, giving up
[ 2735.965073] ata1.15: Port Multiplier detaching
[ 2735.965081] ata1.00: disabled
[ 2735.965084] ata1.01: disabled
[ 2735.965087] ata1.02: disabled
[ 2735.965089] ata1.05: disabled
[ 2735.965092] ata1.00: disabled
[ 2735.965098] ata1: hard resetting link
[ 2739.308053] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2739.308243] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[ 2739.308453] ata1.00: hard resetting link
[ 2739.628109] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2739.628113] ata1.01: hard resetting link
[ 2739.948009] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2739.948013] ata1.02: hard resetting link
[ 2740.267914] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2740.267918] ata1.03: hard resetting link
[ 2740.587815] ata1.03: SATA link down (SStatus 0 SControl 320)
[ 2740.587819] ata1.04: hard resetting link
[ 2740.907722] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2740.907726] ata1.05: hard resetting link
[ 2741.227621] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2741.227624] ata1.06: hard resetting link
[ 2741.547525] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2741.547584] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2741.567765] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2741.587927] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2741.608087] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2741.628249] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[ 2741.628252] ata1.05: 640 sectors, multi 1: LBA 
[ 2741.628261] ata1.05: device is on DMA blacklist, disabling DMA
[ 2741.628464] ata1.05: configured for PIO4
[ 2741.628468] ata1: failed to recover some devices, retrying in 5 secs
[ 2746.629822] ata1.00: hard resetting link
[ 2746.949886] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2746.949891] ata1.01: hard resetting link
[ 2747.269789] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2747.269793] ata1.02: hard resetting link
[ 2747.589691] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2747.589695] ata1.04: hard resetting link
[ 2747.909595] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2747.910678] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[ 2747.910681] ata1.00: 586072368 sectors, multi 0: LBA48 
[ 2747.910684] ata1.00: applying bridge limits
[ 2747.911859] ata1.00: configured for UDMA/100
[ 2747.912923] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[ 2747.912926] ata1.01: 586072368 sectors, multi 0: LBA48 
[ 2747.912929] ata1.01: applying bridge limits
[ 2747.914104] ata1.01: configured for UDMA/100
[ 2747.960737] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[ 2747.960740] ata1.02: 586072368 sectors, multi 0: LBA48 
[ 2747.960743] ata1.02: applying bridge limits
[ 2748.018887] ata1.02: configured for UDMA/100
[ 2748.018981] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2748.019122] ata1.05: device is on DMA blacklist, disabling DMA
[ 2748.019288] ata1.05: configured for PIO4
[ 2748.019291] ata1: failed to recover some devices, retrying in 5 secs
[ 2753.019883] ata1.04: hard resetting link
[ 2753.339948] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2753.342229] ata1.00: configured for UDMA/100
[ 2753.344443] ata1.01: configured for UDMA/100
[ 2753.434140] ata1.02: configured for UDMA/100
[ 2753.434235] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2753.434239] ata1: failed to recover some devices, retrying in 5 secs
[ 2758.434240] ata1.04: hard resetting link
[ 2758.754305] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2758.754564] ata1: EH complete
[ 2758.754572] ata1.00: detaching (SCSI 1:0:0:0)
[ 2758.754749] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[ 2758.755045] sd 1:0:0:0: [sdb] Stopping disk
[ 2758.755191] ata1.01: detaching (SCSI 1:1:0:0)
[ 2758.755325] sd 1:1:0:0: [sdc] Synchronizing SCSI cache
[ 2758.755839] sd 1:1:0:0: [sdc] Stopping disk
[ 2758.756172] ata1.02: detaching (SCSI 1:2:0:0)
[ 2758.756322] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[ 2758.756426] sd 1:2:0:0: [sdd] Stopping disk
[ 2758.756533] ata1.05: detaching (SCSI 1:5:0:0)
[ 2758.756655] sd 1:5:0:0: [sdf] Stopping disk
[ 2758.756846] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[ 2758.756973] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2758.757000] sd 1:0:0:0: [sdb] Write Protect is off
[ 2758.757003] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2758.757032] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2758.757212] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 2758.757237] sd 1:0:0:0: [sdb] Write Protect is off
[ 2758.757240] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2758.757267] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2758.757273]  sdb: sdb1
[ 2759.435145] sd 1:0:0:0: [sdb] Attached SCSI disk
[ 2759.435193] sd 1:0:0:0: Attached scsi generic sg2 type 0
[ 2759.435522] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[ 2759.435611] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2759.435632] sd 1:1:0:0: [sdc] Write Protect is off
[ 2759.435636] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2759.435665] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2759.435719] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 2759.435737] sd 1:1:0:0: [sdc] Write Protect is off
[ 2759.435740] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2759.435767] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2759.435771]  sdc: sdc1
[ 2760.545669] sd 1:1:0:0: [sdc] Attached SCSI disk
[ 2760.545717] sd 1:1:0:0: Attached scsi generic sg3 type 0
[ 2760.545995] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 2760.546083] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2760.546104] sd 1:2:0:0: [sdd] Write Protect is off
[ 2760.546108] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2760.546137] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2760.546191] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 2760.546208] sd 1:2:0:0: [sdd] Write Protect is off
[ 2760.546211] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 2760.546239] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2760.546243]  sdd: sdd1
[ 2761.907801] sd 1:2:0:0: [sdd] Attached SCSI disk
[ 2761.907850] sd 1:2:0:0: Attached scsi generic sg4 type 0
[ 2761.908125] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[ 2761.908216] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 2761.908238] sd 1:5:0:0: [sde] Write Protect is off
[ 2761.908241] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2761.908271] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2761.908323] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 2761.908340] sd 1:5:0:0: [sde] Write Protect is off
[ 2761.908343] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 2761.908371] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2761.908374]  sde: unknown partition table
[ 2761.908705] sd 1:5:0:0: [sde] Attached SCSI disk
[ 2761.908740] sd 1:5:0:0: Attached scsi generic sg5 type 0
[ 2998.839318] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 2998.839324] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 2998.839327] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 2998.839330] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 2998.839333] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 2998.839336] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 2998.839339] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 2998.839343] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 2998.839347] ata1.15: irq_stat 0x01140010, PHY RDY changed
[ 2998.839351] ata1: SError: { 10B8B }
[ 2998.839356] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839361] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839366] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839371] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839376] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839382] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839387] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2998.839394] ata1.15: hard resetting link
[ 3003.931768] ata1.15: SATA link down (SStatus 1 SControl 0)
[ 3004.183686] ata1.15: qc timeout (cmd 0xe4)
[ 3004.183694] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 3004.183697] ata1.15: PMP revalidation failed (errno=-5)
[ 3004.183700] ata1.15: retrying hardreset in 5 secs
[ 3009.186168] ata1.15: hard resetting link
[ 3014.280627] ata1.15: SATA link down (SStatus 1 SControl 0)
[ 3014.532545] ata1.15: qc timeout (cmd 0xe4)
[ 3014.532553] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 3014.532556] ata1.15: PMP revalidation failed (errno=-5)
[ 3014.532560] ata1.15: limiting SATA link speed to 1.5 Gbps
[ 3014.532563] ata1.15: retrying hardreset in 5 secs
[ 3019.535029] ata1.15: hard resetting link
[ 3021.734370] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 3021.734603] ata1.00: hard resetting link
[ 3022.054452] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3022.054456] ata1.01: hard resetting link
[ 3022.374353] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3022.374357] ata1.02: hard resetting link
[ 3022.694255] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3022.694259] ata1.03: hard resetting link
[ 3023.014158] ata1.03: SATA link down (SStatus 0 SControl 310)
[ 3023.014161] ata1.04: hard resetting link
[ 3023.334063] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3023.334067] ata1.05: hard resetting link
[ 3023.653963] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 3023.653967] ata1.06: hard resetting link
[ 3023.973871] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3023.976070] ata1.00: configured for UDMA/100
[ 3023.978246] ata1.01: configured for UDMA/100
[ 3024.074973] ata1.02: configured for UDMA/100
[ 3024.075027] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3024.075194] ata1.05: device is on DMA blacklist, disabling DMA
[ 3024.075300] ata1.05: configured for PIO4
[ 3024.075303] ata1: failed to recover some devices, retrying in 5 secs
[ 3029.076135] ata1.04: hard resetting link
[ 3029.396222] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3029.396279] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3029.396282] ata1: failed to recover some devices, retrying in 5 secs
[ 3034.398519] ata1.04: hard resetting link
[ 3034.718607] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3034.718663] ata1.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3034.718666] ata1: failed to recover some devices, retrying in 5 secs
[ 3039.720910] ata1.04: hard resetting link
[ 3040.040995] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3040.041276] ata1: EH complete
[ 3040.041304] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041316] sd 1:0:0:0: [sdb] Write Protect is off
[ 3040.041319] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3040.041332] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041348] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041356] sd 1:1:0:0: [sdc] Write Protect is off
[ 3040.041359] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3040.041370] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041383] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041391] sd 1:2:0:0: [sdd] Write Protect is off
[ 3040.041394] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 3040.041405] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041418] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 3040.041426] sd 1:5:0:0: [sde] Write Protect is off
[ 3040.041429] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 3040.041440] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041453] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041460] sd 1:0:0:0: [sdb] Write Protect is off
[ 3040.041463] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3040.041474] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041487] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041494] sd 1:1:0:0: [sdc] Write Protect is off
[ 3040.041497] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3040.041508] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041520] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 3040.041528] sd 1:2:0:0: [sdd] Write Protect is off
[ 3040.041531] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 3040.041542] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3040.041554] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 3040.041562] sd 1:5:0:0: [sde] Write Protect is off
[ 3040.041564] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 3040.041672] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 3302.216486] ata1.00: failed to read SCR 1 (Emask=0x40)
[ 3302.216492] ata1.01: failed to read SCR 1 (Emask=0x40)
[ 3302.216495] ata1.02: failed to read SCR 1 (Emask=0x40)
[ 3302.216498] ata1.03: failed to read SCR 1 (Emask=0x40)
[ 3302.216501] ata1.04: failed to read SCR 1 (Emask=0x40)
[ 3302.216504] ata1.05: failed to read SCR 1 (Emask=0x40)
[ 3302.216507] ata1.06: failed to read SCR 1 (Emask=0x40)
[ 3302.216512] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[ 3302.216515] ata1.15: irq_stat 0x01940090, PHY RDY changed
[ 3302.216519] ata1: SError: { 10B8B }
[ 3302.216524] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3302.216529] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3302.216534] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3302.216539] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3302.216544] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3302.216549] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3302.216555] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 3302.216562] ata1.15: hard resetting link
[ 3304.292643] ata1.15: SATA link down (SStatus 0 SControl 10)
[ 3304.544560] ata1.15: qc timeout (cmd 0xe4)
[ 3304.544568] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 3304.544571] ata1.15: PMP revalidation failed (errno=-5)
[ 3304.544575] ata1.15: retrying hardreset in 5 secs
[ 3309.547042] ata1.15: hard resetting link
[ 3311.626416] ata1.15: SATA link down (SStatus 0 SControl 10)
[ 3311.878334] ata1.15: qc timeout (cmd 0xe4)
[ 3311.878342] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 3311.878345] ata1.15: PMP revalidation failed (errno=-5)
[ 3311.878348] ata1.15: retrying hardreset in 5 secs
[ 3316.880818] ata1.15: hard resetting link
[ 3318.960192] ata1.15: SATA link down (SStatus 0 SControl 10)
[ 3319.212110] ata1.15: qc timeout (cmd 0xe4)
[ 3319.212117] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 3319.212120] ata1.15: PMP revalidation failed (errno=-5)
[ 3319.212124] ata1.15: retrying hardreset in 5 secs
[ 3324.214593] ata1.15: hard resetting link
[ 3326.413935] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[ 3326.414147] ata1.00: hard resetting link
[ 3326.734016] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3326.734024] ata1.01: hard resetting link
[ 3327.053917] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3327.053922] ata1.02: hard resetting link
[ 3327.373820] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3327.373824] ata1.03: hard resetting link
[ 3327.693723] ata1.03: SATA link down (SStatus 0 SControl 310)
[ 3327.693727] ata1.04: hard resetting link
[ 3328.013626] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3328.013630] ata1.05: hard resetting link
[ 3328.333526] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[ 3328.333530] ata1.06: hard resetting link
[ 3328.653435] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3328.655654] ata1.00: configured for UDMA/100
[ 3328.657868] ata1.01: configured for UDMA/100
[ 3328.765843] ata1.02: configured for UDMA/100
[ 3328.813649] ata1.04: ATA-7: ST3300622A, 3.AND, max UDMA/100
[ 3328.813653] ata1.04: 586072368 sectors, multi 0: LBA48 
[ 3328.813656] ata1.04: applying bridge limits
[ 3328.871922] ata1.04: configured for UDMA/100
[ 3328.872028] ata1.05: device is on DMA blacklist, disabling DMA
[ 3328.872132] ata1.05: configured for PIO4
[ 3328.872404] ata1: EH complete
[ 3328.872428] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 3328.872440] sd 1:0:0:0: [sdb] Write Protect is off
[ 3328.872443] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3328.872456] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.872471] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 3328.872478] sd 1:1:0:0: [sdc] Write Protect is off
[ 3328.872481] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3328.872493] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.872506] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 3328.872514] sd 1:2:0:0: [sdd] Write Protect is off
[ 3328.872517] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 3328.872528] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.872541] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 3328.872549] sd 1:5:0:0: [sde] Write Protect is off
[ 3328.872552] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 3328.872563] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.872576] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[ 3328.872584] sd 1:0:0:0: [sdb] Write Protect is off
[ 3328.872587] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3328.872598] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.872610] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[ 3328.872618] sd 1:1:0:0: [sdc] Write Protect is off
[ 3328.872621] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3328.872632] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.872644] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[ 3328.872652] sd 1:2:0:0: [sdd] Write Protect is off
[ 3328.872655] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 3328.872666] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.872679] sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
[ 3328.872686] sd 1:5:0:0: [sde] Write Protect is off
[ 3328.872689] sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
[ 3328.872700] sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.872773] scsi 1:4:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[ 3328.873213] sd 1:4:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
[ 3328.873222] sd 1:4:0:0: [sdf] Write Protect is off
[ 3328.873225] sd 1:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 3328.873237] sd 1:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.873681] sd 1:4:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
[ 3328.873690] sd 1:4:0:0: [sdf] Write Protect is off
[ 3328.873693] sd 1:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 3328.873705] sd 1:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3328.873709]  sdf: sdf1
[ 3328.911665] sd 1:4:0:0: [sdf] Attached SCSI disk
[ 3328.911714] sd 1:4:0:0: Attached scsi generic sg6 type 0

--------------020808050009060708060708
Content-Type: text/plain;
 name="TestingRoutine.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="TestingRoutine.txt"

Sata 4726 testing: 4726 on at boot:

1. Cold boot computer, powere the sata 4726 before booting.
	Notes: Turned on 4726, unit powered up. Only first drive is auto-detected during the 3124 HBA's BIOS.
		Booting linux, all drives detected on PMP. All drive status light on storage tower are on.
	
	File: 1_Bootup.log
		
2. Turn 4726 off, wait 10 seconds, turn 4726 on
	Notes: All drives detected properly when unit was turned back on. Verified existance using fdisk.
3. Repeat #2.
	Notes: ata1.03 was not recognized this time. All drive status lights on storage tower are on,
		including for ata1.03, indicating some sort of detection?
	
	File: 2_PowerOnOffTwice.log
	
4. Unplug  4726, wait 10 seconds, plug back in (leave 4726 powered up)
	Notes: All 4 drives detected properly. Verified with fdisk.
	
	File: 3_PlugUnplug.txt

5. Power 4726 off, wait 10 seconds, power back on 4726
	Notes: ata1.03 was not dected, All drive status lights on storage tower are on,
		including for ata1.03, indicating some sort of detection?

6. Repeat step #5
	Notes: ata1.03 not detected again. All drive status lights on storage tower are on,
		including for ata1.03, indicating some sort of detection?
		
		I did double check all of the drives in the storage tower, all of the 
		IDE to SATA adapters and cables are plugged in.
	
	File: 4_PowerOnOffTwice.log
	
7. Turned 4726 off. Swap drives on 3rd and 4th port of 4726 around to see if this
	changes anything. Power 4726 back on. 
	Notes: Drives on first 3 ports are recognized, but ata1.03 are recognized. All
		drive status lights are lit.
	
	File: 5_DriveSwap.log
	
8. Repeating tests 2 through 6.

8.1 Repeating #2
	Notes: First 3 drives come up, ata1.03 is not detected. All
		drive status lights are lit.
	
8.2 Repeating #3
	Notes: First 3 drives come up, ata1.03 is not detected. All
		drive status lights are lit.
	
	File: 6_PowerOnOff.log
		
8.3 Repeating #4
	Notes: All 4 drives are detected properly.
	
	File: 7_PlugUnplug.log
	
8.4 Repeating #5
	Notes: All drives were detected. Verified using fdisk.
	
8.6 Repeating #6
	Notes: ata1.03 failed to be detected, first 3 drives were detected ok.
	
	File: 8_PowerOnOffTwice.log
	
9. Powering off 4726, Reversing drive swap test as noted in Step #7.
	Moving drive on 4th SATA port of 4726 to 5th SATA port.
	
	Notes: ata1.04 or is it ata1.05(??) is not recognized. First 3 drives are detected properly.
		I did have a spare LED to install on the 5th status LED port, 
		so I can't tell what the status is.
		
10. Powering 4726 off, waiting 10 seconds, then on. 
	Notes: Same results as in #9. ata1.04 is not recognized.
		Looking at the logs, 

	File: 9_OccupyLastPMPPort.log
	
11. Unplugging 4726 from HBA, waiting 10 seconds, and re-plugging.
	Notes: All 4 drives detected properly. ata1.04 is recognized.
	
	File: 10_PlugUnplug.log
	
	/dev/sde for ata1.03 is created, but invalid:
	
	BigMouth timestamped # fdisk /dev/sde
	Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
	Building a new DOS disklabel. Changes will remain in memory only,
	until you decide to write them. After that, of course, the previous
	content won't be recoverable.
	
	You must set cylinders.
	You can do this from the extra functions menu.
	Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
	
	Command (m for help): p
	
	Disk /dev/sde: 0 MB, 327680 bytes
	255 heads, 63 sectors/track, 0 cylinders
	Units = cylinders of 16065 * 512 = 8225280 bytes
	
	   Device Boot      Start         End      Blocks   Id  System
	
	Command (m for help): q
	
	
	




--------------020808050009060708060708--
