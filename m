From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [v6 6/7] phy: phy_brcmstb_sata: add data for phy version
Date: Tue, 15 Dec 2015 20:23:04 +0900
Message-ID: <8DDEF728-5E23-4357-98CB-F7D599F16337@gmail.com>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com> <1448506595-4981-7-git-send-email-jaedon.shin@gmail.com> <5656E75F.9020701@cogentembedded.com> <566FEF9F.6040006@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33404 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964902AbbLOLXL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2015 06:23:11 -0500
Received: by mail-pa0-f54.google.com with SMTP id ur14so3430330pab.0
        for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2015 03:23:11 -0800 (PST)
In-Reply-To: <566FEF9F.6040006@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

Hi Kishon,

On Dec 15, 2015, at 7:46 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
> Hi Shin,
> 
> On Thursday 26 November 2015 04:35 PM, Sergei Shtylyov wrote:
>> Hello.
>> 
>> On 11/26/2015 5:56 AM, Jaedon Shin wrote:
>> 
>>> Add data for phy version, and the default value of version is using the
>>> BRCM_SATA_PHY_28NM.
>>> 
>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>>> Acked-by: Brian Norris <computersforpeace@gmail.com>
>>> ---
>>>  drivers/phy/phy-brcmstb-sata.c | 23 ++++++++++++++++++++---
>>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
>>> index 0be55dafe9ea..5de394f589c8 100644
>>> --- a/drivers/phy/phy-brcmstb-sata.c
>>> +++ b/drivers/phy/phy-brcmstb-sata.c
>>> @@ -30,7 +30,11 @@
>>>  #define MAX_PORTS                    2
>>> 
>>>  /* Register offset between PHYs in PCB space */
>>> -#define SATA_MDIO_REG_SPACE_SIZE            0x1000
>>> +#define SATA_MDIO_REG_28NM_SPACE_SIZE            0x1000
>>> +
>>> +enum brcm_sata_phy_version {
>>> +    BRCM_SATA_PHY_28NM,
>>> +};
>> 
>>   So an uninitialized .data field would mean the same?
> 
> Are you planning to fix this?
> 
> Thanks
> Kishon

No, I do not have a plan in this version.

Of course, It is good that correspond to the case of NULL, but a .data field is not 
empty at any time. I'm sure it must have BRCM_SATA_PHY_28NM or BRCM_SATA_PHY_40NM.

And Sergei, thanks to your good point.

Thanks,
Jaedon

>> 
>> [...]
>>> @@ -126,7 +135,8 @@ static const struct phy_ops phy_ops_28nm = {
>>>  };
>>> 
>>>  static const struct of_device_id brcm_sata_phy_of_match[] = {
>>> -    { .compatible    = "brcm,bcm7445-sata-phy" },
>>> +    { .compatible    = "brcm,bcm7445-sata-phy",
>>> +      .data = (void *)BRCM_SATA_PHY_28NM },
>>>      {},
>>>  };
>>>  MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
>>> @@ -135,6 +145,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>>>  {
>>>      struct device *dev = &pdev->dev;
>>>      struct device_node *dn = dev->of_node, *child;
>>> +    const struct of_device_id *of_id;
>>>      struct brcm_sata_phy *priv;
>>>      struct resource *res;
>>>      struct phy_provider *provider;
>>> @@ -154,6 +165,12 @@ static int brcm_sata_phy_probe(struct platform_device
>>> *pdev)
>>>      if (IS_ERR(priv->phy_base))
>>>          return PTR_ERR(priv->phy_base);
>>> 
>>> +    of_id = of_match_node(brcm_sata_phy_of_match, dn);
>>> +    if (of_id)
>>> +        priv->version = (enum brcm_sata_phy_version)of_id->data;
>>> +    else
>>> +        priv->version = BRCM_SATA_PHY_28NM;
>>> +
>>>      for_each_available_child_of_node(dn, child) {
>>>          unsigned int id;
>>>          struct brcm_sata_port *port;
>> 
>> MBR, Sergei

