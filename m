From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [Patch v4 1/3] drivers: phy: Make NULL a valid phy reference
Date: Wed, 5 Feb 2014 00:14:40 -0500
Message-ID: <20140205051440.GP8533@titan.lakedaemon.net>
References: <1391535193-24165-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63038 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbaBEFOr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Feb 2014 00:14:47 -0500
Content-Disposition: inline
In-Reply-To: <1391535193-24165-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: tj@kernel.org, kishon@ti.com, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

Kishon,

On Tue, Feb 04, 2014 at 06:33:11PM +0100, Andrew Lunn wrote:
> The common clock framework considers NULL a valid clock
> reference. This makes handling optional clocks simple, in that if the
> optional clock is not available, a NULL reference can be used in the
> place of a real clock, simplifying the clock consumer.
> 
> Extend this concept to the phy consumer API. A NULL can be passed to
> the release calls, the phy_init() and phy_exit() calls, and
> phy_power_on() and phy_power_off() and a NOP is performed.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> v2
>  No change.
> v4
>  combine !phy and IS_ERR().
>  Add Tested-by
> ---
>  Documentation/phy.txt  |  6 ++++++
>  drivers/phy/phy-core.c | 17 ++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)

Looking over the overall diffstat (there isn't one, Andrew, please don't
forget the coverletter in the future), this series is predominately
changing the phy subsystem.  However, since it's fixing a boot failure
in the arm-soc bootfarm, we'd like to get it into our tree without
pulling in a bunch of unnecessary changes (eg by pulling in -rc2 or
-rc3).

Could you create a topic branch with this series in it we could base off
of?  Or, could you Ack it so we could take it through arm-soc?

thx,

Jason.

> diff --git a/Documentation/phy.txt b/Documentation/phy.txt
> index 0103e4b15b0e..2e24b993e95f 100644
> --- a/Documentation/phy.txt
> +++ b/Documentation/phy.txt
> @@ -84,6 +84,12 @@ The only difference between the two APIs is that devm_phy_get associates the
>  device with the PHY using devres on successful PHY get. On driver detach,
>  release function is invoked on the the devres data and devres data is freed.
>  
> +It should be noted that NULL is a valid phy reference. All phy
> +consumer calls on the NULL phy become NOPs. That is the release calls,
> +the phy_init() and phy_exit() calls, and phy_power_on() and
> +phy_power_off() calls are all NOP when applied to a NULL phy. The NULL
> +phy is useful in devices for handling optional phy devices.
> +
>  5. Releasing a reference to the PHY
>  
>  When the controller no longer needs the PHY, it has to release the reference
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 645c867c1257..a9cdeee20d91 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -162,6 +162,9 @@ int phy_init(struct phy *phy)
>  {
>  	int ret;
>  
> +	if (!phy)
> +		return 0;
> +
>  	ret = phy_pm_runtime_get_sync(phy);
>  	if (ret < 0 && ret != -ENOTSUPP)
>  		return ret;
> @@ -187,6 +190,9 @@ int phy_exit(struct phy *phy)
>  {
>  	int ret;
>  
> +	if (!phy)
> +		return 0;
> +
>  	ret = phy_pm_runtime_get_sync(phy);
>  	if (ret < 0 && ret != -ENOTSUPP)
>  		return ret;
> @@ -212,6 +218,9 @@ int phy_power_on(struct phy *phy)
>  {
>  	int ret;
>  
> +	if (!phy)
> +		return 0;
> +
>  	ret = phy_pm_runtime_get_sync(phy);
>  	if (ret < 0 && ret != -ENOTSUPP)
>  		return ret;
> @@ -240,6 +249,9 @@ int phy_power_off(struct phy *phy)
>  {
>  	int ret;
>  
> +	if (!phy)
> +		return 0;
> +
>  	mutex_lock(&phy->mutex);
>  	if (phy->power_count == 1 && phy->ops->power_off) {
>  		ret =  phy->ops->power_off(phy);
> @@ -308,7 +320,7 @@ err0:
>   */
>  void phy_put(struct phy *phy)
>  {
> -	if (IS_ERR(phy))
> +	if (!phy || IS_ERR(phy))
>  		return;
>  
>  	module_put(phy->ops->owner);
> @@ -328,6 +340,9 @@ void devm_phy_put(struct device *dev, struct phy *phy)
>  {
>  	int r;
>  
> +	if (!phy)
> +		return;
> +
>  	r = devres_destroy(dev, devm_phy_release, devm_phy_match, phy);
>  	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
>  }
> -- 
> 1.8.5.2
> 
