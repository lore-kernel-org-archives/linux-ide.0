From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 20 May 2014 16:40:03 +0200
Message-ID: <20140520144003.GD21579@kwain>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <1821771.zFvTDGF2Ae@amdc1032>
 <20140520134942.GC9873@lunn.ch>
 <20140520140325.GA21579@kwain>
 <20140520140631.GF9873@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:32839 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753580AbaETOkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2014 10:40:08 -0400
Content-Disposition: inline
In-Reply-To: <20140520140631.GF9873@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, tj@kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.hesselbarth@gmail.com

On Tue, May 20, 2014 at 04:06:31PM +0200, Andrew Lunn wrote:
> > > > > +config PHY_BERLIN_SATA
> > > > > +	bool
> > > >=20
> > > > Is there any real reason why this cannot be tristate?
> > >=20
> > > What we have seen with SATA drivers and phys, is there is link ti=
me
> > > breakage if the SATA driver is built in and the phy is modular.
> > >=20
> > > Maybe this has been fixed now?=20
> >=20
> > Using tristate shouldn't be a problem. I compiled without the PHY
> > driver, no link issue.
>=20
> The problem i think was when the PHY core and driver was a module and
> SATA built in. Please give that configuration a go.

I tested, it went fine.

This was actually fixed by:
b51fbf9fb0c3 phy-core: Don't allow building phy-core as a module

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
