From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: DMA not works in Linux 2.6.12, but in Windows works fine.
Date: Mon, 23 May 2005 19:30:10 +0400
Message-ID: <20050523193010.5bf72481.vsu@altlinux.ru>
References: <web-135595327@mail5.rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__23_May_2005_19_30_10_+0400_WXj0EECyXv_wViYA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mivlgu.ru ([81.18.140.87]:16610 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S261881AbVEWPaP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2005 11:30:15 -0400
In-Reply-To: <web-135595327@mail5.rambler.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ivan G <g-i-v@rambler.ru>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

--Signature=_Mon__23_May_2005_19_30_10_+0400_WXj0EECyXv_wViYA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 23 May 2005 14:25:32 +0400 Ivan G wrote:

> DMA not works in Linux 2.6.12, but in Windows works fine.
> 
> DMA not works with HDD and CD drives connected by 80-conductor
> cable to secondary IDE port (ide1).
> 
> Hardware description:
> 
>    1) Motherboard has chipset Intel, Giga-byte
>    2) HDD Seagate ST3160023AS (Serial ATA)
>    3) HDD Seagate ST3200822A (IDE ATA)
>    4) SONY CD-RW CRX320E, IDE ATAPI CD/DVD-ROM
> 
> 
> Hardware connections:
> 
>    ST3160023AS ---> SATA0 ---> BIOS mapping ---> ide0 Pri master 
>  (hda)
>                     SATA1 ---> BIOS mapping ---> ide0 Pri slave
>    CRX320E     --------------------------------> ide1 Sec master 
>  (hdc)
>    ST3200822A  --------------------------------> ide1 Sec slave 
>   (hdd)
[skip]
> ide0: I/O resource 0x1F0-0x1F7 not free.
> ide0: ports already in use, skipping probe
> Probing IDE interface ide1...
> hdc: SONY CD-RW CRX320E, ATAPI CD/DVD-ROM drive
> hdd: ST3200822A, ATA DISK drive
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> ide1 at 0x170-0x177,0x376 on irq 15
> hdd: max request size: 1024KiB
> hdd: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
> hdd: cache flushes supported
>   hdd: hdd1 hdd2
> hdc: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache
> Uniform CD-ROM driver Revision: 3.20
> libata version 1.10 loaded.
> ata_piix version 1.03
> ata_piix: combined mode detected
[skip]

This is a known problem - if the Intel ICH5/6 controller is used in
combined mode (SATA mapped to legacy IDE ports), DMA for PATA devices
does not work.  If you reconfigure the controller in BIOS to not use the
combined mode (so that the SATA part becomes a separate PCI device), DMA
for PATA devices will work fine.

To IDE developers: Is something planned to work around this problem?
AFAIK, there are some machines where BIOS does not provide an option to
turn off the combined mode.

--Signature=_Mon__23_May_2005_19_30_10_+0400_WXj0EECyXv_wViYA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCkfcEW82GfkQfsqIRAmN1AJ93VnUrteSBAbzu8ZEXOImYEvoVNACbBIPj
amNzatgIXnkGUui/RHQGTow=
=mNWY
-----END PGP SIGNATURE-----

--Signature=_Mon__23_May_2005_19_30_10_+0400_WXj0EECyXv_wViYA--
