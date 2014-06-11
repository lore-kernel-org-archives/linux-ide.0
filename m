From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v5 0/7] ARM: berlin: add AHCI support
Date: Wed, 11 Jun 2014 10:36:30 +0200
Message-ID: <20140611083630.GA32216@kwain>
References: <1401115908-2742-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401115908-2742-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi all,

On Mon, May 26, 2014 at 04:51:41PM +0200, Antoine T=E9nart wrote:
> This series adds the support for Berlin SoC AHCI controller. The
> controller allows to use the SATA host interface and, for example, th=
e
> eSATA port on the BG2Q.
>=20
> The series adds a PHY driver to control the two SATA ports available,
> and adds a generic compatible to use the existing ahci_platform drive=
r.
>=20
> Also enable the eSATA interface on the BG2Q DMP.

Any news on this series?


Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
