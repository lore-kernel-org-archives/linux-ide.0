From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/3] ata: ahci_platform: Manage SATA PHY
Date: Wed, 08 Jan 2014 12:46:09 +0100
Message-ID: <5878159.3LjUeZKdYB@wuerfel>
References: <1389174428-31414-1-git-send-email-rogerq@ti.com> <6214646.nAF6lzWV79@wuerfel> <52CD364F.4060104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58602 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbaAHLqP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jan 2014 06:46:15 -0500
In-Reply-To: <52CD364F.4060104@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, tj@kernel.org, sergei.shtylyov@cogentembedded.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>

On Wednesday 08 January 2014 16:58:15 Roger Quadros wrote:
> hpriv->phy = devm_phy_get(dev, "sata-phy");
> if (IS_ERR(hpriv->phy)) {
>         if (PTR_ERR(hpriv->phy) == -ENODEV)
>                 goto continue;
> 
>         dev_err(dev, "couldn't get sata-phy\n");
>         rc = PTR_ERR(hpriv->phy);
>         goto disable_unprepare_clk;
> }
> 
> continue:
> 
> if (!IS_ERR(hpriv->phy)) {
>         rc = phy_init(hpriv->phy);
>         if (rc)
>                 goto disable_unprepare_clk;
> 
>         rc = phy_power_on(hpriv->phy);
>         if (rc) {
>                 phy_exit(hpriv->phy);
>                 goto disable_unprepare_clk;
>         }
> }

As I said, I'd prefer to set hpriv->phy to NULL in case of -ENODEV,
but functionally it seems right (with the fixup from your other mail).

One more comment: you shouldn't print an error message before
returning -EPROBE_DEFER, so if you want to keep that message,
you have to check for that return value after all.

	Arnd
