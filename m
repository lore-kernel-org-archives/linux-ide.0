From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Date: Tue, 31 Oct 2006 13:37:27 +0100
Message-ID: <200610311337.27495.prakash@punnoor.de>
References: <15F501D1A78BD343BE8F4D8DB854566B059FE0B3@hkemmail01.nvidia.com> <15F501D1A78BD343BE8F4D8DB854566B0C42D636@hkemmail01.nvidia.com> <20061031104055.GA8898@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1295795.XoU7xPujRX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:5089 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1423137AbWJaMg4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 07:36:56 -0500
In-Reply-To: <20061031104055.GA8898@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Peer Chen <pchen@nvidia.com>, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

--nextPart1295795.XoU7xPujRX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 31 Oktober 2006 11:40 schrieb Christoph Hellwig:
> On Tue, Oct 31, 2006 at 04:43:19PM +0800, Peer Chen wrote:
> > +	u32 cb_add, temp32;
> > +	struct device *dev =3D pci_dev_to_dev(pdev);
> > +	struct ata_host_set *host_set =3D dev_get_drvdata(dev);
> > +	u8 pro=3D0;
> > +	if (!(pro&0x40))
> > +		return;
> > +
> > +	temp32 =3D csr_add;
> > +	phost->host_sgpio.pcsr =3D (void *)temp32;
> > +	phost->host_sgpio.pcb =3D phys_to_virt(cb_add);
>
> Use of phys_to_virt is generally a bug.  What are you trying to do here?

I am also wondering whether casting of temp32 to a pointer is very 64bit=20
friendly? At least my compiler on x86_64 gives a warning...

I also found=20

http://lkml.org/lkml/2006/8/21/324

which looks alike at first glance and it seems NVidia didn't really fix wha=
t=20
Andrew Morton told them to do so...

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1295795.XoU7xPujRX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFR0OHxU2n/+9+t5gRAnReAKDBA6qZKRKwi8WZO/sIPzldg8hmMgCgvtaB
ikzzUEzN83a0ourqFWFva58=
=6Ifa
-----END PGP SIGNATURE-----

--nextPart1295795.XoU7xPujRX--
