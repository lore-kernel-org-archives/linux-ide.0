Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606323;
	b=iamsJCDaTmb5+khAaQo40o4R2H3oDJ4UTUSii7UzqRgqcsH5wjYFusIx64GzOWwM98OV
	 9oK88VtPY05vAh/tvuFVsbMoLH0DFkDgi17fLHDdKPkoFeleUsjtdDBTx+eSII8cA7TSp
	 jPbzvUxKNPqXI2iGD9SLxacuWhjajWzqrb9QjdkA6pbdJkWN4/0gIqxrqkNTU9j3jO+QJ
	 3KR66hNY6hVt/IEkE+5+6qVVDtX8BwsLPd+Wllerx4WPPHh5PHK0JFJ2opt8CmSkUhKQ9
	 TvztNRLDX63eqxdaHL42mPFWxpUTWiP7Ho9ifkroDJ0qT5Qn/xdxVZhxSuag5rBTBWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606323;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=+TbJY6n57LgNUxMots103uQ9dat6DVlFqW38S0+rh00=;
	b=AwlT6D2tHNZoFlcqb5Oik18fz/qGD09YrwCRT613/MZoZFp2PwwFxxp6uijzxxsI6gAV
	 9amXsAKJx+nkxzpgX5aL6hXLCzleLoWmQtGrgcO8yhAn2JJI3xTyDTwlOUD0hLMd3ZTYr
	 ZpHC1mHPXh7dxgtKJMkpNOk6CMFgVxh3uverfjJBQZfgau30b/EyzhP+S4UJnxCjLCQud
	 oQ4G0YvgkM3y/6TjXToep3tqQe856AbQQ2+kW8FF6vclElF+aVNpEPtu+IOW1d8VV2b3W
	 psozs3e7oCWl2o4O0EF+O2PvzRqXXI5x3U0SiebjThFzHRGMvgyD4xANS9c58TfP4aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b="p/3CsATK";
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2BE606A31A;
	Wed, 21 Oct 2026 18:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D2BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=p/3CsATK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=+TbJY6n57LgNUxMots103uQ9dat6DVlFqW38S0+rh00=; t=1792606321;
	x=1793211121; b=p/3CsATKIRa6bsnmF+gIml9CI3r39zQe0JseAaQ5lEAW1GLEitBd1UTRkFstP
	U2vi27b7NZJ3ZcyXsc7q39xakbOUkm1FSqfBgOVLqFpdmGzqTSr6zc5zP3tIp1YmBgZUsz/DTP3Yk
	1Uu2+aXCTMCaNkyfvNI5Umf6kbIOXg/x1J4XP7I3FqA6no3JFM/NL2tb331hCtu9zc7FLxANR0HcG
	rzQ/EEHItkR26rUsZxqlFcaeVrp6yQ/rcDeHSMyzWFgjOQMV/oHrsz/c5pnOh6Zh6Fh4/lN52aUmn
	cPZJJf4WgQLMvSdOOLTWADt6LjNNfSlacKZgqtaJ6ufiPzMLwQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xJan7-000000019DS-2hcs; Wed, 21 Oct 2026 20:11:57 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xJan7-00000000x1o-1JeM; Wed, 21 Oct 2026 20:11:57 +0200
Message-ID: <f5dc8ecb3f7ed091a4deb6447bd9e7c2c801b847.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Daniel Palmer <daniel@0x0f.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-sh@vger.kernel.org, 	linux-ide@vger.kernel.org
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 20:11:56 +0200
In-Reply-To: <20261017041419.311921-2-daniel@0x0f.com>
References: <20261017041419.311921-1-daniel@0x0f.com>
	 <20261017041419.311921-2-daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Daniel,

On Sat, 2026-10-17 at 13:14 +0900, Daniel Palmer wrote:
> artop_init_one() probes the 6280's "fast" bit with inb() on the raw
> start address of BAR 4.  That address is a PCI I/O address, which is
> only a usable port number on platforms whose I/O port base maps PCI I/O
> space one to one.  On an SH7751 LANDISK (identity io_port_base, PCI I/O
> window at 0xfe240000) the resource starts at 0x1400 and inb(0x1400)
> dereferences that address:
>=20
>   BUG: unable to handle kernel paging request at 00001400
>   PC is at artop_init_one+0x10e/0x170
>=20
> Map the BAR with pci_iomap() and use ioread8(), as libata-sff does for
> the BMDMA registers later on.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  drivers/ata/pata_artop.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 9f8d41639a62..351ff4c8e48e 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -405,13 +405,21 @@ static int artop_init_one (struct pci_dev *pdev, co=
nst struct pci_device_id *id)
>  	case 1:		/* 6260 */
>  		ppi[0] =3D &info_626x;
>  		break;
> -	case 2:		/* 6280 or 6280 + fast */
> -		if (inb(pci_resource_start(pdev, 4)) & 0x10)
> +	case 2: {	/* 6280 or 6280 + fast */
> +		void __iomem *bmdma =3D pci_iomap(pdev, 4, 1);
> +		u8 cfg;
> +
> +		if (!bmdma)
> +			return -ENOMEM;
> +		cfg =3D ioread8(bmdma);
> +		pci_iounmap(pdev, bmdma);
> +		if (cfg & 0x10)
>  			ppi[0] =3D &info_628x_fast;
>  		else
>  			ppi[0] =3D &info_628x;
>  		break;
>  	}
> +	}
> =20
>  	BUG_ON(ppi[0] =3D=3D NULL);
> =20

Since neither of the two maintainers of this driver has responded yet, I ca=
n't
take this patch through my tree. Either Damien or Niklas should ack this ch=
ange
(according to ./scripts/get_maintainer.pl drivers/ata/pata_artop.c).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
