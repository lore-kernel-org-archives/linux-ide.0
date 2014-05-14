From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Wed, 14 May 2014 21:10:09 +0200
Message-ID: <5701370.bQb4QoHk6c@wuerfel>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com> <17808571.N5ZGjXFEVP@wuerfel> <5373BC5D.7010300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5373BC5D.7010300@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, Antoine =?ISO-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, kishon@ti.com, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 14 May 2014 20:56:29 Sebastian Hesselbarth wrote:
> On 05/14/2014 08:51 PM, Arnd Bergmann wrote:
> > On Wednesday 14 May 2014 20:42:16 Sebastian Hesselbarth wrote:
> >>>> For the driver, Antoine then would have to squeeze all PHY register
> >>>> mangling in phy-berlin2.c and see how to make ahci-platform aware of
> >>>> individual port nodes (I haven't looked up if it already exists, sorry)
> >>>> and announce only enabled port child nodes, right?
> >>>
> >>> I've been thinking some more about this aspect. I don't actually have
> >>> a strong opinion on whether it's better to use the generic ahci-platform
> >>> driver, or to keep the multi-phy support as a special variant for
> >>> berlin. If we do the latter, it would however be good to define the
> >>> binding in a way that lets us later merge things into the generic phy
> >>> driver in case we get more of the same.
> >>
> >> Hmm, IMHO multi-phy support is orthogonal to ahci-platform, isn't it?
> >> ahci-platform needs to know about the phy property and calls some
> >> helper that deals with the phy-specifier?
> >>
> >> About a generic _phy_ driver, I am not so sure if berlin is the best
> >> template right now 
> >>
> >> So, my call would be:
> >> - make ahci-platform aware of port sub-nodes and phy properties
> >> - have a berlin specific PHY driver
> > 
> > I'm not sure if we need sub-nodes per port, it should be enough
> > to have an array of phys, plus a way to match them up with the
> > ports.
> 
> Actually, I'd love to see sub-nodes per port as it will allow to
> disabled unused ports on a per-board basis.
> 
> I have this in mind for a long time for Kirkwood's SATA node already:
> Consider a board where you have the one available SATA plug connected
> to port 1. How would that work out with status = "disabled"/"okay" that
> doesn't allow array of strings obviously?

A simple bit mask would work fine, but I see your point. Doing
status="disabled" per port sounds nice.

	Arnd
