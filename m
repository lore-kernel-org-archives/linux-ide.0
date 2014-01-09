From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/3] ata: ahci_platform: Manage SATA PHY
Date: Thu, 9 Jan 2014 11:05:20 +0100
Message-ID: <201401091105.20727.arnd@arndb.de>
References: <1389174428-31414-1-git-send-email-rogerq@ti.com> <5878159.3LjUeZKdYB@wuerfel> <52CE40FA.5070605@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62102 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaAIKFd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jan 2014 05:05:33 -0500
In-Reply-To: <52CE40FA.5070605@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, tj@kernel.org, sergei.shtylyov@cogentembedded.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>

On Thursday 09 January 2014, Roger Quadros wrote:
> >> if (!IS_ERR(hpriv->phy)) {
> >>         rc = phy_init(hpriv->phy);
> >>         if (rc)
> >>                 goto disable_unprepare_clk;
> >>
> >>         rc = phy_power_on(hpriv->phy);
> >>         if (rc) {
> >>                 phy_exit(hpriv->phy);
> >>                 goto disable_unprepare_clk;
> >>         }
> >> }
> > 
> > As I said, I'd prefer to set hpriv->phy to NULL in case of -ENODEV,
> > but functionally it seems right (with the fixup from your other mail).
> > 
> 
> Why do you prefer setting hpriv->phy to NULL instead of using IS_ERR() check
> before hpriv->phy is used?
> The latter seems to be the norm at least among clock framework users.

Two reasons:

1. It feels more natural to read "if (clk)" in driver code as a check for
   "a clock exists" than "if (!IS_ERR(clk))".
2. It clarifies that this code path is only there to check for the
   clk-not-present case, not for other errors.

Obviously the first check after clk_get needs to be IS_ERR() because that
is the documented interface, but then you should decide on the action
based on the specific error.

	Arnd
