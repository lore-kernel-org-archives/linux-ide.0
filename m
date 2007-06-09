From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise: still getting errors with 2.6.22-rc4
Date: Sat, 9 Jun 2007 19:20:55 +0300 (EEST)
Message-ID: <55483.192.168.9.10.1181406055.squirrel@ncircle.nullnet.fi>
References: <200705121504.l4CF4u83028056@harpo.it.uu.se>
    <465A0D8F.8090309@how.dk>
    <42957.194.237.142.21.1180331956.squirrel@ncircle.nullnet.fi>
    <465B0A28.9050305@how.dk>
    <51376.192.168.9.10.1180377924.squirrel@ncircle.nullnet.fi>
    <465B2F1D.30509@how.dk>
    <55161.192.168.9.10.1180381276.squirrel@ncircle.nullnet.fi>
    <465B35E1.1040306@how.dk>
    <52314.194.237.142.21.1181199147.squirrel@ncircle.nullnet.fi>
    <466A97B1.1040906@how.dk>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:58830 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629AbXFIQVE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jun 2007 12:21:04 -0400
In-Reply-To: <466A97B1.1040906@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: linux-ide@vger.kernel.org


Hi,

>  > Have you had time to check if the latest patch fixes our problems
>  > with promise-controller ?
>  >
>  > http://bugzilla.kernel.org/attachment.cgi?id=11694&action=view
>  >
>  > The above patch seems to apply to the latest rc4 kernel.
>  > I have not found the time to reboot my own server as of yet.

> I have tested - but it didn't solve the problem.

Interesting. I tested the above mentioned patch as well with the
fedora development kernel (3209) which is based on 2.6.22-rc4 and
the errors were little bit different compared to previous ones.
I have not seen the HSM violation errror in the past ...

-----------------------------------------------------------------------------

Jun  8 09:21:34 alderan kernel: sata_promise 0000:00:0e.0: applying SATAII
TX4 port numbering workaround
Jun  8 09:21:34 alderan kernel: scsi0 : sata_promise
Jun  8 09:21:34 alderan kernel: scsi1 : sata_promise
Jun  8 09:21:34 alderan kernel: scsi2 : sata_promise
Jun  8 09:21:34 alderan kernel: scsi3 : sata_promise
Jun  8 09:21:34 alderan kernel: ata1: SATA max UDMA/133 cmd 0xf880a380 ctl
0xf880a3b8 bmdma 0x00000000 irq 0
Jun  8 09:21:34 alderan kernel: ata2: SATA max UDMA/133 cmd 0xf880a280 ctl
0xf880a2b8 bmdma 0x00000000 irq 0
Jun  8 09:21:34 alderan kernel: ata3: SATA max UDMA/133 cmd 0xf880a200 ctl
0xf880a238 bmdma 0x00000000 irq 0
Jun  8 09:21:34 alderan kernel: ata4: SATA max UDMA/133 cmd 0xf880a300 ctl
0xf880a338 bmdma 0x00000000 irq 0
Jun  8 09:21:35 alderan kernel: Switched to high resolution mode on CPU 0
Jun  8 09:21:35 alderan kernel: ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Jun  8 09:21:35 alderan kernel: ata1.00: ata_hpa_resize 1: sectors =
390721968, hpa_sectors = 390721968
Jun  8 09:21:35 alderan kernel: ata1.00: ATA-6: ST3200822AS, 3.01, max
UDMA/133
Jun  8 09:21:35 alderan kernel: ata1.00: 390721968 sectors, multi 0: LBA48
Jun  8 09:21:35 alderan kernel: ata1.00: ata_hpa_resize 1: sectors =
390721968, hpa_sectors = 390721968
Jun  8 09:21:35 alderan kernel: ata1.00: configured for UDMA/133
Jun  8 09:21:35 alderan kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Jun  8 09:21:35 alderan kernel: ata2.00: ata_hpa_resize 1: sectors =
390721968, hpa_sectors = 390721968
Jun  8 09:21:35 alderan kernel: ata2.00: ATA-6: ST3200822AS, 3.01, max
UDMA/133
Jun  8 09:21:35 alderan kernel: ata2.00: 390721968 sectors, multi 0: LBA48
Jun  8 09:21:35 alderan kernel: ata2.00: ata_hpa_resize 1: sectors =
390721968, hpa_sectors = 390721968
Jun  8 09:21:35 alderan kernel: ata2.00: configured for UDMA/133
Jun  8 09:21:35 alderan kernel: ata3: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Jun  8 09:21:35 alderan kernel: ata3.00: ata_hpa_resize 1: sectors =
976773168, hpa_sectors = 976773168
Jun  8 09:21:35 alderan kernel: ata3.00: ATA-7: ST3500630AS, 3.AAK, max
UDMA/133
Jun  8 09:21:35 alderan kernel: ata3.00: 976773168 sectors, multi 0: LBA48
NCQ (depth 0/32)
Jun  8 09:21:35 alderan kernel: ata3.00: ata_hpa_resize 1: sectors =
976773168, hpa_sectors = 976773168
Jun  8 09:21:35 alderan kernel: ata3.00: configured for UDMA/133
Jun  8 09:21:35 alderan kernel: ata4: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Jun  8 09:21:35 alderan kernel: ata4.00: ata_hpa_resize 1: sectors =
976773168, hpa_sectors = 976773168
Jun  8 09:21:35 alderan kernel: ata4.00: ATA-7: ST3500630AS, 3.AAK, max
UDMA/133
Jun  8 09:21:35 alderan kernel: ata4.00: 976773168 sectors, multi 0: LBA48
NCQ (depth 0/32)
Jun  8 09:21:35 alderan kernel: ata4.00: ata_hpa_resize 1: sectors =
976773168, hpa_sectors = 976773168
Jun  8 09:21:35 alderan kernel: ata4.00: configured for UDMA/133
Jun  8 09:21:35 alderan kernel: scsi 0:0:0:0: Direct-Access     ATA     
ST3200822AS      3.01 PQ: 0 ANSI: 5
Jun  8 09:21:35 alderan kernel: sd 0:0:0:0: [sda] 390721968 512-byte
hardware sectors (200050 MB)
Jun  8 09:21:35 alderan kernel: sd 0:0:0:0: [sda] Write Protect is off
Jun  8 09:21:35 alderan kernel: sd 0:0:0:0: [sda] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun  8 09:21:35 alderan kernel:  sda: sda1 sda2
Jun  8 09:21:35 alderan kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Jun  8 09:21:35 alderan kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Jun  8 09:21:35 alderan kernel: scsi 1:0:0:0: Direct-Access     ATA     
ST3200822AS      3.01 PQ: 0 ANSI: 5
Jun  8 09:21:35 alderan kernel: sd 1:0:0:0: [sdb] 390721968 512-byte
hardware sectors (200050 MB)
Jun  8 09:21:35 alderan kernel: sd 1:0:0:0: [sdb] Write Protect is off
Jun  8 09:21:35 alderan kernel: sd 1:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun  8 09:21:35 alderan kernel: sd 1:0:0:0: [sdb] 390721968 512-byte
hardware sectors (200050 MB)
Jun  8 09:21:35 alderan kernel: sd 1:0:0:0: [sdb] Write Protect is off
Jun  8 09:21:35 alderan kernel: sd 1:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun  8 09:21:35 alderan kernel:  sdb: sdb1 sdb2
Jun  8 09:21:35 alderan kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
Jun  8 09:21:35 alderan kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Jun  8 09:21:35 alderan kernel: scsi 2:0:0:0: Direct-Access     ATA     
ST3500630AS      3.AA PQ: 0 ANSI: 5
Jun  8 09:21:35 alderan kernel: sd 2:0:0:0: [sdc] 976773168 512-byte
hardware sectors (500108 MB)
Jun  8 09:21:35 alderan kernel: sd 2:0:0:0: [sdc] Write Protect is off
Jun  8 09:21:35 alderan kernel: sd 2:0:0:0: [sdc] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun  8 09:21:35 alderan kernel: sd 2:0:0:0: [sdc] 976773168 512-byte
hardware sectors (500108 MB)
Jun  8 09:21:35 alderan kernel: sd 2:0:0:0: [sdc] Write Protect is off
Jun  8 09:21:35 alderan kernel: sd 2:0:0:0: [sdc] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun  8 09:21:35 alderan kernel:  sdc: sdc1 sdc2
Jun  8 09:21:35 alderan kernel: sd 2:0:0:0: [sdc] Attached SCSI disk
Jun  8 09:21:35 alderan kernel: sd 2:0:0:0: Attached scsi generic sg2 type 0
Jun  8 09:21:35 alderan kernel: scsi 3:0:0:0: Direct-Access     ATA     
ST3500630AS      3.AA PQ: 0 ANSI: 5
Jun  8 09:21:35 alderan kernel: sd 3:0:0:0: [sdd] 976773168 512-byte
hardware sectors (500108 MB)
Jun  8 09:21:35 alderan kernel: sd 3:0:0:0: [sdd] Write Protect is off
Jun  8 09:21:35 alderan kernel: sd 3:0:0:0: [sdd] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun  8 09:21:35 alderan kernel: sd 3:0:0:0: [sdd] 976773168 512-byte
hardware sectors (500108 MB)
Jun  8 09:21:35 alderan kernel: sd 3:0:0:0: [sdd] Write Protect is off
Jun  8 09:21:35 alderan kernel: sd 3:0:0:0: [sdd] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun  8 09:21:35 alderan kernel:  sdd: sdd1 sdd2
Jun  8 09:21:35 alderan kernel: sd 3:0:0:0: [sdd] Attached SCSI disk
Jun  8 09:21:35 alderan kernel: sd 3:0:0:0: Attached scsi generic sg3 type 0

Jun  8 10:11:36 alderan kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2
Jun  8 10:11:36 alderan kernel: ata4.00: (port_status 0x20080000)
Jun  8 10:11:36 alderan kernel: ata4.00: cmd
25/00:08:d7:dc:8a/00:00:33:00:00/e0 tag 0 cdb 0x0 data 4096 in
Jun  8 10:11:36 alderan kernel:          res
50/00:00:de:dc:8a/00:00:33:00:00/e0 Emask 0x2 (HSM violation)
Jun  8 10:11:36 alderan kernel: ata4: soft resetting port
Jun  8 10:11:37 alderan kernel: ata4: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Jun  8 10:11:37 alderan kernel: ata4.00: ata_hpa_resize 1: sectors =
976773168, hpa_sectors = 976773168
Jun  8 10:11:37 alderan kernel: ata4.00: ata_hpa_resize 1: sectors =
976773168, hpa_sectors = 976773168
Jun  8 10:11:37 alderan kernel: ata4.00: configured for UDMA/133
Jun  8 10:11:37 alderan kernel: ata4: EH complete
Jun  8 10:11:37 alderan kernel: sd 3:0:0:0: [sdd] 976773168 512-byte
hardware sectors (500108 MB)
Jun  8 10:11:37 alderan kernel: sd 3:0:0:0: [sdd] Write Protect is off
Jun  8 10:11:37 alderan kernel: sd 3:0:0:0: [sdd] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun  8 10:11:39 alderan kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2
Jun  8 10:11:39 alderan kernel: ata4.00: (port_status 0x20080000)
Jun  8 10:11:39 alderan kernel: ata4.00: cmd
c8/00:08:0f:a9:a5/00:00:00:00:00/e3 tag 0 cdb 0x0 data 4096 in
Jun  8 10:11:39 alderan kernel:          res
50/00:00:16:a9:a5/00:00:33:00:00/e3 Emask 0x2 (HSM violation)
Jun  8 10:11:39 alderan kernel: ata4: soft resetting port
Jun  8 10:11:39 alderan kernel: ata4: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Jun  8 10:11:39 alderan kernel: ata4.00: ata_hpa_resize 1: sectors =
976773168, hpa_sectors = 976773168
Jun  8 10:11:39 alderan kernel: ata4.00: ata_hpa_resize 1: sectors =
976773168, hpa_sectors = 976773168
Jun  8 10:11:39 alderan kernel: ata4.00: configured for UDMA/133
Jun  8 10:11:39 alderan kernel: ata4: EH complete
Jun  8 10:11:39 alderan kernel: sd 3:0:0:0: [sdd] 976773168 512-byte
hardware sectors (500108 MB)
Jun  8 10:11:39 alderan kernel: sd 3:0:0:0: [sdd] Write Protect is off
Jun  8 10:11:39 alderan kernel: sd 3:0:0:0: [sdd] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA

-----------------------------------------------------------------------------

Regards,
Tomi Orava

>
> [ 1076.900017] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000
> action 0x2 frozen
> [ 1076.900031] ata1.00: cmd c8/00:00:00:16:e6/00:00:00:00:00/e1 tag 0
> cdb 0x0 data 131072 in
> [ 1076.900033]          res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [ 1082.249590] ata1: port is slow to respond, please be patient (Status
> 0xff)
> [ 1086.951564] ata1: device not ready (errno=-16), forcing hardreset
> [ 1086.951573] ata1: hard resetting port
> [ 1092.465004] ata1: port is slow to respond, please be patient (Status
> 0xff)
> [ 1096.998967] ata1: COMRESET failed (errno=-16)
> [ 1096.998977] ata1: hard resetting port
> [ 1102.512501] ata1: port is slow to respond, please be patient (Status
> 0xff)
> [ 1107.046465] ata1: COMRESET failed (errno=-16)
> [ 1107.046474] ata1: hard resetting port
> [ 1112.559985] ata1: port is slow to respond, please be patient (Status
> 0xff)
> [ 1142.058746] ata1: COMRESET failed (errno=-16)
> [ 1142.058758] ata1: hard resetting port
> [ 1147.068505] ata1: COMRESET failed (errno=-16)
> [ 1147.068514] ata1: reset failed, giving up
> [ 1147.068517] ata1.00: disabled
> [ 1147.068531] ata1: EH complete
> [ 1147.068962] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> [ 1147.068968] end_request: I/O error, dev sda, sector 31856128
> [ 1147.068972] Buffer I/O error on device sda, logical block 3982016
> [ 1147.068978] Buffer I/O error on device sda, logical block 3982017
> [ 1147.068981] Buffer I/O error on device sda, logical block 3982018
> [ 1147.068985] Buffer I/O error on device sda, logical block 3982019
> [ 1147.068989] Buffer I/O error on device sda, logical block 3982020
> [ 1147.068992] Buffer I/O error on device sda, logical block 3982021
> [ 1147.068996] Buffer I/O error on device sda, logical block 3982022
> [ 1147.068999] Buffer I/O error on device sda, logical block 3982023
> [ 1147.069003] Buffer I/O error on device sda, logical block 3982024
> [ 1147.069006] Buffer I/O error on device sda, logical block 3982025
> [ 1147.069037] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> [ 1147.069041] end_request: I/O error, dev sda, sector 31856384
> [ 1147.071273] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> [ 1147.071282] end_request: I/O error, dev sda, sector 31856128
> [ 1147.072482] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> [ 1147.072491] end_request: I/O error, dev sda, sector 31856128


-- 
Tomi.Orava@ncircle.nullnet.fi

