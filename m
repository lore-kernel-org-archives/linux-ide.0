From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
Date: Tue, 20 May 2014 16:06:31 +0200
Message-ID: <20140520140631.GF9873@lunn.ch>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <1821771.zFvTDGF2Ae@amdc1032>
 <20140520134942.GC9873@lunn.ch>
 <20140520140325.GA21579@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:48710 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbaETOJt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 May 2014 10:09:49 -0400
Content-Disposition: inline
In-Reply-To: <20140520140325.GA21579@kwain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, tj@kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.hesselbarth@gmail.com

> > > > +config PHY_BERLIN_SATA
> > > > +	bool
> > > 
> > > Is there any real reason why this cannot be tristate?
> > 
> > What we have seen with SATA drivers and phys, is there is link time
> > breakage if the SATA driver is built in and the phy is modular.
> > 
> > Maybe this has been fixed now? 
> 
> Using tristate shouldn't be a problem. I compiled without the PHY
> driver, no link issue.

The problem i think was when the PHY core and driver was a module and
SATA built in. Please give that configuration a go.

     Andrew
