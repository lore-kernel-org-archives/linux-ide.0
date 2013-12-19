From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] SATA: MV: Add support for the optional PHYs
Date: Thu, 19 Dec 2013 14:42:37 -0500
Message-ID: <20131219194237.GC22725@htj.dyndns.org>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-3-git-send-email-andrew@lunn.ch>
 <52B140F2.8070900@ti.com>
 <20131218121313.GC4324@htj.dyndns.org>
 <20131219191027.GI4143@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:41535 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3LSTml (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Dec 2013 14:42:41 -0500
Content-Disposition: inline
In-Reply-To: <20131219191027.GI4143@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

Hello,

On Thu, Dec 19, 2013 at 08:10:27PM +0100, Andrew Lunn wrote:
> > Shouldn't it distinguish between failures and at least produce
> > warning?  ie. phy not available and phy init failed due to memory
> > pressure or whatnot shouldn't be handled the same.
> 
> Phy not available is not an error, since not all variants of the SATA
                          ^
			 always

> IP block have the ability to control the phy. I can however add a
> warning for real errors.

Yes, please.

> > > > @@ -4132,6 +4148,8 @@ err:
> > > >  			clk_disable_unprepare(hpriv->port_clks[port]);
> > > >  			clk_put(hpriv->port_clks[port]);
> > > >  		}
> > > > +		if (!IS_ERR(hpriv->port_phys[port]))
> > > > +			phy_power_off(hpriv->port_phys[port]);
> > 
> > And I'd much prefer the array holds either NULL or valid pointer.
> 
> I was trying to keep the code similar to the clk handling. However now
> that it is diverging more and more from how clk is handled, i can add
> yet more divergence and overwrite the error with a NULL.

Thanks.

-- 
tejun
