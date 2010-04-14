From: Florian Wagner <f_wagner@syscomp.de>
Subject: Enclosure services
Date: Wed, 14 Apr 2010 09:46:47 +0200
Message-ID: <20100414094647.64084a1c@auedv3.syscomp.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/g0v+T4MtQ2slVPJwsLetnK6"; protocol="application/pgp-signature"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx4.syscomp.de ([213.23.100.165]:47107 "EHLO fw1.syscomp.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750939Ab0DNHyF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Apr 2010 03:54:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by fw1.syscomp.de (8.14.3/8.14.3/Submit) with ESMTP id o3E7l7A9021314
	for <linux-ide@vger.kernel.org>; Wed, 14 Apr 2010 09:47:07 +0200
Received: from fw1.syscomp.de ([127.0.0.1])
	by localhost (aumaila.syscomp.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fuFMBXUEcM7q for <linux-ide@vger.kernel.org>;
	Wed, 14 Apr 2010 09:47:06 +0200 (CEST)
Received: from auxchangea.syscomp.de (auxchangea.syscomp.de [10.1.4.46])
	by fw1.syscomp.de (8.14.3/8.14.3/Debian-5) with ESMTP id o3E7knKZ021266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 14 Apr 2010 09:46:50 +0200
Received: from auedv3.syscomp.de (auedv3.syscomp.de [10.1.32.53])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by auxchangea.syscomp.de (Postfix) with ESMTP id ED9E8C84CD1
	for <linux-ide@vger.kernel.org>; Wed, 14 Apr 2010 09:46:51 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>

--Sig_/g0v+T4MtQ2slVPJwsLetnK6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm interested in learning about the state of enclosure services on
Linux. From what I gather from reading mailing list posts, there are
three relevant standards: SAF-TE, SES-2 and SFF-8485 SGPIO.

Also there is a enclosure Kernel module (config ENCLOSURE_SERVICES)
available: Does this module support all these standards? Do specific
SATA kernel driver need to support this module?

What user-space tools are available to access the enclosure services?

And more specifically: I do have a Supermicro Server here with a
SAS815TQ backplane. Reading its documentation it seems to support SES-2
and SGPIO (which I'm assuming is SFF-8485, but this isn't stated
explicitly). It is jumpered for SGPIO and connected to a header labeled
T-SGPIO01 on the mainboard (Supermicro H8DMR-82).

Loading the enclosure kernel modules leaves /sys/class/enclosure empty
(I'm assuming something should show up there). Is my Kernel too old
(Debian 2.6.26)? Or am I doing something else wrong? Am I expecting too
much?


Regards
Florian Wagner
--------------

Florian Wagner
Abteilung EDV
Telefon: 0821 / 4201 - 453
Fax: 0821 / 4201 - 411
E-Mail: f_wagner@syscomp.de

Syscomp Biochemische Dienstleistungen GmbH
August-Wessels-Stra=C3=9Fe 5, 86154 Augsburg
Postfach 102506, 86015 Augsburg
Telefon: 0821 / 4201 - 0
Fax: 0821 / 417992
Web: http://www.syscomp.de
E-Mail: syscomp@syscomp.de

Gesch=C3=A4ftsf=C3=BChrer:
  Dr. med. Bernd Schottdorf
  Gabriele Schottdorf

Registergericht Augsburg HRB 8670

--Sig_/g0v+T4MtQ2slVPJwsLetnK6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvFcucACgkQujTGeTwhKys6awCfeEv/oDeim5w3nkctNA+WKqyG
uZkAoLrDQb/i+QshF32ZbC+8QuDCncZz
=MzgI
-----END PGP SIGNATURE-----

--Sig_/g0v+T4MtQ2slVPJwsLetnK6--
