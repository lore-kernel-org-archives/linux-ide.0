From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v6 1/7] phy: add a driver for the Berlin SATA PHY
Date: Mon, 30 Jun 2014 12:20:14 +0200
Message-ID: <20140630102014.GA5155@kwain>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
 <1402914392-6028-2-git-send-email-antoine.tenart@free-electrons.com>
 <53A9685E.9090501@ti.com>
 <53A96A1C.5030800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53A96A1C.5030800@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Jun 24, 2014 at 05:37:56PM +0530, Varka Bhadram wrote:
> On 06/24/2014 05:30 PM, Kishon Vijay Abraham I wrote:
> >On Monday 16 June 2014 03:56 PM, Antoine T=E9nart wrote:
> >>+
> >>+static struct phy *phy_berlin_sata_phy_xlate(struct device *dev,
> >>+					     struct of_phandle_args *args)
>=20
> Indent the function properly like this:
> static struct phy *phy_berlin_sata_phy_xlate(struct device *dev,
> 					     struct of_phandle_args *args)
>=20
> check with checkpatch.pl script

Already fixed in v7.


Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
