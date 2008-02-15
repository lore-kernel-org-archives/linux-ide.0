From: Hugo Mills <hugo@carfax.org.uk>
Subject: Re: Spurious completions during NCQ
Date: Fri, 15 Feb 2008 15:04:50 +0000
Message-ID: <20080215150449.GC27745@vlad.carfax.org.uk>
References: <20080215134658.GB27745@vlad.carfax.org.uk> <1203087600.25150.5.camel@zem>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from frost.carfax.org.uk ([212.13.194.111]:1130 "EHLO
	frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbYBOP3a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 10:29:30 -0500
Content-Disposition: inline
In-Reply-To: <1203087600.25150.5.camel@zem>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Calvin Walton <calvin.walton@gmail.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2008 at 10:00:00AM -0500, Calvin Walton wrote:
> On Fri, 2008-02-15 at 13:46 +0000, Hugo Mills wrote:
> > I'm getting these on my Dell Latitude D830:
> > 
> > Feb 15 13:06:00 willow kernel: ata1.00: exception Emask 0x2 SAct 0x4 SErr 0x0 action 0x2 frozen
> > Feb 15 13:06:00 willow kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x4 FIS=004040a1:00000002
> 
> >    In some cases, there are several cmd/res lines listed. It's
> > happening about once an hour or so (not correlated with any other
> > event that I can see). It doesn't seem to be affecting operation of
> > the machine, but it's making me nervous.
> > 
> >    Can anyone set my mind at rest? (Or suggest a fix?)
> 
> You didn't mention which SATA chipset your laptop has, but some quick
> googling says that it's AHCI. Until 2.6.24, the AHCI driver has a
> problem where it'll report superious NCQ completions due to a bug in the
> driver logic.
> 
> > uname -a reports:
> > Linux willow 2.6.23.1-hrt3 #1 SMP Sun Nov 4 14:51:20 GMT 2007 x86_64 GNU/Linux
> 
> The fix is simple, upgrade your kernel to 2.6.24 :)

   Excellent. Thank you for clearing this up for me. I'll head off and
do the upgrade now.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 515C238D from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
    --- All mushrooms are edible,  but some are only edible once. ---    

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHtaoRIKyzvlFcI40RAld/AJ9ciHYEcPF1Kr6spz4UMMgkXsEa9gCeJuGp
9VkYC7UwdoZC08b9YAHQWvo=
=zh1y
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
