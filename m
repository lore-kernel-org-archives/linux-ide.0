From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Wed, 14 May 2014 20:51:44 +0200
Message-ID: <17808571.N5ZGjXFEVP@wuerfel>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com> <5764751.ffUj9rhnMd@wuerfel> <5373B908.5090904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50476 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaENSv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 14:51:58 -0400
In-Reply-To: <5373B908.5090904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, Antoine =?ISO-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, kishon@ti.com, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, tj@kernel.org

On Wednesday 14 May 2014 20:42:16 Sebastian Hesselbarth wrote:
> >> For the driver, Antoine then would have to squeeze all PHY register
> >> mangling in phy-berlin2.c and see how to make ahci-platform aware of
> >> individual port nodes (I haven't looked up if it already exists, sorry)
> >> and announce only enabled port child nodes, right?
> > 
> > I've been thinking some more about this aspect. I don't actually have
> > a strong opinion on whether it's better to use the generic ahci-platform
> > driver, or to keep the multi-phy support as a special variant for
> > berlin. If we do the latter, it would however be good to define the
> > binding in a way that lets us later merge things into the generic phy
> > driver in case we get more of the same.
> 
> Hmm, IMHO multi-phy support is orthogonal to ahci-platform, isn't it?
> ahci-platform needs to know about the phy property and calls some
> helper that deals with the phy-specifier?
> 
> About a generic _phy_ driver, I am not so sure if berlin is the best
> template right now 
> 
> So, my call would be:
> - make ahci-platform aware of port sub-nodes and phy properties
> - have a berlin specific PHY driver

I'm not sure if we need sub-nodes per port, it should be enough
to have an array of phys, plus a way to match them up with the
ports.

	Arnd
