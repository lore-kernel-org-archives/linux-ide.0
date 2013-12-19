From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/4] SATA: MV: Add support for the optional PHYs
Date: Thu, 19 Dec 2013 20:10:27 +0100
Message-ID: <20131219191027.GI4143@lunn.ch>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-3-git-send-email-andrew@lunn.ch>
 <52B140F2.8070900@ti.com>
 <20131218121313.GC4324@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:36159 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631Ab3LSTLG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Dec 2013 14:11:06 -0500
Content-Disposition: inline
In-Reply-To: <20131218121313.GC4324@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 18, 2013 at 07:13:13AM -0500, Tejun Heo wrote:
> Hello,
> 
> On Wed, Dec 18, 2013 at 12:00:10PM +0530, Kishon Vijay Abraham I wrote:
> > > @@ -4097,6 +4109,10 @@ static int mv_platform_probe(struct platform_device *pdev)
> > >  		hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
> > >  		if (!IS_ERR(hpriv->port_clks[port]))
> > >  			clk_prepare_enable(hpriv->port_clks[port]);
> > > +		sprintf(port_number, "port%d", port);
> > > +		hpriv->port_phys[port] = devm_phy_get(&pdev->dev, port_number);
> > > +		if (!IS_ERR(hpriv->port_phys[port]))
> > > +			phy_power_on(hpriv->port_phys[port]);
> 
> Shouldn't it distinguish between failures and at least produce
> warning?  ie. phy not available and phy init failed due to memory
> pressure or whatnot shouldn't be handled the same.

Phy not available is not an error, since not all variants of the SATA
IP block have the ability to control the phy. I can however add a
warning for real errors.

> > > @@ -4132,6 +4148,8 @@ err:
> > >  			clk_disable_unprepare(hpriv->port_clks[port]);
> > >  			clk_put(hpriv->port_clks[port]);
> > >  		}
> > > +		if (!IS_ERR(hpriv->port_phys[port]))
> > > +			phy_power_off(hpriv->port_phys[port]);
> 
> And I'd much prefer the array holds either NULL or valid pointer.

I was trying to keep the code similar to the clk handling. However now
that it is diverging more and more from how clk is handled, i can add
yet more divergence and overwrite the error with a NULL.

    Andrew
