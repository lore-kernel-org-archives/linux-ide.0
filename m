From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: SIL24: pcie_set_readrq 4096
Date: Fri, 23 Jul 2010 07:30:08 +0200
Message-ID: <201007230730.16935.eike-kernel@sf-tec.de>
References: <AANLkTinMJktVl28m-mL8i9N8_Q9V471LV3XsxsZlLIp7@mail.gmail.com> <4C48452D.5070207@kernel.org> <AANLkTiltS3zLLSBgv_VNEXpQvEez2PpObhjmbcZxJ2c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1390805.6SlFWEIya1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <AANLkTiltS3zLLSBgv_VNEXpQvEez2PpObhjmbcZxJ2c8@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

--nextPart1390805.6SlFWEIya1
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Jassi Brar wrote:
> On Thu, Jul 22, 2010 at 10:18 PM, Tejun Heo <tj@kernel.org> wrote:
> > It's been a while since I read pci-e spec but IIUC readrq size and
> > payload size are independent and if readrq is larger than payload size
> > it's supposed to complete in multiple steps.  I could be wrong tho.
>=20
> AFAIUI readrq size is independent and not greater than the max_payload
> size. Payload size is what max a device can handle and readrq is what a
> device can ask.

The first and third statements are correct, the second is not. Read request=
 may=20
be larger than the usual payload size.

However that is something the complete PCIe fabric up to that device has to=
=20
support. So if the root port does only support read request of something=20
smaller the device must be configured with that maximum size so it will not=
=20
issue any bigger requests. Blindly configuring a device to the maximum allo=
wed=20
value looks dangerous and broken to me.

Eike

--nextPart1390805.6SlFWEIya1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkxJKOgACgkQXKSJPmm5/E7wsgCdEZ0AamXoXiJ8fMTeBSEom5ul
KJgAn32Ikd11NIad6aF8ZwQOvcjVEW6m
=7KVk
-----END PGP SIGNATURE-----

--nextPart1390805.6SlFWEIya1--
