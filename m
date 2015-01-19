From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 0/4] ata: libahci: Allow using a regulator for each
 port
Date: Mon, 19 Jan 2015 16:05:26 +0100
Message-ID: <20150119150526.GB32663@lunn.ch>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <54B8C49A.9070302@redhat.com>
 <20150119145413.GJ8140@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:57899 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbbASPHr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2015 10:07:47 -0500
Content-Disposition: inline
In-Reply-To: <20150119145413.GJ8140@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

On Mon, Jan 19, 2015 at 09:54:13AM -0500, Tejun Heo wrote:
> On Fri, Jan 16, 2015 at 08:58:18AM +0100, Hans de Goede wrote:
> > Hi,
> >=20
> > On 15-01-15 15:09, Gregory CLEMENT wrote:
> > >The current implementation of the libahci allows using one PHY per
> > >port but we still have one single regulator for the whole
> > >controller. This series adds the support of multiple regulators.
> > >
> > >This is the forth version of the series.
> > >
> > >The improvement of this version is the use of
> > >ahci_platform_put_resources to put the reference to the regulators=
=2E
> > >
> > >Thanks,
> > >
> > >Gr=E9gory
> >=20
> > Thanks, patches 1 - 3 look good and are:
> >=20
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> >=20
> > Tejun, can you please queue up 1 - 3 ?
>=20
> Applied 1-3 to libata/for-3.20.

Thanks

I will add 4/4 to mvebu/dt.

  Andrew
