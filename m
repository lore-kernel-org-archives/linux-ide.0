From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v11 4/8] ata: libahci: allow to use multiple PHYs
Date: Tue, 29 Jul 2014 09:14:47 +0200
Message-ID: <20140729071447.GA9410@kwain>
References: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406193450-17283-5-git-send-email-antoine.tenart@free-electrons.com>
 <53D62624.6070502@redhat.com>
 <20140728172724.GA7462@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44648 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751223AbaG2HOw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2014 03:14:52 -0400
Content-Disposition: inline
In-Reply-To: <20140728172724.GA7462@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 28, 2014 at 01:27:24PM -0400, Tejun Heo wrote:
> On Mon, Jul 28, 2014 at 12:29:56PM +0200, Hans de Goede wrote:
> ...
> > > +		if (!enabled_ports) {
> > > +			dev_warn(dev, "No port enabled\n");
> > > +			return ERR_PTR(-ENODEV);
> >=20
> > This should be:
> > 			rc =3D -ENODEV;
> > 			goto err_out;
> >=20
> > Sorry for not catching that sooner.
> >=20
> > Other then that the entire series looks good and is:
> >=20
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Antoine, can you please post an updated version of this patch?  No
> need to repost the whole series.  Also, how should the series be
> routed?

Sure, I'm doing this right away. Regarding the series, Kishon already
took patches 1-2.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
