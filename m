From: Igor Serebryany <igor47@moomers.org>
Subject: disappearing block devices using EFI Partitioning
Date: Wed, 14 Oct 2009 06:24:18 -0500
Message-ID: <20091014112418.GJ25852@moomers.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9Iby/IdMV6Sk7aK"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moomers.org ([64.251.27.79]:43795 "EHLO moomers.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbZJNLct (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Oct 2009 07:32:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--s9Iby/IdMV6Sk7aK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

	I'm not sure if this is the right place to send this, but I'm
	not sure where else to send it...

	I've been having a problem where sometimes, creating a new partition
	(parted mkpart) using GPT disk label causes the block device for the
	previously created partition to disappear.

	Here is an example: http://pastebin.com/f3acd536
	You can see on line 15 that after the previous parted command,
	/dev/sda3 which existed on line 12 is gone. There are no messages in
	dmesg and the partition itself is still on the disk.=20

	I am working on an automated partitioning too, and so I have seen
	this happen with a variety of partition layouts, disks and servers
	(although in slightly different ways each time). I have tried
	putting space between partitions, time between partition commands
	and other methods to no avail. A few hints on where to even begin
	debugging this would be great!

Thanks!
--Igor

--s9Iby/IdMV6Sk7aK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFK1bTiVyVcp2k8D/kRAk9CAJ0Tm2BdpHuYZwHLiODaA/COrCKbggCg1u6s
sv5tF7QfCsl3x+02/d15ADs=
=6FBl
-----END PGP SIGNATURE-----

--s9Iby/IdMV6Sk7aK--
