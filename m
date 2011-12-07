From: Ben Whitten <benwhitten@gmail.com>
Subject: Re: DMA bug with ata_piix on ICH7-M
Date: Wed, 07 Dec 2011 10:57:27 +0000
Message-ID: <1323255447.2972.7.camel@Sparkler>
References: <1323176998.2687.35.camel@Sparkler> <4EDED921.6030207@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-VWHcPz4uhPvc8ka5C4LB"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34825 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab1LGK5b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2011 05:57:31 -0500
Received: by eaak14 with SMTP id k14so327724eaa.19
        for <linux-ide@vger.kernel.org>; Wed, 07 Dec 2011 02:57:30 -0800 (PST)
In-Reply-To: <4EDED921.6030207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org


--=-VWHcPz4uhPvc8ka5C4LB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-12-06 at 21:10 -0600, Robert Hancock wrote:
> On 12/06/2011 07:09 AM, Ben Whitten wrote:
> > Hi,
> > I seem to have found a problem with DMA on a motherboard using an ICH7-=
M
> > chipset, this bug prevents me from installing to the harddrive and I
> > have been unable to find a workaround.
> > The motherboard is a Unicorn computers ENDAT-2794A motherboard[1]
> > When I try to run the Ubuntu 11.10 USB install image which is using
> > kernel 3.0 the system jams for a good few minutes at a stage in boot
> > then eventually comes up. In the dmesg I see the following;
> >
> > [  332.656551] ata1.01: configured for UDMA/33
> > [  332.656590] ata1: EH complete
> > [  332.716560] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x=
6
> > frozen
> > [  332.716776] ata1.01: BMDMA stat 0x44
> > [  332.716887] ata1.01: failed command: READ DMA
> > [  332.717029] ata1.01: cmd c8/00:08:78:03:00/00:00:00:00:00/f0 tag 0
> > dma 4096 in
> > [  332.717034]          res 50/00:00:7f:03:00/00:00:12:00:00/f0 Emask
> > 0x2 (HSM violation)
> > [  332.717435] ata1.01: status: { DRDY }
> > [  332.717564] ata1: soft resetting link
> > [  332.900593] ata1.01: configured for UDMA/33
> > [  332.900631] ata1: EH complete
> > [  332.949133] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x=
6
> > frozen
> > [  332.949344] ata1.01: BMDMA stat 0x44
> > [  332.949454] ata1.01: failed command: READ DMA
> > [  332.949593] ata1.01: cmd c8/00:08:90:03:00/00:00:00:00:00/f0 tag 0
> > dma 4096 in
> > [  332.949598]          res 50/00:00:97:03:00/00:00:12:00:00/f0 Emask
> > 0x2 (HSM violation)
> > [  332.950006] ata1.01: status: { DRDY }
> > [  332.950130] ata1: soft resetting link
> >
> > Prior to this it gets configured for UDMA/133 which I believe is out of
> > spec for the ICH7 following information on a previous fixed bug[2]. It
> > eventually backs it down to 33, which is probably where the system
> > unlocks and can continue to boot.
>=20
> That speed limitation only applies to PATA ports. The UDMA speed=20
> selection doesn't really do much or anything with SATA devices. It=20
> doesn't look like it has any effect on this issue since from the dmesg=
=20
> on the Launchpad report, the problems continue after we speed down to=20
> UDMA33.

Ahh ok, I saw an option in the BIOS regarding UDMA and got mixed up,
thanks for clearing that up.

> >
> > I have also tried this with a development snapshot of Ubuntu 12.04 usin=
g
> > kernel 3.2 with the same result.
> > I have attached a screen shot of the IDE BIOS options in case a default
> > is wrong or there is a workaround until the bug is fixed. Further syste=
m
> > information and logs can be found on the generated ubuntu launchpad bug
> > report [3].
>=20
> Is this hardware setup known to be working? Is there a previous kernel=
=20
> or other OS that worked?
>=20
I have verified that the motherboard works with windows XP, I have also
been in contact with Unicorn who state this example list works. However,
I have not verified them.

NAME KERNEL
Debian 4.0 2.6.18-6-686
FreeBSD 6.4
FreeBSD 7.1
Fedora Core 8 2.6.23.1-42.fc8
Fedora Core 9 2.6.25-14.fc9.i686
OpenSUSE 10.3 2.6.22.5-31-default
OpenSUSE 11.0
Arch Linux 0.72
Mandrake 10.0
Ubuntu 8.04 2.6.24-16-genernic

--=-VWHcPz4uhPvc8ka5C4LB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJO30aQAAoJEEWVEtw/oNCgSGMIAKPFS8Rzo2O5+YN1QKRqvmUF
p+bd7oyQc0O90BVqpqE6REmSoMshpSzv0CkU4rBeIFKlW04LstjIz6RrOOanTt2/
hpQH5SiBRLtxm46K2INcd+CZWQppbsVANJr5a34wMP1cyiAzxMY6Hgr8p7TZOaoR
iudyZd9PrSlRvsLIe3HFN7SXdG8ojrmkWlUryF8o7zSBFbZvNwx+UguLBYCwtxwQ
r/+Wq2HKcUVcv8ey7degtGhe68/mx9OY4E1aAw1M9+DtVdszs7R7387jY9G6i6Wu
Mm49e82UdiZq7j50gmwHfShR8pAxWxl240KWWhlTdV5NqgYPezlKqbTI3hCLlYk=
=iMeE
-----END PGP SIGNATURE-----

--=-VWHcPz4uhPvc8ka5C4LB--

