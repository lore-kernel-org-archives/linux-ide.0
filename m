From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: SiI 3114 and sata_sil
Date: Thu, 15 Feb 2007 17:11:17 -0800
Message-ID: <20070216011117.GA10679@curie-int.orbis-terrarum.net>
References: <45D4A705.4050407@andrei.myip.org> <45D4A98A.7070705@pobox.com> <45D4AB9C.9050808@andrei.myip.org> <45D4B43E.2040807@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:60557 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751829AbXBPBLU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Feb 2007 20:11:20 -0500
Content-Disposition: inline
In-Reply-To: <45D4B43E.2040807@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Florin Andrei <florin@andrei.myip.org>, linux-ide@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2007 at 02:27:58PM -0500, Jeff Garzik wrote:
> >So that means that the FC5 system is not actually on RAID? Even though=
=20
> >it seems so? (using /dev/dm-* for filesystem volumes)
> >
> ># lspci | grep -i sata
> >03:05.0 RAID bus controller: Silicon Image, Inc. SiI 3114=20
> >[SATALink/SATARaid] Serial ATA Controller (rev 02)
> ># df -m
> >Filesystem           1M-blocks      Used Available Use% Mounted on
> >/dev/dm-6               125931      2999    116432   3% /
> >/dev/dm-1                   99        13        81  14% /boot
> >tmpfs                     1012         0      1012   0% /dev/shm
> >/dev/dm-2                 9917       151      9254   2% /tmp
> >/dev/dm-3                 9917       237      9168   3% /var
> ># lsmod | grep ata
> >sata_sil               13897  2
> >libata                 58321  1 sata_sil
> >scsi_mod              129641  3 sg,libata,sd_mod
> ># cat /etc/modprobe.conf | tail -n 1
> >alias scsi_hostadapter sata_sil
> >
> >So in fact /dev/dm-* are just on one disk each (not RAID1), or what is=
=20
> >going on here?
> The's dmraid providing /software/ RAID as noted in=20
> http://linux-ata.org/faq-sata-raid.html#dmraid
No, that's not a correct assertion. We can only say that device-mapper
is being used somehow. It could be LVM, EVMS2, dmraid, or a few other
things.

Use dmsetup (info,ls,status,targets) as well as the sysfs block slave
entries on dm-* to figure it out from scratch. (or at a higher level,
try the LVM tools etc).

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFF1QS1PpIsIjIzwiwRAnZpAJ0eo56kXr//HkoLMxckRIRDAxlGzACeOR4y
+dJcyiyMeiyFL0P5VpstjDM=
=o9Ct
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
