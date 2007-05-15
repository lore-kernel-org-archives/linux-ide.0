From: Thomas Kuther <gimpel@sonnenkinder.org>
Subject: Re: IT821x: no DMA since 2.6.21
Date: Tue, 15 May 2007 14:20:39 +0200
Message-ID: <20070515142039.2eca8927@SiRiUS.home>
References: <20070515125308.3a9f6442@SiRiUS.home>
	<20070515123132.2e596d69@the-village.bc.nu>
	<20070515133555.0111c063@SiRiUS.home>
	<20070515124836.1ce42b0f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_yZcgU7TIMR7bTabJ/G8RS1w";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50090 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757451AbXEOMUq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 May 2007 08:20:46 -0400
In-Reply-To: <20070515124836.1ce42b0f@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

--Sig_yZcgU7TIMR7bTabJ/G8RS1w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Di, 15.05.07 12:48 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > I already tried pata_it821x and it failed to recognize the second
> > harddisk hdf. I use the controller only for additional harddrives,
> > no RAID, no cd-rom.
>=20
> Logs from that would be most helpful as I am maintaining the
> pata_it821x driver.
>=20
> Alan

Okay, I removed the IDE one and tried your libata driver again.

What I maybe just did wrong on my first try, was loading it without any
parameters, as:
--------------------------
pata_it821x: Unknown parameter `it8212.noraid'
pata_it821x: Unknown parameter `it8212_noraid'
--------------------------
Loading without any parameters on this kernel resulted in:
--------------------------
pata_it821x: controller in smart mode.
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 18
scsi3 : pata_it821x
scsi4 : pata_it821x
ata3: PATA max MWDMA2 cmd 0x0001ec00 ctl 0x0001e802 bmdma 0x0001dc00
irq 0=20
ata4: PATA max MWDMA2 cmd 0x0001e400 ctl 0x0001e002 bmdma 0x0001dc08
irq 0=20
ata3: SRST failed (errno=3D-16)
ata3: SRST failed (errno=3D-16)
ata3: SRST failed (errno=3D-16)
ata3: SRST failed (errno=3D-16)
ata3: reset failed, giving up
---------------------------

Now I tried with "noraid=3D1", and now all seems to be working fine.

Thanks very much!
Thomas

--Sig_yZcgU7TIMR7bTabJ/G8RS1w
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQFGSaWbMQFfAqZTGfwRAg0pAJ9qmezuLHvkdtMYs4DuhszAmK8y1gCfa+gT
CDC2YvBYybJLReGEccjH5Hg=
=bIHK
-----END PGP SIGNATURE-----

--Sig_yZcgU7TIMR7bTabJ/G8RS1w--
