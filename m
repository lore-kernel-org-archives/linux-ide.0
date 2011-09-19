From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] pata-generic/of: Make probing via device tree
 non-powerpc-specific
Date: Mon, 19 Sep 2011 11:23:15 +0100
Message-ID: <1316427795.3014.13.camel@hornet.cambridge.arm.com>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
	 <20110916214313.GB16381@n2100.arm.linux.org.uk>
	 <CA+wbFdc0SicHLN6=JQz-rRXqKovhr7=acUQi3esUU_qcXgCaAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41760 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755016Ab1ISK3a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Sep 2011 06:29:30 -0400
In-Reply-To: <CA+wbFdc0SicHLN6=JQz-rRXqKovhr7=acUQi3esUU_qcXgCaAw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>

> > This may not be the correct way to support the CF slot on Versatile
> > Express - it depends whether the CF slot on VE supports just CF
> > memory cards or whether it can take any CF card.
> >
> > If the latter, then what may be inserted could be a CF network card=
,
> > and that means it's probably wrong to tell the kernel that what's
> > there is a PATA interface.
>=20
> Interesting point.  I don't know whether we've tried plugging anythin=
g
> else in...
>=20
> Pawel, can you comment?

VE officially supports CF memory cards only (Arnd already referenced th=
e
spec). So in this case CF =3D=3D PATA.

Cheers!

Pawe=C5=82


