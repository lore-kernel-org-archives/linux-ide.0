From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Errors and resets using sata_promise and libata 1.20
Date: Wed, 12 Jul 2006 14:04:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607121404280.27343@p34.internal.lan>
References: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([66.45.37.187]:10428 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932206AbWGLSEj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jul 2006 14:04:39 -0400
In-Reply-To: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
Cc: linux-ide@vger.kernel.org

I also get similar problems.

Feb 13 20:46:49 p34 kernel: [ 4121.240390] ata3: status=0x51 { DriveReady 
SeekCo
mplete Error }
Feb 13 21:17:06 p34 kernel: [ 5935.732175] ata3: status=0x51 { DriveReady 
SeekCo
mplete Error }
Feb 13 21:42:15 p34 kernel: [ 7443.054619] ata3: status=0x51 { DriveReady 
SeekCo
mplete Error }


Nobody knows yet.


On Wed, 12 Jul 2006, Erik Frederiksen wrote:

> Hi everyone.  Quite regularly I get these messages popping up when I'm
> rebuilding a raid5.
>
> ata2: status=0x50 { DriveReady SeekComplete }
> sdb: Current: sense key=0x0
>    ASC=0x0 ASCQ=0x0
>
> I'm using a Promise TX4 150 controller with 4 HDs, making a raid5 with
> 40GB partitions.  In the dmesg below, I only received 2 errors, but with
> larger partitions in the array, it can be up to about 10 or 12.
>
> After poking through the source a bit, it looks like bit 19 has been set
> in the global control register and a reset is being performed.  If the
> error is being cleared properly (I noticed there's no checking for
> this), should this message be printed?  I did some checksums on a raid
> before and after a rebuild, and even after a whole host of messages it
> doesn't look like the data was affected at all.
>
> Is this a matter of shutting up a superfluous message, or is something
> more sinister going on here?  Please let me know if you need more
> information.
>
> Erik Frederiksen
> Firmware Design Engineer Co-op
> PMC-Sierra Saskatoon
>
> --
>
> C Driver v1.07
> Serial: 8250/16550 driver $Revision: 1.4 $ 4 ports, IRQ sharing disabled
> ttyS0 at MMIO 0xc0000000 (irq = 0) is a 16550A
> ttyS1 at MMIO 0xc0000030 (irq = 0) is a 16550A
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> loop: loaded (max 8 devices)
> PMC-Sierra MSP85x0 10/100/1000 Ethernet Driver
> Device Id : 206014,  Version : 0
> (88E1011): port 0 with MAC address 00:e0:04:00:02:aa
> Rx NAPI supported, Tx Coalescing ON
> (88E1011): port 1 with MAC address 00:e0:04:00:02:ab
> Rx NAPI supported, Tx Coalescing ON
> libata version 1.20 loaded.
> sata_promise 0000:00:02.0: version 1.04
> ata1: SATA max UDMA/133 cmd 0xC001E200 ctl 0xC001E238 bmdma 0x0 irq 11
> ata2: SATA max UDMA/133 cmd 0xC001E280 ctl 0xC001E2B8 bmdma 0x0 irq 11
> ata3: SATA max UDMA/133 cmd 0xC001E300 ctl 0xC001E338 bmdma 0x0 irq 11
> ata4: SATA max UDMA/133 cmd 0xC001E380 ctl 0xC001E3B8 bmdma 0x0 irq 11
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023
> 88:00ff
> ata1: dev 0 ATA-7, max UDMA7, 156301488 sectors: LBA48
> ata1: dev 0 configured for UDMA/133
> scsi0 : sata_promise
> ata2: SATA link up 1.5 Gbps (SStatus 113)
> ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003
> 88:007f
> ata2: dev 0 ATA-7, max UDMA/133, 160086528 sectors: LBA
> ata2: dev 0 configured for UDMA/133
> scsi1 : sata_promise
> ata3: SATA link up 1.5 Gbps (SStatus 113)
> ata3: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023
> 88:00ff
> ata3: dev 0 ATA-7, max UDMA7, 156301488 sectors: LBA48
> ata3: dev 0 configured for UDMA/133
> scsi2 : sata_promise
> ata4: SATA link up 1.5 Gbps (SStatus 113)
> ata4: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003
> 88:007f
> ata4: dev 0 ATA-7, max UDMA/133, 160086528 sectors: LBA
> ata4: dev 0 configured for UDMA/133
> scsi3 : sata_promise
>  Vendor: ATA       Model: SAMSUNG HD080HJ   Rev: ZH10
>  Type:   Direct-Access                      ANSI SCSI revision: 05
>  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
>  Type:   Direct-Access                      ANSI SCSI revision: 05
>  Vendor: ATA       Model: SAMSUNG HD080HJ   Rev: ZH10
>  Type:   Direct-Access                      ANSI SCSI revision: 05
>  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
>  Type:   Direct-Access                      ANSI SCSI revision: 05
> gd->devfs_name [scsi/host0/bus0/target0/lun0] gd->disk_name[sda]
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sda: drive cache: write back
> sda: sda1 sda2
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> gd->devfs_name [scsi/host1/bus0/target0/lun0] gd->disk_name[sdb]
> SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
> SCSI device sdb: drive cache: write back
> sdb: sdb1 sdb2
> Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
> gd->devfs_name [scsi/host2/bus0/target0/lun0] gd->disk_name[sdc]
> SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sdc: drive cache: write back
> SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sdc: drive cache: write back
> sdc: sdc1
> Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
> gd->devfs_name [scsi/host3/bus0/target0/lun0] gd->disk_name[sdd]
> SCSI device sdd: 160086528 512-byte hdwr sectors (81964 MB)
> SCSI device sdd: drive cache: write back
> SCSI device sdd: 160086528 512-byte hdwr sectors (81964 MB)
> SCSI device sdd: drive cache: write back
> sdd: sdd1
> Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
> Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
> Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
> physmap flash device: 800000 at fc800000
> phys_mapped_flash: Found 1 x16 devices at 0x0 in 8-bit bank
> Amd/Fujitsu Extended Query Table at 0x0040
> phys_mapped_flash: CFI does not contain boot bank location. Assuming
> top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> RedBoot partition parsing not available
> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
> (PCI)
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> i2c /dev entries driver
> md: linear personality registered as nr 1
> md: raid0 personality registered as nr 2
> md: raid1 personality registered as nr 3
> md: raid10 personality registered as nr 9
> md: raid5 personality registered as nr 4
> raid5: measuring checksumming speed
>   8regs     :   528.000 MB/sec
>   8regs_prefetch:   512.000 MB/sec
>   32regs    :  1032.000 MB/sec
>   32regs_prefetch:   968.000 MB/sec
> raid5: using function: 32regs (1032.000 MB/sec)
> md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: bitmap version 3.39
> device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
> NET: Registered protocol family 2
> IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> TCP established hash table entries: 16384 (order: 4, 65536 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> TCP reno registered
> ip_tables: (C) 2000-2002 Netfilter core team
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> Assigned IRQ 5 to port 1
> IP-Config: Complete:
>      device=eth1, addr=192.168.183.59, mask=255.255.255.0,
> gw=255.255.255.255,
>     host=192.168.183.59, domain=, nis-domain=(none),
>     bootserver=192.168.183.102, rootserver=192.168.183.102, rootpath=
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> Looking up port of RPC 100003/2 on 192.168.183.102
> Looking up port of RPC 100005/1 on 192.168.183.102
> VFS: Mounted root (nfs filesystem) readonly.
> Freeing unused kernel memory: 140k freed
> md: bind<sda1>
> md: bind<sdb1>
> md: bind<sdc1>
> md: bind<sdd1>
> raid5: device sdc1 operational as raid disk 2
> raid5: device sdb1 operational as raid disk 1
> raid5: device sda1 operational as raid disk 0
> raid5: allocated 4195kB for md0
> raid5: raid level 5 set md0 active with 3 out of 4 devices, algorithm 2
> RAID5 conf printout:
> --- rd:4 wd:3 fd:1
> disk 0, o:1, dev:sda1
> disk 1, o:1, dev:sdb1
> disk 2, o:1, dev:sdc1
> RAID5 conf printout:
> --- rd:4 wd:3 fd:1
> disk 0, o:1, dev:sda1
> disk 1, o:1, dev:sdb1
> disk 2, o:1, dev:sdc1
> disk 3, o:1, dev:sdd1
> md: syncing RAID array md0
> md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
> md: using maximum available idle IO bandwidth (but not more than 200000
> KB/sec) for reconstruction.
> md: using 128k window, over a total of 39061952 blocks.
> ata2: 19
> ata2: status=0x50 { DriveReady SeekComplete }
> sdb: Current: sense key=0x0
>    ASC=0x0 ASCQ=0x0
> Info fld=0x116bcce
> ata2: 19
> ata2: status=0x50 { DriveReady SeekComplete }
> sdb: Current: sense key=0x0
>    ASC=0x0 ASCQ=0x0
> Info fld=0x2c22e96
> md: md0: sync done.
> RAID5 conf printout:
> --- rd:4 wd:4 fd:0
> disk 0, o:1, dev:sda1
> disk 1, o:1, dev:sdb1
> disk 2, o:1, dev:sdc1
> disk 3, o:1, dev:sdd1
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
