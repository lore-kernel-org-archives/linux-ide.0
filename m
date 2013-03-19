From: Noone Nowhere <levelwol@gmail.com>
Subject: Wrong NCQ blacklist at libata for Maxtor DiamondMax 10
Date: Tue, 19 Mar 2013 16:26:14 +0200
Message-ID: <CANxHX8-2EVqgX0vviNt5n6P6PCqjQk3GMGDUue6k_ckSYXoA3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f65.google.com ([209.85.219.65]:51505 "EHLO
	mail-oa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab3CSO0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Mar 2013 10:26:14 -0400
Received: by mail-oa0-f65.google.com with SMTP id k14so123917oag.0
        for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2013 07:26:14 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Not all Maxtor DiamondMax 10 with F/W BANC misbehave with NCQ

Hello to the libata team, this is VoRTeX from the linux kernel ata wiki.
Four years ago in 2009 the libata NONCQ HORKAGE came to our attention.
We had a Seagate ST380817AS 7200.7+ SATA 1.5Gbs NCQ which refused to
work nice on an ASUS mATX NF430 system even on Windows.
After the drive got blacklisted Nick sent it back since it was on
warranty(thought later he regretted it).
Afterwards we tried searching for second hand BANC Maxtors since we
could certify them with home-brew storage verification app.
We found and tested two DM10 SATA I 6L080M0 with f/w BANC1G10. After
the testing finished succesfully for both (but on non NCQ hosts as we
did not have one back then)
an update for nforce 4 came to our attention and we asked for and
received f/w update from seagate (BANC1GG0.zip) after a month's
efforts. The first drive was flashed and tested again and was found
good again.
Now we move fwd to 2013, we have many systems with all sorts of NCQ
hosts and we remove the blacklist from a vanilla kernel to see what
happens under test.
The first stress test was copying /usr from installation disk to the
ext4 formatted BANC HDDs
The second stress test was "sudo bonnie++ -d $idir -s 32080m -m p63 -n
16:100000:16:64 -u root" and takes about 45~60 minutes. We saw the
command on a NCQ bug report concerning 10 RAID5 raptors and thought it
would do the trick. If you find it won't do the job suggest
replacements.
The BANC1GG0 drive was tested on a AMD SB950 with test 1 and on SB950,
SB850, SB750, SiI3132, JMB363, 88SE9128 with test 2 showing ABSOLUTELY
NO PROBLEMS!!
The BANC1G10 drive was tested on a AMD SB950 with test 1 and test 2
showing ABSOLUTELY NO PROBLEMS!!
The blacklist entry must be corrected from BANC* to BANC1x*, BANC1z*
and so on, but not BANC1G. We could not test it on nforce but will try
to buy 2 different mobos by the end of the month (if the pocket
permits). Also we could not test it on ICH and PCH since we do not buy
intel anymore as these are closed chips with most docs locked under
NDA. If a bug occurs on nforce and/or ICH-PCH then a per chipset
blacklist should be made. Could old kernels be faulty?

We can send the patch ourselves if you wish, if the are no objections.

Info of the updated disk running on the modified(BANC* commented out)
vanilla 3.8.2 kernel on a SB950 to verify that NCQ is indeed on:

/dev/sdb:

ATA device, with non-removable media
	Model Number:       Maxtor 6L080M0
	Serial Number:      @@@@@@@@
    Firmware Revision:  BANC1GG0
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 0
	Supported: 7 6 5 4 & some of 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  160086528
	Logical/Physical Sector size:           512 bytes
	device size with M = 1024*1024:       78167 MBytes
	device size with M = 1000*1000:       81964 MBytes (81 GB)
	cache/buffer size  = 8192 KBytes (type=DualPortCache)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Advanced power management level: disabled
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_VERIFY command
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	    	Advanced Power Management feature set
	    	SET_MAX security extension
	   *	Automatic Acoustic Management feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	SMART error logging
	   *	SMART self-test
	    	Media Card Pass-Through
	   *	General Purpose Logging feature set
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	URG for READ_STREAM[_DMA]_EXT
	   *	URG for WRITE_STREAM[_DMA]_EXT
	   *	Gen1 signaling speed (1.5Gb/s)
	   *	Native Command Queueing (NCQ)
	    	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Data Tables (AC5)
Security:
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct


[    1.036575] SCSI subsystem initialized
[    1.057000] libata version 3.00 loaded.
[    1.293292] ahci 0000:00:11.0: version 3.0
[    1.293412] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6
Gbps 0x3f impl SATA mode
[    1.293415] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led
clo pmp pio slum part
[    1.295097] scsi0 : ahci
[    1.295193] scsi1 : ahci
[    1.296123] scsi2 : ahci
[    1.296202] scsi3 : ahci
[    1.296257] scsi4 : ahci
[    1.296313] scsi5 : ahci
[    1.296344] ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port
0xfeb0b100 irq 19
[    1.296347] ata2: SATA max UDMA/133 abar m1024@0xfeb0b000 port
0xfeb0b180 irq 19
[    1.296350] ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port
0xfeb0b200 irq 19
[    1.296352] ata4: SATA max UDMA/133 abar m1024@0xfeb0b000 port
0xfeb0b280 irq 19
[    1.296354] ata5: SATA max UDMA/133 abar m1024@0xfeb0b000 port
0xfeb0b300 irq 19
[    1.296357] ata6: SATA max UDMA/133 abar m1024@0xfeb0b000 port
0xfeb0b380 irq 19
[    1.296546] ahci 0000:02:00.0: AHCI 0001.0100 32 slots 2 ports 3
Gbps 0x3 impl SATA mode
[    1.296549] ahci 0000:02:00.0: flags: 64bit ncq led clo pmp pio
[    1.296808] scsi6 : ahci
[    1.296887] scsi7 : ahci
[    1.296917] ata7: SATA max UDMA/133 abar m512@0xfe900000 port
0xfe900100 irq 44
[    1.296920] ata8: SATA max UDMA/133 abar m512@0xfe900000 port
0xfe900180 irq 44
[    1.615922] ata2: SATA link down (SStatus 0 SControl 300)
[    1.619899] ata5: SATA link down (SStatus 0 SControl 300)
[    1.619943] ata8: SATA link down (SStatus 0 SControl 300)
[    1.619969] ata7: SATA link down (SStatus 0 SControl 300)
[    1.783604] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.785403] ata1.00: ATA-8: WDC WD5000AAKX-001CA0, 15.01H15, max UDMA/133
[    1.785407] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.786746] ata1.00: configured for UDMA/133
[    1.786844] scsi 0:0:0:0: Direct-Access     ATA      WDC
WD5000AAKX-0 15.0 PQ: 0 ANSI: 5
[    1.787558] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.789051] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks:
(500 GB/465 GiB)
[    1.789080] sd 0:0:0:0: [sda] Write Protect is off
[    1.789083] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.789096] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.791589] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.791612] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.793645] ata4.00: ATAPI: Optiarc DVD RW AD-7261S, 1.03, max
UDMA/100, ATAPI AN
[    1.793880] ata6.00: ATA-7: Maxtor 6L080M0, BANC1GG0, max UDMA/133
[    1.793883] ata6.00: 160086528 sectors, multi 0: LBA NCQ (depth 31/32)
[    1.796140] ata4.00: configured for UDMA/100
[    1.796778] ata3.00: ATAPI: HL-DT-ST BD-RE  BH10LS38, 1.01, max
UDMA/133, ATAPI AN
[    1.797053] ata6.00: configured for UDMA/133
[    1.801337] ata3.00: configured for UDMA/133
[    1.809847] scsi 2:0:0:0: CD-ROM            HL-DT-ST BD-RE
BH10LS38  1.01 PQ: 0 ANSI: 5
[    1.811788] scsi 3:0:0:0: CD-ROM            Optiarc  DVD RW
AD-7261S  1.03 PQ: 0 ANSI: 5
[    1.812455] scsi 5:0:0:0: Direct-Access     ATA      Maxtor 6L080M0
  BANC PQ: 0 ANSI: 5
[    1.812630] sd 5:0:0:0: [sdb] 160086528 512-byte logical blocks:
(81.9 GB/76.3 GiB)
[    1.812756] sd 5:0:0:0: [sdb] Write Protect is off
[    1.812759] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.812890] sd 5:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.827958] sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw
xa/form2 cdda tray
[    1.827962] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.828253] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.830309]  sdb: unknown partition table
[    1.830793] sd 5:0:0:0: [sdb] Attached SCSI disk
[    1.830800] sr1: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw
xa/form2 cdda tray
[    1.831002] sr 3:0:0:0: Attached scsi CD-ROM sr1
[    1.832128]  sda: sda1 sda2 sda3 sda4 sda5
[    1.832458] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.835846] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.836483] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    1.836528] sr 3:0:0:0: Attached scsi generic sg2 type 5
[    1.836729] sd 5:0:0:0: Attached scsi generic sg3 type 0
