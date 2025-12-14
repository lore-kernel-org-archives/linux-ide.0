Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C92C21EB
	for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765757807; cv=none; b=QUR/1UjkMZX7hAt57cJtJz8yCegJPlF7eCJXOkcNhBoe21GKsjJoNEb9VNWMjE1DHzTqlFimQGD2OnjImmuaYIwAay4tsP4t1e6p9C86msPDvipMkBT6T7n1c80Xal4nRCixpTBpbvfQ9UzjCSSfiHTVlta5KJtoSkQYg7QSjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765757807; c=relaxed/simple;
	bh=Kn/8VMkZU4QMAiDLg0Bn84JWokrtpPcHiCgUpUr/f8g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ccrky/h1U5eVUbMdATLCnkFzkz5g1TD3tu9Pq0LCFKsEfjpPIDDGeMqhp8hiuUC+oYp3MOAF4PaFyXRKT+SrcXjnARvh0p+UZAEQgny4V6Tc6kWPnNdRIuLrcTkADajHbsuRxn3weS7DJyxJvbZs0+/DJp97zineJ0j2E0tHtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=sV0WONUy; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="sV0WONUy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rwCht4MAur0teX3uZE9XFmvTGqmbyZhHHCWk8Ao+ThY=; b=sV0WONUyE9XI/Mjsn9Zxe8beDs
	IyGYNGm2ADDbKXKvcnwAjal9kIvUN1wLZPtOmNIk4G6YDDX6u14gjYNWQE4cB10kOfhnCSmgeZ2rs
	hX8EJdwKrU4IMzlJnxIgCOpkly5dkeawx7WlR741tKCPM83fuMkhwVv/xhK+/70v0WvgowygEH8jZ
	IFTSqhHfjjKSbeJJwRLxuqyPLxVaC6ZNzyTBI/iVD7e5O+WbEbO9PmxtOlsOUp9nxqREDPunxT1Hx
	t6mYvvenaCwnEZ2CUmjDB1X/KsNbGdYdFRv7bo9CzROG3G4VVkMjHUx22gMCeUzcsYrwUFEyNTga3
	P9i6M9Sg==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH V2] ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI
 Adapter
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <robbat2-20251214T225827-228528801Z@orbis-terrarum.net>
Date: Mon, 15 Dec 2025 00:50:52 +0100
Cc: Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2732856D-2D16-41F9-82AB-16B60AA56308@exactco.de>
References: <20251118.174654.1384716262322584447.rene@exactco.de>
 <aRzSMYp-i4RDYl-l@ryzen> <87550962-6A64-4F07-AD72-001D85824B83@exactco.de>
 <aRzdh6Q8xuu6OL7G@ryzen>
 <robbat2-20251214T225827-228528801Z@orbis-terrarum.net>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

On 14. Dec 2025, at 23:59, Robin H. Johnson <robbat2@gentoo.org> wrote:
>=20
> On Tue, Nov 18, 2025 at 09:56:39PM +0100, Niklas Cassel wrote:
>>>>> + PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888d7b73),
>>>> Don't we want Iomega somewhere in the name here?
>>> IIRC this string came out of some pcmcia tool. I thought it came out =
of the device.
>>> Is it not used for matching or should match what comes out of the =
device IDENTIFY
>>> or so command?
>>=20
>> Looking at drivers/pcmcia/ds.c, you are right,
>> the string is used for matching.
>>=20
>> So we are stuck with this quite generic name :)
> Generic name for the matching - but what about adding a comment that
> describes where the ID & String come from as "Iomega Clik!"?

Well the other entries also don=E2=80=99t have comments and in case of =
there is
git blame anyway.

	Ren=C3=A9

> --=20
> Robin Hugh Johnson (they/he)
> Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe

