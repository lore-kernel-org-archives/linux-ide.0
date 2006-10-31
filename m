From: Tomasz Torcz <zdzichu@irc.pl>
Subject: sata_nv: hot plug or hotswap?
Date: Tue, 31 Oct 2006 15:00:08 +0100
Message-ID: <20061031140008.GA5261@irc.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nsm.pl ([195.34.211.229]:55700 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1423265AbWJaOAb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 09:00:31 -0500
Received: from matthew.ogrody.nsm.pl (unknown [10.10.174.98])
	by nsm.pl (Postfix) with SMTP id 1B152D7953
	for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 15:00:09 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: achew@nvidia.com
Cc: linux-ide@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  Hi,

 I'm pretty confused by information about nVidia SATA controller.
Specifically, Sun Microsystems sells servers with such chip and
describes it's ability as "hotplug". Linux documentation describes
controller as "hotswap".
  Sun uses "hotswap" when disk could be put in AND took out without
powering machine down (like SAS drives in SunFire x4100/4200). Term
"hotplug" is used when when disk can be put in, but NOT took out.
  So is disability to remove disk limitation of controller chip or only
deficency of Solaris driver?

  Thanks for your answer,
--=20
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFFR1bo10UJr+75NrkRAnjrAJ0UPHFk9k52Jkmft/oMypTjblLciACfc5dF
HBobE80YoohPOHHqv81oquY=
=fvT7
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
