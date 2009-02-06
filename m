From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 09/15] ide: add "flagged" taskfile flags to struct
 ide_taskfile
Date: Fri, 6 Feb 2009 17:04:25 +1100
Message-ID: <20090206170425.201346e6.sfr@canb.auug.org.au>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
	<20090201175012.19144.87417.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__6_Feb_2009_17_04_25_+1100_dnkpqyns83Q/12r/"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:58758 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbZBFGEc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Feb 2009 01:04:32 -0500
In-Reply-To: <20090201175012.19144.87417.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

--Signature=_Fri__6_Feb_2009_17_04_25_+1100_dnkpqyns83Q/12r/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bart,

On Sun, 01 Feb 2009 18:50:12 +0100 Bartlomiej Zolnierkiewicz <bzolnier@gmai=
l.com> wrote:
>
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: add "flagged" taskfile flags to struct ide_taskfile
>=20
> * Add ->ftf_flags field to struct ide_taskfile
>   and convert flags for TASKFILE ioctl to use it.
>=20
> * Rename "flagged" taskfile flags:
>   - IDE_TFLAG_FLAGGED -> IDE_FTFLAG_FLAGGED

There were several places where this transformation did not take place as
shown by today's linux-next build.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__6_Feb_2009_17_04_25_+1100_dnkpqyns83Q/12r/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmL0ukACgkQjjKRsyhoI8x6PgCfZFitULk1WqOrpj3cfZ22JXcC
wBkAn0rAVkGuIg9VEtrN+9pDQ7v+4f7k
=Fs/n
-----END PGP SIGNATURE-----

--Signature=_Fri__6_Feb_2009_17_04_25_+1100_dnkpqyns83Q/12r/--
