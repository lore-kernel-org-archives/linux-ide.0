From: Juha-Matti Tapio <jmtapio@verkkotelakka.net>
Subject: [PATCH] ide: fix the IDEDMA_PCI dependency caused by drivers/ide/ppc/pmac.c
Date: Mon, 25 Jul 2005 00:58:10 +0300
Message-ID: <20050724215810.GA17934@verkkotelakka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from refraktori.verkkotelakka.net ([212.16.98.234]:30371 "EHLO
	refraktori.verkkotelakka.net") by vger.kernel.org with ESMTP
	id S261422AbVGXV6q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Jul 2005 17:58:46 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: paulus@au.ibm.com, benh@kernel.crashing.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

drivers/ide/ppc/pmac.c uses symbols ide_build_sglist,
__ide_dma_off_quietly, __ide_dma_on and __ide_dma_timeout when
CONFIG_BLK_DEV_IDEDMA_PMAC is defined. The declarations for these
symbols (in ide.h) depend on CONFIG_BLK_DEV_IDEDMA_PCI. There is a
missing dependency for this in drivers/ide/Kconfig which causes
drivers/ide/ppc/pmac.c to fail to build if CONFIG_BLK_DEV_IDEDMA_PMAC
is selected but CONFIG_BLK_DEV_IDEDMA_PCI is not.

Signed-off-by: Juha-Matti Tapio <jmtapio@verkkotelakka.net>

diff -ur linux-2.6.12/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- linux-2.6.12/drivers/ide/Kconfig	2005-06-22 22:33:05.000000000 +0300
+++ b/drivers/ide/Kconfig	2005-07-24 23:27:41.000000000 +0300
@@ -758,6 +758,7 @@ config BLK_DEV_IDE_PMAC_ATA100FIRST
 config BLK_DEV_IDEDMA_PMAC
 	bool "PowerMac IDE DMA support"
 	depends on BLK_DEV_IDE_PMAC
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This option allows the driver for the built-in IDE controller on
 	  Power Macintoshes and PowerBooks to use DMA (direct memory access)

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC5A7yRGhQc/k/gTsRAoqMAKCi1vR24IebyRSfwiXnrI8fZpz9VACfXQrm
rprxoJ2Yoyvt7MdQNid4jBA=
=knPN
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
