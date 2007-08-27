From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Mon, 27 Aug 2007 15:49:42 -0700
Message-ID: <20070827224942.GB5714@curie-int.orbis-terrarum.net>
References: <46D28668.3020501@sauce.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:59114 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751953AbXH0Wt0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2007 18:49:26 -0400
Content-Disposition: inline
In-Reply-To: <46D28668.3020501@sauce.co.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <richard@sauce.co.nz>, linux-ide@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2007 at 08:08:08PM +1200, Richard Scobie wrote:
>  I was just interested to see if anyone had tested a similar md RAID 5 us=
ing=20
>  these chips on Linux.
/dev/md2 is a 5-disk RAID5 on a Sonnet Fusion 500 enclosure (3726 based):
http://www.sonnettech.com/product/fusiond500p-eseries.html
Drives are 5x Seagate ST3320620AS with the 3.AAE firmware.
Controller is a PCIe x1 sata_sil24 unit.

grubbs-int / # cat /proc/mdstat=20
Personalities : [raid6] [raid5] [raid4]=20
md2 : active raid5 sdf1[0] sdj1[4] sdi1[3] sdh1[2] sdg1[1]
      1250274304 blocks level 5, 64k chunk, algorithm 2 [5/5] [UUUUU]
      bitmap: 0/150 pages [0KB], 1024KB chunk

unused devices: <none>
grubbs-int / # hdparm -tT /dev/md2

/dev/md2:
 Timing cached reads:   2334 MB in  2.00 seconds =3D 1167.20 MB/sec
 Timing buffered disk reads:  350 MB in  3.01 seconds =3D 116.32 MB/sec

It should exceed that speed - if I run hdparm -tT on 3 or more separate dri=
ves
in the array at the same time, their combined speed does not exceed 120Mb/s=
ec
(a single drive manages 71Mb/sec) - The system does claim it negated at 3Gb=
it,
so I've wondering about a firmware bug in the sil24 or sil3726.

Other than that, I can recommend the Sonnet unit for it's nice engineering,
incl. a hotswap fan at the back - just perhaps a overpriced.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFG01UGPpIsIjIzwiwRAr6fAKDNmyT8XoycYolE7RBBzcOARxVcfQCg6223
Qkk31lr9ka5eaSWEDijsIW0=
=qAF0
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
