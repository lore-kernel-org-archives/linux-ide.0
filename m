From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v9 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 8 Jul 2014 14:36:37 +0200
Message-ID: <20140708123637.GA5330@kwain>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-2-git-send-email-antoine.tenart@free-electrons.com>
 <53BBE419.8080107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37732 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754335AbaGHMgm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2014 08:36:42 -0400
Content-Disposition: inline
In-Reply-To: <53BBE419.8080107@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 08, 2014 at 05:59:13PM +0530, Kishon Vijay Abraham I wrote:
> Hi Antoine,
>=20
> On Monday 07 July 2014 03:46 PM, Antoine T=E9nart wrote:
> > The Berlin SoC has a two SATA ports. Add a PHY driver to handle the=
m.
> >=20
> > The mode selection can let us think this PHY can be configured to f=
it
> > other purposes. But there are reasons to think the SATA mode will b=
e
> > the only one usable: the PHY registers are only accessible indirect=
ly
> > through two registers in the SATA range, the PHY seems to be integr=
ated
> > and no information tells us the contrary. For these reasons, make t=
he
> > driver a SATA PHY driver.
>=20
> Thanks for doing multiple revisions of this. Looks good to be merged =
for me now.

Great!

Thanks,
Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
