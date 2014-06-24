From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 24 Jun 2014 13:15:25 +0100
Message-ID: <20140624121525.GM13803@lee--X1>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
 <1402914392-6028-2-git-send-email-antoine.tenart@free-electrons.com>
 <53A9685E.9090501@ti.com>
 <53A96A1C.5030800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53A96A1C.5030800@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

On Tue, 24 Jun 2014, Varka Bhadram wrote:
> On 06/24/2014 05:30 PM, Kishon Vijay Abraham I wrote:
> >On Monday 16 June 2014 03:56 PM, Antoine T=C3=A9nart wrote:
> >>The Berlin SoC has a two SATA ports. Add a PHY driver to handle the=
m.
> >>
> >>The mode selection can let us think this PHY can be configured to f=
it
> >>other purposes. But there are reasons to think the SATA mode will b=
e
> >>the only one usable: the PHY registers are only accessible indirect=
ly
> >>through two registers in the SATA range, the PHY seems to be integr=
ated
> >>and no information tells us the contrary. For these reasons, make t=
he
> >>driver a SATA PHY driver.
> >>
> >>Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.c=
om>
> >>---
> >>  drivers/phy/Kconfig           |   7 ++
> >>  drivers/phy/Makefile          |   1 +
> >>  drivers/phy/phy-berlin-sata.c | 232 +++++++++++++++++++++++++++++=
+++++++++++++
> >>  3 files changed, 240 insertions(+)
> >>  create mode 100644 drivers/phy/phy-berlin-sata.c

Please snip all unseccersary code when replying to patches.

[...]

> >>+static struct phy *phy_berlin_sata_phy_xlate(struct device *dev,
> >>+					     struct of_phandle_args *args)
>=20
> Indent the function properly like this:
> static struct phy *phy_berlin_sata_phy_xlate(struct device *dev,
> 					     struct of_phandle_args *args)

You can also indent with TABs, especially if it means the following
line(s) would wrap.

> check with checkpatch.pl script

Snippy, snippy.

[...]

> >>+static struct platform_driver phy_berlin_sata_driver =3D {
> >>+	.probe	=3D phy_berlin_sata_probe,
> >>+	.driver	=3D {
> >>+		.name		=3D "phy-berlin-sata",
> >>+		.owner		=3D THIS_MODULE,
> >>+		.of_match_table	=3D phy_berlin_sata_of_match,
>=20
> use of_match_ptr for of_match_table

What use is this?

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
