From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: Q67 and QM67 COMRESET solved by skip_host_reset=1
Date: Thu, 26 May 2011 09:12:10 -0400
Message-ID: <BANLkTinq4HB_yyW29PBeU+o_Q3EYmr9BEw@mail.gmail.com>
References: <BANLkTinYpjMgqqmtEuPsZSTGb0ENGWKf8g@mail.gmail.com> <20110525093617.GE10146@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57886 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547Ab1EZNMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 May 2011 09:12:30 -0400
Received: by pwi15 with SMTP id 15so326544pwi.19
        for <linux-ide@vger.kernel.org>; Thu, 26 May 2011 06:12:30 -0700 (PDT)
In-Reply-To: <20110525093617.GE10146@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, dan.j.williams@intel.com, seth.heasley@intel.com, Matthew Wilcox <matthew@wil.cx>

On Wed, May 25, 2011 at 5:36 AM, Tejun Heo <tj@kernel.org> wrote:
> Cc'ing Intel people and Jeff. =A0Hi!
>
> Any ideas what's going on with the following? =A0In short, on sandy
> bridge ahci + intel g2 ssd, doing HOST_RESET during initialization
> makes the first reset timeout inducing 10 sec delay.

On my desktop box, I have three SATA devices: a Sandforce-based SSD, a
normal hard drive, and a CD.  Only the SSD has the problem, and
libahci.skip_host_reset=3D1 fixes it on this box as well.  Here's the
relevant bit of the log:

[    0.859971] SCSI subsystem initialized
[    0.860035] libata version 3.00 loaded.
[    1.699964] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    2.063131] ahci 0000:00:1f.2: version 3.0
[    2.063159] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> I=
RQ 19
[    2.063222] ahci 0000:00:1f.2: irq 44 for MSI/MSI-X
[    2.074006] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6
Gbps 0xd impl SATA mode
[    2.074011] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio
slum part ems apst
[    2.074017] ahci 0000:00:1f.2: setting latency timer to 64
[    2.078640] scsi0 : ahci
[    2.078746] scsi1 : ahci
[    2.078824] scsi2 : ahci
[    2.078901] scsi3 : ahci
[    2.079001] scsi4 : ahci
[    2.079078] scsi5 : ahci
[    2.079265] ata1: SATA max UDMA/133 abar m2048@0xfe625000 port
0xfe625100 irq 44
[    2.079267] ata2: DUMMY
[    2.079271] ata3: SATA max UDMA/133 abar m2048@0xfe625000 port
0xfe625200 irq 44
[    2.079275] ata4: SATA max UDMA/133 abar m2048@0xfe625000 port
0xfe625280 irq 44
[    2.079277] ata5: DUMMY
[    2.079278] ata6: DUMMY
[    2.383860] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.383890] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.385551] ata4.00: ATAPI: ATAPI   iHAS124   Y, BL0V, max UDMA/100
[    2.387157] ata3.00: ATA-8: WDC WD20EARS-00MVWB0, 51.0AB51, max UDMA=
/133
[    2.387162] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    2.387463] ata4.00: configured for UDMA/100
[    2.390392] ata3.00: configured for UDMA/133
[    7.431907] ata1: link is slow to respond, please be patient (ready=3D=
0)
[   12.121178] ata1: COMRESET failed (errno=3D-16)
[   12.428010] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   12.540828] ata1.00: ATA-9: OCZ-VERTEX3, 2.02, max UDMA/133
[   12.540833] ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 3=
1/32), AA
[   12.700454] ata1.00: configured for UDMA/133
[   12.700608] scsi 0:0:0:0: Direct-Access     ATA      OCZ-VERTEX3
  2.02 PQ: 0 ANSI: 5
[   12.700793] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   12.701075] scsi 2:0:0:0: Direct-Access     ATA      WDC
WD20EARS-00M 51.0 PQ: 0 ANSI: 5
[   12.701260] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   12.702606] scsi 3:0:0:0: CD-ROM            ATAPI    iHAS124   Y
  BL0V PQ: 0 ANSI: 5
[   12.704747] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw
xa/form2 cdda tray
[   12.704905] sr 3:0:0:0: Attached scsi CD-ROM sr0
[   12.704994] sr 3:0:0:0: Attached scsi generic sg2 type 5
[   12.732913] sd 0:0:0:0: [sda] Attached SCSI disk
[   13.162743] sd 2:0:0:0: [sdb] Attached SCSI disk
[   13.166078] Write protecting the kernel read-only data: 10240k
[   14.382014] ata_generic 0000:00:16.2: PCI INT C -> GSI 18 (level,
low) -> IRQ 18
[   14.382053] ata_generic 0000:00:16.2: setting latency timer to 64
[   14.382667] scsi6 : ata_generic
[   14.382803] scsi7 : ata_generic
[   14.382910] ata7: PATA max UDMA/100 cmd 0xf130 ctl 0xf120 bmdma 0xf0=
f0 irq 18
[   14.382915] ata8: PATA max UDMA/100 cmd 0xf110 ctl 0xf100 bmdma 0xf0=
f8 irq 18
[   21.025971] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
[   21.065133] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
[   23.589131] EXT4-fs (sda2): mounted filesystem with ordered data
mode. Opts: (null)
[   23.803949] scsi8 : usb-storage 3-1.1.1:1.0
[   24.808346] scsi 8:0:0:0: Direct-Access     Generic  Ultra
HS-SD/MMC  1.91 PQ: 0 ANSI: 0
[   24.809189] sd 8:0:0:0: Attached scsi generic sg3 type 0
[   24.817288] sd 8:0:0:0: [sdc] Attached SCSI removable disk

--Andy
