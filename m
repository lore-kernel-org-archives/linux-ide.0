From: Simon Farnsworth <simon@farnz.org.uk>
Subject: VIA AHCI NCQ [was: Re: Recent AHCI drivers do not work with VIA VT8251 controllers (regression in 2.6.19 from 2.6.18)]
Date: Wed, 31 Jan 2007 20:34:34 +0000
Message-ID: <200701312034.36499.simon@farnz.org.uk>
References: <20070130155355.GB12475@reddwarf.farnz.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1889014.kOgU2BCKBh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.farnz.org.uk ([81.187.250.194]:43032 "EHLO
	mail.farnz.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030579AbXAaVF2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 16:05:28 -0500
Received: from lister.farnz.org.uk (lister.farnz.org.uk [IPv6:2001:8b0:104:2:204:61ff:fe42:f592])
	by mail.farnz.org.uk (Postfix) with ESMTP id 23A8539581
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 20:34:46 +0000 (GMT)
In-Reply-To: <20070130155355.GB12475@reddwarf.farnz.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--nextPart1889014.kOgU2BCKBh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 30 January 2007 15:53, Simon Farnsworth wrote:
> Hello,
>
> I've got a VIA VT8251 AHCI controller, driving two Maxtor SATA disks.
> Under Linux 2.6.18.5, it works; using 2.6.19.1, it fails to work (bug
> report at http://bugzilla.kernel.org/show_bug.cgi?id=3D7589 - note that
> pci=3Dnomsi does not fix things for me, as I still get no interrupts).
>
I've been going through 2.6.20-rc releases this evening. 2.6.20-rc7 resolve=
s=20
my AHCI fault (although not the MSI problem); it looks like Tejun Heo's fix=
=20
to ahci_thaw() in a718728f9e40ec79c0879ec6509a54fee214f5b2 fixes things for=
=20
my setup.

Of course, I'm now curious as to why NCQ is disabled on VIA AHCI controller=
s.=20
Is there a known hardware bug I should be wary of, or is it just a case of=
=20
being cautious due to the other issues with the VT8251 (in which case I'll=
=20
try enabling it and reporting back)?
=2D-=20
Thanks for the code and the fix,
Simon Farnsworth

--nextPart1889014.kOgU2BCKBh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFwP1cSWe+XpRKvi0RAn+LAJ9VA0J1EpP6o/mSfX7oQs8LdmTOhgCfd8YI
4xFjXu3v2zcQvWauKNN5rGI=
=6Hq1
-----END PGP SIGNATURE-----

--nextPart1889014.kOgU2BCKBh--
