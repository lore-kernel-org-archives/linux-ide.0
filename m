From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata and md issues with 2.9.1-rc1
Date: Thu, 26 Aug 2004 14:30:38 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <412DBBCE.2000403@wasp.net.au>
References: <412B79DF.2000705@wasp.net.au> <412BC1C4.2060506@clanhk.org> <412C1B38.7090401@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:32897 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268443AbUHZKaE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Aug 2004 06:30:04 -0400
In-Reply-To: <412C1B38.7090401@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: "J. Ryan Earl" <heretic@clanhk.org>, Jeff Garzik <jgarzik@pobox.com>

Brad Campbell wrote:
> J. Ryan Earl wrote:
> 
>> Brad Campbell wrote:
>>
>>> Just a heads up. I'm experiencing "issues" with 2.6.9-rc1 that don't 
>>> occur with 2.6.5.
>>>
>>> I run a 10 disk raid-5 on 3xPromise SATA150 cards and a 2 disk raid-0 
>>> on the on-board VIA chipset.
>>> The 10 disks are Maxtor Maxline-II SATA drives and the raid-0 is a 
>>> pair of WD2000JB drives with
>>> Addonics SATA->PATA converters. 
>>
>>
>>
>> Did you try RAID-0 with the pair of Western Digital drives on the two 
>> free Promise slots?  If that fails similarly, it might not be a libata 
>> issue.
> 

Worse. It won't even boot!

Jeff, it looks like the same issue I was facing with 2.6.6-pre1 with regards to the taskfile 
submission. It just hangs when the kernel tries to access the drive.

On the via interface it does not hang until I try and write to the drive but only in an md 
configuration, reads are ok. On the promise interface it hangs here during the boot sequence.

I'm going to try and get into the code somewhat deeper, but any insight you could provide on where 
to poke would be much appreciated.

This is obviously not happening with my native SATA drives, but only with the WD drives via the 
PATA->SATA converter. SIL3611CT80 chipset.

I'm removing linux-raid from the cc: as it's most certainly not a raid issue.

VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
     ide0: BM-DMA at 0x6800-0x6807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x6808-0x680f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD400EB-00CPF0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: Host Protected Area detected.
         current capacity is 78159151 sectors (40017 MB)
         native  capacity is 78165360 sectors (40020 MB)
hda: 78159151 sectors (40017 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
ata1: SATA max UDMA/133 cmd 0xE080B200 ctl 0xE080B238 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xE080B280 ctl 0xE080B2B8 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xE080B300 ctl 0xE080B338 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xE080B380 ctl 0xE080B3B8 bmdma 0x0 irq 19
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
ata5: SATA max UDMA/133 cmd 0xE080D200 ctl 0xE080D238 bmdma 0x0 irq 17
ata6: SATA max UDMA/133 cmd 0xE080D280 ctl 0xE080D2B8 bmdma 0x0 irq 17
ata7: SATA max UDMA/133 cmd 0xE080D300 ctl 0xE080D338 bmdma 0x0 irq 17
ata8: SATA max UDMA/133 cmd 0xE080D380 ctl 0xE080D3B8 bmdma 0x0 irq 17
ata5: no device found (phy stat 00000000)
scsi4 : sata_promise
ata6: no device found (phy stat 00000000)
scsi5 : sata_promise
ata7: no device found (phy stat 00000000)
scsi6 : sata_promise
ata8: no device found (phy stat 00000000)
scsi7 : sata_promise
ata9: SATA max UDMA/133 cmd 0xE080F200 ctl 0xE080F238 bmdma 0x0 irq 18
ata10: SATA max UDMA/133 cmd 0xE080F280 ctl 0xE080F2B8 bmdma 0x0 irq 18
ata11: SATA max UDMA/133 cmd 0xE080F300 ctl 0xE080F338 bmdma 0x0 irq 18
ata12: SATA max UDMA/133 cmd 0xE080F380 ctl 0xE080F3B8 bmdma 0x0 irq 18
ata9: no device found (phy stat 00000000)
scsi8 : sata_promise
ata10: no device found (phy stat 00000000)
scsi9 : sata_promise
ata11: dev 0 ATA, max UDMA/100, 390622887 sectors: lba48
ata11: dev 0 configured for UDMA/100
scsi10 : sata_promise
ata12: dev 0 ATA, max UDMA/100, 390719855 sectors: lba48
ata12: dev 0 configured for UDMA/100
scsi11 : sata_promise
   Vendor: ATA       Model: WDC WD2000JB-00D  Rev: 02.1
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD2000JB-00F  Rev: 15.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via(0000:00:0f.0): routed to hard irq line 6
ata13: SATA max UDMA/133 cmd 0x8800 ctl 0x8402 bmdma 0x7400 irq 20
ata14: SATA max UDMA/133 cmd 0x8000 ctl 0x7802 bmdma 0x7408 irq 20
ata13: no device found (phy stat 00000000)
scsi12 : sata_via
ata14: no device found (phy stat 00000000)
scsi13 : sata_via
SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host10/bus0/target0/lun0:<3>ata11: DMA timeout

If I remove the 1st 2 promise cards then it boots fine and I can write to /dev/md1 to my hearts 
content if the drives are on the promise controller.

If I remove all the promise controllers from the machine, I can still reproduce the fault on the via 
controller by itself so I do have an issue there.

I'm going out now to buy 2 new Maxtor-Maxline-II SATA drives to experiment with.

ARGH!

Here is the serial log

I logged in on the local console and ran
mdadm --assemble /dev/md1 /dev/sda /dev/sdb
dd if=/dev/zero | pipebench | dd of=/dev/md1

At about 50MB (Where it starts to try and flush to the disk) it does this

srv login: md: md1 stopped.
md: bind<sdb>
md: bind<sda>
md1: setting max_sectors to 8192, segment boundary to 2097151
raid0: looking at sda
raid0:   comparing sda(195309568) with sda(195309568)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb
raid0:   comparing sdb(195358720) with sda(195309568)
raid0:   NOT EQUAL
raid0:   comparing sdb(195358720) with sdb(195358720)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking sda ... nope.
raid0: checking sdb ... contained as device 0
   (195358720) is smallest!.
raid0: zone->nb_dev: 1, size: 49152
raid0: current zone offset: 195358720
raid0: done.
raid0 : md_size is 390668288 blocks.
raid0 : conf->hash_spacing is 390619136 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
ata1: DMA timeout, stat 0x0
ATA: abnormal status 0xD0 on port 0xA807
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Write (10) 00 00 00 00 00 00 04 00 00
Current sda: sense key Medium Error
Additional sense: Write error - auto reallocation failed
end_request: I/O error, dev sda, sector 0
ATA: abnormal status 0xD0 on port 0xA807
ATA: abnormal status 0xD0 on port 0xA807
ATA: abnormal status 0xD0 on port 0xA807


Here is the relevant part of this boot log. System has been stripped of all promise controllers

VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
     ide0: BM-DMA at 0x8800-0x8807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x8808-0x880f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD400EB-00CPF0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: Host Protected Area detected.
         current capacity is 78159151 sectors (40017 MB)
         native  capacity is 78165360 sectors (40020 MB)
hda: 78159151 sectors (40017 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
sata_via(0000:00:0f.0): routed to hard irq line 5
ata1: SATA max UDMA/133 cmd 0xA800 ctl 0xA402 bmdma 0x9400 irq 20
ata2: SATA max UDMA/133 cmd 0xA000 ctl 0x9802 bmdma 0x9408 irq 20
ata1: dev 0 ATA, max UDMA/100, 390622887 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: dev 0 ATA, max UDMA/100, 390719855 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_via
   Vendor: ATA       Model: WDC WD2000JB-00D  Rev: 02.1
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD2000JB-00F  Rev: 15.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host0/bus0/target0/lun0: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 390719855 512-byte hdwr sectors (200049 MB)
SCSI device sdb: drive cache: write back
  /dev/scsi/host1/bus0/target0/lun0: unknown partition table
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice

Of course, on anything earlier than 2.6.7-rc1 none of this happens and it all works swimmingly!

Regards,
Brad
