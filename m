From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [patch v2 1/3] drivers: phy: Make NULL a valid phy reference
Date: Mon, 3 Feb 2014 19:13:11 +0100
Message-ID: <20140203181311.GA15442@lunn.ch>
References: <52EF6D38.4060200@ti.com>
 <1391450446-15580-1-git-send-email-andrew@lunn.ch>
 <52EFE8A1.8010206@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50448 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaBCSN3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Feb 2014 13:13:29 -0500
Content-Disposition: inline
In-Reply-To: <52EFE8A1.8010206@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, kishon@ti.com, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

On Mon, Feb 03, 2014 at 10:06:09PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 02/03/2014 09:00 PM, Andrew Lunn wrote:
> 
> >The common clock framework considers NULL a valid clock
> >reference. This makes handling optional clocks simple, in that if the
> >optional clock is not available, a NULL reference can be used in the
> >place of a real clock, simplifying the clock consumer.
> 
> >Extend this concept to the phy consumer API. A NULL can be passed to
> >the release calls, the phy_init() and phy_exit() calls, and
> >phy_power_on() and phy_power_off() and a NOP is performed.
> 
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [...]
> 
> >  When the controller no longer needs the PHY, it has to release the reference
> >diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> >index 645c867c1257..56535253e50c 100644
> >--- a/drivers/phy/phy-core.c
> >+++ b/drivers/phy/phy-core.c
> [...]
> >@@ -308,6 +320,9 @@ err0:
> >   */
> >  void phy_put(struct phy *phy)
> >  {
> >+	if (!phy)
> >+		return;
> >+
> >  	if (IS_ERR(phy))
> >  		return;
> 
>    Why not merge these two?

Hi Sergei

Have you heard Russell King talk about IS_ERR_NULL()?

     Andrew
