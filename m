From: Daniel Egger <de@axiros.com>
Subject: Re: Booting from SATA disables IDE?
Date: Sun, 3 Apr 2005 13:20:47 +0200
Message-ID: <aea984413434a26d96baa71aacc12755@axiros.com>
References: <1921eeb1e202db77fdccb439f85ac532@axiros.com> <58cb370e0504030157414470af@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2--1071422461"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:62178
	"EHLO live1.axiros.com") by vger.kernel.org with ESMTP
	id S261683AbVDCLVM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Apr 2005 07:21:12 -0400
In-Reply-To: <58cb370e0504030157414470af@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org


--Apple-Mail-2--1071422461
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 03.04.2005, at 11:57, Bartlomiej Zolnierkiewicz wrote:

> Can we see also messages for non working case

This was the non-working case.

> and IDE messages for both cases?

The non-working messages had been posted already (that's
basically just the few lines saying that the IDE
architecture drivers had been loaded)

The working case is here:

Freeing unused kernel memory: 172k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
vesafb: probe of vesafb0 failed with error -6
NET: Registered protocol family 1
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 169
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1604N, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, 
UDMA(100)
hda: cache flushes supported
  /dev/ide/host0/bus0/target0/lun0: p1 p2
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
SCSI subsystem initialized
libata version 1.10 loaded.
sata_via version 1.0
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 169
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 169
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 
88:007f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
   Type:   Direct-Access                      ANSI SCSI revision: 05
sis900.c: v1.08.07 11/02/2003

Using a IDE DVD-RW drive (in the second machine which also did not work,
See other posts) I had been able to boot an Ubuntu hoary live system 
that
was also able to initialize SATA and PATA at the same time to copy over
the system to PATA and put a bootloader on it. Since I'm booting from
PATA now the system works as expected.

Servus,
       Daniel

--Apple-Mail-2--1071422461
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCT9GPchlzsq9KoIYRAkIJAJ9+ApQtxneZb8j/Zvr/WKKdkT98kgCffUNK
AW1ehWL0G4/RBxfjaEEJLe8=
=Mdgf
-----END PGP SIGNATURE-----

--Apple-Mail-2--1071422461--

