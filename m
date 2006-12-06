From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Oops in pata_pdc2027x
Date: Wed, 6 Dec 2006 17:21:14 +1100
Message-ID: <20061206172114.a1c515f8.sfr@canb.auug.org.au>
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
	<45765EC7.2000908@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:53662 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760247AbWLFGVX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Dec 2006 01:21:23 -0500
In-Reply-To: <45765EC7.2000908@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 06 Dec 2006 14:10:15 +0800 Albert Lee <albertcc@tw.ibm.com> wrote:
>
> Where could I download the patched kernel source? There are two
> POWER5 9110-51A boxes here. Maybe I could try to reproduce the problem
> on these boxes.

You can just use Linus' current tree - it exhibits the same problem (and
the powerpc tree has been merged into it).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdmFaFdBgD/zoJvwRAlrrAJ9nTsXfOmskR8L8mTwmI4mp8C65KwCgmDUe
HB9+ck7EU3PHukwX4zzUs20=
=OW9h
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Dec_2006_17_21_14_+1100_J+KINg=8AeB7wdyv--
