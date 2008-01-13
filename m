From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: Sata 4726 Testing
Date: Sun, 13 Jan 2008 14:01:43 -0500
Message-ID: <478A6017.5060509@shaw.ca>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com>
 <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com>
 <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com>
 <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com>
 <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca>
 <47859D1A.8010006@gmail.com> <47855F02.3010407@shaw.ca>
 <4785BD03.10809@gmail.com> <4786C42A.10403@shaw.ca>
 <47871F88.8070109@gmail.com> <4787F82C.80709@shaw.ca>
 <47899D39.4050108@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------080405040801090803040005
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:52765 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbYANAKW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 19:10:22 -0500
Received: from pd4mr4so.prod.shaw.ca
 (pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUL005YEXQFXG10@l-daemon> for linux-ide@vger.kernel.org; Sun,
 13 Jan 2008 17:08:39 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUL00MG9XQFAE20@pd4mr4so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Sun, 13 Jan 2008 17:08:40 -0700 (MST)
Received: from [192.168.0.2] ([70.76.194.32])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUL006A9XQ9F130@l-daemon> for linux-ide@vger.kernel.org; Sun,
 13 Jan 2008 17:08:38 -0700 (MST)
In-reply-to: <47899D39.4050108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080405040801090803040005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun,

I have completed some of the testing, things were working fine.. then
something died. It will not even recognize the 4726 anymore. During book
when the HBA does it scan nor in windows 2000 does anything work or be
recognized.

I will have a new eSATA cable this week sometime, maybe a pin got
shmucked if lucky. I've attached the logs of the good and the gone dead.

Here's the testing procedure:

Sata 4726 testing: 4726 on at boot:

1. Rebooted the computer, powered the sata on 4726 before booting.
    Notes: Everything works
   
    File: 1_Bootup.log
       
2. Turn 4726 off, wait 10 seconds, turn 4726 on
    Notes: Works
   
3. Repeat #2.
    Notes: Works
   
    File: 2_PowerOnOffTwice.log
   
4. Unplug  4726, wait 10 seconds, plug back in (leave 4726 powered up)
    Notes: Works
   
    File: 3_PlugUnplug.txt

5. Power 4726 off, wait 10 seconds, power back on 4726
    Notes: Something crapped out. (Timestamp 404-505). LED status lights
dark

6. Repeat step #5
    Notes: Repeating did not fix things. Same failures.
   
    File: 4_PowerOnOffTwice.log
   
   
7. Unplugged and re-plugged 4726 on same port
    Notes: Did not do a thing. Did not even generate a kernel message..
(Timestamp between 688 and 776)

8. Unplugged from port 1 and plugged 4726 into port 2
    Same results as #7. (Timestamp 776-836)
   
9. Powered unit off, unplugged cable from HBA, waited 10 seconds,
plugged cable
    back into HBA and powered up.
    Notes: Nothing. No kernel messages or activity.
   
10. Unloaded sata_sil24 module.

    File: 5_Broken.log

11. Reloaded sata_sil24
    Notes: Still unresponsive.
   
    File: 6_ModuleReload.log

12. Repeated steps 10 & 11 but removed sata_sil24 and libata
    Notes: Unresponsive. LED status lights are still dark also since the
initial failure.
   
    File 7_ModuleReload2.log




Tejun Heo wrote:
> Andrew Ryder wrote:
>   
>> Tejun,
>>
>> No problem. I should be thanking you and your team for all the hard work
>> writing the drivers for the hardware..
>>
>> I think this patch might have solved the issue. I did a quick test: warm
>> rebooted and turned the 4726 on and off 3 times and all disks were
>> successfully detected each time. I'll do a more thorough test tomorrow
>> or Sunday.
>>     
>
> Great.  I forwarded the patch for #upstream-fixes as the patch is in the
> right direction whether it fully fixes your problem or not.  Please
> lemme know the test result.
>
> Gaston, for the initial detection failure messages when connected to ICH
> AHCI, I don't really have much idea what's going on or how to fix it.  I
> suspect it's related to initial FISes from drives arriving
> asynchronously after hard resets but can't tell much without bus
> analyzer.  Anyways, as EH can handle the case quickly enough, I guess we
> can leave it at that for now.  If you have ideas on what's going on or
> how to fix it, please lemme know.
>
> Thanks.
>
>   


--------------080405040801090803040005
Content-Type: text/plain;
 name="1_Bootup.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1_Bootup.log"

[    0.000000] Linux version 2.6.24-rc7 (root@BigMouth) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.1)) #3 Fri Jan 11 22:15:34 EST 2008
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
[   41.449000] time.c: Detected 1802.299 MHz processor.
[   41.451400] Console: colour VGA+ 80x25
[   41.451403] console [tty0] enabled
[   41.455463] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   41.457554] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   41.457929] Checking aperture...
[   41.457983] CPU 0: aperture @ f8000000 size 64 MB
[   41.477727] Memory: 2059876k/2096320k available (2288k kernel code, 35684k reserved, 1034k data, 192k init)
[   41.554966] Calibrating delay using timer specific routine.. 3608.83 BogoMIPS (lpj=7217667)
[   41.555122] Mount-cache hash table entries: 256
[   41.555285] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   41.555342] CPU: L2 Cache: 1024K (64 bytes/line)
[   41.555407] CPU: AMD Opteron(tm) Processor 144 stepping 0a
[   41.555550] ACPI: Core revision 20070126
[   41.598361] Using local APIC timer interrupts.
[   41.653885] APIC timer calibration result 12515971
[   41.653887] Detected 12.515 MHz APIC timer.
[   41.654071] net_namespace: 120 bytes
[   41.654499] NET: Registered protocol family 16
[   41.654689] ACPI: bus type pci registered
[   41.654749] PCI: Using configuration type 1
[   41.656890] ACPI: EC: Look up EC in DSDT
[   41.660406] ACPI: Interpreter enabled
[   41.660459] ACPI: (supports S0 S1 S3 S5)
[   41.660672] ACPI: Using IOAPIC for interrupt routing
[   41.667451] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   41.668190] PCI: enabled onboard AC97/MC97 devices
[   41.668490] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   41.675050] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
[   41.675571] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
[   41.676091] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
[   41.676610] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 15)
[   41.677129] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.677735] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.678354] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.678960] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.679561] Linux Plug and Play Support v0.97 (c) Adam Belay
[   41.679638] pnp: PnP ACPI init
[   41.679695] ACPI: bus type pnp registered
[   41.683072] pnp: PnP ACPI: found 14 devices
[   41.683125] ACPI: ACPI bus type pnp unregistered
[   41.683325] SCSI subsystem initialized
[   41.683467] PCI: Using ACPI for IRQ routing
[   41.683521] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   41.683595] PCI: Cannot allocate resource region 0 of device 0000:00:00.0
[   41.693996] agpgart: Detected AGP bridge 0
[   41.697506] agpgart: AGP aperture is 64M @ 0xf8000000
[   41.697944] Time: tsc clocksource has been installed.
[   41.705979] system 00:09: ioport range 0x295-0x296 has been reserved
[   41.706037] system 00:09: ioport range 0x3e1-0x3e7 has been reserved
[   41.706094] system 00:09: ioport range 0x4d0-0x4d1 has been reserved
[   41.706151] system 00:09: ioport range 0x800-0x87f has been reserved
[   41.706208] system 00:09: ioport range 0x400-0x41f has been reserved
[   41.706270] system 00:0a: iomem range 0xfec00000-0xfec00fff has been reserved
[   41.706328] system 00:0a: iomem range 0xfee00000-0xfee00fff could not be reserved
[   41.706396] system 00:0a: iomem range 0xfff80000-0xffffffff could not be reserved
[   41.706469] system 00:0d: iomem range 0x0-0x9ffff could not be reserved
[   41.706526] system 00:0d: iomem range 0xc0000-0xdffff has been reserved
[   41.706584] system 00:0d: iomem range 0xe0000-0xfffff could not be reserved
[   41.706641] system 00:0d: iomem range 0x100000-0x7ffeffff could not be reserved
[   41.706709] system 00:0d: iomem range 0x0-0x0 could not be reserved
[   41.707104] PCI: Bridge: 0000:00:01.0
[   41.707157]   IO window: a000-afff
[   41.707211]   MEM window: fc500000-fcafffff
[   41.707265]   PREFETCH window: b3e00000-f3dfffff
[   41.707337] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   41.707362] NET: Registered protocol family 2
[   41.741986] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   41.742592] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   41.745143] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   41.745545] TCP: Hash tables configured (established 262144 bind 65536)
[   41.745602] TCP reno registered
[   41.754600] audit: initializing netlink socket (disabled)
[   41.754662] audit(1200226061.256:1): initialized
[   41.754982] io scheduler noop registered
[   41.755036] io scheduler anticipatory registered (default)
[   41.755091] io scheduler deadline registered
[   41.755152] io scheduler cfq registered
[   41.755209] PCI: VIA PCI bridge detected. Disabling DAC.
[   41.755733] Boot video device is 0000:01:00.0
[   41.757787] Real Time Clock Driver v1.12ac
[   41.757902] Linux agpgart interface v0.102
[   41.757965] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   41.758125] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   41.758270] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   41.758919] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   41.759221] loop: module loaded
[   41.759278] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   41.759335] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   41.759439] VIA8237SATA: IDE controller (0x1106:0x3149 rev 0x80) at  PCI slot 0000:00:0f.0
[   41.759522] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
[   41.759638] VIA8237SATA: 100% native mode on irq 20
[   41.759696]     ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
[   41.759845]     ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:pio
[   41.759992] Probing IDE interface ide2...
[   42.325754] Probing IDE interface ide3...
[   42.893584] VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at  PCI slot 0000:00:0f.1
[   42.893663] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
[   42.893770] VP_IDE: not 100% native mode: will probe irqs later
[   42.893832] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
[   42.893902]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
[   42.894051]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
[   42.894197] Probing IDE interface ide0...
[   43.309555] hdb: Maxtor 4G160J8, ATA DISK drive
[   43.645452] hda: ST3200822A, ATA DISK drive
[   43.645548] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   43.645778] hda: UDMA/100 mode selected
[   43.646122] hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   43.646215] hdb: UDMA/133 mode selected
[   43.646398] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   43.646550] Probing IDE interface ide1...
[   44.565173] hdd: ASUS DVD-E616P2, ATAPI CD/DVD-ROM drive
[   45.348936] hdc: ASUS DRW-0402P/D, ATAPI CD/DVD-ROM drive
[   45.349107] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   45.349192] hdc: UDMA/33 mode selected
[   45.349311] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   45.349499] hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
[   45.349567] hdd: UDMA/33 mode selected
[   45.349873] ide1 at 0x170-0x177,0x376 on irq 15
[   45.350107] Probing IDE interface ide2...
[   45.916663] Probing IDE interface ide3...
[   46.484512] hda: max request size: 512KiB
[   46.485016] hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
[   46.485278] hda: cache flushes supported
[   46.485354]  hda: hda1 hda2
[   46.494758] hdb: max request size: 512KiB
[   46.502076] hdb: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63
[   46.502219] hdb: cache flushes not supported
[   46.502288]  hdb: hdb1
[   46.516013] hdc: ATAPI 47X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache
[   46.516295] Uniform CD-ROM driver Revision: 3.20
[   47.825381] hdd: ATAPI 48X DVD-ROM drive, 512kB Cache
[   47.836721] ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
[   53.046505] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   53.046507]         <Adaptec 29160N Ultra160 SCSI adapter>
[   53.046508]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   53.046510] 
[   53.050435] scsi 0:0:0:0: Direct-Access     SEAGATE  ST318452LW       0004 PQ: 0 ANSI: 3
[   53.050509] scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
[   53.050608]  target0:0:0: Beginning Domain Validation
[   53.058792]  target0:0:0: wide asynchronous
[   53.064974]  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
[   53.075742]  target0:0:0: Ending Domain Validation
[   53.598425] scsi 0:0:3:0: CD-ROM            YAMAHA   CRW8824S         1.00 PQ: 0 ANSI: 2
[   53.598499]  target0:0:3: Beginning Domain Validation
[   53.611738]  target0:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
[   53.619071]  target0:0:3: Domain Validation skipping write tests
[   53.619127]  target0:0:3: Ending Domain Validation
[   56.438680] Driver 'sd' needs updating - please use bus_type methods
[   56.439575] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   56.440757] sd 0:0:0:0: [sda] Write Protect is off
[   56.440811] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   56.442520] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   56.443360] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   56.444542] sd 0:0:0:0: [sda] Write Protect is off
[   56.444596] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   56.446306] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   56.446375]  sda: sda1 sda2 sda3
[   56.451055] sd 0:0:0:0: [sda] Attached SCSI disk
[   56.451117] Driver 'sr' needs updating - please use bus_type methods
[   56.486032] sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
[   56.486132] sr 0:0:3:0: Attached scsi CD-ROM sr0
[   56.486199] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   56.486617] serio: i8042 KBD port at 0x60,0x64 irq 1
[   56.486674] serio: i8042 AUX port at 0x60,0x64 irq 12
[   56.486836] mice: PS/2 mouse device common for all mice
[   56.516687] input: AT Translated Set 2 keyboard as /class/input/input0
[   56.544551] TCP cubic registered
[   56.544609] NET: Registered protocol family 1
[   56.544673] NET: Registered protocol family 17
[   56.544759] NET: Registered protocol family 33
[   56.544953] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   56.951406] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[   57.068218] ReiserFS: sda3: found reiserfs format "3.6" with standard journal
[   57.068281] ReiserFS: sda3: using ordered data mode
[   57.071275] ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   57.072868] ReiserFS: sda3: checking transaction log (sda3)
[   57.099334] ReiserFS: sda3: Using r5 hash to sort names
[   57.099415] VFS: Mounted root (reiserfs filesystem) readonly.
[   57.099484] Freeing unused kernel memory: 192k freed
[   59.284316] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   59.284339] sr 0:0:3:0: Attached scsi generic sg1 type 5
[   59.319755] ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
[   59.398651] libata version 3.00 loaded.
[   59.500592] usbcore: registered new interface driver usbfs
[   59.500623] usbcore: registered new interface driver hub
[   59.530833] usbcore: registered new device driver usb
[   59.676096] input: Power Button (FF) as /class/input/input2
[   59.677104] USB Universal Host Controller Interface driver v3.0
[   59.688607] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fd400000-fd4007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   59.700544] ACPI: Power Button (FF) [PWRF]
[   59.700633] input: Power Button (CM) as /class/input/input3
[   59.720540] ACPI: Power Button (CM) [PWRB]
[   59.720617] input: Sleep Button (CM) as /class/input/input4
[   59.759265] sata_sil24 0000:00:0c.0: version 1.1
[   59.759287] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   59.759606] PCI: Disallowing DAC for device 0000:00:0c.0
[   59.760618] ACPI: Sleep Button (CM) [SLPB]
[   59.779041] scsi1 : sata_sil24
[   59.800462] scsi2 : sata_sil24
[   59.822270] scsi3 : sata_sil24
[   59.832388] scsi4 : sata_sil24
[   59.832473] ata1: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
[   59.832477] ata2: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[   59.832480] ata3: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[   59.832484] ata4: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[   60.346837] input: PC Speaker as /class/input/input5
[   60.504139] Floppy drive(s): fd0 is 1.44M
[   60.521457] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   60.521575] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   60.524072] FDC 0 is a post-1991 82077
[   61.028170] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
[   62.031786] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   62.031931] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[   62.032124] ata1.00: hard resetting link
[   62.351844] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   62.351851] ata1.01: hard resetting link
[   62.671742] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.671745] ata1.02: hard resetting link
[   62.991645] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.991647] ata1.03: hard resetting link
[   63.311554] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   63.311561] ata1.04: hard resetting link
[   63.631453] ata1.04: SATA link down (SStatus 0 SControl 320)
[   63.631456] ata1.05: hard resetting link
[   63.951352] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   63.951355] ata1.06: hard resetting link
[   64.272205] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   64.273279] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.273282] ata1.00: 586072368 sectors, multi 16: LBA48 
[   64.273285] ata1.00: applying bridge limits
[   64.274423] ata1.00: configured for UDMA/100
[   64.276119] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.276122] ata1.01: 586072368 sectors, multi 0: LBA48 
[   64.276125] ata1.01: applying bridge limits
[   64.277264] ata1.01: configured for UDMA/100
[   64.323947] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.323950] ata1.02: 586072368 sectors, multi 0: LBA48 
[   64.323952] ata1.02: applying bridge limits
[   64.382089] ata1.02: configured for UDMA/100
[   64.426133] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.426136] ata1.03: 586072368 sectors, multi 0: LBA48 
[   64.426138] ata1.03: applying bridge limits
[   64.484410] ata1.03: configured for UDMA/100
[   64.484478] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[   64.484480] ata1.05: 640 sectors, multi 1: LBA 
[   64.484486] ata1.05: device is on DMA blacklist, disabling DMA
[   64.484575] ata1.05: configured for PIO4
[   64.484615] ata1: EH complete
[   66.562409] ata2: SATA link down (SStatus 0 SControl 0)
[   68.641778] ata3: SATA link down (SStatus 0 SControl 0)
[   70.721147] ata4: SATA link down (SStatus 0 SControl 0)
[   70.721260] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.721669] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.721680] sd 1:0:0:0: [sdb] Write Protect is off
[   70.721683] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.721695] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.721740] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.721747] sd 1:0:0:0: [sdb] Write Protect is off
[   70.721750] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.721761] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.721765]  sdb: sdb1
[   70.728578] sd 1:0:0:0: [sdb] Attached SCSI disk
[   70.728614] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   70.729063] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.729336] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.729343] sd 1:1:0:0: [sdc] Write Protect is off
[   70.729346] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.729357] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.729388] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.729395] sd 1:1:0:0: [sdc] Write Protect is off
[   70.729398] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.729409] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.729411]  sdc: sdc1
[   70.751335] sd 1:1:0:0: [sdc] Attached SCSI disk
[   70.751366] sd 1:1:0:0: Attached scsi generic sg3 type 0
[   70.751842] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.751903] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.751911] sd 1:2:0:0: [sdd] Write Protect is off
[   70.751913] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.751924] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.751953] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.751960] sd 1:2:0:0: [sdd] Write Protect is off
[   70.751963] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.751974] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.751977]  sdd: sdd1
[   70.767637] sd 1:2:0:0: [sdd] Attached SCSI disk
[   70.767670] sd 1:2:0:0: Attached scsi generic sg4 type 0
[   70.767716] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.767775] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.767782] sd 1:3:0:0: [sde] Write Protect is off
[   70.767785] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.767796] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.768539] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.768546] sd 1:3:0:0: [sde] Write Protect is off
[   70.768549] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.768560] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.768563]  sde: sde1
[   70.785093] sd 1:3:0:0: [sde] Attached SCSI disk
[   70.785128] sd 1:3:0:0: Attached scsi generic sg5 type 0
[   70.785174] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.785234] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.785241] sd 1:5:0:0: [sdf] Write Protect is off
[   70.785244] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.785255] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.785284] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.785291] sd 1:5:0:0: [sdf] Write Protect is off
[   70.785293] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.785304] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.785307]  sdf: unknown partition table
[   70.786159] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.786191] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.786363] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   70.786553] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   70.786744] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
[   70.786795] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   70.797142] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   70.797280] usb usb1: configuration #1 chosen from 1 choice
[   70.797308] hub 1-0:1.0: USB hub found
[   70.797317] hub 1-0:1.0: 8 ports detected
[   70.901323] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.901336] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.901363] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[   70.901386] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.901506] usb usb2: configuration #1 chosen from 1 choice
[   70.901531] hub 2-0:1.0: USB hub found
[   70.901539] hub 2-0:1.0: 2 ports detected
[   71.005191] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   71.005204] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   71.005229] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[   71.005252] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   71.005373] usb usb3: configuration #1 chosen from 1 choice
[   71.005398] hub 3-0:1.0: USB hub found
[   71.005405] hub 3-0:1.0: 2 ports detected
[   71.109172] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   71.109185] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   71.109211] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[   71.109235] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   71.109351] usb usb4: configuration #1 chosen from 1 choice
[   71.109376] hub 4-0:1.0: USB hub found
[   71.109383] hub 4-0:1.0: 2 ports detected
[   71.213117] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   71.213130] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   71.213155] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[   71.213179] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   71.213299] usb usb5: configuration #1 chosen from 1 choice
[   71.213325] hub 5-0:1.0: USB hub found
[   71.213332] hub 5-0:1.0: 2 ports detected
[   71.317585] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.319838] Audigy2 value: Special config.
[   73.765264] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.765268] Copyright (c) 1999-2006 Intel Corporation.
[   73.765309] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.765314] PCI: Disallowing DAC for device 0000:00:0e.0
[   74.025736] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   74.201234] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   74.355702] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   74.355715] ReiserFS: hdb1: using ordered data mode
[   74.392680] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.394057] ReiserFS: hdb1: checking transaction log (hdb1)
[   74.489291] ReiserFS: hdb1: Using r5 hash to sort names
[   74.553988] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   74.553998] ReiserFS: hda2: using ordered data mode
[   74.558818] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.560151] ReiserFS: hda2: checking transaction log (hda2)
[   74.623128] ReiserFS: hda2: Using r5 hash to sort names
[   80.456682] hda: UDMA/100 mode selected
[   80.460729] hdb: UDMA/133 mode selected
[   80.515263] hdc: UDMA/33 mode selected
[   80.532803] hdd: UDMA/33 mode selected
[   83.053804] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   87.342494] w83627hf: Found W83697HF chip at 0x290

--------------080405040801090803040005
Content-Type: text/plain;
 name="2_PowerOnOffTwice.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2_PowerOnOffTwice.log"

5 wanted PIO255(auto-tune) selected PIO4
[   43.645778] hda: UDMA/100 mode selected
[   43.646122] hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   43.646215] hdb: UDMA/133 mode selected
[   43.646398] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   43.646550] Probing IDE interface ide1...
[   44.565173] hdd: ASUS DVD-E616P2, ATAPI CD/DVD-ROM drive
[   45.348936] hdc: ASUS DRW-0402P/D, ATAPI CD/DVD-ROM drive
[   45.349107] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   45.349192] hdc: UDMA/33 mode selected
[   45.349311] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   45.349499] hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
[   45.349567] hdd: UDMA/33 mode selected
[   45.349873] ide1 at 0x170-0x177,0x376 on irq 15
[   45.350107] Probing IDE interface ide2...
[   45.916663] Probing IDE interface ide3...
[   46.484512] hda: max request size: 512KiB
[   46.485016] hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
[   46.485278] hda: cache flushes supported
[   46.485354]  hda: hda1 hda2
[   46.494758] hdb: max request size: 512KiB
[   46.502076] hdb: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63
[   46.502219] hdb: cache flushes not supported
[   46.502288]  hdb: hdb1
[   46.516013] hdc: ATAPI 47X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache
[   46.516295] Uniform CD-ROM driver Revision: 3.20
[   47.825381] hdd: ATAPI 48X DVD-ROM drive, 512kB Cache
[   47.836721] ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
[   53.046505] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   53.046507]         <Adaptec 29160N Ultra160 SCSI adapter>
[   53.046508]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   53.046510] 
[   53.050435] scsi 0:0:0:0: Direct-Access     SEAGATE  ST318452LW       0004 PQ: 0 ANSI: 3
[   53.050509] scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
[   53.050608]  target0:0:0: Beginning Domain Validation
[   53.058792]  target0:0:0: wide asynchronous
[   53.064974]  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
[   53.075742]  target0:0:0: Ending Domain Validation
[   53.598425] scsi 0:0:3:0: CD-ROM            YAMAHA   CRW8824S         1.00 PQ: 0 ANSI: 2
[   53.598499]  target0:0:3: Beginning Domain Validation
[   53.611738]  target0:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
[   53.619071]  target0:0:3: Domain Validation skipping write tests
[   53.619127]  target0:0:3: Ending Domain Validation
[   56.438680] Driver 'sd' needs updating - please use bus_type methods
[   56.439575] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   56.440757] sd 0:0:0:0: [sda] Write Protect is off
[   56.440811] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   56.442520] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   56.443360] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   56.444542] sd 0:0:0:0: [sda] Write Protect is off
[   56.444596] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   56.446306] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   56.446375]  sda: sda1 sda2 sda3
[   56.451055] sd 0:0:0:0: [sda] Attached SCSI disk
[   56.451117] Driver 'sr' needs updating - please use bus_type methods
[   56.486032] sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
[   56.486132] sr 0:0:3:0: Attached scsi CD-ROM sr0
[   56.486199] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   56.486617] serio: i8042 KBD port at 0x60,0x64 irq 1
[   56.486674] serio: i8042 AUX port at 0x60,0x64 irq 12
[   56.486836] mice: PS/2 mouse device common for all mice
[   56.516687] input: AT Translated Set 2 keyboard as /class/input/input0
[   56.544551] TCP cubic registered
[   56.544609] NET: Registered protocol family 1
[   56.544673] NET: Registered protocol family 17
[   56.544759] NET: Registered protocol family 33
[   56.544953] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   56.951406] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[   57.068218] ReiserFS: sda3: found reiserfs format "3.6" with standard journal
[   57.068281] ReiserFS: sda3: using ordered data mode
[   57.071275] ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   57.072868] ReiserFS: sda3: checking transaction log (sda3)
[   57.099334] ReiserFS: sda3: Using r5 hash to sort names
[   57.099415] VFS: Mounted root (reiserfs filesystem) readonly.
[   57.099484] Freeing unused kernel memory: 192k freed
[   59.284316] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   59.284339] sr 0:0:3:0: Attached scsi generic sg1 type 5
[   59.319755] ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
[   59.398651] libata version 3.00 loaded.
[   59.500592] usbcore: registered new interface driver usbfs
[   59.500623] usbcore: registered new interface driver hub
[   59.530833] usbcore: registered new device driver usb
[   59.676096] input: Power Button (FF) as /class/input/input2
[   59.677104] USB Universal Host Controller Interface driver v3.0
[   59.688607] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fd400000-fd4007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   59.700544] ACPI: Power Button (FF) [PWRF]
[   59.700633] input: Power Button (CM) as /class/input/input3
[   59.720540] ACPI: Power Button (CM) [PWRB]
[   59.720617] input: Sleep Button (CM) as /class/input/input4
[   59.759265] sata_sil24 0000:00:0c.0: version 1.1
[   59.759287] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   59.759606] PCI: Disallowing DAC for device 0000:00:0c.0
[   59.760618] ACPI: Sleep Button (CM) [SLPB]
[   59.779041] scsi1 : sata_sil24
[   59.800462] scsi2 : sata_sil24
[   59.822270] scsi3 : sata_sil24
[   59.832388] scsi4 : sata_sil24
[   59.832473] ata1: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
[   59.832477] ata2: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[   59.832480] ata3: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[   59.832484] ata4: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[   60.346837] input: PC Speaker as /class/input/input5
[   60.504139] Floppy drive(s): fd0 is 1.44M
[   60.521457] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   60.521575] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   60.524072] FDC 0 is a post-1991 82077
[   61.028170] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
[   62.031786] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   62.031931] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[   62.032124] ata1.00: hard resetting link
[   62.351844] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   62.351851] ata1.01: hard resetting link
[   62.671742] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.671745] ata1.02: hard resetting link
[   62.991645] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.991647] ata1.03: hard resetting link
[   63.311554] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   63.311561] ata1.04: hard resetting link
[   63.631453] ata1.04: SATA link down (SStatus 0 SControl 320)
[   63.631456] ata1.05: hard resetting link
[   63.951352] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   63.951355] ata1.06: hard resetting link
[   64.272205] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   64.273279] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.273282] ata1.00: 586072368 sectors, multi 16: LBA48 
[   64.273285] ata1.00: applying bridge limits
[   64.274423] ata1.00: configured for UDMA/100
[   64.276119] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.276122] ata1.01: 586072368 sectors, multi 0: LBA48 
[   64.276125] ata1.01: applying bridge limits
[   64.277264] ata1.01: configured for UDMA/100
[   64.323947] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.323950] ata1.02: 586072368 sectors, multi 0: LBA48 
[   64.323952] ata1.02: applying bridge limits
[   64.382089] ata1.02: configured for UDMA/100
[   64.426133] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.426136] ata1.03: 586072368 sectors, multi 0: LBA48 
[   64.426138] ata1.03: applying bridge limits
[   64.484410] ata1.03: configured for UDMA/100
[   64.484478] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[   64.484480] ata1.05: 640 sectors, multi 1: LBA 
[   64.484486] ata1.05: device is on DMA blacklist, disabling DMA
[   64.484575] ata1.05: configured for PIO4
[   64.484615] ata1: EH complete
[   66.562409] ata2: SATA link down (SStatus 0 SControl 0)
[   68.641778] ata3: SATA link down (SStatus 0 SControl 0)
[   70.721147] ata4: SATA link down (SStatus 0 SControl 0)
[   70.721260] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.721669] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.721680] sd 1:0:0:0: [sdb] Write Protect is off
[   70.721683] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.721695] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.721740] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.721747] sd 1:0:0:0: [sdb] Write Protect is off
[   70.721750] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.721761] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.721765]  sdb: sdb1
[   70.728578] sd 1:0:0:0: [sdb] Attached SCSI disk
[   70.728614] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   70.729063] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.729336] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.729343] sd 1:1:0:0: [sdc] Write Protect is off
[   70.729346] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.729357] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.729388] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.729395] sd 1:1:0:0: [sdc] Write Protect is off
[   70.729398] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.729409] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.729411]  sdc: sdc1
[   70.751335] sd 1:1:0:0: [sdc] Attached SCSI disk
[   70.751366] sd 1:1:0:0: Attached scsi generic sg3 type 0
[   70.751842] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.751903] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.751911] sd 1:2:0:0: [sdd] Write Protect is off
[   70.751913] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.751924] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.751953] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.751960] sd 1:2:0:0: [sdd] Write Protect is off
[   70.751963] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.751974] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.751977]  sdd: sdd1
[   70.767637] sd 1:2:0:0: [sdd] Attached SCSI disk
[   70.767670] sd 1:2:0:0: Attached scsi generic sg4 type 0
[   70.767716] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.767775] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.767782] sd 1:3:0:0: [sde] Write Protect is off
[   70.767785] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.767796] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.768539] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.768546] sd 1:3:0:0: [sde] Write Protect is off
[   70.768549] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.768560] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.768563]  sde: sde1
[   70.785093] sd 1:3:0:0: [sde] Attached SCSI disk
[   70.785128] sd 1:3:0:0: Attached scsi generic sg5 type 0
[   70.785174] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.785234] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.785241] sd 1:5:0:0: [sdf] Write Protect is off
[   70.785244] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.785255] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.785284] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.785291] sd 1:5:0:0: [sdf] Write Protect is off
[   70.785293] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.785304] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.785307]  sdf: unknown partition table
[   70.786159] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.786191] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.786363] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   70.786553] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   70.786744] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
[   70.786795] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   70.797142] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   70.797280] usb usb1: configuration #1 chosen from 1 choice
[   70.797308] hub 1-0:1.0: USB hub found
[   70.797317] hub 1-0:1.0: 8 ports detected
[   70.901323] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.901336] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.901363] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[   70.901386] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.901506] usb usb2: configuration #1 chosen from 1 choice
[   70.901531] hub 2-0:1.0: USB hub found
[   70.901539] hub 2-0:1.0: 2 ports detected
[   71.005191] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   71.005204] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   71.005229] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[   71.005252] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   71.005373] usb usb3: configuration #1 chosen from 1 choice
[   71.005398] hub 3-0:1.0: USB hub found
[   71.005405] hub 3-0:1.0: 2 ports detected
[   71.109172] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   71.109185] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   71.109211] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[   71.109235] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   71.109351] usb usb4: configuration #1 chosen from 1 choice
[   71.109376] hub 4-0:1.0: USB hub found
[   71.109383] hub 4-0:1.0: 2 ports detected
[   71.213117] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   71.213130] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   71.213155] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[   71.213179] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   71.213299] usb usb5: configuration #1 chosen from 1 choice
[   71.213325] hub 5-0:1.0: USB hub found
[   71.213332] hub 5-0:1.0: 2 ports detected
[   71.317585] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.319838] Audigy2 value: Special config.
[   73.765264] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.765268] Copyright (c) 1999-2006 Intel Corporation.
[   73.765309] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.765314] PCI: Disallowing DAC for device 0000:00:0e.0
[   74.025736] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   74.201234] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   74.355702] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   74.355715] ReiserFS: hdb1: using ordered data mode
[   74.392680] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.394057] ReiserFS: hdb1: checking transaction log (hdb1)
[   74.489291] ReiserFS: hdb1: Using r5 hash to sort names
[   74.553988] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   74.553998] ReiserFS: hda2: using ordered data mode
[   74.558818] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.560151] ReiserFS: hda2: checking transaction log (hda2)
[   74.623128] ReiserFS: hda2: Using r5 hash to sort names
[   80.456682] hda: UDMA/100 mode selected
[   80.460729] hdb: UDMA/133 mode selected
[   80.515263] hdc: UDMA/33 mode selected
[   80.532803] hdd: UDMA/33 mode selected
[   83.053804] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   87.342494] w83627hf: Found W83697HF chip at 0x290
[  159.125858] ata1.00: failed to read SCR 1 (Emask=0x40)
[  159.125863] ata1.01: failed to read SCR 1 (Emask=0x40)
[  159.125866] ata1.02: failed to read SCR 1 (Emask=0x40)
[  159.125869] ata1.03: failed to read SCR 1 (Emask=0x40)
[  159.125871] ata1.04: failed to read SCR 1 (Emask=0x40)
[  159.125874] ata1.05: failed to read SCR 1 (Emask=0x40)
[  159.125876] ata1.06: failed to read SCR 1 (Emask=0x40)
[  159.125880] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  159.125883] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  159.125886] ata1: SError: { 10B8B }
[  159.125890] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125895] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125899] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125904] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125908] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125912] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125917] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125923] ata1.15: hard resetting link
[  164.216778] ata1.15: SATA link down (SStatus 1 SControl 0)
[  164.468696] ata1.15: qc timeout (cmd 0xe4)
[  164.468703] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  164.468706] ata1.15: PMP revalidation failed (errno=-5)
[  164.468708] ata1.15: retrying hardreset in 5 secs
[  169.471177] ata1.15: hard resetting link
[  174.565637] ata1.15: SATA link down (SStatus 1 SControl 0)
[  174.817555] ata1.15: qc timeout (cmd 0xe4)
[  174.817562] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  174.817565] ata1.15: PMP revalidation failed (errno=-5)
[  174.817568] ata1.15: limiting SATA link speed to 1.5 Gbps
[  174.817570] ata1.15: retrying hardreset in 5 secs
[  179.820043] ata1.15: hard resetting link
[  182.019380] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  182.019590] ata1.00: hard resetting link
[  182.339460] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  182.339463] ata1.01: hard resetting link
[  182.659362] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.659365] ata1.02: hard resetting link
[  182.979265] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.979269] ata1.03: hard resetting link
[  183.299169] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  183.299172] ata1.04: hard resetting link
[  183.619071] ata1.04: SATA link down (SStatus 0 SControl 310)
[  183.619074] ata1.05: hard resetting link
[  183.938971] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  183.938975] ata1.06: hard resetting link
[  184.258874] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  184.261106] ata1.00: configured for UDMA/100
[  184.263303] ata1.01: configured for UDMA/100
[  184.263398] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  184.263401] ata1.02: revalidation failed (errno=-5)
[  184.263406] ata1.15: hard resetting link
[  186.462034] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  186.462308] ata1.00: hard resetting link
[  186.782113] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  186.782117] ata1.01: hard resetting link
[  187.102015] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.102018] ata1.02: hard resetting link
[  187.421918] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.421922] ata1.03: hard resetting link
[  187.741820] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.741823] ata1.04: hard resetting link
[  188.061723] ata1.04: SATA link down (SStatus 0 SControl 310)
[  188.061727] ata1.05: hard resetting link
[  188.381625] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  188.381628] ata1.06: hard resetting link
[  188.701528] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  188.703706] ata1.00: configured for UDMA/100
[  188.705935] ata1.01: configured for UDMA/100
[  188.811817] ata1.02: configured for UDMA/100
[  188.915919] ata1.03: configured for UDMA/100
[  188.916051] ata1.05: device is on DMA blacklist, disabling DMA
[  188.916182] ata1.05: configured for PIO4
[  188.916453] ata1: EH complete
[  188.916481] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916492] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916496] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916508] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916524] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916532] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916535] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916546] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916560] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916567] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916570] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916581] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916595] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916602] sd 1:3:0:0: [sde] Write Protect is off
[  188.916605] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916616] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916629] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916637] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916640] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916651] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  188.916664] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916671] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916674] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916686] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916698] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916705] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916708] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916720] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916732] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916739] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916742] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916753] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916766] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916773] sd 1:3:0:0: [sde] Write Protect is off
[  188.916776] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916787] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916799] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916807] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916810] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916821] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  233.874452] ata1.00: failed to read SCR 1 (Emask=0x40)
[  233.874458] ata1.01: failed to read SCR 1 (Emask=0x40)
[  233.874462] ata1.02: failed to read SCR 1 (Emask=0x40)
[  233.874465] ata1.03: failed to read SCR 1 (Emask=0x40)
[  233.874468] ata1.04: failed to read SCR 1 (Emask=0x40)
[  233.874471] ata1.05: failed to read SCR 1 (Emask=0x40)
[  233.874474] ata1.06: failed to read SCR 1 (Emask=0x40)
[  233.874478] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  233.874482] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  233.874486] ata1: SError: { 10B8B }
[  233.874490] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874495] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874501] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874506] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874511] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874516] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874521] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874529] ata1.15: hard resetting link
[  238.966100] ata1.15: SATA link down (SStatus 1 SControl 10)
[  239.218017] ata1.15: qc timeout (cmd 0xe4)
[  239.218026] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  239.218029] ata1.15: PMP revalidation failed (errno=-5)
[  239.218032] ata1.15: retrying hardreset in 5 secs
[  244.220499] ata1.15: hard resetting link
[  249.314958] ata1.15: SATA link down (SStatus 1 SControl 10)
[  249.566876] ata1.15: qc timeout (cmd 0xe4)
[  249.566883] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  249.566886] ata1.15: PMP revalidation failed (errno=-5)
[  249.566890] ata1.15: retrying hardreset in 5 secs
[  254.569359] ata1.15: hard resetting link
[  256.768701] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  256.768897] ata1.00: hard resetting link
[  257.088783] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  257.088787] ata1.01: hard resetting link
[  257.408684] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.408688] ata1.02: hard resetting link
[  257.728587] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.728591] ata1.03: hard resetting link
[  258.048491] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  258.048495] ata1.04: hard resetting link
[  258.368394] ata1.04: SATA link down (SStatus 0 SControl 310)
[  258.368397] ata1.05: hard resetting link
[  258.688294] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  258.688298] ata1.06: hard resetting link
[  259.008199] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  259.008295] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  259.008299] ata1.00: revalidation failed (errno=-5)
[  259.008304] ata1.15: hard resetting link
[  261.207356] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  261.207634] ata1.00: hard resetting link
[  261.527434] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  261.527439] ata1.01: hard resetting link
[  261.847337] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  261.847340] ata1.02: hard resetting link
[  262.167238] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.167242] ata1.03: hard resetting link
[  262.487142] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.487146] ata1.04: hard resetting link
[  262.807046] ata1.04: SATA link down (SStatus 0 SControl 310)
[  262.807050] ata1.05: hard resetting link
[  263.126946] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  263.126950] ata1.06: hard resetting link
[  263.446852] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  263.449093] ata1.00: configured for UDMA/100
[  263.451311] ata1.01: configured for UDMA/100
[  263.556976] ata1.02: configured for UDMA/100
[  263.658661] ata1.03: configured for UDMA/100
[  263.658793] ata1.05: device is on DMA blacklist, disabling DMA
[  263.658923] ata1.05: configured for PIO4
[  263.659192] ata1: EH complete
[  263.659218] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659229] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659232] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659245] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659260] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659267] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659270] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659281] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659295] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659303] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659305] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659317] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659330] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659337] sd 1:3:0:0: [sde] Write Protect is off
[  263.659340] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659351] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659365] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659372] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659375] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659386] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  263.659399] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659407] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659409] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659421] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659433] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659440] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659443] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659454] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659467] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659474] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659477] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659488] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659500] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659508] sd 1:3:0:0: [sde] Write Protect is off
[  263.659511] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659522] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659534] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659541] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659544] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659555] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

--------------080405040801090803040005
Content-Type: text/plain;
 name="3_PlugUnplug.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3_PlugUnplug.log"

128@0xfd900000 port 0xfd800000 irq 17
[   59.832477] ata2: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[   59.832480] ata3: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[   59.832484] ata4: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[   60.346837] input: PC Speaker as /class/input/input5
[   60.504139] Floppy drive(s): fd0 is 1.44M
[   60.521457] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   60.521575] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   60.524072] FDC 0 is a post-1991 82077
[   61.028170] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
[   62.031786] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   62.031931] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[   62.032124] ata1.00: hard resetting link
[   62.351844] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   62.351851] ata1.01: hard resetting link
[   62.671742] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.671745] ata1.02: hard resetting link
[   62.991645] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.991647] ata1.03: hard resetting link
[   63.311554] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   63.311561] ata1.04: hard resetting link
[   63.631453] ata1.04: SATA link down (SStatus 0 SControl 320)
[   63.631456] ata1.05: hard resetting link
[   63.951352] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   63.951355] ata1.06: hard resetting link
[   64.272205] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   64.273279] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.273282] ata1.00: 586072368 sectors, multi 16: LBA48 
[   64.273285] ata1.00: applying bridge limits
[   64.274423] ata1.00: configured for UDMA/100
[   64.276119] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.276122] ata1.01: 586072368 sectors, multi 0: LBA48 
[   64.276125] ata1.01: applying bridge limits
[   64.277264] ata1.01: configured for UDMA/100
[   64.323947] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.323950] ata1.02: 586072368 sectors, multi 0: LBA48 
[   64.323952] ata1.02: applying bridge limits
[   64.382089] ata1.02: configured for UDMA/100
[   64.426133] ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.426136] ata1.03: 586072368 sectors, multi 0: LBA48 
[   64.426138] ata1.03: applying bridge limits
[   64.484410] ata1.03: configured for UDMA/100
[   64.484478] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[   64.484480] ata1.05: 640 sectors, multi 1: LBA 
[   64.484486] ata1.05: device is on DMA blacklist, disabling DMA
[   64.484575] ata1.05: configured for PIO4
[   64.484615] ata1: EH complete
[   66.562409] ata2: SATA link down (SStatus 0 SControl 0)
[   68.641778] ata3: SATA link down (SStatus 0 SControl 0)
[   70.721147] ata4: SATA link down (SStatus 0 SControl 0)
[   70.721260] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.721669] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.721680] sd 1:0:0:0: [sdb] Write Protect is off
[   70.721683] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.721695] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.721740] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.721747] sd 1:0:0:0: [sdb] Write Protect is off
[   70.721750] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.721761] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.721765]  sdb: sdb1
[   70.728578] sd 1:0:0:0: [sdb] Attached SCSI disk
[   70.728614] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   70.729063] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.729336] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.729343] sd 1:1:0:0: [sdc] Write Protect is off
[   70.729346] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.729357] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.729388] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.729395] sd 1:1:0:0: [sdc] Write Protect is off
[   70.729398] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.729409] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.729411]  sdc: sdc1
[   70.751335] sd 1:1:0:0: [sdc] Attached SCSI disk
[   70.751366] sd 1:1:0:0: Attached scsi generic sg3 type 0
[   70.751842] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.751903] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.751911] sd 1:2:0:0: [sdd] Write Protect is off
[   70.751913] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.751924] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.751953] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.751960] sd 1:2:0:0: [sdd] Write Protect is off
[   70.751963] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.751974] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.751977]  sdd: sdd1
[   70.767637] sd 1:2:0:0: [sdd] Attached SCSI disk
[   70.767670] sd 1:2:0:0: Attached scsi generic sg4 type 0
[   70.767716] scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.767775] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.767782] sd 1:3:0:0: [sde] Write Protect is off
[   70.767785] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.767796] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.768539] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.768546] sd 1:3:0:0: [sde] Write Protect is off
[   70.768549] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.768560] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.768563]  sde: sde1
[   70.785093] sd 1:3:0:0: [sde] Attached SCSI disk
[   70.785128] sd 1:3:0:0: Attached scsi generic sg5 type 0
[   70.785174] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.785234] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.785241] sd 1:5:0:0: [sdf] Write Protect is off
[   70.785244] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.785255] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.785284] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.785291] sd 1:5:0:0: [sdf] Write Protect is off
[   70.785293] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.785304] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.785307]  sdf: unknown partition table
[   70.786159] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.786191] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.786363] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   70.786553] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   70.786744] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
[   70.786795] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   70.797142] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   70.797280] usb usb1: configuration #1 chosen from 1 choice
[   70.797308] hub 1-0:1.0: USB hub found
[   70.797317] hub 1-0:1.0: 8 ports detected
[   70.901323] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.901336] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.901363] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[   70.901386] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.901506] usb usb2: configuration #1 chosen from 1 choice
[   70.901531] hub 2-0:1.0: USB hub found
[   70.901539] hub 2-0:1.0: 2 ports detected
[   71.005191] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   71.005204] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   71.005229] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[   71.005252] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   71.005373] usb usb3: configuration #1 chosen from 1 choice
[   71.005398] hub 3-0:1.0: USB hub found
[   71.005405] hub 3-0:1.0: 2 ports detected
[   71.109172] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   71.109185] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   71.109211] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[   71.109235] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   71.109351] usb usb4: configuration #1 chosen from 1 choice
[   71.109376] hub 4-0:1.0: USB hub found
[   71.109383] hub 4-0:1.0: 2 ports detected
[   71.213117] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   71.213130] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   71.213155] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[   71.213179] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   71.213299] usb usb5: configuration #1 chosen from 1 choice
[   71.213325] hub 5-0:1.0: USB hub found
[   71.213332] hub 5-0:1.0: 2 ports detected
[   71.317585] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.319838] Audigy2 value: Special config.
[   73.765264] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.765268] Copyright (c) 1999-2006 Intel Corporation.
[   73.765309] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.765314] PCI: Disallowing DAC for device 0000:00:0e.0
[   74.025736] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   74.201234] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   74.355702] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   74.355715] ReiserFS: hdb1: using ordered data mode
[   74.392680] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.394057] ReiserFS: hdb1: checking transaction log (hdb1)
[   74.489291] ReiserFS: hdb1: Using r5 hash to sort names
[   74.553988] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   74.553998] ReiserFS: hda2: using ordered data mode
[   74.558818] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.560151] ReiserFS: hda2: checking transaction log (hda2)
[   74.623128] ReiserFS: hda2: Using r5 hash to sort names
[   80.456682] hda: UDMA/100 mode selected
[   80.460729] hdb: UDMA/133 mode selected
[   80.515263] hdc: UDMA/33 mode selected
[   80.532803] hdd: UDMA/33 mode selected
[   83.053804] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   87.342494] w83627hf: Found W83697HF chip at 0x290
[  159.125858] ata1.00: failed to read SCR 1 (Emask=0x40)
[  159.125863] ata1.01: failed to read SCR 1 (Emask=0x40)
[  159.125866] ata1.02: failed to read SCR 1 (Emask=0x40)
[  159.125869] ata1.03: failed to read SCR 1 (Emask=0x40)
[  159.125871] ata1.04: failed to read SCR 1 (Emask=0x40)
[  159.125874] ata1.05: failed to read SCR 1 (Emask=0x40)
[  159.125876] ata1.06: failed to read SCR 1 (Emask=0x40)
[  159.125880] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  159.125883] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  159.125886] ata1: SError: { 10B8B }
[  159.125890] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125895] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125899] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125904] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125908] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125912] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125917] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125923] ata1.15: hard resetting link
[  164.216778] ata1.15: SATA link down (SStatus 1 SControl 0)
[  164.468696] ata1.15: qc timeout (cmd 0xe4)
[  164.468703] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  164.468706] ata1.15: PMP revalidation failed (errno=-5)
[  164.468708] ata1.15: retrying hardreset in 5 secs
[  169.471177] ata1.15: hard resetting link
[  174.565637] ata1.15: SATA link down (SStatus 1 SControl 0)
[  174.817555] ata1.15: qc timeout (cmd 0xe4)
[  174.817562] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  174.817565] ata1.15: PMP revalidation failed (errno=-5)
[  174.817568] ata1.15: limiting SATA link speed to 1.5 Gbps
[  174.817570] ata1.15: retrying hardreset in 5 secs
[  179.820043] ata1.15: hard resetting link
[  182.019380] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  182.019590] ata1.00: hard resetting link
[  182.339460] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  182.339463] ata1.01: hard resetting link
[  182.659362] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.659365] ata1.02: hard resetting link
[  182.979265] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.979269] ata1.03: hard resetting link
[  183.299169] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  183.299172] ata1.04: hard resetting link
[  183.619071] ata1.04: SATA link down (SStatus 0 SControl 310)
[  183.619074] ata1.05: hard resetting link
[  183.938971] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  183.938975] ata1.06: hard resetting link
[  184.258874] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  184.261106] ata1.00: configured for UDMA/100
[  184.263303] ata1.01: configured for UDMA/100
[  184.263398] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  184.263401] ata1.02: revalidation failed (errno=-5)
[  184.263406] ata1.15: hard resetting link
[  186.462034] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  186.462308] ata1.00: hard resetting link
[  186.782113] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  186.782117] ata1.01: hard resetting link
[  187.102015] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.102018] ata1.02: hard resetting link
[  187.421918] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.421922] ata1.03: hard resetting link
[  187.741820] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.741823] ata1.04: hard resetting link
[  188.061723] ata1.04: SATA link down (SStatus 0 SControl 310)
[  188.061727] ata1.05: hard resetting link
[  188.381625] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  188.381628] ata1.06: hard resetting link
[  188.701528] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  188.703706] ata1.00: configured for UDMA/100
[  188.705935] ata1.01: configured for UDMA/100
[  188.811817] ata1.02: configured for UDMA/100
[  188.915919] ata1.03: configured for UDMA/100
[  188.916051] ata1.05: device is on DMA blacklist, disabling DMA
[  188.916182] ata1.05: configured for PIO4
[  188.916453] ata1: EH complete
[  188.916481] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916492] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916496] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916508] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916524] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916532] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916535] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916546] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916560] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916567] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916570] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916581] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916595] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916602] sd 1:3:0:0: [sde] Write Protect is off
[  188.916605] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916616] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916629] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916637] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916640] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916651] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  188.916664] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916671] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916674] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916686] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916698] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916705] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916708] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916720] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916732] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916739] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916742] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916753] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916766] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916773] sd 1:3:0:0: [sde] Write Protect is off
[  188.916776] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916787] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916799] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916807] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916810] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916821] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  233.874452] ata1.00: failed to read SCR 1 (Emask=0x40)
[  233.874458] ata1.01: failed to read SCR 1 (Emask=0x40)
[  233.874462] ata1.02: failed to read SCR 1 (Emask=0x40)
[  233.874465] ata1.03: failed to read SCR 1 (Emask=0x40)
[  233.874468] ata1.04: failed to read SCR 1 (Emask=0x40)
[  233.874471] ata1.05: failed to read SCR 1 (Emask=0x40)
[  233.874474] ata1.06: failed to read SCR 1 (Emask=0x40)
[  233.874478] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  233.874482] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  233.874486] ata1: SError: { 10B8B }
[  233.874490] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874495] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874501] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874506] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874511] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874516] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874521] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874529] ata1.15: hard resetting link
[  238.966100] ata1.15: SATA link down (SStatus 1 SControl 10)
[  239.218017] ata1.15: qc timeout (cmd 0xe4)
[  239.218026] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  239.218029] ata1.15: PMP revalidation failed (errno=-5)
[  239.218032] ata1.15: retrying hardreset in 5 secs
[  244.220499] ata1.15: hard resetting link
[  249.314958] ata1.15: SATA link down (SStatus 1 SControl 10)
[  249.566876] ata1.15: qc timeout (cmd 0xe4)
[  249.566883] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  249.566886] ata1.15: PMP revalidation failed (errno=-5)
[  249.566890] ata1.15: retrying hardreset in 5 secs
[  254.569359] ata1.15: hard resetting link
[  256.768701] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  256.768897] ata1.00: hard resetting link
[  257.088783] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  257.088787] ata1.01: hard resetting link
[  257.408684] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.408688] ata1.02: hard resetting link
[  257.728587] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.728591] ata1.03: hard resetting link
[  258.048491] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  258.048495] ata1.04: hard resetting link
[  258.368394] ata1.04: SATA link down (SStatus 0 SControl 310)
[  258.368397] ata1.05: hard resetting link
[  258.688294] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  258.688298] ata1.06: hard resetting link
[  259.008199] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  259.008295] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  259.008299] ata1.00: revalidation failed (errno=-5)
[  259.008304] ata1.15: hard resetting link
[  261.207356] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  261.207634] ata1.00: hard resetting link
[  261.527434] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  261.527439] ata1.01: hard resetting link
[  261.847337] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  261.847340] ata1.02: hard resetting link
[  262.167238] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.167242] ata1.03: hard resetting link
[  262.487142] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.487146] ata1.04: hard resetting link
[  262.807046] ata1.04: SATA link down (SStatus 0 SControl 310)
[  262.807050] ata1.05: hard resetting link
[  263.126946] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  263.126950] ata1.06: hard resetting link
[  263.446852] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  263.449093] ata1.00: configured for UDMA/100
[  263.451311] ata1.01: configured for UDMA/100
[  263.556976] ata1.02: configured for UDMA/100
[  263.658661] ata1.03: configured for UDMA/100
[  263.658793] ata1.05: device is on DMA blacklist, disabling DMA
[  263.658923] ata1.05: configured for PIO4
[  263.659192] ata1: EH complete
[  263.659218] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659229] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659232] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659245] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659260] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659267] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659270] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659281] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659295] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659303] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659305] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659317] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659330] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659337] sd 1:3:0:0: [sde] Write Protect is off
[  263.659340] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659351] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659365] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659372] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659375] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659386] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  263.659399] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659407] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659409] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659421] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659433] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659440] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659443] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659454] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659467] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659474] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659477] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659488] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659500] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659508] sd 1:3:0:0: [sde] Write Protect is off
[  263.659511] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659522] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659534] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659541] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659544] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659555] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  337.619074] ata1.00: failed to read SCR 1 (Emask=0x40)
[  337.619079] ata1.01: failed to read SCR 1 (Emask=0x40)
[  337.619083] ata1.02: failed to read SCR 1 (Emask=0x40)
[  337.619086] ata1.03: failed to read SCR 1 (Emask=0x40)
[  337.619089] ata1.04: failed to read SCR 1 (Emask=0x40)
[  337.619092] ata1.05: failed to read SCR 1 (Emask=0x40)
[  337.619095] ata1.06: failed to read SCR 1 (Emask=0x40)
[  337.619099] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  337.619103] ata1.15: irq_stat 0x01940090, PHY RDY changed
[  337.619107] ata1: SError: { 10B8B }
[  337.619111] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619116] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619122] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619127] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619132] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619137] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619142] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619150] ata1.15: hard resetting link
[  339.695540] ata1.15: SATA link down (SStatus 0 SControl 10)
[  339.947457] ata1.15: qc timeout (cmd 0xe4)
[  339.947465] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  339.947469] ata1.15: PMP revalidation failed (errno=-5)
[  339.947472] ata1.15: retrying hardreset in 5 secs
[  344.949939] ata1.15: hard resetting link
[  347.029314] ata1.15: SATA link down (SStatus 0 SControl 10)
[  347.281232] ata1.15: qc timeout (cmd 0xe4)
[  347.281239] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  347.281242] ata1.15: PMP revalidation failed (errno=-5)
[  347.281246] ata1.15: retrying hardreset in 5 secs
[  352.283714] ata1.15: hard resetting link
[  356.250521] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  356.250717] ata1.00: hard resetting link
[  356.570601] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  356.570605] ata1.01: hard resetting link
[  356.890503] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  356.890507] ata1.02: hard resetting link
[  357.210406] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.210411] ata1.03: hard resetting link
[  357.530309] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.530313] ata1.04: hard resetting link
[  357.850212] ata1.04: SATA link down (SStatus 0 SControl 310)
[  357.850216] ata1.05: hard resetting link
[  358.170112] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  358.170116] ata1.06: hard resetting link
[  358.490020] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  358.492276] ata1.00: configured for UDMA/100
[  358.494506] ata1.01: configured for UDMA/100
[  358.595946] ata1.02: configured for UDMA/100
[  358.705215] ata1.03: configured for UDMA/100
[  358.705316] ata1.05: device is on DMA blacklist, disabling DMA
[  358.705472] ata1.05: configured for PIO4
[  358.705734] ata1: EH complete
[  358.705759] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705773] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705776] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705789] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705804] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705812] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705815] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.705827] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705841] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.705849] sd 1:2:0:0: [sdd] Write Protect is off
[  358.705852] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.705863] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705877] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.705885] sd 1:3:0:0: [sde] Write Protect is off
[  358.705888] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.705900] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705913] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.705921] sd 1:5:0:0: [sdf] Write Protect is off
[  358.705924] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.705936] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  358.705949] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705957] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705960] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705972] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705985] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705992] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705995] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.706007] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706020] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.706028] sd 1:2:0:0: [sdd] Write Protect is off
[  358.706030] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.706042] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706055] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.706063] sd 1:3:0:0: [sde] Write Protect is off
[  358.706066] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.706077] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706090] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.706098] sd 1:5:0:0: [sdf] Write Protect is off
[  358.706101] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.706112] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

--------------080405040801090803040005
Content-Type: text/plain;
 name="4_PowerOnOffTwice.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4_PowerOnOffTwice.log"

i 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.785234] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.785241] sd 1:5:0:0: [sdf] Write Protect is off
[   70.785244] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.785255] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.785284] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.785291] sd 1:5:0:0: [sdf] Write Protect is off
[   70.785293] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.785304] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.785307]  sdf: unknown partition table
[   70.786159] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.786191] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.786363] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   70.786553] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   70.786744] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
[   70.786795] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   70.797142] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   70.797280] usb usb1: configuration #1 chosen from 1 choice
[   70.797308] hub 1-0:1.0: USB hub found
[   70.797317] hub 1-0:1.0: 8 ports detected
[   70.901323] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.901336] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.901363] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[   70.901386] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.901506] usb usb2: configuration #1 chosen from 1 choice
[   70.901531] hub 2-0:1.0: USB hub found
[   70.901539] hub 2-0:1.0: 2 ports detected
[   71.005191] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   71.005204] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   71.005229] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[   71.005252] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   71.005373] usb usb3: configuration #1 chosen from 1 choice
[   71.005398] hub 3-0:1.0: USB hub found
[   71.005405] hub 3-0:1.0: 2 ports detected
[   71.109172] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   71.109185] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   71.109211] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[   71.109235] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   71.109351] usb usb4: configuration #1 chosen from 1 choice
[   71.109376] hub 4-0:1.0: USB hub found
[   71.109383] hub 4-0:1.0: 2 ports detected
[   71.213117] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   71.213130] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   71.213155] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[   71.213179] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   71.213299] usb usb5: configuration #1 chosen from 1 choice
[   71.213325] hub 5-0:1.0: USB hub found
[   71.213332] hub 5-0:1.0: 2 ports detected
[   71.317585] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.319838] Audigy2 value: Special config.
[   73.765264] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.765268] Copyright (c) 1999-2006 Intel Corporation.
[   73.765309] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.765314] PCI: Disallowing DAC for device 0000:00:0e.0
[   74.025736] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   74.201234] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   74.355702] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   74.355715] ReiserFS: hdb1: using ordered data mode
[   74.392680] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.394057] ReiserFS: hdb1: checking transaction log (hdb1)
[   74.489291] ReiserFS: hdb1: Using r5 hash to sort names
[   74.553988] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   74.553998] ReiserFS: hda2: using ordered data mode
[   74.558818] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.560151] ReiserFS: hda2: checking transaction log (hda2)
[   74.623128] ReiserFS: hda2: Using r5 hash to sort names
[   80.456682] hda: UDMA/100 mode selected
[   80.460729] hdb: UDMA/133 mode selected
[   80.515263] hdc: UDMA/33 mode selected
[   80.532803] hdd: UDMA/33 mode selected
[   83.053804] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   87.342494] w83627hf: Found W83697HF chip at 0x290
[  159.125858] ata1.00: failed to read SCR 1 (Emask=0x40)
[  159.125863] ata1.01: failed to read SCR 1 (Emask=0x40)
[  159.125866] ata1.02: failed to read SCR 1 (Emask=0x40)
[  159.125869] ata1.03: failed to read SCR 1 (Emask=0x40)
[  159.125871] ata1.04: failed to read SCR 1 (Emask=0x40)
[  159.125874] ata1.05: failed to read SCR 1 (Emask=0x40)
[  159.125876] ata1.06: failed to read SCR 1 (Emask=0x40)
[  159.125880] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  159.125883] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  159.125886] ata1: SError: { 10B8B }
[  159.125890] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125895] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125899] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125904] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125908] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125912] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125917] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125923] ata1.15: hard resetting link
[  164.216778] ata1.15: SATA link down (SStatus 1 SControl 0)
[  164.468696] ata1.15: qc timeout (cmd 0xe4)
[  164.468703] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  164.468706] ata1.15: PMP revalidation failed (errno=-5)
[  164.468708] ata1.15: retrying hardreset in 5 secs
[  169.471177] ata1.15: hard resetting link
[  174.565637] ata1.15: SATA link down (SStatus 1 SControl 0)
[  174.817555] ata1.15: qc timeout (cmd 0xe4)
[  174.817562] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  174.817565] ata1.15: PMP revalidation failed (errno=-5)
[  174.817568] ata1.15: limiting SATA link speed to 1.5 Gbps
[  174.817570] ata1.15: retrying hardreset in 5 secs
[  179.820043] ata1.15: hard resetting link
[  182.019380] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  182.019590] ata1.00: hard resetting link
[  182.339460] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  182.339463] ata1.01: hard resetting link
[  182.659362] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.659365] ata1.02: hard resetting link
[  182.979265] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.979269] ata1.03: hard resetting link
[  183.299169] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  183.299172] ata1.04: hard resetting link
[  183.619071] ata1.04: SATA link down (SStatus 0 SControl 310)
[  183.619074] ata1.05: hard resetting link
[  183.938971] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  183.938975] ata1.06: hard resetting link
[  184.258874] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  184.261106] ata1.00: configured for UDMA/100
[  184.263303] ata1.01: configured for UDMA/100
[  184.263398] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  184.263401] ata1.02: revalidation failed (errno=-5)
[  184.263406] ata1.15: hard resetting link
[  186.462034] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  186.462308] ata1.00: hard resetting link
[  186.782113] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  186.782117] ata1.01: hard resetting link
[  187.102015] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.102018] ata1.02: hard resetting link
[  187.421918] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.421922] ata1.03: hard resetting link
[  187.741820] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.741823] ata1.04: hard resetting link
[  188.061723] ata1.04: SATA link down (SStatus 0 SControl 310)
[  188.061727] ata1.05: hard resetting link
[  188.381625] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  188.381628] ata1.06: hard resetting link
[  188.701528] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  188.703706] ata1.00: configured for UDMA/100
[  188.705935] ata1.01: configured for UDMA/100
[  188.811817] ata1.02: configured for UDMA/100
[  188.915919] ata1.03: configured for UDMA/100
[  188.916051] ata1.05: device is on DMA blacklist, disabling DMA
[  188.916182] ata1.05: configured for PIO4
[  188.916453] ata1: EH complete
[  188.916481] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916492] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916496] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916508] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916524] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916532] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916535] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916546] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916560] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916567] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916570] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916581] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916595] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916602] sd 1:3:0:0: [sde] Write Protect is off
[  188.916605] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916616] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916629] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916637] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916640] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916651] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  188.916664] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916671] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916674] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916686] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916698] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916705] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916708] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916720] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916732] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916739] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916742] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916753] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916766] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916773] sd 1:3:0:0: [sde] Write Protect is off
[  188.916776] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916787] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916799] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916807] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916810] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916821] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  233.874452] ata1.00: failed to read SCR 1 (Emask=0x40)
[  233.874458] ata1.01: failed to read SCR 1 (Emask=0x40)
[  233.874462] ata1.02: failed to read SCR 1 (Emask=0x40)
[  233.874465] ata1.03: failed to read SCR 1 (Emask=0x40)
[  233.874468] ata1.04: failed to read SCR 1 (Emask=0x40)
[  233.874471] ata1.05: failed to read SCR 1 (Emask=0x40)
[  233.874474] ata1.06: failed to read SCR 1 (Emask=0x40)
[  233.874478] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  233.874482] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  233.874486] ata1: SError: { 10B8B }
[  233.874490] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874495] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874501] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874506] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874511] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874516] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874521] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874529] ata1.15: hard resetting link
[  238.966100] ata1.15: SATA link down (SStatus 1 SControl 10)
[  239.218017] ata1.15: qc timeout (cmd 0xe4)
[  239.218026] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  239.218029] ata1.15: PMP revalidation failed (errno=-5)
[  239.218032] ata1.15: retrying hardreset in 5 secs
[  244.220499] ata1.15: hard resetting link
[  249.314958] ata1.15: SATA link down (SStatus 1 SControl 10)
[  249.566876] ata1.15: qc timeout (cmd 0xe4)
[  249.566883] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  249.566886] ata1.15: PMP revalidation failed (errno=-5)
[  249.566890] ata1.15: retrying hardreset in 5 secs
[  254.569359] ata1.15: hard resetting link
[  256.768701] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  256.768897] ata1.00: hard resetting link
[  257.088783] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  257.088787] ata1.01: hard resetting link
[  257.408684] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.408688] ata1.02: hard resetting link
[  257.728587] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.728591] ata1.03: hard resetting link
[  258.048491] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  258.048495] ata1.04: hard resetting link
[  258.368394] ata1.04: SATA link down (SStatus 0 SControl 310)
[  258.368397] ata1.05: hard resetting link
[  258.688294] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  258.688298] ata1.06: hard resetting link
[  259.008199] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  259.008295] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  259.008299] ata1.00: revalidation failed (errno=-5)
[  259.008304] ata1.15: hard resetting link
[  261.207356] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  261.207634] ata1.00: hard resetting link
[  261.527434] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  261.527439] ata1.01: hard resetting link
[  261.847337] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  261.847340] ata1.02: hard resetting link
[  262.167238] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.167242] ata1.03: hard resetting link
[  262.487142] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.487146] ata1.04: hard resetting link
[  262.807046] ata1.04: SATA link down (SStatus 0 SControl 310)
[  262.807050] ata1.05: hard resetting link
[  263.126946] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  263.126950] ata1.06: hard resetting link
[  263.446852] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  263.449093] ata1.00: configured for UDMA/100
[  263.451311] ata1.01: configured for UDMA/100
[  263.556976] ata1.02: configured for UDMA/100
[  263.658661] ata1.03: configured for UDMA/100
[  263.658793] ata1.05: device is on DMA blacklist, disabling DMA
[  263.658923] ata1.05: configured for PIO4
[  263.659192] ata1: EH complete
[  263.659218] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659229] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659232] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659245] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659260] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659267] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659270] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659281] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659295] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659303] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659305] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659317] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659330] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659337] sd 1:3:0:0: [sde] Write Protect is off
[  263.659340] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659351] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659365] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659372] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659375] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659386] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  263.659399] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659407] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659409] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659421] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659433] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659440] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659443] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659454] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659467] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659474] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659477] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659488] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659500] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659508] sd 1:3:0:0: [sde] Write Protect is off
[  263.659511] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659522] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659534] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659541] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659544] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659555] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  337.619074] ata1.00: failed to read SCR 1 (Emask=0x40)
[  337.619079] ata1.01: failed to read SCR 1 (Emask=0x40)
[  337.619083] ata1.02: failed to read SCR 1 (Emask=0x40)
[  337.619086] ata1.03: failed to read SCR 1 (Emask=0x40)
[  337.619089] ata1.04: failed to read SCR 1 (Emask=0x40)
[  337.619092] ata1.05: failed to read SCR 1 (Emask=0x40)
[  337.619095] ata1.06: failed to read SCR 1 (Emask=0x40)
[  337.619099] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  337.619103] ata1.15: irq_stat 0x01940090, PHY RDY changed
[  337.619107] ata1: SError: { 10B8B }
[  337.619111] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619116] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619122] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619127] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619132] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619137] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619142] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619150] ata1.15: hard resetting link
[  339.695540] ata1.15: SATA link down (SStatus 0 SControl 10)
[  339.947457] ata1.15: qc timeout (cmd 0xe4)
[  339.947465] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  339.947469] ata1.15: PMP revalidation failed (errno=-5)
[  339.947472] ata1.15: retrying hardreset in 5 secs
[  344.949939] ata1.15: hard resetting link
[  347.029314] ata1.15: SATA link down (SStatus 0 SControl 10)
[  347.281232] ata1.15: qc timeout (cmd 0xe4)
[  347.281239] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  347.281242] ata1.15: PMP revalidation failed (errno=-5)
[  347.281246] ata1.15: retrying hardreset in 5 secs
[  352.283714] ata1.15: hard resetting link
[  356.250521] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  356.250717] ata1.00: hard resetting link
[  356.570601] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  356.570605] ata1.01: hard resetting link
[  356.890503] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  356.890507] ata1.02: hard resetting link
[  357.210406] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.210411] ata1.03: hard resetting link
[  357.530309] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.530313] ata1.04: hard resetting link
[  357.850212] ata1.04: SATA link down (SStatus 0 SControl 310)
[  357.850216] ata1.05: hard resetting link
[  358.170112] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  358.170116] ata1.06: hard resetting link
[  358.490020] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  358.492276] ata1.00: configured for UDMA/100
[  358.494506] ata1.01: configured for UDMA/100
[  358.595946] ata1.02: configured for UDMA/100
[  358.705215] ata1.03: configured for UDMA/100
[  358.705316] ata1.05: device is on DMA blacklist, disabling DMA
[  358.705472] ata1.05: configured for PIO4
[  358.705734] ata1: EH complete
[  358.705759] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705773] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705776] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705789] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705804] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705812] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705815] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.705827] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705841] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.705849] sd 1:2:0:0: [sdd] Write Protect is off
[  358.705852] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.705863] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705877] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.705885] sd 1:3:0:0: [sde] Write Protect is off
[  358.705888] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.705900] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705913] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.705921] sd 1:5:0:0: [sdf] Write Protect is off
[  358.705924] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.705936] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  358.705949] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705957] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705960] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705972] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705985] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705992] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705995] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.706007] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706020] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.706028] sd 1:2:0:0: [sdd] Write Protect is off
[  358.706030] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.706042] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706055] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.706063] sd 1:3:0:0: [sde] Write Protect is off
[  358.706066] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.706077] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706090] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.706098] sd 1:5:0:0: [sdf] Write Protect is off
[  358.706101] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.706112] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  404.739637] ata1.15: limiting speed to UDMA7:PIO5
[  404.739644] ata1.00: failed to read SCR 1 (Emask=0x40)
[  404.739648] ata1.01: failed to read SCR 1 (Emask=0x40)
[  404.739651] ata1.02: failed to read SCR 1 (Emask=0x40)
[  404.739654] ata1.03: failed to read SCR 1 (Emask=0x40)
[  404.739657] ata1.04: failed to read SCR 1 (Emask=0x40)
[  404.739660] ata1.05: failed to read SCR 1 (Emask=0x40)
[  404.739663] ata1.06: failed to read SCR 1 (Emask=0x40)
[  404.739667] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  404.739671] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  404.739675] ata1: SError: { 10B8B }
[  404.739679] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739685] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739690] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739695] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739700] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739705] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739710] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739718] ata1.15: hard resetting link
[  409.830262] ata1.15: SATA link down (SStatus 1 SControl 10)
[  410.082180] ata1.15: qc timeout (cmd 0xe4)
[  410.082188] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  410.082191] ata1.15: PMP revalidation failed (errno=-5)
[  410.082194] ata1.15: retrying hardreset in 5 secs
[  415.084662] ata1.15: hard resetting link
[  420.179121] ata1.15: SATA link down (SStatus 1 SControl 10)
[  420.431039] ata1.15: qc timeout (cmd 0xe4)
[  420.431047] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  420.431050] ata1.15: PMP revalidation failed (errno=-5)
[  420.431054] ata1.15: retrying hardreset in 5 secs
[  425.433523] ata1.15: hard resetting link
[  435.438490] ata1.15: softreset failed (timeout)
[  435.438494] ata1.15: hard resetting link
[  445.443457] ata1.15: softreset failed (timeout)
[  445.443463] ata1.15: hard resetting link
[  480.432842] ata1.15: softreset failed (timeout)
[  480.432850] ata1.15: hard resetting link
[  485.431325] ata1.15: softreset failed (timeout)
[  485.431329] ata1.15: failed to reset PMP, giving up
[  485.431332] ata1.15: Port Multiplier detaching
[  485.431340] ata1.00: disabled
[  485.431343] ata1.01: disabled
[  485.431346] ata1.02: disabled
[  485.431348] ata1.03: disabled
[  485.431350] ata1.05: disabled
[  485.431354] ata1.00: disabled
[  485.431360] ata1: hard resetting link
[  495.436287] ata1: softreset failed (timeout)
[  495.436290] ata1: hard resetting link
[  505.441252] ata1: softreset failed (timeout)
[  505.441255] ata1: hard resetting link
[  540.430639] ata1: softreset failed (timeout)
[  540.430647] ata1: limiting SATA link speed to 1.5 Gbps
[  540.430650] ata1: hard resetting link
[  545.525097] ata1: SATA link down (SStatus 1 SControl 10)
[  545.525115] ata1: EH complete
[  545.525125] ata1.00: detaching (SCSI 1:0:0:0)
[  545.525299] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  545.525613] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[  545.525617] sd 1:0:0:0: [sdb] Stopping disk
[  545.525623] sd 1:0:0:0: [sdb] START_STOP FAILED
[  545.525626] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[  545.525663] ata1.01: detaching (SCSI 1:1:0:0)
[  545.525799] sd 1:1:0:0: [sdc] Synchronizing SCSI cache
[  545.525944] sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  545.525948] sd 1:1:0:0: [sdc] Stopping disk
[  545.525970] sd 1:1:0:0: [sdc] START_STOP FAILED
[  545.525972] sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  545.526000] ata1.02: detaching (SCSI 1:2:0:0)
[  545.526146] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[  545.527048] sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  545.527053] sd 1:2:0:0: [sdd] Stopping disk
[  545.527071] sd 1:2:0:0: [sdd] START_STOP FAILED
[  545.527074] sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  545.527106] ata1.03: detaching (SCSI 1:3:0:0)
[  545.527246] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  545.527287] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  545.527290] sd 1:3:0:0: [sde] Stopping disk
[  545.527304] sd 1:3:0:0: [sde] START_STOP FAILED
[  545.527306] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  545.527333] ata1.05: detaching (SCSI 1:5:0:0)
[  545.527451] sd 1:5:0:0: [sdf] Stopping disk
[  545.527459] sd 1:5:0:0: [sdf] START_STOP FAILED
[  545.527462] sd 1:5:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
[  559.279656] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
[  559.279662] ata1: irq_stat 0x00a40080, device exchanged
[  559.279673] ata1: hard resetting link
[  563.427669] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  563.679583] ata1.15: qc timeout (cmd 0xe4)
[  563.679589] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  563.679593] ata1: failed to recover some devices, retrying in 5 secs
[  568.682071] ata1: hard resetting link
[  578.687033] ata1: softreset failed (timeout)
[  578.687039] ata1: hard resetting link
[  588.691996] ata1: softreset failed (timeout)
[  588.691999] ata1: hard resetting link
[  623.681382] ata1: softreset failed (timeout)
[  623.681390] ata1: limiting SATA link speed to 1.5 Gbps
[  623.681393] ata1: hard resetting link
[  628.679864] ata1: softreset failed (timeout)
[  628.679867] ata1: reset failed, giving up
[  628.679878] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xa frozen t4
[  628.679883] ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
[  628.679892] ata1: hard resetting link
[  638.684830] ata1: softreset failed (timeout)
[  638.684836] ata1: hard resetting link
[  648.689795] ata1: softreset failed (timeout)
[  648.689801] ata1: hard resetting link
[  683.679179] ata1: softreset failed (timeout)
[  683.679186] ata1: limiting SATA link speed to 1.5 Gbps
[  683.679189] ata1: hard resetting link
[  688.677661] ata1: softreset failed (timeout)
[  688.677664] ata1: reset failed, giving up
[  688.677670] ata1: EH complete

--------------080405040801090803040005
Content-Type: text/plain;
 name="5_Broken.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="5_Broken.log"

sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.786363] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   70.786553] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   70.786744] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
[   70.786795] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   70.797142] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   70.797280] usb usb1: configuration #1 chosen from 1 choice
[   70.797308] hub 1-0:1.0: USB hub found
[   70.797317] hub 1-0:1.0: 8 ports detected
[   70.901323] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.901336] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.901363] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[   70.901386] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.901506] usb usb2: configuration #1 chosen from 1 choice
[   70.901531] hub 2-0:1.0: USB hub found
[   70.901539] hub 2-0:1.0: 2 ports detected
[   71.005191] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   71.005204] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   71.005229] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[   71.005252] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   71.005373] usb usb3: configuration #1 chosen from 1 choice
[   71.005398] hub 3-0:1.0: USB hub found
[   71.005405] hub 3-0:1.0: 2 ports detected
[   71.109172] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   71.109185] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   71.109211] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[   71.109235] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   71.109351] usb usb4: configuration #1 chosen from 1 choice
[   71.109376] hub 4-0:1.0: USB hub found
[   71.109383] hub 4-0:1.0: 2 ports detected
[   71.213117] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   71.213130] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   71.213155] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[   71.213179] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   71.213299] usb usb5: configuration #1 chosen from 1 choice
[   71.213325] hub 5-0:1.0: USB hub found
[   71.213332] hub 5-0:1.0: 2 ports detected
[   71.317585] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.319838] Audigy2 value: Special config.
[   73.765264] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.765268] Copyright (c) 1999-2006 Intel Corporation.
[   73.765309] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.765314] PCI: Disallowing DAC for device 0000:00:0e.0
[   74.025736] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   74.201234] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   74.355702] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   74.355715] ReiserFS: hdb1: using ordered data mode
[   74.392680] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.394057] ReiserFS: hdb1: checking transaction log (hdb1)
[   74.489291] ReiserFS: hdb1: Using r5 hash to sort names
[   74.553988] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   74.553998] ReiserFS: hda2: using ordered data mode
[   74.558818] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.560151] ReiserFS: hda2: checking transaction log (hda2)
[   74.623128] ReiserFS: hda2: Using r5 hash to sort names
[   80.456682] hda: UDMA/100 mode selected
[   80.460729] hdb: UDMA/133 mode selected
[   80.515263] hdc: UDMA/33 mode selected
[   80.532803] hdd: UDMA/33 mode selected
[   83.053804] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   87.342494] w83627hf: Found W83697HF chip at 0x290
[  159.125858] ata1.00: failed to read SCR 1 (Emask=0x40)
[  159.125863] ata1.01: failed to read SCR 1 (Emask=0x40)
[  159.125866] ata1.02: failed to read SCR 1 (Emask=0x40)
[  159.125869] ata1.03: failed to read SCR 1 (Emask=0x40)
[  159.125871] ata1.04: failed to read SCR 1 (Emask=0x40)
[  159.125874] ata1.05: failed to read SCR 1 (Emask=0x40)
[  159.125876] ata1.06: failed to read SCR 1 (Emask=0x40)
[  159.125880] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  159.125883] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  159.125886] ata1: SError: { 10B8B }
[  159.125890] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125895] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125899] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125904] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125908] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125912] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125917] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125923] ata1.15: hard resetting link
[  164.216778] ata1.15: SATA link down (SStatus 1 SControl 0)
[  164.468696] ata1.15: qc timeout (cmd 0xe4)
[  164.468703] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  164.468706] ata1.15: PMP revalidation failed (errno=-5)
[  164.468708] ata1.15: retrying hardreset in 5 secs
[  169.471177] ata1.15: hard resetting link
[  174.565637] ata1.15: SATA link down (SStatus 1 SControl 0)
[  174.817555] ata1.15: qc timeout (cmd 0xe4)
[  174.817562] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  174.817565] ata1.15: PMP revalidation failed (errno=-5)
[  174.817568] ata1.15: limiting SATA link speed to 1.5 Gbps
[  174.817570] ata1.15: retrying hardreset in 5 secs
[  179.820043] ata1.15: hard resetting link
[  182.019380] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  182.019590] ata1.00: hard resetting link
[  182.339460] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  182.339463] ata1.01: hard resetting link
[  182.659362] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.659365] ata1.02: hard resetting link
[  182.979265] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.979269] ata1.03: hard resetting link
[  183.299169] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  183.299172] ata1.04: hard resetting link
[  183.619071] ata1.04: SATA link down (SStatus 0 SControl 310)
[  183.619074] ata1.05: hard resetting link
[  183.938971] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  183.938975] ata1.06: hard resetting link
[  184.258874] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  184.261106] ata1.00: configured for UDMA/100
[  184.263303] ata1.01: configured for UDMA/100
[  184.263398] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  184.263401] ata1.02: revalidation failed (errno=-5)
[  184.263406] ata1.15: hard resetting link
[  186.462034] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  186.462308] ata1.00: hard resetting link
[  186.782113] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  186.782117] ata1.01: hard resetting link
[  187.102015] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.102018] ata1.02: hard resetting link
[  187.421918] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.421922] ata1.03: hard resetting link
[  187.741820] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.741823] ata1.04: hard resetting link
[  188.061723] ata1.04: SATA link down (SStatus 0 SControl 310)
[  188.061727] ata1.05: hard resetting link
[  188.381625] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  188.381628] ata1.06: hard resetting link
[  188.701528] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  188.703706] ata1.00: configured for UDMA/100
[  188.705935] ata1.01: configured for UDMA/100
[  188.811817] ata1.02: configured for UDMA/100
[  188.915919] ata1.03: configured for UDMA/100
[  188.916051] ata1.05: device is on DMA blacklist, disabling DMA
[  188.916182] ata1.05: configured for PIO4
[  188.916453] ata1: EH complete
[  188.916481] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916492] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916496] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916508] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916524] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916532] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916535] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916546] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916560] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916567] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916570] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916581] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916595] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916602] sd 1:3:0:0: [sde] Write Protect is off
[  188.916605] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916616] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916629] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916637] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916640] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916651] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  188.916664] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916671] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916674] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916686] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916698] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916705] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916708] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916720] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916732] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916739] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916742] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916753] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916766] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916773] sd 1:3:0:0: [sde] Write Protect is off
[  188.916776] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916787] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916799] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916807] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916810] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916821] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  233.874452] ata1.00: failed to read SCR 1 (Emask=0x40)
[  233.874458] ata1.01: failed to read SCR 1 (Emask=0x40)
[  233.874462] ata1.02: failed to read SCR 1 (Emask=0x40)
[  233.874465] ata1.03: failed to read SCR 1 (Emask=0x40)
[  233.874468] ata1.04: failed to read SCR 1 (Emask=0x40)
[  233.874471] ata1.05: failed to read SCR 1 (Emask=0x40)
[  233.874474] ata1.06: failed to read SCR 1 (Emask=0x40)
[  233.874478] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  233.874482] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  233.874486] ata1: SError: { 10B8B }
[  233.874490] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874495] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874501] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874506] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874511] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874516] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874521] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874529] ata1.15: hard resetting link
[  238.966100] ata1.15: SATA link down (SStatus 1 SControl 10)
[  239.218017] ata1.15: qc timeout (cmd 0xe4)
[  239.218026] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  239.218029] ata1.15: PMP revalidation failed (errno=-5)
[  239.218032] ata1.15: retrying hardreset in 5 secs
[  244.220499] ata1.15: hard resetting link
[  249.314958] ata1.15: SATA link down (SStatus 1 SControl 10)
[  249.566876] ata1.15: qc timeout (cmd 0xe4)
[  249.566883] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  249.566886] ata1.15: PMP revalidation failed (errno=-5)
[  249.566890] ata1.15: retrying hardreset in 5 secs
[  254.569359] ata1.15: hard resetting link
[  256.768701] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  256.768897] ata1.00: hard resetting link
[  257.088783] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  257.088787] ata1.01: hard resetting link
[  257.408684] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.408688] ata1.02: hard resetting link
[  257.728587] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.728591] ata1.03: hard resetting link
[  258.048491] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  258.048495] ata1.04: hard resetting link
[  258.368394] ata1.04: SATA link down (SStatus 0 SControl 310)
[  258.368397] ata1.05: hard resetting link
[  258.688294] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  258.688298] ata1.06: hard resetting link
[  259.008199] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  259.008295] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  259.008299] ata1.00: revalidation failed (errno=-5)
[  259.008304] ata1.15: hard resetting link
[  261.207356] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  261.207634] ata1.00: hard resetting link
[  261.527434] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  261.527439] ata1.01: hard resetting link
[  261.847337] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  261.847340] ata1.02: hard resetting link
[  262.167238] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.167242] ata1.03: hard resetting link
[  262.487142] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.487146] ata1.04: hard resetting link
[  262.807046] ata1.04: SATA link down (SStatus 0 SControl 310)
[  262.807050] ata1.05: hard resetting link
[  263.126946] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  263.126950] ata1.06: hard resetting link
[  263.446852] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  263.449093] ata1.00: configured for UDMA/100
[  263.451311] ata1.01: configured for UDMA/100
[  263.556976] ata1.02: configured for UDMA/100
[  263.658661] ata1.03: configured for UDMA/100
[  263.658793] ata1.05: device is on DMA blacklist, disabling DMA
[  263.658923] ata1.05: configured for PIO4
[  263.659192] ata1: EH complete
[  263.659218] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659229] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659232] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659245] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659260] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659267] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659270] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659281] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659295] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659303] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659305] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659317] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659330] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659337] sd 1:3:0:0: [sde] Write Protect is off
[  263.659340] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659351] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659365] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659372] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659375] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659386] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  263.659399] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659407] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659409] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659421] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659433] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659440] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659443] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659454] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659467] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659474] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659477] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659488] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659500] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659508] sd 1:3:0:0: [sde] Write Protect is off
[  263.659511] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659522] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659534] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659541] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659544] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659555] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  337.619074] ata1.00: failed to read SCR 1 (Emask=0x40)
[  337.619079] ata1.01: failed to read SCR 1 (Emask=0x40)
[  337.619083] ata1.02: failed to read SCR 1 (Emask=0x40)
[  337.619086] ata1.03: failed to read SCR 1 (Emask=0x40)
[  337.619089] ata1.04: failed to read SCR 1 (Emask=0x40)
[  337.619092] ata1.05: failed to read SCR 1 (Emask=0x40)
[  337.619095] ata1.06: failed to read SCR 1 (Emask=0x40)
[  337.619099] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  337.619103] ata1.15: irq_stat 0x01940090, PHY RDY changed
[  337.619107] ata1: SError: { 10B8B }
[  337.619111] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619116] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619122] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619127] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619132] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619137] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619142] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619150] ata1.15: hard resetting link
[  339.695540] ata1.15: SATA link down (SStatus 0 SControl 10)
[  339.947457] ata1.15: qc timeout (cmd 0xe4)
[  339.947465] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  339.947469] ata1.15: PMP revalidation failed (errno=-5)
[  339.947472] ata1.15: retrying hardreset in 5 secs
[  344.949939] ata1.15: hard resetting link
[  347.029314] ata1.15: SATA link down (SStatus 0 SControl 10)
[  347.281232] ata1.15: qc timeout (cmd 0xe4)
[  347.281239] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  347.281242] ata1.15: PMP revalidation failed (errno=-5)
[  347.281246] ata1.15: retrying hardreset in 5 secs
[  352.283714] ata1.15: hard resetting link
[  356.250521] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  356.250717] ata1.00: hard resetting link
[  356.570601] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  356.570605] ata1.01: hard resetting link
[  356.890503] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  356.890507] ata1.02: hard resetting link
[  357.210406] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.210411] ata1.03: hard resetting link
[  357.530309] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.530313] ata1.04: hard resetting link
[  357.850212] ata1.04: SATA link down (SStatus 0 SControl 310)
[  357.850216] ata1.05: hard resetting link
[  358.170112] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  358.170116] ata1.06: hard resetting link
[  358.490020] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  358.492276] ata1.00: configured for UDMA/100
[  358.494506] ata1.01: configured for UDMA/100
[  358.595946] ata1.02: configured for UDMA/100
[  358.705215] ata1.03: configured for UDMA/100
[  358.705316] ata1.05: device is on DMA blacklist, disabling DMA
[  358.705472] ata1.05: configured for PIO4
[  358.705734] ata1: EH complete
[  358.705759] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705773] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705776] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705789] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705804] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705812] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705815] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.705827] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705841] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.705849] sd 1:2:0:0: [sdd] Write Protect is off
[  358.705852] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.705863] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705877] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.705885] sd 1:3:0:0: [sde] Write Protect is off
[  358.705888] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.705900] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705913] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.705921] sd 1:5:0:0: [sdf] Write Protect is off
[  358.705924] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.705936] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  358.705949] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705957] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705960] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705972] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705985] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705992] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705995] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.706007] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706020] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.706028] sd 1:2:0:0: [sdd] Write Protect is off
[  358.706030] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.706042] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706055] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.706063] sd 1:3:0:0: [sde] Write Protect is off
[  358.706066] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.706077] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706090] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.706098] sd 1:5:0:0: [sdf] Write Protect is off
[  358.706101] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.706112] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  404.739637] ata1.15: limiting speed to UDMA7:PIO5
[  404.739644] ata1.00: failed to read SCR 1 (Emask=0x40)
[  404.739648] ata1.01: failed to read SCR 1 (Emask=0x40)
[  404.739651] ata1.02: failed to read SCR 1 (Emask=0x40)
[  404.739654] ata1.03: failed to read SCR 1 (Emask=0x40)
[  404.739657] ata1.04: failed to read SCR 1 (Emask=0x40)
[  404.739660] ata1.05: failed to read SCR 1 (Emask=0x40)
[  404.739663] ata1.06: failed to read SCR 1 (Emask=0x40)
[  404.739667] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  404.739671] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  404.739675] ata1: SError: { 10B8B }
[  404.739679] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739685] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739690] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739695] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739700] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739705] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739710] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739718] ata1.15: hard resetting link
[  409.830262] ata1.15: SATA link down (SStatus 1 SControl 10)
[  410.082180] ata1.15: qc timeout (cmd 0xe4)
[  410.082188] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  410.082191] ata1.15: PMP revalidation failed (errno=-5)
[  410.082194] ata1.15: retrying hardreset in 5 secs
[  415.084662] ata1.15: hard resetting link
[  420.179121] ata1.15: SATA link down (SStatus 1 SControl 10)
[  420.431039] ata1.15: qc timeout (cmd 0xe4)
[  420.431047] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  420.431050] ata1.15: PMP revalidation failed (errno=-5)
[  420.431054] ata1.15: retrying hardreset in 5 secs
[  425.433523] ata1.15: hard resetting link
[  435.438490] ata1.15: softreset failed (timeout)
[  435.438494] ata1.15: hard resetting link
[  445.443457] ata1.15: softreset failed (timeout)
[  445.443463] ata1.15: hard resetting link
[  480.432842] ata1.15: softreset failed (timeout)
[  480.432850] ata1.15: hard resetting link
[  485.431325] ata1.15: softreset failed (timeout)
[  485.431329] ata1.15: failed to reset PMP, giving up
[  485.431332] ata1.15: Port Multiplier detaching
[  485.431340] ata1.00: disabled
[  485.431343] ata1.01: disabled
[  485.431346] ata1.02: disabled
[  485.431348] ata1.03: disabled
[  485.431350] ata1.05: disabled
[  485.431354] ata1.00: disabled
[  485.431360] ata1: hard resetting link
[  495.436287] ata1: softreset failed (timeout)
[  495.436290] ata1: hard resetting link
[  505.441252] ata1: softreset failed (timeout)
[  505.441255] ata1: hard resetting link
[  540.430639] ata1: softreset failed (timeout)
[  540.430647] ata1: limiting SATA link speed to 1.5 Gbps
[  540.430650] ata1: hard resetting link
[  545.525097] ata1: SATA link down (SStatus 1 SControl 10)
[  545.525115] ata1: EH complete
[  545.525125] ata1.00: detaching (SCSI 1:0:0:0)
[  545.525299] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  545.525613] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[  545.525617] sd 1:0:0:0: [sdb] Stopping disk
[  545.525623] sd 1:0:0:0: [sdb] START_STOP FAILED
[  545.525626] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[  545.525663] ata1.01: detaching (SCSI 1:1:0:0)
[  545.525799] sd 1:1:0:0: [sdc] Synchronizing SCSI cache
[  545.525944] sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  545.525948] sd 1:1:0:0: [sdc] Stopping disk
[  545.525970] sd 1:1:0:0: [sdc] START_STOP FAILED
[  545.525972] sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  545.526000] ata1.02: detaching (SCSI 1:2:0:0)
[  545.526146] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[  545.527048] sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  545.527053] sd 1:2:0:0: [sdd] Stopping disk
[  545.527071] sd 1:2:0:0: [sdd] START_STOP FAILED
[  545.527074] sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  545.527106] ata1.03: detaching (SCSI 1:3:0:0)
[  545.527246] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  545.527287] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  545.527290] sd 1:3:0:0: [sde] Stopping disk
[  545.527304] sd 1:3:0:0: [sde] START_STOP FAILED
[  545.527306] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  545.527333] ata1.05: detaching (SCSI 1:5:0:0)
[  545.527451] sd 1:5:0:0: [sdf] Stopping disk
[  545.527459] sd 1:5:0:0: [sdf] START_STOP FAILED
[  545.527462] sd 1:5:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
[  559.279656] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
[  559.279662] ata1: irq_stat 0x00a40080, device exchanged
[  559.279673] ata1: hard resetting link
[  563.427669] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  563.679583] ata1.15: qc timeout (cmd 0xe4)
[  563.679589] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  563.679593] ata1: failed to recover some devices, retrying in 5 secs
[  568.682071] ata1: hard resetting link
[  578.687033] ata1: softreset failed (timeout)
[  578.687039] ata1: hard resetting link
[  588.691996] ata1: softreset failed (timeout)
[  588.691999] ata1: hard resetting link
[  623.681382] ata1: softreset failed (timeout)
[  623.681390] ata1: limiting SATA link speed to 1.5 Gbps
[  623.681393] ata1: hard resetting link
[  628.679864] ata1: softreset failed (timeout)
[  628.679867] ata1: reset failed, giving up
[  628.679878] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xa frozen t4
[  628.679883] ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
[  628.679892] ata1: hard resetting link
[  638.684830] ata1: softreset failed (timeout)
[  638.684836] ata1: hard resetting link
[  648.689795] ata1: softreset failed (timeout)
[  648.689801] ata1: hard resetting link
[  683.679179] ata1: softreset failed (timeout)
[  683.679186] ata1: limiting SATA link speed to 1.5 Gbps
[  683.679189] ata1: hard resetting link
[  688.677661] ata1: softreset failed (timeout)
[  688.677664] ata1: reset failed, giving up
[  688.677670] ata1: EH complete
[  776.735711] ata2: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
[  776.735717] ata2: irq_stat 0x00a40080, device exchanged
[  776.735721] ata2: SError: { PHYRdyChg }
[  776.735731] ata2: hard resetting link
[  786.739911] ata2: softreset failed (timeout)
[  786.739918] ata2: hard resetting link
[  796.744875] ata2: softreset failed (timeout)
[  796.744881] ata2: hard resetting link
[  831.734261] ata2: softreset failed (timeout)
[  831.734268] ata2: limiting SATA link speed to 1.5 Gbps
[  831.734271] ata2: hard resetting link
[  836.732744] ata2: softreset failed (timeout)
[  836.732747] ata2: reset failed, giving up
[  836.732753] ata2: EH complete
[ 1001.096027] ACPI: PCI interrupt for device 0000:00:0c.0 disabled

--------------080405040801090803040005
Content-Type: text/plain;
 name="6_ModuleReload.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="6_ModuleReload.log"

> IRQ 21
[   71.005204] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   71.005229] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[   71.005252] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   71.005373] usb usb3: configuration #1 chosen from 1 choice
[   71.005398] hub 3-0:1.0: USB hub found
[   71.005405] hub 3-0:1.0: 2 ports detected
[   71.109172] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   71.109185] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   71.109211] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[   71.109235] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   71.109351] usb usb4: configuration #1 chosen from 1 choice
[   71.109376] hub 4-0:1.0: USB hub found
[   71.109383] hub 4-0:1.0: 2 ports detected
[   71.213117] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   71.213130] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   71.213155] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[   71.213179] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   71.213299] usb usb5: configuration #1 chosen from 1 choice
[   71.213325] hub 5-0:1.0: USB hub found
[   71.213332] hub 5-0:1.0: 2 ports detected
[   71.317585] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.319838] Audigy2 value: Special config.
[   73.765264] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.765268] Copyright (c) 1999-2006 Intel Corporation.
[   73.765309] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.765314] PCI: Disallowing DAC for device 0000:00:0e.0
[   74.025736] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   74.201234] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   74.355702] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   74.355715] ReiserFS: hdb1: using ordered data mode
[   74.392680] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.394057] ReiserFS: hdb1: checking transaction log (hdb1)
[   74.489291] ReiserFS: hdb1: Using r5 hash to sort names
[   74.553988] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   74.553998] ReiserFS: hda2: using ordered data mode
[   74.558818] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.560151] ReiserFS: hda2: checking transaction log (hda2)
[   74.623128] ReiserFS: hda2: Using r5 hash to sort names
[   80.456682] hda: UDMA/100 mode selected
[   80.460729] hdb: UDMA/133 mode selected
[   80.515263] hdc: UDMA/33 mode selected
[   80.532803] hdd: UDMA/33 mode selected
[   83.053804] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   87.342494] w83627hf: Found W83697HF chip at 0x290
[  159.125858] ata1.00: failed to read SCR 1 (Emask=0x40)
[  159.125863] ata1.01: failed to read SCR 1 (Emask=0x40)
[  159.125866] ata1.02: failed to read SCR 1 (Emask=0x40)
[  159.125869] ata1.03: failed to read SCR 1 (Emask=0x40)
[  159.125871] ata1.04: failed to read SCR 1 (Emask=0x40)
[  159.125874] ata1.05: failed to read SCR 1 (Emask=0x40)
[  159.125876] ata1.06: failed to read SCR 1 (Emask=0x40)
[  159.125880] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  159.125883] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  159.125886] ata1: SError: { 10B8B }
[  159.125890] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125895] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125899] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125904] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125908] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125912] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125917] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125923] ata1.15: hard resetting link
[  164.216778] ata1.15: SATA link down (SStatus 1 SControl 0)
[  164.468696] ata1.15: qc timeout (cmd 0xe4)
[  164.468703] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  164.468706] ata1.15: PMP revalidation failed (errno=-5)
[  164.468708] ata1.15: retrying hardreset in 5 secs
[  169.471177] ata1.15: hard resetting link
[  174.565637] ata1.15: SATA link down (SStatus 1 SControl 0)
[  174.817555] ata1.15: qc timeout (cmd 0xe4)
[  174.817562] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  174.817565] ata1.15: PMP revalidation failed (errno=-5)
[  174.817568] ata1.15: limiting SATA link speed to 1.5 Gbps
[  174.817570] ata1.15: retrying hardreset in 5 secs
[  179.820043] ata1.15: hard resetting link
[  182.019380] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  182.019590] ata1.00: hard resetting link
[  182.339460] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  182.339463] ata1.01: hard resetting link
[  182.659362] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.659365] ata1.02: hard resetting link
[  182.979265] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.979269] ata1.03: hard resetting link
[  183.299169] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  183.299172] ata1.04: hard resetting link
[  183.619071] ata1.04: SATA link down (SStatus 0 SControl 310)
[  183.619074] ata1.05: hard resetting link
[  183.938971] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  183.938975] ata1.06: hard resetting link
[  184.258874] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  184.261106] ata1.00: configured for UDMA/100
[  184.263303] ata1.01: configured for UDMA/100
[  184.263398] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  184.263401] ata1.02: revalidation failed (errno=-5)
[  184.263406] ata1.15: hard resetting link
[  186.462034] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  186.462308] ata1.00: hard resetting link
[  186.782113] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  186.782117] ata1.01: hard resetting link
[  187.102015] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.102018] ata1.02: hard resetting link
[  187.421918] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.421922] ata1.03: hard resetting link
[  187.741820] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.741823] ata1.04: hard resetting link
[  188.061723] ata1.04: SATA link down (SStatus 0 SControl 310)
[  188.061727] ata1.05: hard resetting link
[  188.381625] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  188.381628] ata1.06: hard resetting link
[  188.701528] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  188.703706] ata1.00: configured for UDMA/100
[  188.705935] ata1.01: configured for UDMA/100
[  188.811817] ata1.02: configured for UDMA/100
[  188.915919] ata1.03: configured for UDMA/100
[  188.916051] ata1.05: device is on DMA blacklist, disabling DMA
[  188.916182] ata1.05: configured for PIO4
[  188.916453] ata1: EH complete
[  188.916481] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916492] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916496] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916508] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916524] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916532] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916535] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916546] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916560] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916567] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916570] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916581] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916595] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916602] sd 1:3:0:0: [sde] Write Protect is off
[  188.916605] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916616] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916629] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916637] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916640] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916651] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  188.916664] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916671] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916674] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916686] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916698] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916705] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916708] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916720] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916732] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916739] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916742] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916753] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916766] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916773] sd 1:3:0:0: [sde] Write Protect is off
[  188.916776] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916787] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916799] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916807] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916810] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916821] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  233.874452] ata1.00: failed to read SCR 1 (Emask=0x40)
[  233.874458] ata1.01: failed to read SCR 1 (Emask=0x40)
[  233.874462] ata1.02: failed to read SCR 1 (Emask=0x40)
[  233.874465] ata1.03: failed to read SCR 1 (Emask=0x40)
[  233.874468] ata1.04: failed to read SCR 1 (Emask=0x40)
[  233.874471] ata1.05: failed to read SCR 1 (Emask=0x40)
[  233.874474] ata1.06: failed to read SCR 1 (Emask=0x40)
[  233.874478] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  233.874482] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  233.874486] ata1: SError: { 10B8B }
[  233.874490] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874495] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874501] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874506] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874511] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874516] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874521] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874529] ata1.15: hard resetting link
[  238.966100] ata1.15: SATA link down (SStatus 1 SControl 10)
[  239.218017] ata1.15: qc timeout (cmd 0xe4)
[  239.218026] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  239.218029] ata1.15: PMP revalidation failed (errno=-5)
[  239.218032] ata1.15: retrying hardreset in 5 secs
[  244.220499] ata1.15: hard resetting link
[  249.314958] ata1.15: SATA link down (SStatus 1 SControl 10)
[  249.566876] ata1.15: qc timeout (cmd 0xe4)
[  249.566883] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  249.566886] ata1.15: PMP revalidation failed (errno=-5)
[  249.566890] ata1.15: retrying hardreset in 5 secs
[  254.569359] ata1.15: hard resetting link
[  256.768701] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  256.768897] ata1.00: hard resetting link
[  257.088783] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  257.088787] ata1.01: hard resetting link
[  257.408684] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.408688] ata1.02: hard resetting link
[  257.728587] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.728591] ata1.03: hard resetting link
[  258.048491] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  258.048495] ata1.04: hard resetting link
[  258.368394] ata1.04: SATA link down (SStatus 0 SControl 310)
[  258.368397] ata1.05: hard resetting link
[  258.688294] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  258.688298] ata1.06: hard resetting link
[  259.008199] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  259.008295] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  259.008299] ata1.00: revalidation failed (errno=-5)
[  259.008304] ata1.15: hard resetting link
[  261.207356] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  261.207634] ata1.00: hard resetting link
[  261.527434] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  261.527439] ata1.01: hard resetting link
[  261.847337] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  261.847340] ata1.02: hard resetting link
[  262.167238] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.167242] ata1.03: hard resetting link
[  262.487142] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.487146] ata1.04: hard resetting link
[  262.807046] ata1.04: SATA link down (SStatus 0 SControl 310)
[  262.807050] ata1.05: hard resetting link
[  263.126946] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  263.126950] ata1.06: hard resetting link
[  263.446852] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  263.449093] ata1.00: configured for UDMA/100
[  263.451311] ata1.01: configured for UDMA/100
[  263.556976] ata1.02: configured for UDMA/100
[  263.658661] ata1.03: configured for UDMA/100
[  263.658793] ata1.05: device is on DMA blacklist, disabling DMA
[  263.658923] ata1.05: configured for PIO4
[  263.659192] ata1: EH complete
[  263.659218] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659229] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659232] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659245] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659260] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659267] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659270] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659281] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659295] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659303] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659305] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659317] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659330] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659337] sd 1:3:0:0: [sde] Write Protect is off
[  263.659340] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659351] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659365] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659372] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659375] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659386] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  263.659399] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659407] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659409] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659421] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659433] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659440] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659443] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659454] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659467] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659474] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659477] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659488] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659500] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659508] sd 1:3:0:0: [sde] Write Protect is off
[  263.659511] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659522] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659534] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659541] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659544] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659555] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  337.619074] ata1.00: failed to read SCR 1 (Emask=0x40)
[  337.619079] ata1.01: failed to read SCR 1 (Emask=0x40)
[  337.619083] ata1.02: failed to read SCR 1 (Emask=0x40)
[  337.619086] ata1.03: failed to read SCR 1 (Emask=0x40)
[  337.619089] ata1.04: failed to read SCR 1 (Emask=0x40)
[  337.619092] ata1.05: failed to read SCR 1 (Emask=0x40)
[  337.619095] ata1.06: failed to read SCR 1 (Emask=0x40)
[  337.619099] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  337.619103] ata1.15: irq_stat 0x01940090, PHY RDY changed
[  337.619107] ata1: SError: { 10B8B }
[  337.619111] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619116] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619122] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619127] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619132] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619137] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619142] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619150] ata1.15: hard resetting link
[  339.695540] ata1.15: SATA link down (SStatus 0 SControl 10)
[  339.947457] ata1.15: qc timeout (cmd 0xe4)
[  339.947465] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  339.947469] ata1.15: PMP revalidation failed (errno=-5)
[  339.947472] ata1.15: retrying hardreset in 5 secs
[  344.949939] ata1.15: hard resetting link
[  347.029314] ata1.15: SATA link down (SStatus 0 SControl 10)
[  347.281232] ata1.15: qc timeout (cmd 0xe4)
[  347.281239] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  347.281242] ata1.15: PMP revalidation failed (errno=-5)
[  347.281246] ata1.15: retrying hardreset in 5 secs
[  352.283714] ata1.15: hard resetting link
[  356.250521] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  356.250717] ata1.00: hard resetting link
[  356.570601] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  356.570605] ata1.01: hard resetting link
[  356.890503] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  356.890507] ata1.02: hard resetting link
[  357.210406] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.210411] ata1.03: hard resetting link
[  357.530309] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.530313] ata1.04: hard resetting link
[  357.850212] ata1.04: SATA link down (SStatus 0 SControl 310)
[  357.850216] ata1.05: hard resetting link
[  358.170112] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  358.170116] ata1.06: hard resetting link
[  358.490020] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  358.492276] ata1.00: configured for UDMA/100
[  358.494506] ata1.01: configured for UDMA/100
[  358.595946] ata1.02: configured for UDMA/100
[  358.705215] ata1.03: configured for UDMA/100
[  358.705316] ata1.05: device is on DMA blacklist, disabling DMA
[  358.705472] ata1.05: configured for PIO4
[  358.705734] ata1: EH complete
[  358.705759] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705773] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705776] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705789] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705804] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705812] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705815] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.705827] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705841] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.705849] sd 1:2:0:0: [sdd] Write Protect is off
[  358.705852] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.705863] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705877] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.705885] sd 1:3:0:0: [sde] Write Protect is off
[  358.705888] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.705900] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705913] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.705921] sd 1:5:0:0: [sdf] Write Protect is off
[  358.705924] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.705936] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  358.705949] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705957] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705960] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705972] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705985] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705992] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705995] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.706007] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706020] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.706028] sd 1:2:0:0: [sdd] Write Protect is off
[  358.706030] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.706042] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706055] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.706063] sd 1:3:0:0: [sde] Write Protect is off
[  358.706066] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.706077] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706090] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.706098] sd 1:5:0:0: [sdf] Write Protect is off
[  358.706101] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.706112] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  404.739637] ata1.15: limiting speed to UDMA7:PIO5
[  404.739644] ata1.00: failed to read SCR 1 (Emask=0x40)
[  404.739648] ata1.01: failed to read SCR 1 (Emask=0x40)
[  404.739651] ata1.02: failed to read SCR 1 (Emask=0x40)
[  404.739654] ata1.03: failed to read SCR 1 (Emask=0x40)
[  404.739657] ata1.04: failed to read SCR 1 (Emask=0x40)
[  404.739660] ata1.05: failed to read SCR 1 (Emask=0x40)
[  404.739663] ata1.06: failed to read SCR 1 (Emask=0x40)
[  404.739667] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  404.739671] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  404.739675] ata1: SError: { 10B8B }
[  404.739679] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739685] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739690] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739695] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739700] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739705] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739710] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739718] ata1.15: hard resetting link
[  409.830262] ata1.15: SATA link down (SStatus 1 SControl 10)
[  410.082180] ata1.15: qc timeout (cmd 0xe4)
[  410.082188] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  410.082191] ata1.15: PMP revalidation failed (errno=-5)
[  410.082194] ata1.15: retrying hardreset in 5 secs
[  415.084662] ata1.15: hard resetting link
[  420.179121] ata1.15: SATA link down (SStatus 1 SControl 10)
[  420.431039] ata1.15: qc timeout (cmd 0xe4)
[  420.431047] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  420.431050] ata1.15: PMP revalidation failed (errno=-5)
[  420.431054] ata1.15: retrying hardreset in 5 secs
[  425.433523] ata1.15: hard resetting link
[  435.438490] ata1.15: softreset failed (timeout)
[  435.438494] ata1.15: hard resetting link
[  445.443457] ata1.15: softreset failed (timeout)
[  445.443463] ata1.15: hard resetting link
[  480.432842] ata1.15: softreset failed (timeout)
[  480.432850] ata1.15: hard resetting link
[  485.431325] ata1.15: softreset failed (timeout)
[  485.431329] ata1.15: failed to reset PMP, giving up
[  485.431332] ata1.15: Port Multiplier detaching
[  485.431340] ata1.00: disabled
[  485.431343] ata1.01: disabled
[  485.431346] ata1.02: disabled
[  485.431348] ata1.03: disabled
[  485.431350] ata1.05: disabled
[  485.431354] ata1.00: disabled
[  485.431360] ata1: hard resetting link
[  495.436287] ata1: softreset failed (timeout)
[  495.436290] ata1: hard resetting link
[  505.441252] ata1: softreset failed (timeout)
[  505.441255] ata1: hard resetting link
[  540.430639] ata1: softreset failed (timeout)
[  540.430647] ata1: limiting SATA link speed to 1.5 Gbps
[  540.430650] ata1: hard resetting link
[  545.525097] ata1: SATA link down (SStatus 1 SControl 10)
[  545.525115] ata1: EH complete
[  545.525125] ata1.00: detaching (SCSI 1:0:0:0)
[  545.525299] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  545.525613] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[  545.525617] sd 1:0:0:0: [sdb] Stopping disk
[  545.525623] sd 1:0:0:0: [sdb] START_STOP FAILED
[  545.525626] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[  545.525663] ata1.01: detaching (SCSI 1:1:0:0)
[  545.525799] sd 1:1:0:0: [sdc] Synchronizing SCSI cache
[  545.525944] sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  545.525948] sd 1:1:0:0: [sdc] Stopping disk
[  545.525970] sd 1:1:0:0: [sdc] START_STOP FAILED
[  545.525972] sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  545.526000] ata1.02: detaching (SCSI 1:2:0:0)
[  545.526146] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[  545.527048] sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  545.527053] sd 1:2:0:0: [sdd] Stopping disk
[  545.527071] sd 1:2:0:0: [sdd] START_STOP FAILED
[  545.527074] sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  545.527106] ata1.03: detaching (SCSI 1:3:0:0)
[  545.527246] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  545.527287] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  545.527290] sd 1:3:0:0: [sde] Stopping disk
[  545.527304] sd 1:3:0:0: [sde] START_STOP FAILED
[  545.527306] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  545.527333] ata1.05: detaching (SCSI 1:5:0:0)
[  545.527451] sd 1:5:0:0: [sdf] Stopping disk
[  545.527459] sd 1:5:0:0: [sdf] START_STOP FAILED
[  545.527462] sd 1:5:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
[  559.279656] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
[  559.279662] ata1: irq_stat 0x00a40080, device exchanged
[  559.279673] ata1: hard resetting link
[  563.427669] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  563.679583] ata1.15: qc timeout (cmd 0xe4)
[  563.679589] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  563.679593] ata1: failed to recover some devices, retrying in 5 secs
[  568.682071] ata1: hard resetting link
[  578.687033] ata1: softreset failed (timeout)
[  578.687039] ata1: hard resetting link
[  588.691996] ata1: softreset failed (timeout)
[  588.691999] ata1: hard resetting link
[  623.681382] ata1: softreset failed (timeout)
[  623.681390] ata1: limiting SATA link speed to 1.5 Gbps
[  623.681393] ata1: hard resetting link
[  628.679864] ata1: softreset failed (timeout)
[  628.679867] ata1: reset failed, giving up
[  628.679878] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xa frozen t4
[  628.679883] ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
[  628.679892] ata1: hard resetting link
[  638.684830] ata1: softreset failed (timeout)
[  638.684836] ata1: hard resetting link
[  648.689795] ata1: softreset failed (timeout)
[  648.689801] ata1: hard resetting link
[  683.679179] ata1: softreset failed (timeout)
[  683.679186] ata1: limiting SATA link speed to 1.5 Gbps
[  683.679189] ata1: hard resetting link
[  688.677661] ata1: softreset failed (timeout)
[  688.677664] ata1: reset failed, giving up
[  688.677670] ata1: EH complete
[  776.735711] ata2: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
[  776.735717] ata2: irq_stat 0x00a40080, device exchanged
[  776.735721] ata2: SError: { PHYRdyChg }
[  776.735731] ata2: hard resetting link
[  786.739911] ata2: softreset failed (timeout)
[  786.739918] ata2: hard resetting link
[  796.744875] ata2: softreset failed (timeout)
[  796.744881] ata2: hard resetting link
[  831.734261] ata2: softreset failed (timeout)
[  831.734268] ata2: limiting SATA link speed to 1.5 Gbps
[  831.734271] ata2: hard resetting link
[  836.732744] ata2: softreset failed (timeout)
[  836.732747] ata2: reset failed, giving up
[  836.732753] ata2: EH complete
[ 1001.096027] ACPI: PCI interrupt for device 0000:00:0c.0 disabled
[ 1051.175431] sata_sil24 0000:00:0c.0: version 1.1
[ 1051.175576] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
[ 1051.175960] PCI: Disallowing DAC for device 0000:00:0c.0
[ 1051.176552] scsi5 : sata_sil24
[ 1051.177500] scsi6 : sata_sil24
[ 1051.178092] scsi7 : sata_sil24
[ 1051.178658] scsi8 : sata_sil24
[ 1051.178696] ata5: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
[ 1051.178701] ata6: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[ 1051.178705] ata7: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[ 1051.178709] ata8: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[ 1061.180649] ata5: softreset failed (timeout)
[ 1071.185612] ata5: softreset failed (timeout)
[ 1106.174999] ata5: softreset failed (timeout)
[ 1111.173481] ata5: softreset failed (timeout)
[ 1111.173484] ata5: reset failed, giving up
[ 1116.267939] ata6: SATA link down (SStatus 1 SControl 10)
[ 1118.347308] ata7: SATA link down (SStatus 0 SControl 0)
[ 1120.426676] ata8: SATA link down (SStatus 0 SControl 0)

--------------080405040801090803040005
Content-Type: text/plain;
 name="7_ModuleReload2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="7_ModuleReload2.log"

 found
[   71.213332] hub 5-0:1.0: 2 ports detected
[   71.317585] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.319838] Audigy2 value: Special config.
[   73.765264] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.765268] Copyright (c) 1999-2006 Intel Corporation.
[   73.765309] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.765314] PCI: Disallowing DAC for device 0000:00:0e.0
[   74.025736] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   74.201234] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   74.355702] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   74.355715] ReiserFS: hdb1: using ordered data mode
[   74.392680] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.394057] ReiserFS: hdb1: checking transaction log (hdb1)
[   74.489291] ReiserFS: hdb1: Using r5 hash to sort names
[   74.553988] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   74.553998] ReiserFS: hda2: using ordered data mode
[   74.558818] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   74.560151] ReiserFS: hda2: checking transaction log (hda2)
[   74.623128] ReiserFS: hda2: Using r5 hash to sort names
[   80.456682] hda: UDMA/100 mode selected
[   80.460729] hdb: UDMA/133 mode selected
[   80.515263] hdc: UDMA/33 mode selected
[   80.532803] hdd: UDMA/33 mode selected
[   83.053804] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   87.342494] w83627hf: Found W83697HF chip at 0x290
[  159.125858] ata1.00: failed to read SCR 1 (Emask=0x40)
[  159.125863] ata1.01: failed to read SCR 1 (Emask=0x40)
[  159.125866] ata1.02: failed to read SCR 1 (Emask=0x40)
[  159.125869] ata1.03: failed to read SCR 1 (Emask=0x40)
[  159.125871] ata1.04: failed to read SCR 1 (Emask=0x40)
[  159.125874] ata1.05: failed to read SCR 1 (Emask=0x40)
[  159.125876] ata1.06: failed to read SCR 1 (Emask=0x40)
[  159.125880] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  159.125883] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  159.125886] ata1: SError: { 10B8B }
[  159.125890] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125895] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125899] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125904] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125908] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125912] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125917] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  159.125923] ata1.15: hard resetting link
[  164.216778] ata1.15: SATA link down (SStatus 1 SControl 0)
[  164.468696] ata1.15: qc timeout (cmd 0xe4)
[  164.468703] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  164.468706] ata1.15: PMP revalidation failed (errno=-5)
[  164.468708] ata1.15: retrying hardreset in 5 secs
[  169.471177] ata1.15: hard resetting link
[  174.565637] ata1.15: SATA link down (SStatus 1 SControl 0)
[  174.817555] ata1.15: qc timeout (cmd 0xe4)
[  174.817562] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  174.817565] ata1.15: PMP revalidation failed (errno=-5)
[  174.817568] ata1.15: limiting SATA link speed to 1.5 Gbps
[  174.817570] ata1.15: retrying hardreset in 5 secs
[  179.820043] ata1.15: hard resetting link
[  182.019380] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  182.019590] ata1.00: hard resetting link
[  182.339460] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  182.339463] ata1.01: hard resetting link
[  182.659362] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.659365] ata1.02: hard resetting link
[  182.979265] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  182.979269] ata1.03: hard resetting link
[  183.299169] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  183.299172] ata1.04: hard resetting link
[  183.619071] ata1.04: SATA link down (SStatus 0 SControl 310)
[  183.619074] ata1.05: hard resetting link
[  183.938971] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  183.938975] ata1.06: hard resetting link
[  184.258874] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  184.261106] ata1.00: configured for UDMA/100
[  184.263303] ata1.01: configured for UDMA/100
[  184.263398] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  184.263401] ata1.02: revalidation failed (errno=-5)
[  184.263406] ata1.15: hard resetting link
[  186.462034] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  186.462308] ata1.00: hard resetting link
[  186.782113] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  186.782117] ata1.01: hard resetting link
[  187.102015] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.102018] ata1.02: hard resetting link
[  187.421918] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.421922] ata1.03: hard resetting link
[  187.741820] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  187.741823] ata1.04: hard resetting link
[  188.061723] ata1.04: SATA link down (SStatus 0 SControl 310)
[  188.061727] ata1.05: hard resetting link
[  188.381625] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  188.381628] ata1.06: hard resetting link
[  188.701528] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  188.703706] ata1.00: configured for UDMA/100
[  188.705935] ata1.01: configured for UDMA/100
[  188.811817] ata1.02: configured for UDMA/100
[  188.915919] ata1.03: configured for UDMA/100
[  188.916051] ata1.05: device is on DMA blacklist, disabling DMA
[  188.916182] ata1.05: configured for PIO4
[  188.916453] ata1: EH complete
[  188.916481] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916492] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916496] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916508] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916524] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916532] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916535] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916546] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916560] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916567] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916570] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916581] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916595] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916602] sd 1:3:0:0: [sde] Write Protect is off
[  188.916605] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916616] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916629] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916637] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916640] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916651] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  188.916664] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  188.916671] sd 1:0:0:0: [sdb] Write Protect is off
[  188.916674] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  188.916686] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916698] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  188.916705] sd 1:1:0:0: [sdc] Write Protect is off
[  188.916708] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  188.916720] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916732] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  188.916739] sd 1:2:0:0: [sdd] Write Protect is off
[  188.916742] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  188.916753] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916766] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  188.916773] sd 1:3:0:0: [sde] Write Protect is off
[  188.916776] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  188.916787] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  188.916799] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  188.916807] sd 1:5:0:0: [sdf] Write Protect is off
[  188.916810] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  188.916821] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  233.874452] ata1.00: failed to read SCR 1 (Emask=0x40)
[  233.874458] ata1.01: failed to read SCR 1 (Emask=0x40)
[  233.874462] ata1.02: failed to read SCR 1 (Emask=0x40)
[  233.874465] ata1.03: failed to read SCR 1 (Emask=0x40)
[  233.874468] ata1.04: failed to read SCR 1 (Emask=0x40)
[  233.874471] ata1.05: failed to read SCR 1 (Emask=0x40)
[  233.874474] ata1.06: failed to read SCR 1 (Emask=0x40)
[  233.874478] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  233.874482] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  233.874486] ata1: SError: { 10B8B }
[  233.874490] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874495] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874501] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874506] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874511] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874516] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874521] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  233.874529] ata1.15: hard resetting link
[  238.966100] ata1.15: SATA link down (SStatus 1 SControl 10)
[  239.218017] ata1.15: qc timeout (cmd 0xe4)
[  239.218026] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  239.218029] ata1.15: PMP revalidation failed (errno=-5)
[  239.218032] ata1.15: retrying hardreset in 5 secs
[  244.220499] ata1.15: hard resetting link
[  249.314958] ata1.15: SATA link down (SStatus 1 SControl 10)
[  249.566876] ata1.15: qc timeout (cmd 0xe4)
[  249.566883] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  249.566886] ata1.15: PMP revalidation failed (errno=-5)
[  249.566890] ata1.15: retrying hardreset in 5 secs
[  254.569359] ata1.15: hard resetting link
[  256.768701] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  256.768897] ata1.00: hard resetting link
[  257.088783] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  257.088787] ata1.01: hard resetting link
[  257.408684] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.408688] ata1.02: hard resetting link
[  257.728587] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.728591] ata1.03: hard resetting link
[  258.048491] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  258.048495] ata1.04: hard resetting link
[  258.368394] ata1.04: SATA link down (SStatus 0 SControl 310)
[  258.368397] ata1.05: hard resetting link
[  258.688294] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  258.688298] ata1.06: hard resetting link
[  259.008199] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  259.008295] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  259.008299] ata1.00: revalidation failed (errno=-5)
[  259.008304] ata1.15: hard resetting link
[  261.207356] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  261.207634] ata1.00: hard resetting link
[  261.527434] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  261.527439] ata1.01: hard resetting link
[  261.847337] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  261.847340] ata1.02: hard resetting link
[  262.167238] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.167242] ata1.03: hard resetting link
[  262.487142] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  262.487146] ata1.04: hard resetting link
[  262.807046] ata1.04: SATA link down (SStatus 0 SControl 310)
[  262.807050] ata1.05: hard resetting link
[  263.126946] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  263.126950] ata1.06: hard resetting link
[  263.446852] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  263.449093] ata1.00: configured for UDMA/100
[  263.451311] ata1.01: configured for UDMA/100
[  263.556976] ata1.02: configured for UDMA/100
[  263.658661] ata1.03: configured for UDMA/100
[  263.658793] ata1.05: device is on DMA blacklist, disabling DMA
[  263.658923] ata1.05: configured for PIO4
[  263.659192] ata1: EH complete
[  263.659218] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659229] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659232] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659245] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659260] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659267] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659270] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659281] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659295] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659303] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659305] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659317] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659330] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659337] sd 1:3:0:0: [sde] Write Protect is off
[  263.659340] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659351] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659365] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659372] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659375] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659386] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  263.659399] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  263.659407] sd 1:0:0:0: [sdb] Write Protect is off
[  263.659409] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  263.659421] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659433] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  263.659440] sd 1:1:0:0: [sdc] Write Protect is off
[  263.659443] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  263.659454] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659467] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  263.659474] sd 1:2:0:0: [sdd] Write Protect is off
[  263.659477] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  263.659488] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659500] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  263.659508] sd 1:3:0:0: [sde] Write Protect is off
[  263.659511] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  263.659522] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  263.659534] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  263.659541] sd 1:5:0:0: [sdf] Write Protect is off
[  263.659544] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  263.659555] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  337.619074] ata1.00: failed to read SCR 1 (Emask=0x40)
[  337.619079] ata1.01: failed to read SCR 1 (Emask=0x40)
[  337.619083] ata1.02: failed to read SCR 1 (Emask=0x40)
[  337.619086] ata1.03: failed to read SCR 1 (Emask=0x40)
[  337.619089] ata1.04: failed to read SCR 1 (Emask=0x40)
[  337.619092] ata1.05: failed to read SCR 1 (Emask=0x40)
[  337.619095] ata1.06: failed to read SCR 1 (Emask=0x40)
[  337.619099] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  337.619103] ata1.15: irq_stat 0x01940090, PHY RDY changed
[  337.619107] ata1: SError: { 10B8B }
[  337.619111] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619116] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619122] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619127] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619132] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619137] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619142] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  337.619150] ata1.15: hard resetting link
[  339.695540] ata1.15: SATA link down (SStatus 0 SControl 10)
[  339.947457] ata1.15: qc timeout (cmd 0xe4)
[  339.947465] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  339.947469] ata1.15: PMP revalidation failed (errno=-5)
[  339.947472] ata1.15: retrying hardreset in 5 secs
[  344.949939] ata1.15: hard resetting link
[  347.029314] ata1.15: SATA link down (SStatus 0 SControl 10)
[  347.281232] ata1.15: qc timeout (cmd 0xe4)
[  347.281239] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  347.281242] ata1.15: PMP revalidation failed (errno=-5)
[  347.281246] ata1.15: retrying hardreset in 5 secs
[  352.283714] ata1.15: hard resetting link
[  356.250521] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  356.250717] ata1.00: hard resetting link
[  356.570601] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  356.570605] ata1.01: hard resetting link
[  356.890503] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  356.890507] ata1.02: hard resetting link
[  357.210406] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.210411] ata1.03: hard resetting link
[  357.530309] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  357.530313] ata1.04: hard resetting link
[  357.850212] ata1.04: SATA link down (SStatus 0 SControl 310)
[  357.850216] ata1.05: hard resetting link
[  358.170112] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  358.170116] ata1.06: hard resetting link
[  358.490020] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  358.492276] ata1.00: configured for UDMA/100
[  358.494506] ata1.01: configured for UDMA/100
[  358.595946] ata1.02: configured for UDMA/100
[  358.705215] ata1.03: configured for UDMA/100
[  358.705316] ata1.05: device is on DMA blacklist, disabling DMA
[  358.705472] ata1.05: configured for PIO4
[  358.705734] ata1: EH complete
[  358.705759] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705773] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705776] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705789] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705804] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705812] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705815] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.705827] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705841] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.705849] sd 1:2:0:0: [sdd] Write Protect is off
[  358.705852] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.705863] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705877] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.705885] sd 1:3:0:0: [sde] Write Protect is off
[  358.705888] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.705900] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705913] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.705921] sd 1:5:0:0: [sdf] Write Protect is off
[  358.705924] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.705936] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  358.705949] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  358.705957] sd 1:0:0:0: [sdb] Write Protect is off
[  358.705960] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  358.705972] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.705985] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  358.705992] sd 1:1:0:0: [sdc] Write Protect is off
[  358.705995] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  358.706007] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706020] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  358.706028] sd 1:2:0:0: [sdd] Write Protect is off
[  358.706030] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  358.706042] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706055] sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  358.706063] sd 1:3:0:0: [sde] Write Protect is off
[  358.706066] sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  358.706077] sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  358.706090] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  358.706098] sd 1:5:0:0: [sdf] Write Protect is off
[  358.706101] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  358.706112] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  404.739637] ata1.15: limiting speed to UDMA7:PIO5
[  404.739644] ata1.00: failed to read SCR 1 (Emask=0x40)
[  404.739648] ata1.01: failed to read SCR 1 (Emask=0x40)
[  404.739651] ata1.02: failed to read SCR 1 (Emask=0x40)
[  404.739654] ata1.03: failed to read SCR 1 (Emask=0x40)
[  404.739657] ata1.04: failed to read SCR 1 (Emask=0x40)
[  404.739660] ata1.05: failed to read SCR 1 (Emask=0x40)
[  404.739663] ata1.06: failed to read SCR 1 (Emask=0x40)
[  404.739667] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  404.739671] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  404.739675] ata1: SError: { 10B8B }
[  404.739679] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739685] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739690] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739695] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739700] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739705] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739710] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  404.739718] ata1.15: hard resetting link
[  409.830262] ata1.15: SATA link down (SStatus 1 SControl 10)
[  410.082180] ata1.15: qc timeout (cmd 0xe4)
[  410.082188] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  410.082191] ata1.15: PMP revalidation failed (errno=-5)
[  410.082194] ata1.15: retrying hardreset in 5 secs
[  415.084662] ata1.15: hard resetting link
[  420.179121] ata1.15: SATA link down (SStatus 1 SControl 10)
[  420.431039] ata1.15: qc timeout (cmd 0xe4)
[  420.431047] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  420.431050] ata1.15: PMP revalidation failed (errno=-5)
[  420.431054] ata1.15: retrying hardreset in 5 secs
[  425.433523] ata1.15: hard resetting link
[  435.438490] ata1.15: softreset failed (timeout)
[  435.438494] ata1.15: hard resetting link
[  445.443457] ata1.15: softreset failed (timeout)
[  445.443463] ata1.15: hard resetting link
[  480.432842] ata1.15: softreset failed (timeout)
[  480.432850] ata1.15: hard resetting link
[  485.431325] ata1.15: softreset failed (timeout)
[  485.431329] ata1.15: failed to reset PMP, giving up
[  485.431332] ata1.15: Port Multiplier detaching
[  485.431340] ata1.00: disabled
[  485.431343] ata1.01: disabled
[  485.431346] ata1.02: disabled
[  485.431348] ata1.03: disabled
[  485.431350] ata1.05: disabled
[  485.431354] ata1.00: disabled
[  485.431360] ata1: hard resetting link
[  495.436287] ata1: softreset failed (timeout)
[  495.436290] ata1: hard resetting link
[  505.441252] ata1: softreset failed (timeout)
[  505.441255] ata1: hard resetting link
[  540.430639] ata1: softreset failed (timeout)
[  540.430647] ata1: limiting SATA link speed to 1.5 Gbps
[  540.430650] ata1: hard resetting link
[  545.525097] ata1: SATA link down (SStatus 1 SControl 10)
[  545.525115] ata1: EH complete
[  545.525125] ata1.00: detaching (SCSI 1:0:0:0)
[  545.525299] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  545.525613] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[  545.525617] sd 1:0:0:0: [sdb] Stopping disk
[  545.525623] sd 1:0:0:0: [sdb] START_STOP FAILED
[  545.525626] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[  545.525663] ata1.01: detaching (SCSI 1:1:0:0)
[  545.525799] sd 1:1:0:0: [sdc] Synchronizing SCSI cache
[  545.525944] sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  545.525948] sd 1:1:0:0: [sdc] Stopping disk
[  545.525970] sd 1:1:0:0: [sdc] START_STOP FAILED
[  545.525972] sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  545.526000] ata1.02: detaching (SCSI 1:2:0:0)
[  545.526146] sd 1:2:0:0: [sdd] Synchronizing SCSI cache
[  545.527048] sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  545.527053] sd 1:2:0:0: [sdd] Stopping disk
[  545.527071] sd 1:2:0:0: [sdd] START_STOP FAILED
[  545.527074] sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  545.527106] ata1.03: detaching (SCSI 1:3:0:0)
[  545.527246] sd 1:3:0:0: [sde] Synchronizing SCSI cache
[  545.527287] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  545.527290] sd 1:3:0:0: [sde] Stopping disk
[  545.527304] sd 1:3:0:0: [sde] START_STOP FAILED
[  545.527306] sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
[  545.527333] ata1.05: detaching (SCSI 1:5:0:0)
[  545.527451] sd 1:5:0:0: [sdf] Stopping disk
[  545.527459] sd 1:5:0:0: [sdf] START_STOP FAILED
[  545.527462] sd 1:5:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
[  559.279656] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
[  559.279662] ata1: irq_stat 0x00a40080, device exchanged
[  559.279673] ata1: hard resetting link
[  563.427669] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  563.679583] ata1.15: qc timeout (cmd 0xe4)
[  563.679589] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  563.679593] ata1: failed to recover some devices, retrying in 5 secs
[  568.682071] ata1: hard resetting link
[  578.687033] ata1: softreset failed (timeout)
[  578.687039] ata1: hard resetting link
[  588.691996] ata1: softreset failed (timeout)
[  588.691999] ata1: hard resetting link
[  623.681382] ata1: softreset failed (timeout)
[  623.681390] ata1: limiting SATA link speed to 1.5 Gbps
[  623.681393] ata1: hard resetting link
[  628.679864] ata1: softreset failed (timeout)
[  628.679867] ata1: reset failed, giving up
[  628.679878] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xa frozen t4
[  628.679883] ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
[  628.679892] ata1: hard resetting link
[  638.684830] ata1: softreset failed (timeout)
[  638.684836] ata1: hard resetting link
[  648.689795] ata1: softreset failed (timeout)
[  648.689801] ata1: hard resetting link
[  683.679179] ata1: softreset failed (timeout)
[  683.679186] ata1: limiting SATA link speed to 1.5 Gbps
[  683.679189] ata1: hard resetting link
[  688.677661] ata1: softreset failed (timeout)
[  688.677664] ata1: reset failed, giving up
[  688.677670] ata1: EH complete
[  776.735711] ata2: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
[  776.735717] ata2: irq_stat 0x00a40080, device exchanged
[  776.735721] ata2: SError: { PHYRdyChg }
[  776.735731] ata2: hard resetting link
[  786.739911] ata2: softreset failed (timeout)
[  786.739918] ata2: hard resetting link
[  796.744875] ata2: softreset failed (timeout)
[  796.744881] ata2: hard resetting link
[  831.734261] ata2: softreset failed (timeout)
[  831.734268] ata2: limiting SATA link speed to 1.5 Gbps
[  831.734271] ata2: hard resetting link
[  836.732744] ata2: softreset failed (timeout)
[  836.732747] ata2: reset failed, giving up
[  836.732753] ata2: EH complete
[ 1001.096027] ACPI: PCI interrupt for device 0000:00:0c.0 disabled
[ 1051.175431] sata_sil24 0000:00:0c.0: version 1.1
[ 1051.175576] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
[ 1051.175960] PCI: Disallowing DAC for device 0000:00:0c.0
[ 1051.176552] scsi5 : sata_sil24
[ 1051.177500] scsi6 : sata_sil24
[ 1051.178092] scsi7 : sata_sil24
[ 1051.178658] scsi8 : sata_sil24
[ 1051.178696] ata5: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
[ 1051.178701] ata6: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[ 1051.178705] ata7: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[ 1051.178709] ata8: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[ 1061.180649] ata5: softreset failed (timeout)
[ 1071.185612] ata5: softreset failed (timeout)
[ 1106.174999] ata5: softreset failed (timeout)
[ 1111.173481] ata5: softreset failed (timeout)
[ 1111.173484] ata5: reset failed, giving up
[ 1116.267939] ata6: SATA link down (SStatus 1 SControl 10)
[ 1118.347308] ata7: SATA link down (SStatus 0 SControl 0)
[ 1120.426676] ata8: SATA link down (SStatus 0 SControl 0)
[ 1190.130660] ACPI: PCI interrupt for device 0000:00:0c.0 disabled
[ 1201.390201] libata version 3.00 loaded.
[ 1201.391922] sata_sil24 0000:00:0c.0: version 1.1
[ 1201.391993] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
[ 1201.392356] PCI: Disallowing DAC for device 0000:00:0c.0
[ 1201.393728] scsi9 : sata_sil24
[ 1201.394401] scsi10 : sata_sil24
[ 1201.394980] scsi11 : sata_sil24
[ 1201.395552] scsi12 : sata_sil24
[ 1201.395590] ata1: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
[ 1201.395594] ata2: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[ 1201.395598] ata3: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[ 1201.395603] ata4: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[ 1211.399074] ata1: softreset failed (timeout)
[ 1221.404038] ata1: softreset failed (timeout)
[ 1256.393425] ata1: softreset failed (timeout)
[ 1261.391906] ata1: softreset failed (timeout)
[ 1261.391910] ata1: reset failed, giving up
[ 1266.486364] ata2: SATA link down (SStatus 1 SControl 10)
[ 1268.565732] ata3: SATA link down (SStatus 0 SControl 0)
[ 1270.645101] ata4: SATA link down (SStatus 0 SControl 0)

--------------080405040801090803040005--
