From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v4] libata: pata_samsung_cf: Add Samsung PATA controller driver
Date: Fri, 25 Jun 2010 06:18:36 +0200
Message-ID: <201006250618.37076.marek.vasut@gmail.com>
References: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com> <4C22704B.50103@pobox.com> <001f01cb1417$dce8f8d0$96baea70$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:2883 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab0FYEUv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 00:20:51 -0400
In-Reply-To: <001f01cb1417$dce8f8d0$96baea70$%kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Jeff Garzik' <jgarzik@pobox.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, 'Abhilash Kesavan' <a.kesavan@samsung.com>

Dne P=C3=A1 25. =C4=8Dervna 2010 05:38:19 Kukjin Kim napsal(a):
> Jeff Garzik wrote:
> > On 06/14/2010 03:07 AM, Kukjin Kim wrote:
> > > From: Abhilash Kesavan<a.kesavan@samsung.com>
> > >=20
> > > Adds support for the Samsung PATA controller. This driver is base=
d on
>=20
> the
>=20
> > > Libata subsystem and references the earlier patches sent for IDE
>=20
> subsystem.
>=20
> > > Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> > > Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> >=20
> > Acked-by: Jeff Garzik <jgarzik@redhat.com>
> >=20
> > Send it through the appropriate subsystem tree for this platform...
>=20
> Hi,
>=20
> You mean in my case, appropriate subsystem tree is ARM tree.
> But I think, as Ben commented, it's better drivers go to upstream via=
 the
> driver's tree.
> And of course, I read your comments about this like below...
> 'platform drivers do not build and/or work without additional platfor=
m
> glue...'
>=20
> Hmm.
> I'm not sure which way is better...

I pushed pata_pxa through Eric as well ... go for the linux-arm tree.
Cheers
>=20
> Russell,
>=20
> How do you think?
> May I send this to your patch tracking system?
> Or...how should I handle this?
>=20
> Thanks.
>=20
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
