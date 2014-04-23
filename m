From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 5/6] ARM: berlin: add the AHCI node for the BG2
Date: Wed, 23 Apr 2014 10:58:02 +0200
Message-ID: <20140423085802.GF24355@kwain>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-6-git-send-email-antoine.tenart@free-electrons.com>
 <20140423104539.37c9366f@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140423104539.37c9366f@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, "tj@kernel.org" <tj@kernel.org>, "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>, Jimmy Xu <zmxu@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Jisheng,

On Wed, Apr 23, 2014 at 10:45:39AM +0800, Jisheng Zhang wrote:
> On Tue, 22 Apr 2014 08:38:24 -0700
> Antoine T=E9nart <antoine.tenart@free-electrons.com> wrote:
>=20
> > The BG2 has an AHCI SATA controller. Add the corresponding node
> > in its device tree.
>=20
> The AHCI IP of BG2 is different with BG2Q, so the driver in the serie=
s of patch
> doesn't work on BG2.

Thanks for the info! I'll drop BG2 and BG2CD nodes in the v2.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
