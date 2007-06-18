From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 15:28:44 +0900
Message-ID: <4676261C.1010006@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com>    <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com>    <466FC901.4060907@effenberger.org> <46710DDC.1030900@gmail.com>    <467122B8.1090206@effenberger.org> <467133D7.7070000@gmail.com>    <46715ADB.4020202@effenberger.org> <4675F7A7.8000109@gmail.com> <40311.192.168.9.10.1182146934.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:1684 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbXFRG2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 02:28:51 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1283790nzf
        for <linux-ide@vger.kernel.org>; Sun, 17 Jun 2007 23:28:50 -0700 (PDT)
In-Reply-To: <40311.192.168.9.10.1182146934.squirrel@ncircle.nullnet.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi Orava <Tomi.Orava@ncircle.nullnet.fi>
Cc: Florian Effenberger <florian@effenberger.org>, linux-ide@vger.kernel.org, jeff@garzik.org, Mikael Pettersson <mikpe@it.uu.se>

Hello,

Yeah, it seems promise has some problem with 3G link.  Cc'ing Mikael
Pettersson and quoting whole body for him.  Mikael, does this look familiar?

Tomi Orava wrote:
> Hi Tejun,
> 
> I've been trying to find a solution for a long time for quite a similar
> libata errror messages as shown in this thread. Perhaps you might get have
> some ideas what the actual originator might be:
> 
> With the latest 2.6.22-rc4-git4 kernel I still get the following error
> messages
> with high I/O load:
> 
> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> ata3.00: (port_status 0x20080000)
> ata3.00: cmd c8/00:08:af:91:49/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
>          res 50/00:00:b6:91:49/00:00:11:00:00/e5 Emask 0x2 (HSM violation)
> ata3: soft resetting port
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: configured for UDMA/133
> ata3: EH complete
> 
> ... and later in the chain ...
> 
> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> ata3.00: (port_status 0x20080000)
> ata3.00: cmd c8/00:08:67:74:65/00:00:00:00:00/ec tag 0 cdb 0x0 data 4096 in
>          res 50/00:00:6e:74:65/00:00:1b:00:00/ec Emask 0x2 (HSM violation)
> ata3: soft resetting port
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: configured for UDMA/100
> ata3: EH complete
> 
> --- This goes on until UDMA/33 has been reched
> 
> The problematic hardware combination is:
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. KT880 Host Bridge (rev 80)
> 00:00.1 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
> 00:00.2 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
> 00:00.3 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
> 00:00.4 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
> 00:00.7 Host bridge: VIA Technologies, Inc. KT880 Host Bridge
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> 00:09.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit
> Ethernet Controller (rev 13)
> 00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
> 00:0e.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA
> 300 TX4) (rev 02)
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
> Controller (rev 80)
> 00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
> [KT600/K8T800/K8T890 South]
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc.
> VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
> 00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem
> Controller (rev 80)
> 01:00.0 VGA compatible controller: nVidia Corporation NV36.2 [GeForce FX
> 5700] (rev a1)
> 
> and the problems relate only to Seagate 7200.10 SATA-disks, never with the
> older 7200.7 SATA-disks alll connected to Promise Sata 300TX4-controller.
> 
> Because this problem has been around for as long as I've had the Promise
> Sata300TX4 controller an additional new problem is that after kernel
> version 2.6.21-rc3-git10 the libata error handling/interface speed
> downgrade has been fixed ---> these new seagate disks get downgraded from
> UDMA/133 to UDMA/33 overnight (can the speed downgrade  be disabled as a
> quick and dirty fix in this case somehow ?). For some reason the above
> mentioned libata error messages don't really do any noticeable harm but it
> would be very nice to be able to prevent the interface speed downgrade for
> now.
> 
>>> What do you mean by "merged speed down fix"? Is your fix for the speed
>>> down logic implemented in the current kernel, so I don't have to patch
>>> anymore (except when I want to force 1.5Gbps right from the beginning)?
>> Yeap, kernel will automatically downgrade to 1.5Gbps after several
>> failures.
> 
> Yes, this feature seems to work quite nicely as the included logs show.
> 
> Regards,
> Tomi Orava
> 
> PS. These problems are not special to this single machine as a friend at work
>       has the same Promise Sata300TX4 card with exactly the same Seagate
> 7200.10
>       SATA-disks on an intel-based P4 machine with similar problems under
> I/O-load.
> 
> ---------------------------------------------------------
> scsi0 : sata_promise
> scsi1 : sata_promise
> scsi2 : sata_promise
> scsi3 : sata_promise
> ata1: SATA max UDMA/133 cmd 0xf880a380 ctl 0xf880a3b8 bmdma 0x00000000 irq 0
> ata2: SATA max UDMA/133 cmd 0xf880a280 ctl 0xf880a2b8 bmdma 0x00000000 irq 0
> ata3: SATA max UDMA/133 cmd 0xf880a200 ctl 0xf880a238 bmdma 0x00000000 irq 0
> ata4: SATA max UDMA/133 cmd 0xf880a300 ctl 0xf880a338 bmdma 0x00000000 irq 0
> Switched to high resolution mode on CPU 0
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ata_hpa_resize 1: sectors = 390721968, hpa_sectors = 390721968
> ata1.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
> ata1.00: 390721968 sectors, multi 0: LBA48
> ata1.00: ata_hpa_resize 1: sectors = 390721968, hpa_sectors = 390721968
> ata1.00: configured for UDMA/133
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: ata_hpa_resize 1: sectors = 390721968, hpa_sectors = 390721968
> ata2.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
> ata2.00: 390721968 sectors, multi 0: LBA48
> ata2.00: ata_hpa_resize 1: sectors = 390721968, hpa_sectors = 390721968
> ata2.00: configured for UDMA/133
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
> ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: configured for UDMA/133
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata4.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
> ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> ata4.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata4.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>  sda: sda1 sda2
> sd 0:0:0:0: [sda] Attached SCSI disk
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> scsi 1:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
> sd 1:0:0:0: [sdb] 390721968 512-byte hardware sectors (200050 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 1:0:0:0: [sdb] 390721968 512-byte hardware sectors (200050 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>  sdb: sdb1 sdb2
> sd 1:0:0:0: [sdb] Attached SCSI disk
> sd 1:0:0:0: Attached scsi generic sg1 type 0
> scsi 2:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>  sdc: sdc1 sdc2
> sd 2:0:0:0: [sdc] Attached SCSI disk
> sd 2:0:0:0: Attached scsi generic sg2 type 0
> scsi 3:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
> sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
> sd 3:0:0:0: [sdd] Write Protect is off
> sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
> sd 3:0:0:0: [sdd] Write Protect is off
> sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>  sdd: sdd1 sdd2
> sd 3:0:0:0: [sdd] Attached SCSI disk
> sd 3:0:0:0: Attached scsi generic sg3 type 0
> 


-- 
tejun
