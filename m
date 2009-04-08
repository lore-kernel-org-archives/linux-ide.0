From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Thu, 09 Apr 2009 09:53:13 +1000
Message-ID: <1239234793.6214.5.camel@localhost>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	 <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
	 <1239156559.10104.7.camel@localhost>
	 <ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
	 <49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com>
	 <49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
	 <49DD17C3.7040607@kernel.org>
	 <ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-7giAax17ruEw6v62IPlA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.10.76.25]:33824 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952AbZDHXxP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 19:53:15 -0400
In-Reply-To: <ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>


--=-7giAax17ruEw6v62IPlA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-08 at 17:15 -0500, Timur Tabi wrote:
> On Wed, Apr 8, 2009 at 4:31 PM, Tejun Heo <tj@kernel.org> wrote:
> > Hmmm... for now,
> > I think it would be best to revert the original change.  Jeff, can you
> > please do that?
>=20
> Actually, give me a few days before you do that.  A colleague gave me
> some suggestions to debug this.

What device did you say it was? A "ULI M1575" ?

Is that this one?

DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, hpcd_quirk_uli1575);    =
                                             =20

static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)              =
                                                 =20
{
        u32 temp32;

        if (!machine_is(mpc86xx_hpcd))
                return;

        /* Disable INTx */
        pci_read_config_dword(dev, 0x48, &temp32);
        pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
..


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-7giAax17ruEw6v62IPlA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkndOOkACgkQdSjSd0sB4dL/WwCbBHwjGifGBSsCWuJQzbgiz1vh
edMAoI+rCPUZylkCxqa00WYz2c6efmrK
=b3u/
-----END PGP SIGNATURE-----

--=-7giAax17ruEw6v62IPlA--

