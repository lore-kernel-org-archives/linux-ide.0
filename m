From: Frans Pop <elendil@planet.nl>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 22:14:16 +0200
Message-ID: <200906212214.18189.elendil@planet.nl>
References: <200906202352.33894.elendil@planet.nl> <200906211446.38598.elendil@planet.nl> <200906211533.41452.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aSpPKWxtoTzqKsy"
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906211533.41452.bzolnier@gmail.com>
Sender: sparclinux-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--Boundary-00=_aSpPKWxtoTzqKsy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 21 June 2009, Bartlomiej Zolnierkiewicz wrote:
> Great work Sherlock, Frans has found this already by himself.. ;)

Well, that info wasn't included yet in the original mail I sent only to 
sparclinux...

> Frans, could you try also the current Linus tree + David's patch?

I'd seen that some additional patches had gone in recently, but with 
current .31 (v2.6.30-7732-g2453d6f) I still get the last remaining
"nobody cared" error.

On Sunday 21 June 2009, Bartlomiej Zolnierkiewicz wrote:
> I wonder if the weird hdd device could be a problem here

AFAIK it's the original CD drive that came with the box.

> (does it use DMA under pata_cmd64x,

Attached the dmesg for a boot with pata_cmd64x. It is a bit noisy with all 
those "active {10,3} recovery {10,1} setup {3,1}" messages (are those 
harmless?), but otherwise clean.

Not 100% sure, but I think it shows DMA being used:
ata2.01: ATAPI: CD-ROM 56X/AKH, A8E, max MWDMA2
ata2.01: configured for MWDMA2

> also please send 'hdparm --Istdout /dev/hdd' output)..

# hdparm --Istdout /dev/hdd	# with 2.6.26
/dev/hdd:
 HDIO_DRIVE_CMD(identify) failed: Invalid exchange

> Could you check if it helps if we skip ide1 for debug purposes:

I have not yet tried this.

--Boundary-00=_aSpPKWxtoTzqKsy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="2.6.30.pata"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="2.6.30.pata"

SCSI subsystem initialized
libata version 3.00 loaded.
scsi0 : pata_cmd64x
scsi1 : pata_cmd64x
ata1: PATA max MWDMA2 cmd 0x1fe02c00000 ctl 0x1fe02c00008 bmdma 0x1fe02c00020 irq 14
ata2: PATA max MWDMA2 cmd 0x1fe02c00010 ctl 0x1fe02c00018 bmdma 0x1fe02c00028 irq 14
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
ata1.00: ATA-2: ST34342A, 0.42, max UDMA/33
ata1.00: 8404830 sectors, multi 0: LBA 
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata1.00: configured for MWDMA2
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata1.00: configured for MWDMA2
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      ST34342A         0.42 PQ: 0 ANSI: 5
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
ata2.00: ATA-7: Maxtor 6E040L0, NAR61590, max UDMA/133
ata2.00: 80293248 sectors, multi 0: LBA 
ata2.01: ATAPI: CD-ROM 56X/AKH, A8E, max MWDMA2
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata2.00: configured for MWDMA2
ata2.01: configured for MWDMA2
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6E040L0   NAR6 PQ: 0 ANSI: 5
scsi 1:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH   A8E  PQ: 0 ANSI: 5
Driver 'sd' needs updating - please use bus_type methods
sd 0:0:0:0: [sda] 8404830 512-byte hardware sectors: (4.30 GB/4.00 GiB)
sd 1:0:0:0: [sdb] 80293248 512-byte hardware sectors: (41.1 GB/38.2 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:<6> sda: sdb1 sdb2 sdb3 sdb4 sdb5
 sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: [sdb] Attached SCSI disk
Driver 'sr' needs updating - please use bus_type methods
sr0: scsi3-mmc drive: 0x/52x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sr 1:0:1:0: Attached scsi generic sg2 type 5

--Boundary-00=_aSpPKWxtoTzqKsy--
