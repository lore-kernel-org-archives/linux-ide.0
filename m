From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 2/3] ata: ahci_platform: Manage SATA PHY
Date: Wed, 8 Jan 2014 16:58:15 +0530
Message-ID: <52CD364F.4060104@ti.com>
References: <1389174428-31414-1-git-send-email-rogerq@ti.com> <1389174428-31414-3-git-send-email-rogerq@ti.com> <52CD2176.6050102@ti.com> <6214646.nAF6lzWV79@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6214646.nAF6lzWV79@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: tj@kernel.org, sergei.shtylyov@cogentembedded.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-ide@vger.kernel.org

On 01/08/2014 03:35 PM, Arnd Bergmann wrote:
> On Wednesday 08 January 2014 15:29:18 Kishon Vijay Abraham I wrote:
>>> +     hpriv->phy = devm_phy_get(dev, "sata-phy");
>>> +     if (IS_ERR(hpriv->phy)) {
>>> +             dev_dbg(dev, "can't get sata-phy\n");
>>> +             /* return only if -EPROBE_DEFER */
>>> +             if (PTR_ERR(hpriv->phy) == -EPROBE_DEFER) {
>>> +                     rc = -EPROBE_DEFER;
>>> +                     goto disable_unprepare_clk;
>>> +             }
>>> +     }
> 
> This should probably check for all errors except "not present"
> rather than checking for -EPROBE_DEFER. We want to abort the
> probe function for deferred probe as well as the case where we
> a PHY was listed but isn't working properly.

OK.

> 
>>> +     if (!IS_ERR(hpriv->phy)) {
>>> +             phy_init(hpriv->phy);
>>
>> Don't we have to check the return values of phy_init and phy_power_on? Is it
>> not needed because it is an optional phy?
> 
> Right. I think we should set hpriv->phy to NULL if it's not there and
> then call the functions only if it's actually present but bail out on
> an error.

OK. How does this look?

hpriv->phy = devm_phy_get(dev, "sata-phy");
if (IS_ERR(hpriv->phy)) {
	if (PTR_ERR(hpriv->phy) == -ENODEV)
		goto continue;

	dev_err(dev, "couldn't get sata-phy\n");
	rc = PTR_ERR(hpriv->phy);
	goto disable_unprepare_clk;
}

continue:

if (!IS_ERR(hpriv->phy)) {
	rc = phy_init(hpriv->phy);
	if (rc)
		goto disable_unprepare_clk;

	rc = phy_power_on(hpriv->phy);
	if (rc) {
		phy_exit(hpriv->phy);
		goto disable_unprepare_clk;
	}
}

cheers,
-roger
