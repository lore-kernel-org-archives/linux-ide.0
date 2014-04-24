From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
Date: Thu, 24 Apr 2014 12:26:39 +0200
Message-ID: <20140424102639.GA31101@kwain>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140424175041.0bade2d6@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140424175041.0bade2d6@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, "tj@kernel.org" <tj@kernel.org>, "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>, Jimmy Xu <zmxu@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Jisheng,

On Thu, Apr 24, 2014 at 05:50:41PM +0800, Jisheng Zhang wrote:
> Hi Antoine,
>=20
> On Tue, 22 Apr 2014 08:38:20 -0700
> Antoine T=E9nart <antoine.tenart@free-electrons.com> wrote:
>=20
> > +		/* CT timing fix */
> > +		ahci_berlin_reg_set(ctrl_reg + PORT_VSR_ADDR, BIT(6) |
> > BIT(1));
> > +		ahci_berlin_reg_set(ctrl_reg + PORT_VSR_ADDR,
> > +				    BIT(15) | BIT(13) | BIT(12) | BIT(11) |
> > +				    BIT(10) | BIT(2) | BIT(1));
>=20
> Could you please remove these code? They are not used for BG2Q, I'm s=
orry there's
> such mistake in the code I provided to you ;)

OK, thanks for the update!

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
