From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom STB
 SoCs
Date: Tue, 7 Apr 2015 11:37:43 +0530
Message-ID: <5523742F.2060105@ti.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com> <1426728222-8197-4-git-send-email-computersforpeace@gmail.com> <55132FD0.2000103@ti.com> <20150328002844.GA32500@ld-irv-0074> <551A3844.6060806@ti.com> <20150402022822.GE32500@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150402022822.GE32500@ld-irv-0074>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On Thursday 02 April 2015 07:58 AM, Brian Norris wrote:
> On Tue, Mar 31, 2015 at 11:31:40AM +0530, Kishon Vijay Abraham I wrote:
>> On Saturday 28 March 2015 05:58 AM, Brian Norris wrote:
>>> On Thu, Mar 26, 2015 at 03:29:44AM +0530, Kishon Vijay Abraham I wrote:
>>>> On Thursday 19 March 2015 06:53 AM, Brian Norris wrote:
>>>>> +static struct phy *brcm_sata_phy_xlate(struct device *dev,
>>>>> +				       struct of_phandle_args *args)
>>>>> +{
>>>>> +	struct brcm_sata_phy *priv = dev_get_drvdata(dev);
>>>>> +	int i = args->args[0];
>>>>> +
>>>>> +	if (i >= MAX_PORTS || !priv->phys[i].phy) {
>>>>> +		dev_err(dev, "invalid phy: %d\n", i);
>>>>> +		return ERR_PTR(-ENODEV);
>>>>> +	}
>>>>> +
>>>>> +	return priv->phys[i].phy;
>>>>> +}
>>>>
>>>> this xlate is not required at all if the controller device tree node has
>>>> phandle to the phy node (sub node) instead of the phy provider device tree
>>>> node.
>>>
>>> That doesn't match any convention I see in existing SATA phy bindings,
>>> nor do I see how the existing of_phy_simple_xlate() would support this,
>>> unless I instantiate a device for each port's PHY. If I adjust the
>>> device tree as you suggest, and use of_phy_simple_xlate() instead of
>>> this, of_phy_get() can't find the PHY provider, because the provider is
>>> registered to the parent, not the subnode.
>>
>> The phy core should still be able to get the PHY provider.
>> See this in of_phy_provider_lookup
>>                  for_each_child_of_node(phy_provider->dev->of_node, child)
>>                          if (child == node)
>>                                  return phy_provider;
>
> That just searches for children of the node. It doesn't walk parent
> nodes.

okay.. in your phy_create pass the np of the PHYs (sub-node pointer to phy 
provider).

>
>> Can you post your device tree node here?
>
> You mean patch 5?
>
> https://lkml.org/lkml/2015/3/18/937
>
>>>
>>> Can you elaborate on your suggestion?

Change the dt node to something like below..

+
+		sata@f045a000 {
+			<snip>
+
+			sata0: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+
+			sata1: sata-port@1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+			};
+		};
+
+		sata_phy: sata-phy@f0458100 {
+			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
+			reg = <0x458100 0x1e00>, <0x45804c 0x10>;
+			reg-names = "phy", "port-ctrl";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+
+			sata_phy0: sata-phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			sata_phy1: sata-phy@1 {
+				#phy-cells = <0>;
+			};
+		};
  	};
>>>
>>>>> +
>>>>> +static const struct of_device_id brcmstb_sata_phy_of_match[] = {
>>>>> +	{ .compatible	= "brcm,bcm7445-sata-phy" },
>>>>> +	{},
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, brcmstb_sata_phy_of_match);
>>>>> +
>>>>> +static int brcmstb_sata_phy_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct device_node *dn = dev->of_node, *child;
>>>>> +	struct brcm_sata_phy *priv;
>>>>> +	struct resource *res;
>>>>> +	struct phy_provider *provider;
>>>>> +	int count = 0;
>>>>> +
>>>>> +	if (of_get_child_count(dn) == 0)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>>> +	if (!priv)
>>>>> +		return -ENOMEM;
>>>>> +	dev_set_drvdata(dev, priv);
>>>>> +	priv->dev = dev;
>>>>> +
>>>>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "port-ctrl");
>>>>> +	if (!res) {
>>>>> +		dev_err(dev, "couldn't get port-ctrl resource\n");
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +	/*
>>>>> +	 * Don't request region, since it may be within a region owned by the
>>>>> +	 * SATA driver
>>>>
>>>> It should be in the SATA driver then. Why is it here?
>>>
>>> Did you read the discussion branching here?
>>>
>>> http://article.gmane.org/gmane.linux.drivers.devicetree/114637
>>>
>>> I've seen the exact opposite suggestion already (move it to the PHY
>>> driver), and I'm not sure either suggestion is correct. The same
>>> register block has registers for both the PHY and the SATA controller.
>>
>> IMHO the register space shouldn't be defined based on the programming sequence
>> but by where the register is actually present in the IP. From that thread it
>> doesn't look like it is present in the PHY IP.
>
> If you say so. But it has plenty of PHY controls packed into those
> registers, so are you just recommending handling those bits from the
> SATA driver?

Yes. Let's program only the PHY IP in this driver.
>
> ...
>
>>>> lets not make the boot noisy. Make it dev_vdbg if it is required.
>>>
>>> I think it's important to have at least some of the three informational
>>> prints that you're suggesting turn into dbg. It's pretty important to
>>> see that we're powering on one or more PHY ports, for both
>>> power/correctness concerns (trying to power on a port that is
>>> OTP-disabled, for instance) and debugging concerns (the suggestions you
>>> made about the device tree yielded a dead SATA, and it was obvious,
>>> because the "powering on" prints were missing).
>>
>> All these are debugging info. Hence it's better to keep in dev_vdbg or dev_dbg.
>>>
>>> I'd kinda like to see the previous power on/off prints above stay as
>>> dev_info(), though the "registered" print might be superfluous, as the
>>> registration info should show up in sysfs.
>>>
>>> Related: I don't see any API for monitoring the PHY status from user
>>> space. e.g., there's nothing useful in /sys/class/phy/*/.
>>
>> Do you really need to monitor the PHY status? We should be careful about
>> exposing anything to the user space since it will become an ABI and we can
>> never modify it.
>
> Not really, but the debugging info (which you want me to remove by
> default, and which is unretrievable after system boot) is the next

I didn't ask you to remove it. I just asked you to keep in dev_dbg. If you are 
interested in the debugging info, all you need to do is change the debug log level.

Cheers
Kishon
