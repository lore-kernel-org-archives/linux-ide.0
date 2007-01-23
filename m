From: =?iso-8859-1?Q?Oddbj=F8rn?= Kvalsund <oddbjorn@nixx.no>
Subject: Possible performance issue with sata_sil og Gigabyte i-Ram
Date: Tue, 23 Jan 2007 21:53:01 +0100
Message-ID: <20070123205301.GK1054@nixx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nixx.no ([80.68.92.62]:34278 "EHLO nixx.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965469AbXAWVeX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jan 2007 16:34:23 -0500
Received: from oddbjorn by nixx.no with local (Exim 4.50)
	id 1H9SdZ-0003mo-6z
	for linux-ide@vger.kernel.org; Tue, 23 Jan 2007 21:53:01 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I recently purchased a Gigabyte i-Ram GC Ramdisk after reading some
quite impressive reviews online. Getting the card up and running
connected to a ST Lab A-223 Serial ATA PCI Card (sil3114 using sata_sil=
)
with kernel 2.6.19.1 was quite easy, thanks guys!

Access times on this thing are great, but I seem to be hitting some
strange performance-issues when doing large reads/writes. "hdparm -t
/dev/sda" gives me 80-82 MB/s on average and bonnie++ (see link to
complete output below) confirms these results.  My simple stdio
C-program gives write-speeds of around 70 MB/s. =20

Other people using this device report of read/write speeds constantly
maxing out their SATA150 or PCI-bus. Is this my sil3114 being the
bottleneck? Other devices on the PCI-bus? My general system (see link t=
o
the complete output of lspci and /proc/cpuinfo below)? Or is this some
glitch in the iRam + sil3114 combination?

I cannot manually enable DMA on this device, as "hdparm -d1 /dev/sda"
fails with "HDIO_SET_DMA failed: Inappropriate ioctl for device", but
from what I can tell from dmesg (U)DMA should be enabled for this drive=
=2E
I have tried enabling UDMA/133 for the controller (in sata_sil.c), givi=
ng this
output on boot:

libata version 2.00 loaded.
sata_sil 0000:03:03.0: version 2.0
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xD081AC80 ctl 0xD081AC8A bmdma 0xD081AC00 =
irq 17
ata2: SATA max UDMA/133 cmd 0xD081ACC0 ctl 0xD081ACCA bmdma 0xD081AC08 =
irq 17
ata3: SATA max UDMA/133 cmd 0xD081AE80 ctl 0xD081AE8A bmdma 0xD081AE00 =
irq 17
ata4: SATA max UDMA/133 cmd 0xD081AEC0 ctl 0xD081AECA bmdma 0xD081AE08 =
irq 17
scsi0 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 1048319 sectors: LBA=20
ata1.00: ata1: dev 0 multi count 16
ata1.00: Drive reports diagnostics failure. This may indicate a drive
ata1.00: fault or invalid emulation. Contact drive vendor for informati=
on.
ata1.00: configured for UDMA/133
<snip>
scsi 0:0:0:0: Direct-Access     ATA      GIGABYTE i-RAM   v0.9 PQ: 0 AN=
SI: 5

=2E..but this makes no noticeable difference from the default UDMA/100 =
mode.

The test system is a pretty standard desktop computer from a few years =
back:
CPU: Intel Pentium 4 - 2.4 GHz, 512 KB cache
Mainboard: MSI 845G Max-L
Memory: Apacer 256 MB PC2700
System disk: IBM IC35L040AVER07-0 40 GB 7200 RPM 8.5 MS SEEK TIME 2 MB =
BUFFER

I'm using the old piix-driver (not libata) for the IBM-disk, as I was
having some problems getting it to work with the libata-driver. I might
try to fix it later on, but could this be what's causing the problems?
The file system is ext3 both on the IBM disk and the i-Ram.  On boot I
get a message saying "The chipset may have PM-Timer Bug". I have tried
setting acpi_pm_good=3D1 as a kernel parameter, but this made no
difference.

Complete output of dmesg/cpuinfo/bonnie/lspci/hdparm can be found here:=
=20
http://nixx.no/oddbjorn/iram

Could someone please shed some light on this?

I hope I have provided enough information about the relevant hardware,
if not; let me know and I'll post what I can find.

Thanks! :)

--=20
Regards
Oddbj=F8rn Kvalsund
