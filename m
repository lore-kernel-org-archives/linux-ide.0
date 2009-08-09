From: Mathieu GELI <mathieu.geli@gmail.com>
Subject: Re: CF to SATA bridge support
Date: Sun, 9 Aug 2009 18:23:38 +0200
Message-ID: <43479bc90908090923h40305e14mf726d30fbed0733f@mail.gmail.com>
References: <43479bc90908071059o2ce5ac94v1d9d959e3af44326@mail.gmail.com>
	 <4A7CEF3B.9090506@gmail.com>
	 <43479bc90908081135i229d4061k9d461444d3600645@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:43327 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbZHIQXk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 12:23:40 -0400
Received: by qyk34 with SMTP id 34so2284925qyk.33
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 09:23:38 -0700 (PDT)
In-Reply-To: <43479bc90908081135i229d4061k9d461444d3600645@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Investigating the IORDY problem I did cross-build a custom 2.6.30.4
(from kernel.org) arm kernel and patched it accordingly to [1].
What results is : Compact Flash is now *detected* but when using it in
real life (mkswap+swapon) things are getting bad.

at boot time :

[    2.190000] SCSI subsystem initialized
[    2.410000] libata version 3.00 loaded.
[    2.460000] sata_mv sata_mv.0: version 1.28
[    2.470000] sata_mv sata_mv.0: slots 32 ports 2
[    2.480000] scsi0 : sata_mv
[    2.480000] scsi1 : sata_mv
[    2.480000] ata1: SATA max UDMA/133 irq 29
[    2.490000] ata2: SATA max UDMA/133 irq 29
[    3.000000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.060000] ata1.00: CFA: LEXAR ATA FLASH, V2.02, max PIO4
[    3.060000] ata1.00: 2003904 sectors, multi 0: LBA
[    3.070000] ata1.00: applying bridge limits
[    3.110000] ata1.00: configured for PIO4
[    3.170000] ata1.00: configured for PIO4
[    3.170000] ata1: EH complete
[    3.170000] scsi 0:0:0:0: Direct-Access     ATA      LEXAR ATA
FLASH  V2.0 PQ: 0 ANSI: 5
[    3.690000] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.710000] ata2.00: ATA-7: SAMSUNG HD103UJ, 1AA01118, max UDMA7
[    3.710000] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    3.740000] ata2.00: configured for UDMA/133
[    3.740000] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG
HD103UJ  1AA0 PQ: 0 ANSI: 5
[    5.750000] Driver 'sd' needs updating - please use bus_type methods
[    5.760000] sd 0:0:0:0: [sda] 2003904 512-byte hardware sectors:
(1.02 GB/978 MiB)
[    5.760000] sd 0:0:0:0: [sda] Write Protect is off
[    5.770000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.770000] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    5.780000]  sda:<4>ata1: sata_mv: attempting PIO w/multiple DRQ:
this may fail due to h/w errata
[    5.810000]  sda1
[    5.810000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    5.860000] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    5.870000] sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors:
(1.00 TB/931 GiB)
[    5.880000] sd 1:0:0:0: [sdb] Write Protect is off
[    5.880000] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.880000] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.890000]  sdb: sdb1 sdb2
[    5.900000] sd 1:0:0:0: [sdb] Attached SCSI disk
[    6.870000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    6.880000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    6.900000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    6.920000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    6.940000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    6.960000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    6.980000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    7.010000] ata1: sata_mv: attempting PIO w/multiple DRQ: this may
fail due to h/w errata
[    7.890000] device-mapper: uevent: version 1.0.3
[...]

and after swapon and running memory demanding application :
[ 2149.180000] ata1: hard resetting link
[ 2149.700000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2149.780000] ata1.00: configured for PIO0
[ 2149.820000] ata1.00: configured for PIO0
[ 2149.820000] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[ 2149.830000] sd 0:0:0:0: [sda] Sense Key : Aborted Command [current]
[descriptor]
[ 2149.830000] Descriptor sense data with sense descriptors (in hex):
[ 2149.840000]         72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 2149.850000]         00 00 80 f7
[ 2149.850000] sd 0:0:0:0: [sda] Add. Sense: Scsi parity error
[ 2149.860000] end_request: I/O error, dev sda, sector 33015
[ 2149.860000] Write-error on swap-device (8:0:33023)
[ 2149.870000] Write-error on swap-device (8:0:33031)
[ 2149.870000] Write-error on swap-device (8:0:33039)
[...]
[ 2150.010000] Write-error on swap-device (8:0:33271)
[ 2150.020000] ata1: EH complete
[ 2150.060000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2150.070000] ata1.00: cmd 30/00:00:f7:81:00/00:00:00:00:00/e0 tag 0
pio 131072 out
[ 2150.070000]          res 58/00:00:f7:81:00/00:00:00:00:00/e0 Emask
0x2 (HSM violation)
[ 2150.080000] ata1.00: status: { DRDY DRQ }
[ 2150.090000] ata1: hard resetting link

While that's happening, userland is unresponsive.

On a side note, just running hdparm on it doesn't trigger all those errors :

$ sudo hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   160 MB in  2.02 seconds =  79.31 MB/sec
 Timing buffered disk reads:   14 MB in  3.39 seconds =   4.13 MB/sec

Cheers

[1] http://patchwork.ozlabs.org/patch/29080/

-- 
Mathieu
