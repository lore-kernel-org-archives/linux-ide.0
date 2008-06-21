From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Fri, 20 Jun 2008 17:32:58 -0700 (PDT)
Message-ID: <20080621003258.C9268108035@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40140 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753746AbYFUAdE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 20:33:04 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5L0Wwah010271
	for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 17:32:59 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #2 from gfpadovan@gmail.com  2008-06-20 17:32 -------
-It's a notebook from a Brazilian vendor (Itautec S.A.).
-When ahci is built into kernel the machine shutdown. All okay.
-Kernel boot log:
[   22.444268] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI)
Driver
[   22.444315] USB Universal Host Controller Interface driver v3.0
[   22.452500] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) ->
IRQ 17
[   22.460704] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[   22.460709] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   22.469087] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus
number 3
[   22.469124] usb 1-1: new high speed USB device using ehci_hcd and address 2
[   22.485748] uhci_hcd 0000:00:1a.0: irq 17, io base 0x00001820
[   22.494113] usb usb3: configuration #1 chosen from 1 choice
[   22.502539] hub 3-0:1.0: USB hub found
[   22.510891] hub 3-0:1.0: 2 ports detected
[   22.606758] usb 1-1: configuration #1 chosen from 1 choice
[   22.619329] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) ->
IRQ 21
[   22.627683] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   22.627688] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   22.635988] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus
number 4
[   22.644207] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001840
[   22.652301] usb usb4: configuration #1 chosen from 1 choice
[   22.660383] hub 4-0:1.0: USB hub found
[   22.668275] hub 4-0:1.0: 2 ports detected
[   22.776917] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) ->
IRQ 20
[   22.784727] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   22.784731] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   22.792399] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus
number 5
[   22.800135] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001860
[   22.808018] usb usb5: configuration #1 chosen from 1 choice
[   22.815821] hub 5-0:1.0: USB hub found
[   22.823516] hub 5-0:1.0: 2 ports detected
[   22.834722] usb 2-3: new high speed USB device using ehci_hcd and address 2
[   22.931737] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) ->
IRQ 18
[   22.939336] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   22.939341] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   22.947237] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus
number 6
[   22.955108] uhci_hcd 0000:00:1d.1: irq 18, io base 0x00001880
[   22.963258] usb usb6: configuration #1 chosen from 1 choice
[   22.971202] hub 6-0:1.0: USB hub found
[   22.978965] hub 6-0:1.0: 2 ports detected
[   22.998697] usb 2-3: configuration #1 chosen from 1 choice
[   23.087560] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) ->
IRQ 19
[   23.095394] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   23.095399] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   23.103379] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus
number 7
[   23.111320] uhci_hcd 0000:00:1d.2: irq 19, io base 0x000018a0
[   23.119362] usb usb7: configuration #1 chosen from 1 choice
[   23.127339] hub 7-0:1.0: USB hub found
[   23.135137] hub 7-0:1.0: 2 ports detected
[   23.243399] Initializing USB Mass Storage driver...
[   23.276333] scsi0 : SCSI emulation for USB Mass Storage devices
[   23.284146] usb-storage: device found at 2
[   23.284149] usb-storage: waiting for device to settle before scanning
[   23.380142] usbcore: registered new interface driver usb-storage
[   23.387817] USB Mass Storage support registered.
[   23.395718] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64
irq 1,12
[   23.407493] i8042.c: Detected active multiplexing controller, rev 1.1.
[   23.417430] serio: i8042 KBD port at 0x60,0x64 irq 1
[   23.425326] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   23.433102] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   23.440798] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   23.448326] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   23.462347] mice: PS/2 mouse device common for all mice
[   23.500391] input: AT Translated Set 2 keyboard as /class/input/input1
[   23.586888] usb 7-1: new low speed USB device using uhci_hcd and address 2
[   23.640663] EISA: Probing bus 0 at eisa.0
[   23.648127] Cannot allocate resource for EISA slot 1
[   23.655676] Cannot allocate resource for EISA slot 2
[   23.663124] Cannot allocate resource for EISA slot 3
[   23.670392] EISA: Detected 0 cards.
[   23.677508] cpuidle: using governor ladder
[   23.684593] cpuidle: using governor menu
[   23.772669] usb 7-1: configuration #1 chosen from 1 choice
[   23.782500] usbcore: registered new interface driver hiddev
[   23.802551] input: Microsoft  Microsoft Basic Optical Mouse v2.0  as
/class/input/input2
[   23.812965] input,hidraw0: USB HID v1.11 Mouse [Microsoft  Microsoft Basic
Optical Mouse v2.0 ] on usb-0000:00:1d.2-1
[   23.820378] usbcore: registered new interface driver usbhid
[   23.827788] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   23.835384] TCP cubic registered
[   23.842784] NET: Registered protocol family 1
[   23.850140] NET: Registered protocol family 17
[   23.857544] RPC: Registered udp transport module.
[   23.864835] RPC: Registered tcp transport module.
[   23.871983] Starting balanced_irq
[   23.878983] Using IPI No-Shortcut mode
[   23.886170] Freeing unused kernel memory: 304k freed
[   23.925355] scsi 0:0:0:0: Direct-Access     Generic- Multi-Card       1.00
PQ: 0 ANSI: 0 CCS
[   23.926399] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   24.024696] input: PS/2 Mouse as /class/input/input3
[   24.047170] input: AlpsPS/2 ALPS GlidePoint as /class/input/input4
[   24.123317] sl811: driver sl811-hcd, 19 May 2005
[   24.303397] libata version 3.00 loaded.
[   24.787118] ahci 0000:00:1f.2: version 3.0
[   24.787155] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) ->
IRQ 18
[   25.786485] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7
impl SATA mode
[   25.786489] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum
part
[   25.786496] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   25.786723] scsi1 : ahci
[   25.786810] scsi2 : ahci
[   25.786876] scsi3 : ahci
[   25.786993] ata1: SATA max UDMA/133 abar m2048@0xf4504000 port 0xf4504100
irq 221
[   25.786998] ata2: SATA max UDMA/133 abar m2048@0xf4504000 port 0xf4504180
irq 221
[   25.787002] ata3: SATA max UDMA/133 abar m2048@0xf4504000 port 0xf4504200
irq 221
[   26.241968] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   26.243300] ata1.00: ATA-7: ST94813AS, 3.04, max UDMA/133
[   26.243304] ata1.00: 78140160 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   26.244948] ata1.00: configured for UDMA/133
[   26.547626] ata2: SATA link down (SStatus 0 SControl 300)
[   26.850291] ata3: SATA link down (SStatus 0 SControl 300)
[   26.850402] scsi 1:0:0:0: Direct-Access     ATA      ST94813AS        3.04
PQ: 0 ANSI: 5
[   26.850537] sd 1:0:0:0: [sdb] 78140160 512-byte hardware sectors (40008 MB)
[   26.850550] sd 1:0:0:0: [sdb] Write Protect is off
[   26.850553] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   26.850572] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[   26.850626] sd 1:0:0:0: [sdb] 78140160 512-byte hardware sectors (40008 MB)
[   26.850637] sd 1:0:0:0: [sdb] Write Protect is off
[   26.850640] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   26.850658] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[   26.850661]  sdb: sdb1 sdb2
[   26.897771] sd 1:0:0:0: [sdb] Attached SCSI disk
[   27.027519] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised:
dm-devel@redhat.com
[   27.113059] md: raid0 personality registered for level 0
[   27.151983] md: raid1 personality registered for level 1
[   27.191973] md: raid10 personality registered for level 10
[   27.244708] JFS: nTxBlock = 8011, nTxLock = 64091
[   27.293990] SGI XFS with ACLs, no debug enabled
[   27.294304] SGI XFS Quota Management subsystem
[   27.338141] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   27.338145] Copyright (c) 1999-2006 Intel Corporation.
[   27.453376] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   27.453422] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   27.777218] scsi: <fdomain> Detection failed (no card)
[   27.821022] GDT-HA: Storage RAID Controller Driver. Version: 3.05
[   27.821103] GDT-HA: Found 0 PCI Storage RAID Controllers
[   28.193672] 3ware Storage Controller device driver for Linux v1.26.02.002.
[   28.236506] 3ware 9000 Storage Controller device driver for Linux
v2.26.02.010.
[   28.280495] usb-storage: device scan complete
[   28.280857] sysfs: duplicate filename '0:0:0:0' can not be created
[   28.280861] WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
[   28.280865] Pid: 5480, comm: scsi_scan_0 Not tainted
2.6.24-gentoo-r8_dsk_smp #1
[   28.280879]  [<c01a8a2f>] sysfs_add_one+0x54/0xb8
[   28.280892]  [<c01a8ef4>] create_dir+0x3c/0x6c
[   28.280898]  [<c01a8f51>] sysfs_create_dir+0x2d/0x40
[   28.280902]  [<c026cd4f>] kobject_get+0xf/0x13
[   28.280907]  [<c026d174>] kobject_add+0xe9/0x190
[   28.280911]  [<c026d078>] kobject_set_name+0x81/0x94
[   28.280917]  [<c02cd31d>] device_add+0x8d/0x541
[   28.280925]  [<c02fc0ea>] scsi_sysfs_add_sdev+0x2a/0x142
[   28.280930]  [<c02f342a>] __scsi_iterate_devices+0x44/0x57
[   28.280937]  [<c02fb05b>] do_scan_async+0x6e/0x12c
[   28.280941]  [<c011c3e5>] complete+0x36/0x44
[   28.280947]  [<c02fafed>] do_scan_async+0x0/0x12c
[   28.280958]  [<c01329c7>] kthread+0x38/0x5d
[   28.280963]  [<c013298f>] kthread+0x0/0x5d
[   28.280967]  [<c0104b2b>] kernel_thread_helper+0x7/0x10
[   28.280973]  =======================
[   28.280977] kobject_add failed for 0:0:0:0 with -EEXIST, don't try to
register things with the same name in the same directory.
[   28.280981] Pid: 5480, comm: scsi_scan_0 Not tainted
2.6.24-gentoo-r8_dsk_smp #1
[   28.280985]  [<c026d1e9>] kobject_add+0x15e/0x190
[   28.280989]  [<c026d078>] kobject_set_name+0x81/0x94
[   28.280995]  [<c02cd31d>] device_add+0x8d/0x541
[   28.281001]  [<c02fc0ea>] scsi_sysfs_add_sdev+0x2a/0x142
[   28.281006]  [<c02f342a>] __scsi_iterate_devices+0x44/0x57
[   28.281011]  [<c02fb05b>] do_scan_async+0x6e/0x12c
[   28.281016]  [<c011c3e5>] complete+0x36/0x44
[   28.281021]  [<c02fafed>] do_scan_async+0x0/0x12c
[   28.281025]  [<c01329c7>] kthread+0x38/0x5d
[   28.281029]  [<c013298f>] kthread+0x0/0x5d
[   28.281033]  [<c0104b2b>] kernel_thread_helper+0x7/0x10
[   28.281038]  =======================
[   28.281040] error 1
[   28.282297] Adaptec aacraid driver 1.1-5[2449]-ms
[   28.327709] Loading Adaptec I2O RAID: Version 2.4 Build 5go
[   28.327714] Detecting Adaptec I2O RAID controllers...
[   28.493037] QLogic Fibre Channel HBA Driver
[   29.215423] ipr: IBM Power RAID SCSI Device Driver version: 2.4.1 (April 24,
2007)
[   29.267844] DC390: clustering now enabled by default. If you get problems
load
[   29.267847]  with "disable_clustering=1" and report to maintainers
[   29.318305] nsp32: loading...
[   29.413062] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST
2006)
[   29.478913] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
[   29.529250] Fusion MPT base driver 3.04.06
[   29.529254] Copyright (c) 1999-2007 LSI Corporation
[   29.724131] Fusion MPT SAS Host driver 3.04.06
[   29.822543] Fusion MPT SPI Host driver 3.04.06
[   30.004687] Fusion MPT FC Host driver 3.04.06
[   30.055445] Compaq SMART2 Driver (v 2.6.0)
[   30.106295] HP CISS Driver (v 3.6.14)
[   30.261582] megasas: 00.00.03.10-rc5 Thu May 17 10:09:32 PDT 2007
[   30.348151] Emulex LightPulse Fibre Channel SCSI driver 8.2.2
[   30.348155] Copyright(c) 2004-2007 Emulex.  All rights reserved.
[   31.620851] EXT3-fs: INFO: recovery required on readonly filesystem.
[   31.620856] EXT3-fs: write access will be enabled during recovery.
[   37.864838] kjournald starting.  Commit interval 5 seconds
[   37.864851] EXT3-fs: recovery complete.
[   37.865317] EXT3-fs: mounted filesystem with ordered data mode.
[   41.625786] agpgart: Detected an Intel 965GM Chipset.
[   41.626600] agpgart: Detected 7676K stolen memory.
[   41.706315] agpgart: AGP aperture is 256M @ 0xd0000000
[   42.286417] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) ->
IRQ 22
[   42.286452] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   42.321514] patch_cxthsfmodem: symbol_request(cnxthwhda_probe) failed
[   42.409958] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) ->
IRQ 16
[   42.409977] PCI: Setting latency timer of device 0000:04:00.0 to 64
[   42.410025] sky2 0000:04:00.0: v1.20 addr 0xf4200000 irq 16 Yukon-EC Ultra
(0xb4) rev 3
[   42.410575] sky2 eth0: addr 00:14:0b:44:87:b4
[   42.607091] iTCO_vendor_support: vendor-support=0
[   42.618583] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
[   42.618698] iTCO_wdt: Found a ICH8M TCO device (Version=2, TCOBASE=0x1060)
[   42.618743] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=1)
[   42.820988] ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 19 (level, low) ->
IRQ 18
[   42.826536] input: PC Speaker as /class/input/input5
[   42.855934] Real Time Clock Driver v1.12ac
[   45.535658] EXT3 FS on sdb1, internal journal
[   45.759014] ACPI: AC Adapter [ACAD] (on-line)
[   45.772599] ACPI: SSDT 3F6D5021, 01F6 (r1  PmRef  Cpu0Ist     3000 INTL
20050624)
[   45.772880] ACPI: SSDT 3F6D49B2, 05EA (r1  PmRef  Cpu0Cst     3001 INTL
20050624)
[   45.775013] Monitor-Mwait will be used to enter C-1 state
[   45.775017] Monitor-Mwait will be used to enter C-2 state
[   45.775067] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   45.775074] ACPI: Processor [CPU0] (supports 8 throttling states)
[   45.775375] ACPI: SSDT 3F6D5217, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL
20050624)
[   45.775637] ACPI: SSDT 3F6D4F9C, 0085 (r1  PmRef  Cpu1Cst     3000 INTL
20050624)
[   45.776884] ACPI: CPU1 (power states: C1[C1] C2[C2])
[   45.776893] ACPI: Processor [CPU1] (supports 8 throttling states)
[   45.777006] Marking TSC unstable due to: TSC halts in idle.
[   45.777423] Time: hpet clocksource has been installed.
[   45.863675] ACPI: Battery Slot [BAT0] (battery present)
[   45.878954] input: Power Button (FF) as /class/input/input6
[   45.890577] ACPI: Power Button (FF) [PWRF]
[   45.890671] input: Lid Switch as /class/input/input7
[   45.894675] ACPI: Lid Switch [LID]
[   45.894766] input: Power Button (CM) as /class/input/input8
[   45.906544] ACPI: Power Button (CM) [PWRB]
[   45.906617] input: Sleep Button (CM) as /class/input/input9
[   45.921533] ACPI: Sleep Button (CM) [SLPB]
[   46.137536] No dock devices found.
[   46.164219] ACPI: Transitioning device [FAN0] to D3
[   46.164226] ACPI: Transitioning device [FAN0] to D3
[   46.164234] ACPI: Fan [FAN0] (off)
[   46.164399] ACPI: Transitioning device [FAN1] to D3
[   46.164403] ACPI: Transitioning device [FAN1] to D3
[   46.164409] ACPI: Fan [FAN1] (off)
[   46.273678] ACPI: Thermal Zone [TZ00] (57 C)
[   46.274653] ACPI: Thermal Zone [TZ01] (27 C)
[   46.306172] input: Video Bus as /class/input/input10
[   46.318016] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   46.764228] Adding 996020k swap on /dev/sdb2.  Priority:-1 extents:1
across:996020k
[   62.822590] hda: UDMA/33 mode selected
[   64.226282] hsfengine: module license 'see LICENSE file distributed with
driver' taints kernel.
[   64.477731] sky2 eth0: enabling interface
[   65.530854] usbcore: registered new interface driver hsfusbcd2
[   66.253446] sky2 eth0: Link is up at 100 Mbps, full duplex, flow control
both
[   66.766591] NET: Registered protocol family 10
[   66.766912] lo: Disabled Privacy Extensions
[   77.619790] eth0: no IPv6 routers present


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
