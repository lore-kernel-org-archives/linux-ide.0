From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] pata_platform: move ARCH_RPC to use MACH_HAS_PATA_PLATFORM
Date: Mon, 19 Nov 2007 12:43:40 +0000
Message-ID: <20071119124340.GJ26444@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:46760 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbXKSMnl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 07:43:41 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
Cc: Vincent Sanders <vince@simtec.co.uk>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move ARCH_RPC to using MACH_HAS_PATA_PLATFORM as an example
of using this new configuration.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X linux-2.6.24-rc3-pata1/Documentation/dontdiff linux-2.6.24-rc=
3-pata1/drivers/ata/Kconfig linux-2.6.24-rc3-pata2/drivers/ata/Kconfig
--- linux-2.6.24-rc3-pata1/drivers/ata/Kconfig	2007-11-19 12:25:03.00000000=
0 +0000
+++ linux-2.6.24-rc3-pata2/drivers/ata/Kconfig	2007-11-19 12:24:51.00000000=
0 +0000
@@ -570,7 +570,7 @@ config MACH_HAS_PATA_PLATFORM
=20
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EMBEDDED || ARCH_RPC || MACH_HAS_PATA_PLATFORM
+	depends on EMBEDDED || MACH_HAS_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.
diff -urpN -X linux-2.6.24-rc3-pata1/Documentation/dontdiff linux-2.6.24-rc=
3-pata1/arch/arm/Kconfig linux-2.6.24-rc3-pata2/arch/arm/Kconfig
--- linux-2.6.24-rc3-pata1/arch/arm/Kconfig	2007-10-09 21:31:38.000000000 +=
0100
+++ linux-2.6.24-rc3-pata2/arch/arm/Kconfig	2007-11-19 12:25:43.000000000 +=
0000
@@ -353,6 +353,7 @@ config ARCH_RPC
 	select ARCH_MAY_HAVE_PC_FDC
 	select ISA_DMA_API
 	select NO_IOPORT
+	select MACH_HAS_PATA_PLATFORM
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFHQYT7JZCApG2L7OYRApjBAJ9CDfjAMbpV4/9AFsivAIYYr+cVngCgoQro
oxJbiwQ7anPC6D583Pnbsag=
=GnDk
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
