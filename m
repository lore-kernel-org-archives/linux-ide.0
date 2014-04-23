From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
Date: Wed, 23 Apr 2014 10:13:05 +0200
Message-ID: <20140423081305.GA24355@kwain>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <4239617.ieu9uluV2B@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55057 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753426AbaDWINJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2014 04:13:09 -0400
Content-Disposition: inline
In-Reply-To: <4239617.ieu9uluV2B@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: sebastian.hesselbarth@gmail.com, tj@kernel.org, alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 22, 2014 at 06:54:27PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> Hi,
>=20
> On Tuesday, April 22, 2014 05:38:20 PM Antoine T=C3=A9nart wrote:

[=E2=80=A6]

> > +static struct platform_driver ahci_berlin_driver =3D {
> > +	.probe	=3D ahci_berlin_probe,
> > +	.remove	=3D ata_platform_remove_one,
> > +	.driver	=3D {
> > +		.name		=3D "ahci-berlin",
> > +		.owner		=3D THIS_MODULE,
> > +		.of_match_table =3D ahci_berlin_of_match,
>=20
> Please add a comment explaining lack of power management support
> (i.e. that your platform doesn't have PM support implemented yet).

I can add the power management support in the v2.

Thanks!

Antoine

--=20
Antoine T=C3=A9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
