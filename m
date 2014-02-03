From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/3] drivers: phy: Add support for optional phys
Date: Mon, 3 Feb 2014 10:36:06 +0100
Message-ID: <20140203093606.GA8038@lunn.ch>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
 <1391264157-2112-2-git-send-email-andrew@lunn.ch>
 <52EF2E74.1040501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50225 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbaBCJgX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Feb 2014 04:36:23 -0500
Content-Disposition: inline
In-Reply-To: <52EF2E74.1040501@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, linux-ide@vger.kernel.org

> >  /**
> > + * devm_phy_optional_get() - lookup and obtain a reference to an optional phy.
> > + * @dev: device that requests this phy
> > + * @string: the phy name as given in the dt data or phy device name
> > + * for non-dt case
> > + *
> > + * Gets the phy using phy_get(), and associates a device with it using
> > + * devres. On driver detach, release function is invoked on the devres data,
> > + * then, devres data is freed. This differs to devm_phy_get() in that if the
> > + * phy does not exist, it is not considered an error. Instead the NULL phy
> > + * is returned, which can be passed to all other phy consumer calls.
> 
> It doesn't explain how devm_phy_optional_get is different from phy_get :-s

How about i append, 

, and so will never return -ENODEV.

to the next but last sentence?

> > + */
> > +struct phy *devm_phy_optional_get(struct device *dev, const char *string)
> > +{
> > +	struct phy *phy = devm_phy_get(dev, string);
> > +
> > +	if (PTR_ERR(phy) == -ENODEV)
> > +		phy = NULL;
> 
> Do we need an API in phy-core to handle this? Can't this be done in the
> controller driver itself?

Sure it can be done in the consumer, but the code is ugly. Take a look
at:

http://marc.info/?l=linux-ide&m=139116894403306&w=2

	Andrew
