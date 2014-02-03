From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/3] drivers: phy: Add support for optional phys
Date: Mon, 3 Feb 2014 15:49:36 +0530
Message-ID: <52EF6D38.4060200@ti.com>
References: <0140131114857.GC26148@htj.dyndns.org> <1391264157-2112-1-git-send-email-andrew@lunn.ch> <1391264157-2112-2-git-send-email-andrew@lunn.ch> <52EF2E74.1040501@ti.com> <20140203093606.GA8038@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44153 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbaBCKTs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Feb 2014 05:19:48 -0500
In-Reply-To: <20140203093606.GA8038@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On Monday 03 February 2014 03:06 PM, Andrew Lunn wrote:
>>>  /**
>>> + * devm_phy_optional_get() - lookup and obtain a reference to an optional phy.
>>> + * @dev: device that requests this phy
>>> + * @string: the phy name as given in the dt data or phy device name
>>> + * for non-dt case
>>> + *
>>> + * Gets the phy using phy_get(), and associates a device with it using
>>> + * devres. On driver detach, release function is invoked on the devres data,
>>> + * then, devres data is freed. This differs to devm_phy_get() in that if the
>>> + * phy does not exist, it is not considered an error. Instead the NULL phy
>>> + * is returned, which can be passed to all other phy consumer calls.
>>
>> It doesn't explain how devm_phy_optional_get is different from phy_get :-s

ah.. it actually explained. Sorry.
> 
> How about i append, 
> 
> , and so will never return -ENODEV.
> 
> to the next but last sentence?

Yeah, that can be added too.
> 
>>> + */
>>> +struct phy *devm_phy_optional_get(struct device *dev, const char *string)
>>> +{
>>> +	struct phy *phy = devm_phy_get(dev, string);
>>> +
>>> +	if (PTR_ERR(phy) == -ENODEV)
>>> +		phy = NULL;
>>
>> Do we need an API in phy-core to handle this? Can't this be done in the
>> controller driver itself?
> 
> Sure it can be done in the consumer, but the code is ugly. Take a look
> at:
> 
> http://marc.info/?l=linux-ide&m=139116894403306&w=2

Ok. Just one comment though. Implement phy_get_optional too so that we have
both the devres and the other variant.

Thanks
Kishon
