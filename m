From: Daniel Beichl <daniel_beichl@gmx.net>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Fri, 04 May 2007 20:18:43 +0200
Message-ID: <463B7903.4070206@gmx.net>
References: <46362672.7080103@gmx.net> <4636DCA9.9050803@gmail.com> <4636FBB7.3030605@gmx.net> <463AE631.9030701@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080003080701080506040208"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031516AbXEDSSr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 May 2007 14:18:47 -0400
In-Reply-To: <463AE631.9030701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080003080701080506040208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Daniel Beichl wrote:
>   
>> I reverted to my initial patch and added a printk line to log the first
>> command byte and
>> qc->nbytes for each command that has been reduced to pio and
>> authenticated a dvd:
>>
>> not Authenticated
>> ata2.00: Reduce cmd 0xa4 (nbytes=0) to pio
>> Request AGID [1]...     AGID 3
>> Host sending challenge:  68 96 40 A8 F2 1A 66 ED A9 33
>> ata2.00: Reduce cmd 0xa4 (nbytes=0) to pio
>> ata2.00: Reduce cmd 0xa3 (nbytes=0) to pio
>> LU sent key1:  65 A0 60 C5 22
>> Drive Authentic - using varient 0
>> ata2.00: Reduce cmd 0xa4 (nbytes=0) to pio
>> LU sent challenge:  D8 D1 AA A6 45 A8 40 33 1C CB
>> Host sending key 2:  A7 90 93 04 B6
>> ata2.00: Reduce cmd 0xa4 (nbytes=0) to pio
>> DVD is authenticated
>> Received Session Key:   7C A0 0F E9 E2
>> ata2.00: Reduce cmd 0xa3 (nbytes=0) to pio
>> not Authenticated
>> ata2.00: Reduce cmd 0xa4 (nbytes=0) to pio
>> Received Disc Key:      55 43 42 B3 C5 FB 6A 00 46 39
>> Authenticated
>> ata2.00: Reduce cmd 0xa4 (nbytes=0) to pio
>>
>> As you can see, every command had a qc->nbytes of zero,
>> therefore your code would have allowed dma transfer as "(0 & 511) != 0"
>> is false(0)
>> and returning 0 allows dma.
>>
>> I wonder why these commands have a nbytes of zero, perhaps its the
>> amount of data sectors transferred? I have searched
>> the libata documentation pdf and did a quick google search, but i
>> didn't come up with anything useful.
>> So your suggestion would work if you say size is not aligned to
>> ATA_SECT_SIZE or zero, i.e:
>>
>> /* returning 0 allows dma everything else does not */
>> return ((qc->nbytes & (ATA_SECT_SIZE-1)) || (qc->nbytes == 0));
>>
>> But why do you think this should be dependent on the qc->nbytes attribute
>> as the authentification commands all have nbytes set to zero?
>> Are you aware of some other issues with this sata controller?
>>
>> It would be great to drill this down further, but i have no clue how to
>> continue. If you have any suggestions please let me know.
>>     
>
> Okay, I've been thinking about it for some time.  I think I know what's
> going on now.  Those authentication related commands are issued by
> invoking ioctls on the device node.  The cdrom driver receives the
> ioctls and issues respective SCSI commands for it.  All those DVD auth
> commands either transfer or receive data from the device and thus
> specifies certain data direction when they're issued.  libata selects
> command protocol accordingly.
>
> It's all good and dandy till now but the problem is that those commands
> can be issued with data length of zero!  This is allowed by the SCSI MMC
> standard and used to probe whether the command succeeds or not before
> taking further actions.  When this happens, libata chooses command
> protocol according to the data direction, but has to feed 0-length data
> to the DMA engine.  It seems sata_sil dma engine barfs if that happens.
>  Can you please add the following code snippet at the head of atapi_xlat()?
>
> 	if (!nodata && !qc->nbytes) {
> 		printk("XXX forcing PIO for 0 length data cdb %02x\n",
> 			scmd->cmnd[0]);
> 		dump_stack();
> 		using_pio = 1;
> 	}
>
> Also, do you mind cc'ing linux-ide@vger.kernel.org?
>
>   
Hi Tejun,


i inserted the code snippet you mentioned to atapi_xlat() in libata-scsi.c
and the dvd authentication succeeds.

Please see the attached dmesg file for the generated stack dumps.

The question is whether this is the right place to fix it, as this seems 
to limit all
drivers to pio if a zero data length command is transferred.
It would make more sense to me if the individual driver decides this by
performing a similar check in the check_atapi_dma function implemented 
by the
individual driver. I did this for the sata_sil driver in the attached patch.

Thanks for sharing your insight,

Daniel

--------------080003080701080506040208
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

.c: subsystem: 01297:a550 bound to 0000:00:05.0
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK2] -> GSI 11 (level, low) -> IRQ 11
sym0: <875> rev 0x26 at pci 0000:01:05.0 irq 11
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUB2] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: irq 9, io mem 0xe8005000
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
sym0: Tekram NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi2 : sym-2.2.3
usb 1-2: new high speed USB device using ehci_hcd and address 3
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 1-3: new high speed USB device using ehci_hcd and address 4
usb 1-3: configuration #1 chosen from 1 choice
usb 1-2.1: new high speed USB device using ehci_hcd and address 5
usb 1-2.1: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUBA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 9, io mem 0xe8003000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUBB] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 9, io mem 0xe8004000
Initializing USB Mass Storage driver...
ieee80211_crypt: registered algorithm 'NULL'
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [LNK3] -> GSI 3 (level, low) -> IRQ 3
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[3]  MMIO=[e7002000-e70027ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 14
PCI: setting IRQ 14 as level-triggered
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK5] -> GSI 14 (level, low) -> IRQ 14
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
usb 2-1: new low speed USB device using ohci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
Console: switching to colour frame buffer device 160x64
radeonfb (0000:02:00.0): ATI Radeon Ya 
usb 1-2.1: reset high speed USB device using ehci_hcd and address 5
zd1211rw 1-2.1:1.0: firmware version 4725
zd1211rw 1-2.1:1.0: zd1211b chip 0586:340f v4810 high 00-13-49 AL2230_RF pa0 g---
zd1211rw 1-2.1:1.0: eth1
usbcore: registered new interface driver zd1211rw
input: Logitech USB Mouse as /class/input/input2
usbcore: registered new interface driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00301bb10000d279]
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
EXT3 FS on sda2, internal journal
usbcore: registered new interface driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3000+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0xa
it87: Found IT8712F chip at 0x290, revision 5
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
fuse init (API version 7.8)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi 3:0:0:0: Direct-Access     USB2.0   CardReader CF RW 0.0> PQ: 0 ANSI: 0
sd 3:0:0:0: Attached scsi removable disk sdb
sd 3:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:1: Direct-Access     USB2.0   CardReader Combo 0.0> PQ: 0 ANSI: 0
sd 3:0:0:1: Attached scsi removable disk sdc
sd 3:0:0:1: Attached scsi generic sg3 type 0
usb-storage: device scan complete
eth0: no link during initialization.
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
eth0: no link during initialization.
SoftMAC: Open Authentication completed with 00:13:49:9a:e2:79
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
ieee80211_crypt: registered algorithm 'TKIP'
Time: acpi_pm clocksource has been installed.
Clocksource tsc unstable (delta = -259997568 ns)
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.25.0 20060524 on minor 0
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:02:00.0 into 4x mode
[drm] Setting GART location based on new memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 1 usecs
wlan0: no IPv6 routers present
XXX forcing PIO for 0 length data cdb a4
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c0128355>] lock_timer_base+0x15/0x2f
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f8862934>] dvd_do_auth+0x261/0x4a8 [cdrom]
 [<c011bc40>] default_wake_function+0x0/0xc
 [<f8863bb2>] mmc_ioctl+0x1037/0x11e5 [cdrom]
 [<c01bb55b>] blk_execute_rq+0x8b/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01b84b0>] elv_set_request+0x14/0x22
 [<c01baf52>] get_request+0x1d7/0x1f0
 [<c01ba7c7>] __freed_request+0x23/0x74
 [<c01ba835>] freed_request+0x1d/0x37
 [<c01baac2>] blk_put_request+0x22/0x36
 [<c022d67c>] scsi_execute+0xed/0xf6
 [<c022d702>] scsi_execute_req+0x7d/0xd5
 [<c022d79d>] scsi_test_unit_ready+0x43/0x80
 [<f88450ea>] sr_media_change+0x32/0x1e5 [sr_mod]
 [<c0168a91>] do_lookup+0x4f/0x140
 [<f886106e>] media_changed+0x40/0x6e [cdrom]
 [<c01c436f>] kobject_get+0xf/0x13
 [<c01bed7f>] scsi_cmd_ioctl+0x330/0x35d
 [<f8865254>] cdrom_open+0x8da/0x91d [cdrom]
 [<c016ab9e>] link_path_walk+0xa9/0xb3
 [<c0161589>] get_unused_fd+0x4a/0xa9
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c016a961>] __link_path_walk+0xa66/0xbfa
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c01bdfb5>] get_disk+0x31/0x47
 [<c01bdfd2>] exact_lock+0x7/0xd
 [<c01c436f>] kobject_get+0xf/0x13
 [<f8845363>] sr_block_open+0x74/0x81 [sr_mod]
 [<c0181a4f>] do_open+0x1dd/0x25c
 [<c018186a>] bdget+0xe7/0xef
 [<c0149071>] find_get_page+0x18/0x38
 [<c014b33f>] filemap_nopage+0x18d/0x2ef
 [<c0181c6d>] blkdev_open+0x25/0x4d
 [<c0153ddc>] __handle_mm_fault+0x2cd/0x793
 [<c016181d>] do_filp_open+0x32/0x39
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================
XXX forcing PIO for 0 length data cdb a4
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c0128355>] lock_timer_base+0x15/0x2f
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f8862766>] dvd_do_auth+0x93/0x4a8 [cdrom]
 [<c011bc40>] default_wake_function+0x0/0xc
 [<f8863bb2>] mmc_ioctl+0x1037/0x11e5 [cdrom]
 [<c01bb55b>] blk_execute_rq+0x8b/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01b84b0>] elv_set_request+0x14/0x22
 [<c01baf52>] get_request+0x1d7/0x1f0
 [<c01ba7c7>] __freed_request+0x23/0x74
 [<c01ba835>] freed_request+0x1d/0x37
 [<c01baac2>] blk_put_request+0x22/0x36
 [<c022d67c>] scsi_execute+0xed/0xf6
 [<c022d702>] scsi_execute_req+0x7d/0xd5
 [<c022d79d>] scsi_test_unit_ready+0x43/0x80
 [<f88450ea>] sr_media_change+0x32/0x1e5 [sr_mod]
 [<c0168a91>] do_lookup+0x4f/0x140
 [<f886106e>] media_changed+0x40/0x6e [cdrom]
 [<c01c436f>] kobject_get+0xf/0x13
 [<c01bed7f>] scsi_cmd_ioctl+0x330/0x35d
 [<f8865254>] cdrom_open+0x8da/0x91d [cdrom]
 [<c011bc36>] try_to_wake_up+0x3a1/0x3ab
 [<c0119aae>] __activate_task+0x1c/0x29
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c01198b2>] __wake_up_common+0x32/0x55
 [<c0119df7>] __wake_up+0x32/0x43
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c01bdfb5>] get_disk+0x31/0x47
 [<c01c7c34>] mmx_clear_page+0x24/0x60
 [<c014d12a>] get_page_from_freelist+0x26a/0x2e6
 [<c0181a4f>] do_open+0x1dd/0x25c
 [<c0149071>] find_get_page+0x18/0x38
 [<c014b33f>] filemap_nopage+0x18d/0x2ef
 [<c0211893>] pty_write+0x2f/0x39
 [<c0153ddc>] __handle_mm_fault+0x2cd/0x793
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================
XXX forcing PIO for 0 length data cdb a3
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c0128355>] lock_timer_base+0x15/0x2f
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f88629b9>] dvd_do_auth+0x2e6/0x4a8 [cdrom]
 [<c011bc40>] default_wake_function+0x0/0xc
 [<f8863bb2>] mmc_ioctl+0x1037/0x11e5 [cdrom]
 [<c01bb55b>] blk_execute_rq+0x8b/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01b84b0>] elv_set_request+0x14/0x22
 [<c01baf52>] get_request+0x1d7/0x1f0
 [<c01ba7c7>] __freed_request+0x23/0x74
 [<c01ba835>] freed_request+0x1d/0x37
 [<c01baac2>] blk_put_request+0x22/0x36
 [<c022d67c>] scsi_execute+0xed/0xf6
 [<c022d702>] scsi_execute_req+0x7d/0xd5
 [<c022d79d>] scsi_test_unit_ready+0x43/0x80
 [<f88450ea>] sr_media_change+0x32/0x1e5 [sr_mod]
 [<c0168a91>] do_lookup+0x4f/0x140
 [<f886106e>] media_changed+0x40/0x6e [cdrom]
 [<c01c436f>] kobject_get+0xf/0x13
 [<c01bed7f>] scsi_cmd_ioctl+0x330/0x35d
 [<f8865254>] cdrom_open+0x8da/0x91d [cdrom]
 [<c011bc36>] try_to_wake_up+0x3a1/0x3ab
 [<c0119aae>] __activate_task+0x1c/0x29
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c01198b2>] __wake_up_common+0x32/0x55
 [<c0119df7>] __wake_up+0x32/0x43
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c01bdfb5>] get_disk+0x31/0x47
 [<c01c7c34>] mmx_clear_page+0x24/0x60
 [<c014d12a>] get_page_from_freelist+0x26a/0x2e6
 [<c0181a4f>] do_open+0x1dd/0x25c
 [<c0211893>] pty_write+0x2f/0x39
 [<c020b9a5>] tty_default_put_char+0x17/0x1a
 [<c0119df7>] __wake_up+0x32/0x43
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================
XXX forcing PIO for 0 length data cdb a4
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c0128355>] lock_timer_base+0x15/0x2f
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f88627c8>] dvd_do_auth+0xf5/0x4a8 [cdrom]
 [<c011bc40>] default_wake_function+0x0/0xc
 [<f8863bb2>] mmc_ioctl+0x1037/0x11e5 [cdrom]
 [<c01bb55b>] blk_execute_rq+0x8b/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01b84b0>] elv_set_request+0x14/0x22
 [<c01baf52>] get_request+0x1d7/0x1f0
 [<c01ba7c7>] __freed_request+0x23/0x74
 [<c01ba835>] freed_request+0x1d/0x37
 [<c01baac2>] blk_put_request+0x22/0x36
 [<c022d67c>] scsi_execute+0xed/0xf6
 [<c022d702>] scsi_execute_req+0x7d/0xd5
 [<c022d79d>] scsi_test_unit_ready+0x43/0x80
 [<f88450ea>] sr_media_change+0x32/0x1e5 [sr_mod]
 [<c0168a91>] do_lookup+0x4f/0x140
 [<f886106e>] media_changed+0x40/0x6e [cdrom]
 [<c01c436f>] kobject_get+0xf/0x13
 [<c01bed7f>] scsi_cmd_ioctl+0x330/0x35d
 [<f8865254>] cdrom_open+0x8da/0x91d [cdrom]
 [<c011bc36>] try_to_wake_up+0x3a1/0x3ab
 [<c0119aae>] __activate_task+0x1c/0x29
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c01198b2>] __wake_up_common+0x32/0x55
 [<c0119df7>] __wake_up+0x32/0x43
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c01bdfb5>] get_disk+0x31/0x47
 [<c01c7c34>] mmx_clear_page+0x24/0x60
 [<c014d12a>] get_page_from_freelist+0x26a/0x2e6
 [<c0181a4f>] do_open+0x1dd/0x25c
 [<c0211893>] pty_write+0x2f/0x39
 [<c020b9a5>] tty_default_put_char+0x17/0x1a
 [<c0119df7>] __wake_up+0x32/0x43
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================
XXX forcing PIO for 0 length data cdb a4
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c0128355>] lock_timer_base+0x15/0x2f
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f8862826>] dvd_do_auth+0x153/0x4a8 [cdrom]
 [<c011bc40>] default_wake_function+0x0/0xc
 [<f8863bb2>] mmc_ioctl+0x1037/0x11e5 [cdrom]
 [<c01bb55b>] blk_execute_rq+0x8b/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01b84b0>] elv_set_request+0x14/0x22
 [<c01baf52>] get_request+0x1d7/0x1f0
 [<c01ba7c7>] __freed_request+0x23/0x74
 [<c01ba835>] freed_request+0x1d/0x37
 [<c01baac2>] blk_put_request+0x22/0x36
 [<c022d67c>] scsi_execute+0xed/0xf6
 [<c022d702>] scsi_execute_req+0x7d/0xd5
 [<c022d79d>] scsi_test_unit_ready+0x43/0x80
 [<f88450ea>] sr_media_change+0x32/0x1e5 [sr_mod]
 [<c0168a91>] do_lookup+0x4f/0x140
 [<f886106e>] media_changed+0x40/0x6e [cdrom]
 [<c01c436f>] kobject_get+0xf/0x13
 [<c01bed7f>] scsi_cmd_ioctl+0x330/0x35d
 [<f8865254>] cdrom_open+0x8da/0x91d [cdrom]
 [<c011bc36>] try_to_wake_up+0x3a1/0x3ab
 [<c0119aae>] __activate_task+0x1c/0x29
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c01198b2>] __wake_up_common+0x32/0x55
 [<c0119df7>] __wake_up+0x32/0x43
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c01bdfb5>] get_disk+0x31/0x47
 [<c01c7c34>] mmx_clear_page+0x24/0x60
 [<c014d12a>] get_page_from_freelist+0x26a/0x2e6
 [<c0181a4f>] do_open+0x1dd/0x25c
 [<c0211893>] pty_write+0x2f/0x39
 [<c020b9a5>] tty_default_put_char+0x17/0x1a
 [<c0119df7>] __wake_up+0x32/0x43
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================
XXX forcing PIO for 0 length data cdb a3
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c0128355>] lock_timer_base+0x15/0x2f
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f8862a1f>] dvd_do_auth+0x34c/0x4a8 [cdrom]
 [<c011bc40>] default_wake_function+0x0/0xc
 [<f8863bb2>] mmc_ioctl+0x1037/0x11e5 [cdrom]
 [<c01bb55b>] blk_execute_rq+0x8b/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01b84b0>] elv_set_request+0x14/0x22
 [<c01baf52>] get_request+0x1d7/0x1f0
 [<c01ba7c7>] __freed_request+0x23/0x74
 [<c01ba835>] freed_request+0x1d/0x37
 [<c01baac2>] blk_put_request+0x22/0x36
 [<c022d67c>] scsi_execute+0xed/0xf6
 [<c022d702>] scsi_execute_req+0x7d/0xd5
 [<c022d79d>] scsi_test_unit_ready+0x43/0x80
 [<f88450ea>] sr_media_change+0x32/0x1e5 [sr_mod]
 [<c0168a91>] do_lookup+0x4f/0x140
 [<f886106e>] media_changed+0x40/0x6e [cdrom]
 [<c01c436f>] kobject_get+0xf/0x13
 [<c01bed7f>] scsi_cmd_ioctl+0x330/0x35d
 [<f8865254>] cdrom_open+0x8da/0x91d [cdrom]
 [<c011bc36>] try_to_wake_up+0x3a1/0x3ab
 [<c0119aae>] __activate_task+0x1c/0x29
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c01198b2>] __wake_up_common+0x32/0x55
 [<c0119df7>] __wake_up+0x32/0x43
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c01bdfb5>] get_disk+0x31/0x47
 [<c01c7c34>] mmx_clear_page+0x24/0x60
 [<c014d12a>] get_page_from_freelist+0x26a/0x2e6
 [<c0181a4f>] do_open+0x1dd/0x25c
 [<c0211893>] pty_write+0x2f/0x39
 [<c020b9a5>] tty_default_put_char+0x17/0x1a
 [<c0119df7>] __wake_up+0x32/0x43
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================
XXX forcing PIO for 0 length data cdb a4
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c0128355>] lock_timer_base+0x15/0x2f
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f8862934>] dvd_do_auth+0x261/0x4a8 [cdrom]
 [<c011bc40>] default_wake_function+0x0/0xc
 [<f8863bb2>] mmc_ioctl+0x1037/0x11e5 [cdrom]
 [<c01bb55b>] blk_execute_rq+0x8b/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01b84b0>] elv_set_request+0x14/0x22
 [<c01baf52>] get_request+0x1d7/0x1f0
 [<c01ba7c7>] __freed_request+0x23/0x74
 [<c01ba835>] freed_request+0x1d/0x37
 [<c01baac2>] blk_put_request+0x22/0x36
 [<c022d67c>] scsi_execute+0xed/0xf6
 [<c022d702>] scsi_execute_req+0x7d/0xd5
 [<c022d79d>] scsi_test_unit_ready+0x43/0x80
 [<f88450ea>] sr_media_change+0x32/0x1e5 [sr_mod]
 [<c0168a91>] do_lookup+0x4f/0x140
 [<f886106e>] media_changed+0x40/0x6e [cdrom]
 [<c01c436f>] kobject_get+0xf/0x13
 [<c01bed7f>] scsi_cmd_ioctl+0x330/0x35d
 [<f8865254>] cdrom_open+0x8da/0x91d [cdrom]
 [<c011bc36>] try_to_wake_up+0x3a1/0x3ab
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c01198b2>] __wake_up_common+0x32/0x55
 [<c0119df7>] __wake_up+0x32/0x43
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c01bdfb5>] get_disk+0x31/0x47
 [<c01c7c34>] mmx_clear_page+0x24/0x60
 [<c014d12a>] get_page_from_freelist+0x26a/0x2e6
 [<c0181a4f>] do_open+0x1dd/0x25c
 [<c0211893>] pty_write+0x2f/0x39
 [<c020b9a5>] tty_default_put_char+0x17/0x1a
 [<c0119df7>] __wake_up+0x32/0x43
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================
XXX forcing PIO for 0 length data cdb ad
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0146ff6>] handle_IRQ_event+0x1a/0x3f
 [<c0107acc>] enable_8259A_irq+0xd/0x42
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0106382>] do_IRQ+0x5c/0x72
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f8863939>] mmc_ioctl+0xdbe/0x11e5 [cdrom]
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01b84b0>] elv_set_request+0x14/0x22
 [<c01baf52>] get_request+0x1d7/0x1f0
 [<c01ba7c7>] __freed_request+0x23/0x74
 [<c01ba835>] freed_request+0x1d/0x37
 [<c01baac2>] blk_put_request+0x22/0x36
 [<c022d67c>] scsi_execute+0xed/0xf6
 [<c022d702>] scsi_execute_req+0x7d/0xd5
 [<c022d79d>] scsi_test_unit_ready+0x43/0x80
 [<f88450ea>] sr_media_change+0x32/0x1e5 [sr_mod]
 [<c0168a91>] do_lookup+0x4f/0x140
 [<c011bc36>] try_to_wake_up+0x3a1/0x3ab
 [<c0119aae>] __activate_task+0x1c/0x29
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c01198b2>] __wake_up_common+0x32/0x55
 [<c0119df7>] __wake_up+0x32/0x43
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c01bdfb5>] get_disk+0x31/0x47
 [<c01c7c34>] mmx_clear_page+0x24/0x60
 [<c014d12a>] get_page_from_freelist+0x26a/0x2e6
 [<c0181a4f>] do_open+0x1dd/0x25c
 [<c0211893>] pty_write+0x2f/0x39
 [<c020b9a5>] tty_default_put_char+0x17/0x1a
 [<c0119df7>] __wake_up+0x32/0x43
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================
XXX forcing PIO for 0 length data cdb a4
 [<c0238e37>] atapi_xlat+0x42/0x13f
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c0238940>] ata_scsi_translate+0xec/0x151
 [<c0228ae7>] scsi_done+0x0/0x16
 [<c023a947>] ata_scsi_queuecmd+0x121/0x13f
 [<c0238df5>] atapi_xlat+0x0/0x13f
 [<c012845d>] __mod_timer+0x90/0x9a
 [<c0229055>] scsi_dispatch_cmd+0x1d3/0x250
 [<c0128355>] lock_timer_base+0x15/0x2f
 [<c022da42>] scsi_request_fn+0x268/0x31d
 [<c01bb419>] blk_remove_plug+0x4f/0x5b
 [<c01bb442>] __generic_unplug_device+0x1d/0x1f
 [<c01bb4bf>] blk_execute_rq_nowait+0x7b/0x8c
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01c2715>] cfq_set_request+0x299/0x315
 [<c01bb554>] blk_execute_rq+0x84/0x9e
 [<c01baa7d>] blk_end_sync_rq+0x0/0x23
 [<c01c247c>] cfq_set_request+0x0/0x315
 [<c01807dd>] bio_map_kern+0x91/0xd5
 [<c01b9d21>] blk_rq_bio_prep+0x61/0x85
 [<c022d672>] scsi_execute+0xe3/0xf6
 [<f8845e66>] sr_do_ioctl+0x9a/0x1dc [sr_mod]
 [<f8852b92>] do_get_write_access+0x4b6/0x4e3 [jbd]
 [<f88450b3>] sr_packet+0x1a/0x1f [sr_mod]
 [<f8862934>] dvd_do_auth+0x261/0x4a8 [cdrom]
 [<f88949d2>] __ext3_journal_dirty_metadata+0x16/0x3a [ext3]
 [<f88896d1>] __ext3_get_inode_loc+0x115/0x2e3 [ext3]
 [<f8887405>] ext3_new_blocks+0x4b7/0x5bd [ext3]
 [<f8863bb2>] mmc_ioctl+0x1037/0x11e5 [cdrom]
 [<c017dad1>] __find_get_block+0x14c/0x156
 [<c017dafe>] __getblk+0x23/0x26c
 [<f8852b92>] do_get_write_access+0x4b6/0x4e3 [jbd]
 [<c017dad1>] __find_get_block+0x14c/0x156
 [<f88896d1>] __ext3_get_inode_loc+0x115/0x2e3 [ext3]
 [<f88949d2>] __ext3_journal_dirty_metadata+0x16/0x3a [ext3]
 [<f8852be0>] journal_get_write_access+0x21/0x26 [jbd]
 [<f8889556>] ext3_mark_iloc_dirty+0x26e/0x2d4 [ext3]
 [<f888992d>] ext3_mark_inode_dirty+0x20/0x27 [ext3]
 [<c0119df7>] __wake_up+0x32/0x43
 [<c01c436f>] kobject_get+0xf/0x13
 [<c01bed7f>] scsi_cmd_ioctl+0x330/0x35d
 [<c014a791>] generic_file_buffered_write+0x597/0x606
 [<f886450c>] cdrom_ioctl+0x7ac/0xb3e [cdrom]
 [<c0124548>] current_fs_time+0x41/0x46
 [<c014ace5>] __generic_file_aio_write_nolock+0x4e5/0x55e
 [<f8845d5c>] sr_block_ioctl+0x47/0x7f [sr_mod]
 [<c01bcd92>] blkdev_driver_ioctl+0x4e/0x5e
 [<c01bd3d4>] blkdev_ioctl+0x632/0x67e
 [<c014adbc>] generic_file_aio_write+0x5e/0xb3
 [<f8888020>] ext3_file_write+0x24/0x8f [ext3]
 [<c016290a>] do_sync_write+0xc7/0x10a
 [<c016bae2>] open_namei+0x24c/0x552
 [<c01617dc>] nameidata_to_filp+0x24/0x33
 [<c0130b89>] autoremove_wake_function+0x0/0x35
 [<c0181291>] block_ioctl+0x18/0x1b
 [<c0181279>] block_ioctl+0x0/0x1b
 [<c016c863>] do_ioctl+0x1f/0x62
 [<c016caf2>] vfs_ioctl+0x24c/0x25e
 [<c0174aed>] mntput_no_expire+0x11/0x68
 [<c016cb50>] sys_ioctl+0x4c/0x64
 [<c0103c88>] sysenter_past_esp+0x5d/0x81
 =======================

--------------080003080701080506040208
Content-Type: text/x-patch;
 name="sata_sil.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_sil.c.patch"

--- sata_sil.c	2007-04-26 05:08:32.000000000 +0200
+++ sata_sil.c	2007-05-04 20:06:03.000000000 +0200
@@ -43,10 +43,11 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sil"
-#define DRV_VERSION	"2.1"
+#define DRV_VERSION	"2.1a"
 
 enum {
 	SIL_MMIO_BAR		= 5,
@@ -121,6 +122,7 @@
 static irqreturn_t sil_interrupt(int irq, void *dev_instance);
 static void sil_freeze(struct ata_port *ap);
 static void sil_thaw(struct ata_port *ap);
+static int sil_check_atapi_dma(struct ata_queued_cmd *qc);
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
@@ -196,6 +198,7 @@
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
+	.check_atapi_dma	= sil_check_atapi_dma,
 	.dev_select		= ata_std_dev_select,
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
@@ -289,6 +292,22 @@
 module_param(slow_down, int, 0444);
 MODULE_PARM_DESC(slow_down, "Sledgehammer used to work around random problems, by limiting commands to 15 sectors (0=off, 1=on)");
 
+static int sil_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	/* limit zero data size atapi commands to pio as certain sil */
+	/* chips seem to have trouble to perform dma for these commands */
+	if ( (qc->scsicmd != NULL) &&
+             (qc->scsicmd->sc_data_direction != DMA_NONE) &&
+	     (qc->nbytes == 0) )
+	{
+		/* do not allow dma */
+		return -1;
+	}
+
+	/* allow dma */
+	return 0;
+}
+
 
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {

--------------080003080701080506040208--
