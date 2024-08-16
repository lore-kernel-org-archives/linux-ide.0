Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1F1D69E
	for <linux-ide@vger.kernel.org>; Fri, 16 Aug 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797487; cv=none; b=unVOHTbDV43rNf4K/ZSgQMr7Zg/buf7w3GBJy/ekixVJ5buJ9qBP/nte0EqMt7SDUk8DcGgQufxMlkg0NRmfHtiSyTLoobcUciwH+2rDP8wfnHqHZ6rYI8uuBv0UQ+0OFsDTVwGG6RSBLBUCBPR858TFpwpHv/oBHgVm4LRDdWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797487; c=relaxed/simple;
	bh=JnIZUSSP9N1PiBEdjQpAZAkKB6LaVkL1kLF1vqwhXI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdlE0D7IloHa/Twj7h634RWutNKANxYcxBnztehNOyjfx/Q/0UpoVrP6IY/LUKhn2p/LnZncYnz88nDA9v6wgMYaZjTKPTMIhbofUDUoSvjTsrUVf4i0CldK9DvPzBCHPPaX+puhUoc8vcPzOPNxqvOFQLkA1opA1T0vMldZw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuMdpbLA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuMdpbLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723797485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hPy+ljvcwg8eCsFrqW3cI/bGJbalTNBOH48MWMLXiA=;
	b=JuMdpbLAK5pWMP4X9l66Tu42FPNVOtvPpoTvQNWK5JkscFUEJhe6v2/7+qlNEC3zmxfyzj
	jWrlqJvoCT1Om1lSaVvPxaVeA7IPHCsj+hRWjnNbFOedJ8JAAMDy6vh+Ck3wkjbUYxrPWm
	GYcdOUI7YjzNEHGXXzQxypYM3t/bDVA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-yIwTfBWNOaO6jeQyEIUZ_w-1; Fri, 16 Aug 2024 04:38:02 -0400
X-MC-Unique: yIwTfBWNOaO6jeQyEIUZ_w-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5d5d0612dbdso331385eaf.2
        for <linux-ide@vger.kernel.org>; Fri, 16 Aug 2024 01:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723797482; x=1724402282;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hPy+ljvcwg8eCsFrqW3cI/bGJbalTNBOH48MWMLXiA=;
        b=gDzZaH/On6mxs0L49LuA9zkDzPIVJkQqBk9GnHa+/4Nu1p2gkbLbARhnt3MZO43bTG
         +HNud13NhTGLSJ2votaN/g8okzSYsdfsIGyfKgsuPxiDSYlZM6GJBhbCot4Z/5wArnoH
         mhjcWsIjXyiX3tPCnBOK0DIM78I4Sf7kDFYOBjA0PwpMxnwNt7RlYxsA23lhayuB0+hm
         amndR6HeIhiDmPQ2RtdRyY9uNTh21KusThXCkf6z+RNR9KuKrIK1KiFtARTUY5AuNGk3
         Xr9NfA4cIONtKhy+Cn3Hl1ySf5jO9mIpmco5yLcNIrtnti4jyPJItdbi1KaTvPkgX9En
         SS4w==
X-Gm-Message-State: AOJu0YwttZF20tFnmKDJRK0w1wwk9W6tkC03PCZvsGA/XCZMxzQX7pXG
	uv/keULuRmlBZZ6uxSR/7H7dJ1fXr7/K9TmNSKIvjBlqnN7R1Eu7gfsjgji3Ai3yTQwRDQX6mIq
	jgXvyJ/6+ZddIPiROlGkHHRjvXPFoBa2/WD5pXzLVQG6by+5SN1GB1ht/6w==
X-Received: by 2002:a05:6358:6384:b0:1ac:a26c:a07a with SMTP id e5c5f4694b2df-1b3964509fbmr127149055d.4.1723797481951;
        Fri, 16 Aug 2024 01:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpDb53mgYIMHYZSfcJGbvbsHrNkMIY4fub/ey6krOIiquG9r7isTihjikCrI9uLfVjd3+QGQ==
X-Received: by 2002:a05:6358:6384:b0:1ac:a26c:a07a with SMTP id e5c5f4694b2df-1b3964509fbmr127148155d.4.1723797481514;
        Fri, 16 Aug 2024 01:38:01 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff06c517sm148335785a.58.2024.08.16.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:38:01 -0700 (PDT)
Message-ID: <9c2aeec1c3f97bcebb3596b5b7c87140bc29b72e.camel@redhat.com>
Subject: Re: [PATCH] ata: Replace deprecated PCI devres functions
From: Philipp Stanner <pstanner@redhat.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>, Mikael Pettersson
 <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pstanner@redhat.com
Date: Fri, 16 Aug 2024 10:37:58 +0200
In-Reply-To: <c2d21da0-7fe1-f995-5562-7ff04e9f1b8b@omp.ru>
References: <20240812084839.37580-2-pstanner@redhat.com>
	 <c2d21da0-7fe1-f995-5562-7ff04e9f1b8b@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 20:32 +0300, Sergey Shtylyov wrote:
> On 8/12/24 11:48 AM, Philipp Stanner wrote:
>=20
> > The ata subsystem uses the PCI devres functions pcim_iomap_table()
> > and
> > pcim_request_regions(), which have been deprecated in commit
> > e354bb84a4c1
> > ("PCI: Deprecate pcim_iomap_table(),
> > pcim_iomap_regions_request_all()").
> >=20
> > These functions internally already use their successors, notably
> > pcim_request_region(), so they are quite trivial to replace.
> >=20
> > However, one thing special about ata is that it stores the iomap
> > table
> > provided by pcim_iomap_table() in struct ata_host. This can be
> > replaced
> > with a __iomem pointer table, statically allocated with size
> > PCI_STD_NUM_BARS so it can house the maximum number of PCI BARs.
> > The
> > only further modification then necessary is to explicitly fill that
> > table, whereas before it was filled implicitly by
> > pcim_request_regions().
> >=20
> > Modify the iomap table in struct ata_host.
> >=20
> > Replace all calls to pcim_request_region() with ones to
> > pcim_request_region().
>=20
> =C2=A0=C2=A0 Huh? :-)
> =C2=A0=C2=A0 Besides, I'm not seeing pcim_request_region() anywhere in th=
is
> patch...
>=20
> > Remove all calls to pcim_iomap_table().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> [...]
> > =C2=A0drivers/ata/ata_piix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+---
> > =C2=A0drivers/ata/libata-sff.c=C2=A0=C2=A0=C2=A0 | 50 +++++++++++++++++=
+++++++++++++---
> > ----
> > =C2=A0drivers/ata/pata_atp867x.c=C2=A0 | 13 ++++++----
> > =C2=A0drivers/ata/pata_hpt3x3.c=C2=A0=C2=A0 |=C2=A0 8 +++---
> > =C2=A0drivers/ata/pata_ninja32.c=C2=A0 | 10 ++++----
> > =C2=A0drivers/ata/pata_pdc2027x.c | 11 ++++----
> > =C2=A0drivers/ata/pata_sil680.c=C2=A0=C2=A0 | 11 ++++----
> > =C2=A0drivers/ata/pdc_adma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++=
+----
> > =C2=A0drivers/ata/sata_inic162x.c | 10 +++-----
> > =C2=A0drivers/ata/sata_mv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 8 +++---
> > =C2=A0drivers/ata/sata_nv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 8 +++---
> > =C2=A0drivers/ata/sata_promise.c=C2=A0 |=C2=A0 7 +++---
> > =C2=A0drivers/ata/sata_qstor.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++---
> > =C2=A0drivers/ata/sata_sil.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+---
> > =C2=A0drivers/ata/sata_sil24.c=C2=A0=C2=A0=C2=A0 | 20 ++++++++-------
> > =C2=A0drivers/ata/sata_sis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++=
+---
> > =C2=A0drivers/ata/sata_svw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++=
++---
> > =C2=A0drivers/ata/sata_sx4.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++=
+++---
> > =C2=A0drivers/ata/sata_via.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 31 +++++++=
+++++++---------
> > =C2=A0drivers/ata/sata_vsc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+---
> > =C2=A0include/linux/libata.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+++-
> > =C2=A021 files changed, 163 insertions(+), 102 deletions(-)
>=20
> =C2=A0=C2=A0 I did review all the changes, not just PATA drivers.
>=20
> [...]
> > diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> > index 250f7dae05fd..d58db8226436 100644
> > --- a/drivers/ata/libata-sff.c
> > +++ b/drivers/ata/libata-sff.c
> [...]
> > @@ -2172,8 +2173,41 @@ int ata_pci_sff_init_host(struct ata_host
> > *host)
> > =C2=A0			continue;
> > =C2=A0		}
> > =C2=A0
> > -		rc =3D pcim_iomap_regions(pdev, 0x3 << base,
> > -					dev_driver_string(gdev));
> > +		/*
> > +		 * In a first loop run, we want to get BARs 0 and
> > 1.
> > +		 * In a second run, we want BARs 2 and 3.
> > +		 */
> > +		if (i =3D=3D 0) {
> > +			io_tmp =3D pcim_iomap_region(pdev, 0,
> > drv_name);
> > +			if (IS_ERR(io_tmp)) {
> > +				rc =3D PTR_ERR(io_tmp);
> > +				goto err;
> > +			}
> > +			host->iomap[0] =3D io_tmp;
> > +
> > +			io_tmp =3D pcim_iomap_region(pdev, 1,
> > drv_name);
> > +			if (IS_ERR(io_tmp)) {
> > +				rc =3D PTR_ERR(io_tmp);
> > +				goto err;
> > +			}
> > +			host->iomap[1] =3D io_tmp;
> > +		} else {
> > +			io_tmp =3D pcim_iomap_region(pdev, 2,
> > drv_name);
> > +			if (IS_ERR(io_tmp)) {
> > +				rc =3D PTR_ERR(io_tmp);
> > +				goto err;
> > +			}
> > +			host->iomap[2] =3D io_tmp;
> > +
> > +			io_tmp =3D pcim_iomap_region(pdev, 3,
> > drv_name);
> > +			if (IS_ERR(io_tmp)) {
> > +				rc =3D PTR_ERR(io_tmp);
> > +				goto err;
> > +			}
> > +			host->iomap[3] =3D io_tmp;
> > +		}
> > +
>=20
> =C2=A0=C2=A0 Ugh... Why you couldn't keep using base (or just i * 2) and =
avoid
> such code duplication?
>=20
> [...]
> > diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> > index abe64b5f83cf..8a17df73412e 100644
> > --- a/drivers/ata/pata_sil680.c
> > +++ b/drivers/ata/pata_sil680.c
> > @@ -360,15 +360,16 @@ static int sil680_init_one(struct pci_dev
> > *pdev, const struct pci_device_id *id)
> > =C2=A0	/* Try to acquire MMIO resources and fallback to PIO if
> > =C2=A0	 * that fails
> > =C2=A0	 */
> > -	rc =3D pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR,
> > DRV_NAME);
> > -	if (rc)
> > +	mmio_base =3D pcim_iomap_region(pdev, SIL680_MMIO_BAR,
> > DRV_NAME);
> > +	if (IS_ERR(mmio_base)) {
> > +		rc =3D PTR_ERR(mmio_base);
> =C2=A0=C2=A0		goto use_ioports;
>=20
> =C2=A0=C2=A0 The code under that label ignores rc, no?

Oh, forgot to address this.

Yes, it does ignore it, but it behaves as the existing code does. The
existing version jumps into ata_pci_bmdma_init_one() if it cannot
request or ioremap the BAR.

	/* Try to acquire MMIO resources and fallback to PIO if
	 * that fails
	 */
	rc =3D pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
	if (rc)
		goto use_ioports;


Is that a bug in the existing version, too?
The comment hints to me that this is fine and intended.

Otherwise we want to remain consistent with the pre-existing behavior.


P.

>=20
> [...]
> > diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> > index a482741eb181..d115f6f66974 100644
> > --- a/drivers/ata/sata_sx4.c
> > +++ b/drivers/ata/sata_sx4.c
> > @@ -1390,6 +1390,7 @@ static int pdc_sata_init_one(struct pci_dev
> > *pdev,
> > =C2=A0	struct ata_host *host;
> > =C2=A0	struct pdc_host_priv *hpriv;
> > =C2=A0	int i, rc;
> > +	void __iomem *io_tmp;
>=20
> =C2=A0=C2=A0 I'd suggest to call it base or s/th...
>=20
> [...]
> > diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
> > index 57cbf2cef618..73b78834fa3f 100644
> > --- a/drivers/ata/sata_via.c
> > +++ b/drivers/ata/sata_via.c
> > @@ -457,6 +457,7 @@ static int vt6420_prepare_host(struct pci_dev
> > *pdev, struct ata_host **r_host)
> > =C2=A0{
> > =C2=A0	const struct ata_port_info *ppi[] =3D { &vt6420_port_info,
> > NULL };
> > =C2=A0	struct ata_host *host;
> > +	void __iomem *iomem;
>=20
> =C2=A0=C2=A0 Call it base, maybe?
>=20
> [...]
> > @@ -486,6 +488,7 @@ static int vt6421_prepare_host(struct pci_dev
> > *pdev, struct ata_host **r_host)
> > =C2=A0	const struct ata_port_info *ppi[] =3D
> > =C2=A0		{ &vt6421_sport_info, &vt6421_sport_info,
> > &vt6421_pport_info };
> > =C2=A0	struct ata_host *host;
> > +	void __iomem *iomem;
>=20
> =C2=A0=C2=A0 Here as well...
>=20
> [...]
>=20
> MBR, Sergey
>=20

