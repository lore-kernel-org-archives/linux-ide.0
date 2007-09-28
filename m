From: Peter Schwabe <schwabe@ti.rwth-aachen.de>
Subject: [patch 2.6.23-rc8] add HTS541612J9SA00 to NCQ blacklist
Date: Fri, 28 Sep 2007 14:58:49 +0200
Message-ID: <46FCFA89.7020802@ti.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enigE1BB7E9B6653266617AE64A6
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta-1.ms.rz.RWTH-Aachen.DE ([134.130.7.72]:64461 "EHLO
	mta-1.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752204AbXI1N0R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 09:26:17 -0400
Received: from ironport-out-2.rz.rwth-aachen.de ([134.130.3.59])
 by mta-1.ms.rz.RWTH-Aachen.de
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0JP2003KAX89CEC0@mta-1.ms.rz.RWTH-Aachen.de> for
 linux-ide@vger.kernel.org; Fri, 28 Sep 2007 14:55:21 +0200 (CEST)
Received: from [134.130.35.81] (elaine.ti.RWTH-Aachen.DE [134.130.35.81])
	(authenticated bits=0)	by relay-auth.rwth-aachen.de (8.13.8/8.13.1/1)
 with ESMTP id l8SCtLpo020195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 14:55:21 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1BB7E9B6653266617AE64A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

There is another Hitachi disk doing spurious NCQ completion -- at least
with old firmware SBDIC7JP.

Signed-off by: Peter Schwabe <schwabe@ti.rwth-aachen.de>


--- linux.vanilla-2.6.23-rc8/drivers/ata/libata-core.c	2007-09-28
14:45:58.000000000 +0200
+++ linux-2.6.23-rc8/drivers/ata/libata-core.c	2007-09-28
14:47:50.000000000 +0200
@@ -3794,6 +3794,7 @@
 	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
+	{ "HITACHI HTS541612J9SA00", "SBDIC7JP", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },


--------------enigE1BB7E9B6653266617AE64A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG/PqOKIi5kL3Gj1wRAgLBAJ9NBGJWdtqmkfKO3vSpw9oFzGn09QCfYY4r
0w4uk4hnmVYYp+hippfMQsY=
=oa9C
-----END PGP SIGNATURE-----

--------------enigE1BB7E9B6653266617AE64A6--
