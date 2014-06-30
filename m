From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v7 1/7] phy: add a driver for the Berlin SATA PHY
Date: Mon, 30 Jun 2014 17:44:09 +0200
Message-ID: <20140630154409.GB29613@kwain>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403530783-17180-2-git-send-email-antoine.tenart@free-electrons.com>
 <53AB1CFD.4040500@cogentembedded.com>
 <20140630095940.GB10058@kwain>
 <53B176F1.5060308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56123 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbaF3PoN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jun 2014 11:44:13 -0400
Content-Disposition: inline
In-Reply-To: <53B176F1.5060308@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, tj@kernel.org, kishon@ti.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org

Hi Sebastian,

On Mon, Jun 30, 2014 at 04:40:49PM +0200, Sebastian Hesselbarth wrote:
> On 06/30/2014 11:59 AM, Antoine T=E9nart wrote:
> >On Wed, Jun 25, 2014 at 11:03:25PM +0400, Sergei Shtylyov wrote:
> >>On 06/23/2014 05:39 PM, Antoine T=E9nart wrote:
> >>>+	/* set the controller speed */
> >>>+	writel(0x31, ctrl_reg + PORT_SCR_CTL);
> >>
> >>    Value undocumented? Or is this the SATA SControl register by ch=
ance?
> >
> >Some magic is still there...
>=20
> I guess Sergei was referring to AHCI spec here. PORT_SCR bits are
> documented in AHCI spec as:
>=20
> 7:4 =3D 0x3 Limit speed negotiation to a rate not greater than Gen3
>           communication rate.
>=20
> 3:0 =3D 0x1 Perform interface communication sequence [...]. This is
>           functionally equivalent to a hard reset [...].
>=20
> So, the question is: Should we really need to reset controller in the
> PHY driver or is it already done in AHCI common code? At least we
> should change the comment to something like
> /* set Gen3 controller speed and perform hard reset */

I just checked, the AHCI common code has a function to do the reset:
ahci_reset_controller(). As of the max speed negociation rate, I did no=
t
see it in the common AHCI functions.

The eSATA port on the Berlin2Q works without this line, but it may be a
good idea to keep the max speed negociation rate.

Anyway, we can remove the reset part. Nice catch!

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
