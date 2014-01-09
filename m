From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 2/3] ata: ahci_platform: Manage SATA PHY
Date: Thu, 9 Jan 2014 11:56:02 +0530
Message-ID: <52CE40FA.5070605@ti.com>
References: <1389174428-31414-1-git-send-email-rogerq@ti.com> <6214646.nAF6lzWV79@wuerfel> <52CD364F.4060104@ti.com> <5878159.3LjUeZKdYB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbaAIG0S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jan 2014 01:26:18 -0500
In-Reply-To: <5878159.3LjUeZKdYB@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, tj@kernel.org, sergei.shtylyov@cogentembedded.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>

On 01/08/2014 05:16 PM, Arnd Bergmann wrote:
> On Wednesday 08 January 2014 16:58:15 Roger Quadros wrote:
>> hpriv->phy = devm_phy_get(dev, "sata-phy");
>> if (IS_ERR(hpriv->phy)) {
>>         if (PTR_ERR(hpriv->phy) == -ENODEV)
>>                 goto continue;
>>
>>         dev_err(dev, "couldn't get sata-phy\n");
>>         rc = PTR_ERR(hpriv->phy);
>>         goto disable_unprepare_clk;
>> }
>>
>> continue:
>>
>> if (!IS_ERR(hpriv->phy)) {
>>         rc = phy_init(hpriv->phy);
>>         if (rc)
>>                 goto disable_unprepare_clk;
>>
>>         rc = phy_power_on(hpriv->phy);
>>         if (rc) {
>>                 phy_exit(hpriv->phy);
>>                 goto disable_unprepare_clk;
>>         }
>> }
> 
> As I said, I'd prefer to set hpriv->phy to NULL in case of -ENODEV,
> but functionally it seems right (with the fixup from your other mail).
> 

Why do you prefer setting hpriv->phy to NULL instead of using IS_ERR() check
before hpriv->phy is used?
The latter seems to be the norm at least among clock framework users.

> One more comment: you shouldn't print an error message before
> returning -EPROBE_DEFER, so if you want to keep that message,
> you have to check for that return value after all.
>
Right.

cheers,
-roger
