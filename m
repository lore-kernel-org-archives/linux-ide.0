From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom STB
 SoCs
Date: Tue, 7 Apr 2015 11:35:51 -0700
Message-ID: <20150407183551.GL32500@ld-irv-0074>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
 <1426728222-8197-4-git-send-email-computersforpeace@gmail.com>
 <55132FD0.2000103@ti.com>
 <20150328002844.GA32500@ld-irv-0074>
 <551A3844.6060806@ti.com>
 <20150402022822.GE32500@ld-irv-0074>
 <5523742F.2060105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35049 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbDGSf7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2015 14:35:59 -0400
Content-Disposition: inline
In-Reply-To: <5523742F.2060105@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Apr 07, 2015 at 11:37:43AM +0530, Kishon Vijay Abraham I wrote:
> On Thursday 02 April 2015 07:58 AM, Brian Norris wrote:
> >On Tue, Mar 31, 2015 at 11:31:40AM +0530, Kishon Vijay Abraham I wrote:
> >>On Saturday 28 March 2015 05:58 AM, Brian Norris wrote:
> >>>On Thu, Mar 26, 2015 at 03:29:44AM +0530, Kishon Vijay Abraham I wrote:
> >>>>On Thursday 19 March 2015 06:53 AM, Brian Norris wrote:
> >>>>>+static struct phy *brcm_sata_phy_xlate(struct device *dev,
> >>>>>+				       struct of_phandle_args *args)
> >>>>>+{
> >>>>>+	struct brcm_sata_phy *priv = dev_get_drvdata(dev);
> >>>>>+	int i = args->args[0];
> >>>>>+
> >>>>>+	if (i >= MAX_PORTS || !priv->phys[i].phy) {
> >>>>>+		dev_err(dev, "invalid phy: %d\n", i);
> >>>>>+		return ERR_PTR(-ENODEV);
> >>>>>+	}
> >>>>>+
> >>>>>+	return priv->phys[i].phy;
> >>>>>+}
> >>>>
> >>>>this xlate is not required at all if the controller device tree node has
> >>>>phandle to the phy node (sub node) instead of the phy provider device tree
> >>>>node.
> >>>
> >>>That doesn't match any convention I see in existing SATA phy bindings,
> >>>nor do I see how the existing of_phy_simple_xlate() would support this,
> >>>unless I instantiate a device for each port's PHY. If I adjust the
> >>>device tree as you suggest, and use of_phy_simple_xlate() instead of
> >>>this, of_phy_get() can't find the PHY provider, because the provider is
> >>>registered to the parent, not the subnode.
> >>
> >>The phy core should still be able to get the PHY provider.
> >>See this in of_phy_provider_lookup
> >>                 for_each_child_of_node(phy_provider->dev->of_node, child)
> >>                         if (child == node)
> >>                                 return phy_provider;
> >
> >That just searches for children of the node. It doesn't walk parent
> >nodes.
> 
> okay.. in your phy_create pass the np of the PHYs (sub-node pointer
> to phy provider).

Ah, I see. I completely passed over the 2nd parameter to phy_create()...
Thanks for the tip.

> >>Can you post your device tree node here?
> >
> >You mean patch 5?
> >
> >https://lkml.org/lkml/2015/3/18/937
> >
> >>>
> >>>Can you elaborate on your suggestion?
> 
> Change the dt node to something like below..

[snip]

Yes, that worked. Thanks.

OK, I'll fix this up and send out v2 shortly.

Brian
