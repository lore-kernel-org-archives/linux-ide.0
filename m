From: Richard Mawson <richard@crow.mawsonit.co.uk>
Subject: Re: SATA driver sata_sil24
Date: Fri, 23 Apr 2010 21:34:46 +0100
Message-ID: <20100423203446.GF1883@crow.mawsonit.co.uk>
References: <20100422083226.GA6018@crow.mawsonit.co.uk> <4BD0203C.7010903@gmail.com> <20100422121747.GC6018@crow.mawsonit.co.uk> <4BD05043.10709@gmail.com> <20100422223309.GA1883@crow.mawsonit.co.uk> <4BD1129E.6030104@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smarthost02.mail.zen.net.uk ([212.23.3.141]:51366 "EHLO
	smarthost02.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755905Ab0DXAQa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2010 20:16:30 -0400
Content-Disposition: inline
In-Reply-To: <4BD1129E.6030104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2010 at 09:23:10PM -0600, Robert Hancock wrote:
> Hmm, that seems like this line in drivers/ata/sata_sil24.c:
>
>         /* Set max read request size to 4096.  This slightly increases
>          * write throughput for pci-e variants.
>          */
>         pcie_set_readrq(pdev, 4096);
>
> Can you try commenting out or deleting that line and rebuilding, and see =
=20
> if things work better? That's not really a solution, but if it worked, =
=20
> it would indicate there's something about the system configuration with =
=20
> that converter card installed that explodes when trying to set the max =
=20
> read request size. In that case can you post the output of "lspci -vv" =
=20
> and the full dmesg boot log?

Having put printk messages all over the driver, I see it currently locks up
during this readl call:

                /* Clear port RST */
                tmp =3D readl(port + PORT_CTRL_STAT);

=2E. but as this is clearly later on from the previously mentioned stack, I=
'm
starting to suspect that this is failing in random places when talking acro=
ss
this pci-pcie bridge. Do you agree that this sounds plausible?

I did attempt to get a crash dump, but failed to get any joy from using the
nmi watchdog to trigger the use of the debug kernel in this state.

I will attempt using a different machine, hopefully tomorrow, but I have no
native pcie machines so can't eliminate the pci-pcie bridge being at fault.

Thanks for your help.

--=20
Richard Mawson
Mawson IT Services

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvSBGYACgkQEqu+mbnN8VKZTgCeMu3flpdyVdp7smp8qaaJPGIp
8h8AnReBz04O1NVYqD16zLnYcnN9NNHZ
=bANg
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
