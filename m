From: Stefan <gentoopower@yahoo.de>
Subject: Re:
Date: Thu, 08 Sep 2005 03:21:58 +0200
Message-ID: <431F9236.1040801@yahoo.de>
References: <011401c5b2b2$becb3b40$1f01a8c0@Ric> <431D4C7A.3000908@yahoo.de> <016b01c5b2bc$c2cc93b0$1f01a8c0@Ric> <431D76CE.5090007@yahoo.de> <007301c5b38d$78f3c750$1f01a8c0@Ric>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:15182 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932749AbVIHBWG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Sep 2005 21:22:06 -0400
In-Reply-To: <007301c5b38d$78f3c750$1f01a8c0@Ric>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Riccardo Castellani <r.castellani@usl6.toscana.it>
Cc: linux-ide@vger.kernel.org

What happens if you check udma level with a live cd like knoppix?

Riccardo Castellani wrote:

> I'm sure that I replaced old 80-wire cable with "newer 80-wire IDE
> cable".
>
>
> ----- Original Message ----- From: "Stefan" <gentoopower@yahoo.de>
> To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
> Cc: <linux-ide@vger.kernel.org>
> Sent: Tuesday, September 06, 2005 1:00 PM
> Subject: Re:
>
>
>> Riccardo Castellani wrote:
>>
>>> I bought it directly from store.
>>> Several weeks ago I had problems with IDE cable and I could see UDMA5
>>> (with "hdparm" command) inside UDMA modes list. UDMA was the current
>>> active mode.
>>> Then I replaced 80- wire cable and I needed (for other reasons) again
>>> to reinstall operating system FC3 and now I'm here.
>>
>>
>> Well you probably answered the question yourself now, you must have
>> installed a cable only capable of udma2/udma 33.
>> The older ide cables have sligthly thicker lines than the >udma2 cables,
>> they have the same connector and of course there are mire connected pins
>> on the >udma2
>> cables but you don't see that if looking at the connector.
>>
>>>
>>> ----- Original Message ----- From: "Stefan" <gentoopower@yahoo.de>
>>> To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
>>> Cc: <linux-ide@vger.kernel.org>
>>> Sent: Tuesday, September 06, 2005 9:59 AM
>>> Subject: Re:
>>>
>>>
>>>> Riccardo Castellani wrote:
>>>>
>>>>> My HD supports  U-ATA 133 while motherboard supports U-ATA 100.
>>>>> (Fedora Core 3)
>>>>> DMA works at 33 Mhz (UDMA2) !?!
>>>>> WHY ? How Can I set to UDMA5 ?
>>>>
>>>>
>>>>
>>>> To change to udma5 run:
>>>>
>>>> hdparm -X udma5
>>>>
>>>>>
>>>>>
>>>>> With  "hdparm -i /dev/hda" I can see:
>>>>>
>>>>> Model=Maxtor 6Y080L0, FwRev=YAR41BW0, SerialNo=Y23TZR2C
>>>>> Config={ Fixed }
>>>>> RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>>>>> BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
>>>>> CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=160086528
>>>>> IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>>>>> PIO modes:  pio0 pio1 pio2 pio3 pio4
>>>>> DMA modes:  mdma0 mdma1 mdma2
>>>>> UDMA modes: udma0 udma1 *udma2
>>>>> AdvancedPM=yes: disabled (255) WriteCache=enabled
>>>>> Drive conforms to: (null):
>>>>
>>>>
>>>>
>>>>
>>>> Looks like the drive  was switched to only support UDMA2, did you buy
>>>> this drive directly from store?
>>>> This drive can be set to only support udma2 with the help of maxtors
>>>> utility, this is sometimes needed to fix problems with older boards,
>>>> so if you bought this drive from someone, there is a chance, that this
>>>> person switched the udma mode for that drive.
>>>> If you got it directly from a store, then this should not be the case.
>>>>
>>>>>
>>>>>
>>>>>
>>>>> dmesg gives:
>>>>>
>>>>> Linux version 2.6.12-1.1376_FC3 (bhcompile@tweety.build.redhat.com)
>>>>> (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 Fri Aug 26 23:27:26
>>>>> EDT 2005
>>>>> BIOS-provided physical RAM map:
>>>>> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>>>>> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>>>>> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>>>>> BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
>>>>> BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
>>>>> BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
>>>>> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>>>>> 0MB HIGHMEM available.
>>>>> 255MB LOWMEM available.
>>>>> Using x86 segment limits to approximate NX protection
>>>>> On node 0 totalpages: 65520
>>>>>  DMA zone: 4096 pages, LIFO batch:1
>>>>>  Normal zone: 61424 pages, LIFO batch:31
>>>>>  HighMem zone: 0 pages, LIFO batch:1
>>>>> DMI 2.3 present.
>>>>> ACPI: RSDP (v000 AMI                                   ) @ 0x000fc570
>>>>> ACPI: RSDT (v001 AMIINT VIA_P6   0x00000010 MSFT 0x00000097) @
>>>>> 0x0fff0000
>>>>> ACPI: FADT (v001 AMIINT VIA_P6   0x00000011 MSFT 0x00000097) @
>>>>> 0x0fff0030
>>>>> ACPI: DSDT (v001    VIA APOLLO-P 0x00001000 MSFT 0x0100000b) @
>>>>> 0x00000000
>>>>> ACPI: BIOS age (2000) fails cutoff (2001), acpi=force is required to
>>>>> enable ACPI
>>>>> ACPI: Disabling ACPI support
>>>>> Allocating PCI resources starting at 10000000 (gap:
>>>>> 10000000:efff0000)
>>>>> Built 1 zonelists
>>>>> Kernel command line: ro root=LABEL=/
>>>>> Initializing CPU#0
>>>>> CPU 0 irqstacks, hard=c0447000 soft=c0446000
>>>>> PID hash table entries: 1024 (order: 10, 16384 bytes)
>>>>> Detected 798.270 MHz processor.
>>>>> Using tsc for high-res timesource
>>>>> Console: colour VGA+ 80x25
>>>>> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>>>>> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>>>>> Memory: 254828k/262080k available (2450k kernel code, 6572k reserved,
>>>>> 694k data, 180k init, 0k highmem)
>>>>> Checking if this processor honours the WP bit even in supervisor
>>>>> mode... Ok.
>>>>> Calibrating delay loop... 1568.76 BogoMIPS (lpj=784384)
>>>>> Security Framework v1.0.0 initialized
>>>>> SELinux:  Initializing.
>>>>> SELinux:  Starting in permissive mode
>>>>> selinux_register_security:  Registering secondary module capability
>>>>> Capability LSM initialized as secondary
>>>>> Mount-cache hash table entries: 512
>>>>> CPU: After generic identify, caps: 0383f9ff 00000000 00000000
>>>>> 00000000
>>>>> 00000000 00000000 00000000
>>>>> CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
>>>>> 00000000 00000000 00000000
>>>>> CPU: L1 I cache: 16K, L1 D cache: 16K
>>>>> CPU: L2 cache: 256K
>>>>> CPU: After all inits, caps: 0383f1ff 00000000 00000000 00000040
>>>>> 00000000 00000000 00000000
>>>>> Intel machine check architecture supported.
>>>>> Intel machine check reporting enabled on CPU#0.
>>>>> CPU: Intel Pentium III (Coppermine) stepping 06
>>>>> Enabling fast FPU save and restore... done.
>>>>> Enabling unmasked SIMD FPU exception support... done.
>>>>> Checking 'hlt' instruction... OK.
>>>>> checking if image is initramfs... it is
>>>>> Freeing initrd memory: 399k freed
>>>>> NET: Registered protocol family 16
>>>>> PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
>>>>> PCI: Using configuration type 1
>>>>> mtrr: v2.0 (20020519)
>>>>> ACPI: Subsystem revision 20050729
>>>>> ACPI: Interpreter disabled.
>>>>> Linux Plug and Play Support v0.97 (c) Adam Belay
>>>>> pnp: PnP ACPI: disabled
>>>>> usbcore: registered new driver usbfs
>>>>> usbcore: registered new driver hub
>>>>> PCI: Probing PCI hardware
>>>>> PCI: Probing PCI hardware (bus 00)
>>>>> Boot video device is 0000:01:00.0
>>>>> PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
>>>>> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
>>>>> audit: initializing netlink socket (disabled)
>>>>> audit(1125948457.147:1): initialized
>>>>> Total HugeTLB memory allocated, 0
>>>>> VFS: Disk quotas dquot_6.5.1
>>>>> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>>>>> SELinux:  Registering netfilter hooks
>>>>> Initializing Cryptographic API
>>>>> ksign: Installing public key data
>>>>> Loading keyring
>>>>> - Added public key ACD1A80A1D789A78
>>>>> - User ID: Red Hat, Inc. (Kernel Module GPG key)
>>>>> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>>>>> isapnp: Scanning for PnP cards...
>>>>> isapnp: No Plug & Play device found
>>>>> Real Time Clock Driver v1.12
>>>>> Linux agpgart interface v0.101 (c) Dave Jones
>>>>> agpgart: Detected VIA Apollo Pro 133 chipset
>>>>> agpgart: AGP aperture is 64M @ 0xe0000000
>>>>> PNP: No PS/2 controller found. Probing ports directly.
>>>>> serio: i8042 AUX port at 0x60,0x64 irq 12
>>>>> serio: i8042 KBD port at 0x60,0x64 irq 1
>>>>> Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing
>>>>> enabled
>>>>> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>>>> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>>>>> io scheduler noop registered
>>>>> io scheduler anticipatory registered
>>>>> io scheduler deadline registered
>>>>> io scheduler cfq registered
>>>>> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024
>>>>> blocksize
>>>>> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>>>>> ide: Assuming 33MHz system bus speed for PIO modes; override with
>>>>> idebus=xx
>>>>> VP_IDE: IDE controller at PCI slot 0000:00:07.1
>>>>> PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
>>>>> VP_IDE: chipset revision 6
>>>>> VP_IDE: not 100% native mode: will probe irqs later
>>>>> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on
>>>>> pci0000:00:07.1
>>>>>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>>>>>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:DMA
>>>>> Probing IDE interface ide0...
>>>>> hda: Maxtor 6Y080L0, ATA DISK drive
>>>>> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>>>> Probing IDE interface ide1...
>>>>> hdd: LG CD-ROM CRD-8521B, ATAPI CD/DVD-ROM drive
>>>>> ide1 at 0x170-0x177,0x376 on irq 15
>>>>> hda: max request size: 128KiB
>>>>> hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63,
>>>>> UDMA(33)
>>>>> hda: cache flushes supported
>>>>> hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
>>>>> hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
>>>>> Uniform CD-ROM driver Revision: 3.20
>>>>> ide-floppy driver 0.99.newide
>>>>> usbcore: registered new driver hiddev
>>>>> usbcore: registered new driver usbhid
>>>>> drivers/usb/input/hid-core.c: v2.01:USB HID core driver
>>>>> mice: PS/2 mouse device common for all mice
>>>>> md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
>>>>> NET: Registered protocol family 2
>>>>> IP: routing cache hash table of 512 buckets, 16Kbytes
>>>>> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
>>>>> TCP bind hash table entries: 16384 (order: 6, 458752 bytes)
>>>>> TCP: Hash tables configured (established 16384 bind 16384)
>>>>> Initializing IPsec netlink socket
>>>>> NET: Registered protocol family 1
>>>>> NET: Registered protocol family 17
>>>>> Freeing unused kernel memory: 180k freed
>>>>> input: AT Translated Set 2 keyboard on isa0060/serio0
>>>>> kjournald starting.  Commit interval 5 seconds
>>>>> EXT3-fs: mounted filesystem with ordered data mode.
>>>>> SELinux:  Disabled at runtime.
>>>>> SELinux:  Unregistering netfilter hooks
>>>>> Floppy drive(s): fd0 is 1.44M
>>>>> FDC 0 is a post-1991 82077
>>>>> 8139too Fast Ethernet driver 0.9.27
>>>>> PCI: Found IRQ 9 for device 0000:00:0a.0
>>>>> eth0: RealTek RTL8139 at 0xd800, 00:50:bf:5a:8d:bf, IRQ 9
>>>>> eth0:  Identified 8139 chip type 'RTL-8139C'
>>>>> USB Universal Host Controller Interface driver v2.2
>>>>> PCI: Found IRQ 11 for device 0000:00:07.2
>>>>> uhci_hcd 0000:00:07.2: UHCI Host Controller
>>>>> uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
>>>>> uhci_hcd 0000:00:07.2: irq 11, io base 0x0000dc00
>>>>> hub 1-0:1.0: USB hub found
>>>>> hub 1-0:1.0: 2 ports detected
>>>>> md: Autodetecting RAID arrays.
>>>>> md: autorun ...
>>>>> md: ... autorun DONE.
>>>>> EXT3 FS on hda5, internal journal
>>>>> device-mapper: 4.4.0-ioctl (2005-01-12) initialised:
>>>>> dm-devel@redhat.com
>>>>> kjournald starting.  Commit interval 5 seconds
>>>>> EXT3 FS on hda1, internal journal
>>>>> EXT3-fs: mounted filesystem with ordered data mode.
>>>>> kjournald starting.  Commit interval 5 seconds
>>>>> EXT3 FS on hda2, internal journal
>>>>> EXT3-fs: mounted filesystem with ordered data mode.
>>>>> kjournald starting.  Commit interval 5 seconds
>>>>> EXT3 FS on hda8, internal journal
>>>>> EXT3-fs: mounted filesystem with ordered data mode.
>>>>> kjournald starting.  Commit interval 5 seconds
>>>>> EXT3 FS on hda3, internal journal
>>>>> EXT3-fs: mounted filesystem with ordered data mode.
>>>>> Adding 1052216k swap on /dev/hda7.  Priority:-1 extents:1
>>>>> parport_pc: VIA 686A/8231 detected
>>>>> parport_pc: probing current configuration
>>>>> parport_pc: Current parallel port base: 0x378
>>>>> parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
>>>>> parport_pc: VIA parallel port: io=0x378, irq=7
>>>>> ieee1394: Initialized config rom entry `ip1394'
>>>>> ip_tables: (C) 2000-2002 Netfilter core team
>>>>> ip_tables: (C) 2000-2002 Netfilter core team
>>>>> eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
>>>>> i2c /dev entries driver
>>>>> NET: Registered protocol family 10
>>>>> Disabled Privacy Extensions on device c03d60a0(lo)
>>>>> IPv6 over IPv4 tunneling driver
>>>>> eth0: no IPv6 routers present
>>>>> -
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-ide" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> ___________________________________________________________
>>>> Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier
>>>> anmelden: http://mail.yahoo.de
>>>>
>>>
>>>
>>
>>
>>
>>
>>
>>
>> ___________________________________________________________
>> Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier
>> anmelden: http://mail.yahoo.de
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

