From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH libata/for-3.11-fixes] libata: make it clear that
 sata_inic162x is experimental
Date: Fri, 26 Jul 2013 05:57:20 +0100
Message-ID: <1374814640.13555.1.camel@deadeye.wl.decadent.org.uk>
References: <20130627160606.3447.9939.reportbug@storm.xmen.local>
	 <20130627165114.GK4752@decadent.org.uk> <1372353297.24346.4.camel@phoenix>
	 <20130627173142.GM4752@decadent.org.uk> <1372375714.330.17.camel@phoenix>
	 <1372383087.23847.35.camel@deadeye.wl.decadent.org.uk>
	 <1372427725.23094.17.camel@phoenix>
	 <1372603764.5155.17.camel@deadeye.wl.decadent.org.uk>
	 <20130701061726.GA10717@mtj.dyndns.org> <1372668742.17064.23.camel@phoenix>
	 <20130722211307.GA16776@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-G0ZHm6uVNJ4YbQ5pYOjy"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52152 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751045Ab3GZE5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jul 2013 00:57:32 -0400
In-Reply-To: <20130722211307.GA16776@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Martin Braure de Calignon <braurede@free.fr>, 714295@bugs.debian.org, linux-ide@vger.kernel.org, risc4all@yahoo.com


--=-G0ZHm6uVNJ4YbQ5pYOjy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2013-07-22 at 17:13 -0400, Tejun Heo wrote:
> Hello, guys.
>=20
> I've committed the following patch to for-3.11-fixes.  It's
> unfortunate but I can't see a good way out at this point.  :(
[...]

This change is also appropriate for a stable update.

I will also remove the driver from Debian packages.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-G0ZHm6uVNJ4YbQ5pYOjy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUfIBsOe/yOyVhhEJAQry7Q//QU5TdNBauEFAJt68Tx3yuhp5Tjc941Bx
fQH+/cD7U2dhWQdAxXDAMfjqChV1DGF4BMS1p/9cN0viSzI8O5nNQbV4lWHi48AM
3yuIU2eHAzeecXSLDDA2802nHs62g1POQ1x+SPaZ4/5HD80OzGne7m8CP0xoM+2Y
Kmwxv47m4u7uy4RIM8ndzHNnjc3FsrKH7eGsethkYErKpwH7Ze9rXkej+zqKnH19
fuLmIEKvkbGXkHeux+tiXFk8aANT6NfS82LZ4J2CvToQ4/pmFWcziiq60ZOeiL/E
3PJRbsop4apCpfnZ1p6QukL31NA314wdJw88dnXhJKYW5CD1CKB/DU0SPlyE9Glp
/GKViwdFSvzcFSbnWoltH4HTfQEF2+3eZniFpKwzE8axEl0MmfZKWSWg59WxtJmo
i2jVPTCHtmQeslSAlsqqVGiqwmd/dGIB3QLMjf0u/vLTGW3VkhgEPmRiQadOCCuj
epD9tRaIO8p4NSTEP5jHz2EZeoInBdLKEznU0XbLu8mGFsXPuGHyCjZKzqUqmiGk
7NB0NpinhjRakxKSEPbtF3I/OmQC5QS8wB1JHPnSVoaI3KulymrxmGlEyovlMkjF
ROY7MfB3ouaDv+XBuhC3bunQhOXhBY36XaqlLIb9iTjrgDYnsd40N+gXM97gS9DT
13SivZVSWAc=
=ijHF
-----END PGP SIGNATURE-----

--=-G0ZHm6uVNJ4YbQ5pYOjy--
