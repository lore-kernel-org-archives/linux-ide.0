From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v4] libata: pata_samsung_cf: Add Samsung PATA controller
 driver
Date: Tue, 29 Jun 2010 20:32:13 +0900
Message-ID: <00e701cb177e$bab1e550$3015aff0$%kim@samsung.com>
References: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com>
 <4C22704B.50103@pobox.com> <001f01cb1417$dce8f8d0$96baea70$%kim@samsung.com>
 <201006250618.37076.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:25064 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab0F2LcL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2010 07:32:11 -0400
In-reply-to: <201006250618.37076.marek.vasut@gmail.com>
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Marek Vasut' <marek.vasut@gmail.com>
Cc: 'Jeff Garzik' <jgarzik@pobox.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, 'Abhilash Kesavan' <a.kesavan@samsung.com>

Marek Vasut wrote:
>=20
Hello Marek,

> Dne P=C3=A1 25. =C4=8Dervna 2010 05:38:19 Kukjin Kim napsal(a):
> > Jeff Garzik wrote:
> > > On 06/14/2010 03:07 AM, Kukjin Kim wrote:
> > > > From: Abhilash Kesavan<a.kesavan@samsung.com>
> > > >
> > > > Adds support for the Samsung PATA controller. This driver is ba=
sed on
> >
> > the
> >
> > > > Libata subsystem and references the earlier patches sent for ID=
E
> >
> > subsystem.
> >
> > > > Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> > > > Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> > >
> > > Acked-by: Jeff Garzik <jgarzik@redhat.com>
> > >
> > > Send it through the appropriate subsystem tree for this platform.=
=2E.
> >
> > Hi,
> >
> > You mean in my case, appropriate subsystem tree is ARM tree.
> > But I think, as Ben commented, it's better drivers go to upstream v=
ia the
> > driver's tree.
> > And of course, I read your comments about this like below...
> > 'platform drivers do not build and/or work without additional platf=
orm
> > glue...'
> >
> > Hmm.
> > I'm not sure which way is better...
>=20
> I pushed pata_pxa through Eric as well ... go for the linux-arm tree.

Thanks for your help ;-)

But if possible, rmk patch tracking system is better to me.
As Russell's comments, I will send to rmk with Ben's ack.

Thanks.

> Cheers
> >
> > Russell,
> >
> > How do you think?
> > May I send this to your patch tracking system?
> > Or...how should I handle this?
> >

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

