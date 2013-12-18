From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] SATA: MV: Add support for the optional PHYs
Date: Wed, 18 Dec 2013 07:13:13 -0500
Message-ID: <20131218121313.GC4324@htj.dyndns.org>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-3-git-send-email-andrew@lunn.ch>
 <52B140F2.8070900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:62999 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab3LRMNR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Dec 2013 07:13:17 -0500
Content-Disposition: inline
In-Reply-To: <52B140F2.8070900@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

Hello,

On Wed, Dec 18, 2013 at 12:00:10PM +0530, Kishon Vijay Abraham I wrote:
> > @@ -4097,6 +4109,10 @@ static int mv_platform_probe(struct platform_device *pdev)
> >  		hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
> >  		if (!IS_ERR(hpriv->port_clks[port]))
> >  			clk_prepare_enable(hpriv->port_clks[port]);
> > +		sprintf(port_number, "port%d", port);
> > +		hpriv->port_phys[port] = devm_phy_get(&pdev->dev, port_number);
> > +		if (!IS_ERR(hpriv->port_phys[port]))
> > +			phy_power_on(hpriv->port_phys[port]);

Shouldn't it distinguish between failures and at least produce
warning?  ie. phy not available and phy init failed due to memory
pressure or whatnot shouldn't be handled the same.

> > @@ -4132,6 +4148,8 @@ err:
> >  			clk_disable_unprepare(hpriv->port_clks[port]);
> >  			clk_put(hpriv->port_clks[port]);
> >  		}
> > +		if (!IS_ERR(hpriv->port_phys[port]))
> > +			phy_power_off(hpriv->port_phys[port]);

And I'd much prefer the array holds either NULL or valid pointer.

Thanks.

-- 
tejun
