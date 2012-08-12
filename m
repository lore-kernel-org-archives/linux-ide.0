From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: PATCH] ata: Kconfig: Elaborate that SFF is meant for legacy and
 PATA stuff
Date: Sun, 12 Aug 2012 23:54:16 +0200
Message-ID: <1344808456.4275.66.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-UdS9AxhsiLQIRMOZAUsd"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:57470 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab2HLVy1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Aug 2012 17:54:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>


--=-UdS9AxhsiLQIRMOZAUsd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Date: Sun, 12 Aug 2012 23:43:42 +0200

Building Linux for an ASUS Eee PC 701 4G with

        ata2.00: CFA: SILICONMOTION SM223AC, , max UDMA/66
        ata2.00: 7815024 sectors, multi 0: LBA
        ata2.00: configured for UDMA/66
        scsi 1:0:0:0: Direct-Access     ATA      SILICONMOTION SM n/a  PQ: =
0 ANSI: 5
        sd 1:0:0:0: [sda] 7815024 512-byte logical blocks: (4.00 GB/3.72 Gi=
B)
        sd 1:0:0:0: [sda] Write Protect is off
        sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
        sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn=
't support DPO or FUA
         sda: sda1
        sd 1:0:0:0: [sda] Attached SCSI disk
        sd 1:0:0:0: Attached scsi generic sg0 type 0

I followed the advice to not use the deprecated old PATA subsystem

        ATA/ATAPI/MFM/RLL support (DEPRECATED)  --->

and use the ATA subsystem instead.

        Serial ATA and Parallel ATA drivers  --->

Unfortunately I needed several tries to find out, that I needed the SFF
menu I had not selected before because I had never heard that term
before. I think it would have helped me, to have PATA or legacy IDE in
that item=E2=80=99s name.

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
If you can improve the commit summary, I would be thankful.

 drivers/ata/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2be8ef1..27cecd3 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -115,7 +115,7 @@ config SATA_SIL24
 	  If unsure, say N.
=20
 config ATA_SFF
-	bool "ATA SFF support"
+	bool "ATA SFF support (for legacy IDE and PATA)"
 	default y
 	help
 	  This option adds support for ATA controllers with SFF
--=20
1.7.10.4

--=-UdS9AxhsiLQIRMOZAUsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlAoJggACgkQPX1aK2wOHVg63ACbBYoEgGQ79w3ob5Z+7ykFyBdY
lYkAn1KjTnpvkpuKwUdgMhDPbwCchl0X
=PjkQ
-----END PGP SIGNATURE-----

--=-UdS9AxhsiLQIRMOZAUsd--

