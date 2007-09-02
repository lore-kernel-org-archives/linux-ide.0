From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Sun, 2 Sep 2007 19:29:03 +0100
Message-ID: <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	 <46DAB5DD.80807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:18658 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbXIBS3F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 14:29:05 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1166210fkz
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 11:29:04 -0700 (PDT)
In-Reply-To: <46DAB5DD.80807@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 02/09/07, Tejun Heo <htejun@gmail.com> wrote:
> Eddie Hung wrote:
> > Hello everyone,
> >
> > In the hope of making myself a cheap SSD, I decided to replace my IDE
> > HDD on my IBM Thinkpad X41 (non tablet) with a generic CF-IDE adaptor,
> > and a Sandisk Extreme IV 4Gb CF, for reasonable prices off ebay. This
> > was partly influenced by the report that one X41 Tablet user had it
> > working successfully: http://forum.thinkpads.com/viewtopic.php?t=41568
> > (last post on that page)
> >
> > As some of you may know, the X41 uses a SATA controller, which goes
> > into a SATA-PATA bridge, and then connects to a PATA HDD. This is a
> > strange setup, and may go some distance as to explaining why it
> > doesn't work.
> >
> > The first I tried was the Ubuntu Feisty LiveCD, which uses 2.6.20, and
> > libata picks the drive up correctly. A hdparm -I showed that the
> > device was currently running at mdma2 - which was not what I expected
> > - the Sandisk, as garnered from review websites, supports UDMA. A
> > quick hdparm -t also revealed that I was only getting about 6MB/s.
> >
> > Nonetheless, I tried to partition the disk - at which point mkfs.ext3
> > froze. Looking at dmesg, I saw some timeout commands, looking
> > something like:
> > ata1: port is slow to respond, please be patient (Status 0xd0)
> > ata1: soft resetting port
> > ata1: ... exception ... res 40/00:00:00:00:00/00:00:00:00:00/a0 Emask
> > 0x4 (timeout)
>
> From 2.6.22, please post the boot log and full error log (dmesg result)
> and the result of 'hdparm -I /dev/sda'.
>
> I don't think the device supports UDMA.  Supported transfer modes are
> indicated in the IDENTIFY page (hdparm -I) and libata/ide would use UDMA
> if the device reports so.  There's no black magic there.
>
> Regarding MWDMA2 not working, are you sure that windows uses mwdma2?
> We've had quite some number of reports about broken mwdma2 and till now
> we thought those devices were broken and black listed them but it's also
> possible that mwdma2 mode programming or something else is broken in
> ata_piix.  If so, it really needs fixing.
>
> Thanks.
>
> --
> tejun
>

Hello tejun,

Thanks for replying so quickly.

Here's the information you requested:

*** uname -r ***
2.6.22-10-generic

*** hdparm -I ***

/dev/sda:

ATA device, with non-removable media
	Model Number:       SMI MODEL
	Serial Number:      SZAUSWIN    000006E5
	Firmware Revision:  20070709
Standards:
	Likely used: 5
Configuration:
	Logical		max	current
	cylinders	7866	7866
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:    7928928
	LBA    user addressable sectors:    7928928
	device size with M = 1024*1024:        3871 MBytes
	device size with M = 1000*1000:        4059 MBytes (4 GB)
Capabilities:
	LBA, IORDY(may be)(cannot be disabled)
	bytes avail on r/w long: 4
	Standby timer values: spec'd by Vendor
	R/W multiple sector transfer: Max = 1	Current = 0
	DMA: mdma0 mdma1 *mdma2
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
HW reset results:
	CBLID- below Vih
	Device num = 0
Integrity word not set (found 0x0000, expected 0x14a5)

*** hdparm -i ***

/dev/sda:

 Model=SMI MODEL                               , FwRev=20070709,
SerialNo=SZAUSWIN    000006E5
 Config={ HardSect NotMFM Fixed DTR>10Mbs }
 RawCHS=7866/16/63, TrkSize=0, SectSize=576, ECCbytes=4
 BuffType=DualPort, BuffSize=1kB, MaxMultSect=1, MultSect=?0?
 CurCHS=7866/16/63, CurSects=7928928, LBA=yes, LBAsects=7928928
 IORDY=no, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 *mdma2
 AdvancedPM=no

 * signifies the current active mode

*** hdparm -t ***

/dev/sda:
 Timing buffered disk reads:   26 MB in  3.01 seconds =   8.64 MB/sec

*** dmesg (relevant only) ***

[    0.000000] Linux version 2.6.22-10-generic (buildd@palmer) (gcc
version 4.1.3 20070812 (prerelease) (Ubuntu 4.1.2-15ubuntu2)) #1 SMP
Wed Aug 22 08:11:52 GMT 2007 (Ubuntu 2.6.22-10.30-generic)
...snip...
[    4.328000] ahci 0000:00:1f.2: version 2.2
[    4.328000] ahci: probe of 0000:00:1f.2 failed with error -22
[    4.332000] ata_piix 0000:00:1f.2: version 2.11
[    4.332000] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[    4.332000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    4.332000] scsi0 : ata_piix
[    4.332000] scsi1 : ata_piix
[    4.332000] ata1: SATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6
bmdma 0x00011810 irq 14
[    4.332000] ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376
bmdma 0x00011818 irq 15
[    4.504000] ata1.00: ATA-0: SMI MODEL, 20070709, max MWDMA2
[    4.504000] ata1.00: 7928928 sectors, multi 0: LBA
[    4.504000] ata1.00: applying bridge limits
[    4.520000] ata1.00: configured for MWDMA2
[    4.660000] usb 1-1: device not accepting address 2, error -71
[    4.840000] ata2.00: ATAPI: DVD/CDRW UJDA775, CB03, max UDMA/33
[    5.012000] ata2.00: configured for UDMA/33
[    5.012000] scsi 0:0:0:0: Direct-Access     ATA      SMI MODEL
  2007 PQ: 0 ANSI: 5
[    5.012000] scsi 1:0:0:0: CD-ROM            MATSHITA DVD/CDRW
UJDA775 CB03 PQ: 0 ANSI: 5
[    5.028000] sd 0:0:0:0: [sda] 7928928 512-byte hardware sectors (4060 MB)
[    5.028000] sd 0:0:0:0: [sda] Write Protect is off
[    5.028000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.028000] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    5.028000] sd 0:0:0:0: [sda] 7928928 512-byte hardware sectors (4060 MB)
[    5.028000] sd 0:0:0:0: [sda] Write Protect is off
[    5.028000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.028000] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    5.028000]  sda: sda1
[    5.028000] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.032000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.032000] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    5.044000] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[    5.044000] Uniform CD-ROM driver Revision: 3.20
[    5.044000] sr 1:0:0:0: Attached scsi CD-ROM sr0
...snip...
[ 1148.368000] program gparted is using a deprecated SCSI ioctl,
please convert it to SG_IO
[ 1159.200000] program gparted is using a deprecated SCSI ioctl,
please convert it to SG_IO
[ 1238.644000] program gparted is using a deprecated SCSI ioctl,
please convert it to SG_IO
[ 1301.836000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1301.836000] ata1.00: cmd ca/00:80:50:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1301.836000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1306.876000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1311.860000] ata1: device not ready (errno=-16), forcing hardreset
[ 1311.860000] ata1: soft resetting port
[ 1312.048000] ata1.00: configured for MWDMA2
[ 1312.048000] ata1: EH complete
[ 1342.048000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1342.048000] ata1.00: cmd ca/00:80:50:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1342.048000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1347.088000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1352.072000] ata1: device not ready (errno=-16), forcing hardreset
[ 1352.072000] ata1: soft resetting port
[ 1352.260000] ata1.00: configured for MWDMA2
[ 1352.260000] ata1: EH complete
[ 1382.260000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1382.260000] ata1.00: cmd ca/00:80:50:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1382.260000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1387.300000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1392.284000] ata1: device not ready (errno=-16), forcing hardreset
[ 1392.284000] ata1: soft resetting port
[ 1392.472000] ata1.00: configured for MWDMA2
[ 1392.472000] ata1: EH complete
[ 1422.472000] ata1.00: limiting speed to MWDMA1:PIO4
[ 1422.472000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1422.472000] ata1.00: cmd ca/00:80:50:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1422.472000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1427.512000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1432.496000] ata1: device not ready (errno=-16), forcing hardreset
[ 1432.496000] ata1: soft resetting port
[ 1432.684000] ata1.00: configured for MWDMA1
[ 1432.684000] ata1: EH complete
[ 1462.684000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1462.684000] ata1.00: cmd ca/00:80:50:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1462.684000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1467.724000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1472.708000] ata1: device not ready (errno=-16), forcing hardreset
[ 1472.708000] ata1: soft resetting port
[ 1472.896000] ata1.00: configured for MWDMA1
[ 1472.896000] ata1: EH complete
[ 1502.896000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1502.896000] ata1.00: cmd ca/00:80:50:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1502.896000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1507.936000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1512.920000] ata1: device not ready (errno=-16), forcing hardreset
[ 1512.920000] ata1: soft resetting port
[ 1513.108000] ata1.00: configured for MWDMA1
[ 1513.108000] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[ 1513.108000] sd 0:0:0:0: [sda] Sense Key : Aborted Command [current]
[descriptor]
[ 1513.108000] Descriptor sense data with sense descriptors (in hex):
[ 1513.108000]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 1513.108000]         00 00 00 00
[ 1513.108000] sd 0:0:0:0: [sda] Add. Sense: No additional sense information
[ 1513.108000] end_request: I/O error, dev sda, sector 2053456
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053393
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053394
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053395
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053396
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053397
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053398
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053399
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053400
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053401
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] Buffer I/O error on device sda1, logical block 2053402
[ 1513.108000] lost page write due to I/O error on sda1
[ 1513.108000] ata1: EH complete
[ 1543.108000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1543.108000] ata1.00: cmd ca/00:80:d0:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1543.108000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1548.148000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1553.132000] ata1: device not ready (errno=-16), forcing hardreset
[ 1553.132000] ata1: soft resetting port
[ 1553.320000] ata1.00: configured for MWDMA1
[ 1553.320000] ata1: EH complete
[ 1583.320000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1583.320000] ata1.00: cmd ca/00:80:d0:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1583.320000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1588.360000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1593.344000] ata1: device not ready (errno=-16), forcing hardreset
[ 1593.344000] ata1: soft resetting port
[ 1593.532000] ata1.00: configured for MWDMA1
[ 1593.532000] ata1: EH complete
[ 1623.532000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1623.532000] ata1.00: cmd ca/00:80:d0:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1623.532000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1628.572000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1633.556000] ata1: device not ready (errno=-16), forcing hardreset
[ 1633.556000] ata1: soft resetting port
[ 1633.744000] ata1.00: configured for MWDMA1
[ 1633.744000] ata1: EH complete
[ 1663.744000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1663.744000] ata1.00: cmd ca/00:80:d0:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1663.744000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1668.784000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1673.768000] ata1: device not ready (errno=-16), forcing hardreset
[ 1673.768000] ata1: soft resetting port
[ 1673.956000] ata1.00: configured for MWDMA1
[ 1673.956000] ata1: EH complete
[ 1703.956000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 1703.956000] ata1.00: cmd ca/00:80:d0:55:1f/00:00:00:00:00/e0 tag 0
cdb 0x0 data 65536 out
[ 1703.956000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
0x4 (timeout)
[ 1708.996000] ata1: port is slow to respond, please be patient (Status 0xd0)
[ 1713.980000] ata1: device not ready (errno=-16), forcing hardreset
[ 1713.980000] ata1: soft resetting port
[ 1714.168000] ata1.00: configured for MWDMA1
[ 1714.168000] ata1: EH complete

** End ***

I can see that it falls back from MWDMA2 to MWDMA1, but it doesn't
fall back again to Single Word DMA?

What is very strange also is that I can mount the NTFS drive just
fine, and copy 70Mb of files off it (pretty nippily, I might add =D) -
without any timeouts, but as soon as I tried to do something
"lowlevel" to the disk (i.e. as you may have spotted, I used gparted
to try and resize the NTFS partition, so I could try and run mkfs.ext3
again - which was what caused the timeouts when I originally tried to
install.

I can confirm that my chipset does indeed support UDMA, here is the
hdparm -I report on my original disk:

/dev/sda:

ATA device, with non-removable media
        Model Number:       HITACHI_DK13FA-40B
        Serial Number:      D09466
        Firmware Revision:  00MCA0B7
Standards:
        Used: ATA/ATAPI-5 T13 1321D revision 3
        Supported: 5 4 3 & some of 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   78140160
        device size with M = 1024*1024:       38154 MBytes
        device size with M = 1000*1000:       40007 MBytes (40 GB)
Capabilities:
        LBA, IORDY(cannot be disabled)
        bytes avail on r/w long: 4
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 128 (0x80)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    Advanced Power Management feature set
                Address Offset Reserved Area Boot
                SET_MAX security extension
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    SMART error logging
           *    SMART self-test
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
                supported: enhanced erase
        52min for SECURITY ERASE UNIT. 52min for ENHANCED SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

*** End ***

In regards to Windows performance: I have been using the tool HDTune
to see which mode the device is in - and it reports Multiword DMA 2.
Also, the benchmark facility with HDTune reveals that the burst speed
of the drive is 2MB - consistent with the hdparm -t speed when
ide-generic is used.

Strangely enough, I've gone into Device Manager, and the transfer mode
Windows claims it is using is PIO, which seems to be contradictory to
what HDTune is telling me (and leads me to ask another question, I've
included in my reply to Alan) I've also tried to various registry
settings to try and force the device into UDMA or PIO, to no success -
as far as I can tell MWDMA may well be the lowest speed Windows XP
supports operating devices at?

Eddie
