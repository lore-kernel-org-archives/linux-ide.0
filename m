From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
Date: Sun, 16 Feb 2014 18:17:24 -0300
Message-ID: <20140216211723.GA8291@localhost>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
 <20140216143735.GA8680@localhost>
 <20140216202957.GC26583@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35462 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753396AbaBPVVk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Feb 2014 16:21:40 -0500
Content-Disposition: inline
In-Reply-To: <20140216202957.GC26583@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mikael Pettersson <mikpelinux@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Sun, Feb 16, 2014 at 09:29:57PM +0100, Andrew Lunn wrote:
> On Sun, Feb 16, 2014 at 11:45:20AM -0300, Ezequiel Garcia wrote:
> > Hi Mikael,
> >=20
> > On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
> > > My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-r=
c2
> > > boot always fails due to a kernel NULL dereference in __clk_put.
> > >=20
> > > This is a non-DT kernel, with:
> > >=20
> > > CONFIG_ARCH_KIRKWOOD=3Dy
> > > CONFIG_KIRKWOOD_LEGACY=3Dy
> > > CONFIG_MACH_TS219=3Dy
> > > # CONFIG_ARCH_KIRKWOOD_DT is not set
> > >=20
> >=20
> > Thanks for the report. I thought this issue was already fixed, but =
I
> > cannot find it on either the mailing lists or linux-next.
> >=20
> > So, in case it hasn't been fixed here's an untested fix for you to =
test.
> > Please try this patch and let us know.
> >=20
> > Your SATA won't work but if the patch is OK the kernel wont't blow =
away.
> >=20
> > Andrew? Do we support the new phy requirement in non-DT platforms?
[..]
>=20
> I consider Non-DT kirkwood now pretty much near death. Probably with
> 3.16 it will of gone altogether. So i did not plan for Non-DT to
> support SATA phy. I did however want it to at least boot, so i broke
> something here :-(
>=20

I'm pretty sure v3.14-rc{3,4} will be fine for DT and non-DT plaforms,
as Mikael already reported linux-next works. Non-DT Kirkwood would
behave just as Armada 370/XP platforms, where a SATA phy is not
registered.

> I will take a look at your fix and what we can expect in the next -rc=
=2E
>=20

AFAICS, the patch is a fix on its own, and should be merged (after we'r=
e
happy with it) for v3.14.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
