From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
Date: Wed, 23 Apr 2014 10:24:09 +0200
Message-ID: <20140423082409.GC24355@kwain>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <CAL_JsqKE_Z3kBhS1VaQADV5ob8x6AKHhbHaQEGoVSwkwdd50zA@mail.gmail.com>
 <CAL_JsqJwC2xcZakXiJXJscK7tN7xt2OotBKyr9u+aK3bOP+7GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55135 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755203AbaDWIYM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2014 04:24:12 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqJwC2xcZakXiJXJscK7tN7xt2OotBKyr9u+aK3bOP+7GQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tejun Heo <tj@kernel.org>, zmxu@marvell.com, Jisheng Zhang <jszhang@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Rob,

On Tue, Apr 22, 2014 at 01:54:33PM -0500, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 1:47 PM, Rob Herring <robherring2@gmail.com> =
wrote:
> > On Tue, Apr 22, 2014 at 10:38 AM, Antoine T=E9nart
> > <antoine.tenart@free-electrons.com> wrote:
> >> Add support for the Berlin SoCs AHCI SATA controller allowing to
> >> interface with devices like external hard drives.
>=20
> One more thing.
>=20
> >> +       nports =3D readl(hpriv->mmio + HOST_PORTS_IMPL);
> >> +
> >> +       /* force_map is modified only if the property is found */
> >> +       of_property_read_u32(np, "marvell,force-port-map", &force_=
map);
>=20
> This property does not appear to be documented.

I'll update it regarding Sebastian comments, or maybe drop it if it is
possible to enable each port individually.

>=20
> >> +       if (force_map)
> >> +               nports =3D force_map;
>=20
> You don't need this as your comment says, you can just do:
>=20
> of_property_read_u32(np, "marvell,force-port-map", &nports);
>=20
> nports will only be changed if property is present.

Sure.

Thanks!

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
