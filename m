From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/3] drivers: phy: Add support for optional phys
Date: Mon, 3 Feb 2014 11:21:48 +0530
Message-ID: <52EF2E74.1040501@ti.com>
References: <0140131114857.GC26148@htj.dyndns.org> <1391264157-2112-1-git-send-email-andrew@lunn.ch> <1391264157-2112-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41386 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbaBCFv5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Feb 2014 00:51:57 -0500
In-Reply-To: <1391264157-2112-2-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hi,

On Saturday 01 February 2014 07:45 PM, Andrew Lunn wrote:
> Add devm_phy_optional_get, which should be used when the phy is
> optional. It does not return an error when the phy does not exist,
> rather it returns NULL, which is considered as a valid phy, but
> results in NOPs when used with the consumer API.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/phy.txt   | 18 +++++++++++-------
>  drivers/phy/phy-core.c  | 27 +++++++++++++++++++++++++--
>  include/linux/phy/phy.h |  7 +++++++
>  3 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/phy.txt b/Documentation/phy.txt
> index 2e24b993e95f..1f34a44975ba 100644
> --- a/Documentation/phy.txt
> +++ b/Documentation/phy.txt
> @@ -76,13 +76,17 @@ it. This framework provides the following APIs to get a reference to the PHY.
>  
>  struct phy *phy_get(struct device *dev, const char *string);
>  struct phy *devm_phy_get(struct device *dev, const char *string);
> -
> -phy_get and devm_phy_get can be used to get the PHY. In the case of dt boot,
> -the string arguments should contain the phy name as given in the dt data and
> -in the case of non-dt boot, it should contain the label of the PHY.
> -The only difference between the two APIs is that devm_phy_get associates the
> -device with the PHY using devres on successful PHY get. On driver detach,
> -release function is invoked on the the devres data and devres data is freed.
> +struct phy *devm_phy_optional_get(struct device *dev, const char *string);
> +
> +phy_get, devm_phy_get and devm_phy_optional_get can be used to get the
> +PHY. In the case of dt boot, the string arguments should contain the
> +phy name as given in the dt data and in the case of non-dt boot, it
> +should contain the label of the PHY.  The two devm_phy_get associates
> +the device with the PHY using devres on successful PHY get. On driver
> +detach, release function is invoked on the the devres data and devres
> +data is freed. devm_phy_optional_get should be used when the phy is
> +optional. It does not return an error when the phy cannot be found, it
> +returns NULL.
>  
>  It should be noted that NULL is a valid phy reference. All phy
>  consumer calls on the NULL phy become NOPs. That is the release calls,
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 74d34b5cc75c..4992523111b5 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -390,13 +390,13 @@ struct phy *phy_get(struct device *dev, const char *string)
>  			string);
>  		phy = of_phy_get(dev, index);
>  		if (IS_ERR(phy)) {
> -			dev_err(dev, "unable to find phy\n");
> +			dev_dbg(dev, "unable to find phy\n");
>  			return phy;
>  		}
>  	} else {
>  		phy = phy_lookup(dev, string);
>  		if (IS_ERR(phy)) {
> -			dev_err(dev, "unable to find phy\n");
> +			dev_dbg(dev, "unable to find phy\n");
>  			return phy;
>  		}

Hans de Goede has a patch [1] that deals with this. You might want to have a
look at it.
[1] -> https://groups.google.com/forum/#!msg/linux-sunxi/NfWi6rWcGsA/nw2jUw8KVOEJ
>  	}
> @@ -441,6 +441,29 @@ struct phy *devm_phy_get(struct device *dev, const char *string)
>  EXPORT_SYMBOL_GPL(devm_phy_get);
>  
>  /**
> + * devm_phy_optional_get() - lookup and obtain a reference to an optional phy.
> + * @dev: device that requests this phy
> + * @string: the phy name as given in the dt data or phy device name
> + * for non-dt case
> + *
> + * Gets the phy using phy_get(), and associates a device with it using
> + * devres. On driver detach, release function is invoked on the devres data,
> + * then, devres data is freed. This differs to devm_phy_get() in that if the
> + * phy does not exist, it is not considered an error. Instead the NULL phy
> + * is returned, which can be passed to all other phy consumer calls.

It doesn't explain how devm_phy_optional_get is different from phy_get :-s
> + */
> +struct phy *devm_phy_optional_get(struct device *dev, const char *string)
> +{
> +	struct phy *phy = devm_phy_get(dev, string);
> +
> +	if (PTR_ERR(phy) == -ENODEV)
> +		phy = NULL;

Do we need an API in phy-core to handle this? Can't this be done in the
controller driver itself?

Cheers
Kishon
