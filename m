From: Scott James Remnant <scott@ubuntu.com>
Subject: Re: Problem with IDE driver not claiming the disk
Date: Tue, 06 Dec 2005 12:39:30 +0000
Message-ID: <1133872770.8181.99.camel@localhost.localdomain>
References: <1133826994.8181.68.camel@localhost.localdomain>
	 <58cb370e0512051634l323e922cxabb713a96ec72cab@mail.gmail.com>
	 <1133832984.8181.87.camel@localhost.localdomain>
	 <58cb370e0512060023w3ce35e9bk316ff6eb3f7e43f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GuK+yEfKulVHjvduCu9p"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from populous.netsplit.com ([62.49.129.34]:55179 "EHLO
	mailgate.netsplit.com") by vger.kernel.org with ESMTP
	id S1751463AbVLFMji (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Dec 2005 07:39:38 -0500
In-Reply-To: <58cb370e0512060023w3ce35e9bk316ff6eb3f7e43f9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net, Ben Collins <ben.collins@ubuntu.com>


--=-GuK+yEfKulVHjvduCu9p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-12-06 at 09:23 +0100, Bartlomiej Zolnierkiewicz wrote:

> On 12/6/05, Scott James Remnant <scott@ubuntu.com> wrote:
> > I was first hoping it was a glaringly obvious thing we were doing wrong=
,
> > and wouldn't come to comparing kernel code;  the kernel is the current
> > Ubuntu one, it's based off 2.6.15 -- our patches are all in git:
> >
> > http://www.kernel.org/git/?p=3Dlinux/kernel/git/bcollins/ubuntu-2.6.git
> >
> > I'm not best placed to answer the patches that are in the exact version
> > I used ("our" 2.6.15-6.8), Ben Collins is (Cc'd).
>=20
> You have IDE patches in your tree, please try vanilla 2.6.15.
>=20
Yeah, one was compiling over night (still waiting for my AMD64 beast to
arrive) and I tried it out this morning ... I see your point, it works
exactly as advertised in vanilla 2.6.15-rc5 -- loading the real IDE
driver finds the devices itself, and there's no need to load
ide-generic.

> Changes to setup-pci.c and ide-generic.c in the following patch are wrong=
:
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/bcollins/ubuntu-2.6.git;a=
=3Dcommitdiff;h=3D149744c1475cdaf2c6babfd92f163cca8f10c540;hp=3D5a373d68631=
531fff09047364be4565d67335f08
>=20
> It seems that with this patch 'pre_init' in setup-pci.c. will
> become '0' (it equals '1' initially) only after ide-generic is loaded...
> and ide_pci_register_driver() checks 'pre_init' value.
>=20
> Sigh, this patch was NACK-ed upstream for some (important) reasons...
>=20
I'll go bludgeon our kernel guy for a bit then!

Thanks for your time,

Scott
--=20
Scott James Remnant
scott@ubuntu.com

--=-GuK+yEfKulVHjvduCu9p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDlYaCSnQiFMl4yK4RAs9lAJ49WAfQ6uOr4xWjTu6JPiH6BxJ3OwCfVXyX
fmWhqxpWRUr/55IpPTmLtUM=
=sa/n
-----END PGP SIGNATURE-----

--=-GuK+yEfKulVHjvduCu9p--

