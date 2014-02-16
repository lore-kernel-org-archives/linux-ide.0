From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
Date: Sun, 16 Feb 2014 12:28:02 -0300
Message-ID: <20140216152802.GA3637@localhost>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
 <20140216143735.GA8680@localhost>
 <21248.54474.414445.790516@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34883 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752540AbaBPPaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Feb 2014 10:30:05 -0500
Content-Disposition: inline
In-Reply-To: <21248.54474.414445.790516@gargle.gargle.HOWL>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org

On Sun, Feb 16, 2014 at 04:10:02PM +0100, Mikael Pettersson wrote:
> Ezequiel Garcia writes:
>  > Hi Mikael,
>  >=20
>  > On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
>  > > My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-=
rc2
>  > > boot always fails due to a kernel NULL dereference in __clk_put.
>  > >=20
>  > > This is a non-DT kernel, with:
>  > >=20
>  > > CONFIG_ARCH_KIRKWOOD=3Dy
>  > > CONFIG_KIRKWOOD_LEGACY=3Dy
>  > > CONFIG_MACH_TS219=3Dy
>  > > # CONFIG_ARCH_KIRKWOOD_DT is not set
>  > >=20
>  >=20
>  > Thanks for the report. I thought this issue was already fixed, but=
 I
>  > cannot find it on either the mailing lists or linux-next.
>  >=20
>  > So, in case it hasn't been fixed here's an untested fix for you to=
 test.
>  > Please try this patch and let us know.
>  >=20
>  > Your SATA won't work but if the patch is OK the kernel wont't blow=
 away.
>=20
> Thanks, this fixes the oops but does leave sata_mv non-functional,
> which is still a major regression from 3.13.
>=20

Please, try linux-next to get the most recent fixes and make sure you h=
ave
CONFIG_PHY_MVEBU_SATA enabled.

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
