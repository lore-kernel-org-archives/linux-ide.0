From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce pata node, make
	use pata_of_platform driver
Date: Mon, 26 Nov 2007 03:34:56 +0300
Message-ID: <20071126003456.GA20130@zarina>
References: <20071123175229.GA27143@localhost.localdomain> <20071123175356.GC27338@localhost.localdomain> <200711242157.47303.arnd@arndb.de>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.mail.ru ([194.67.23.149]:22904 "EHLO mx3.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382AbXKZAlb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Nov 2007 19:41:31 -0500
Content-Disposition: inline
In-Reply-To: <200711242157.47303.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Sat, Nov 24, 2007 at 09:57:46PM +0100, Arnd Bergmann wrote:
> On Friday 23 November 2007, Anton Vorontsov wrote:
> >=20
> > +static struct of_device_id mpc834x_ids[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "pata-=
platform", },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{},
> > +};
> > +
> > +static int __init mpc834x_declare_of_platform_devices(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!machine_is(mpc834x_=
itx))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of_platform_bus_probe(NU=
LL, mpc834x_ids, NULL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
> > +device_initcall(mpc834x_declare_of_platform_devices);
>=20
> This is not really how of_platform_bus_probe was meant to be used.
> Instead of listing the device you want to probe, you should list
> all buses that potentially contain a device that you are probing.

Yup, I sort of knew it. For mpc8349emitx, pata node should be in
the localbus node. But there is no localbus node yet... I'll fix
that issue in the next round of these patches.


Much thanks,

--=20
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
