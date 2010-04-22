From: Richard Mawson <richard@crow.mawsonit.co.uk>
Subject: Re: SATA driver sata_sil24
Date: Thu, 22 Apr 2010 13:17:47 +0100
Message-ID: <20100422121747.GC6018@crow.mawsonit.co.uk>
References: <20100422083226.GA6018@crow.mawsonit.co.uk> <4BD0203C.7010903@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from queue01.mail.zen.net.uk ([212.23.3.234]:53607 "EHLO
	fizeau.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab0DVMhQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 08:37:16 -0400
Received: from [212.23.3.141] (helo=smarthost02.mail.zen.net.uk)
	by fizeau.zen.co.uk with esmtp (Exim 4.63)
	(envelope-from <richard@crow.mawsonit.co.uk>)
	id 1O4vMy-0004Ab-By
	for linux-ide@vger.kernel.org; Thu, 22 Apr 2010 12:19:00 +0000
Content-Disposition: inline
In-Reply-To: <4BD0203C.7010903@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tejun,

On Thu, Apr 22, 2010 at 12:09:00PM +0200, Tejun Heo wrote:
> > I'm having difficulty with the system locking up as I load the module,
> > and I wondered whether this chip has been seen to actually work with
> > this driver? Perhaps there is a good reason for not mentioning this
> > chipset in the discription?
>=20
> Yeap, they should work.  They're just different flavors of about the
> same chip.  How does it lock up?  Which kernel version?  Does the
> kernel complain about anything?

Initially this was a problem on debian testing 2.6.26-2-xen-686 and I didn't
investigate any more than to blacklist the module. The symptom with this was
that the keyboard was unresponsive.

I've briefly tried debian unstable's 2.6.32-4-xen-686.
All I tried was manually loading the module in single user mode. This print=
ed
to the console a line including the PCI slot occupied by the card, then see=
med
to be hung. The keyboard was still responsive (ctl-c would display ^C on the
console for example, but it was stuck in kernel space at a guess so the sig=
nal
wasn't delivered?) -- I then gave up. I didn't look at dmesg as I was in si=
ngle
user mode and couldn't easily.

As you suggest that this should work, I will persist and see if I can find =
out
the problem. I wanted to avoid flogging a dead horse..

If you have any suggestions as to what the likely problem is, or things to =
look
for I am all ears.

regards,

Richard

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvQPmsACgkQEqu+mbnN8VKLGQCdFf1QDw/RKjfe499OlDqTTCby
l/AAmgI0hRJco5uLnuV6CgdriKnQzh14
=pFmD
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
