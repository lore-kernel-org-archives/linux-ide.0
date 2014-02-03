From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [patch v2 1/3] drivers: phy: Make NULL a valid phy reference
Date: Mon, 03 Feb 2014 22:15:12 +0100
Message-ID: <52F006E0.5080903@free-electrons.com>
References: <52EF6D38.4060200@ti.com> <1391450446-15580-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53079 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750789AbaBCVPR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 16:15:17 -0500
In-Reply-To: <1391450446-15580-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: tj@kernel.org, kishon@ti.com, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

On 03/02/2014 19:00, Andrew Lunn wrote:
> The common clock framework considers NULL a valid clock
> reference. This makes handling optional clocks simple, in that if the
> optional clock is not available, a NULL reference can be used in the
> place of a real clock, simplifying the clock consumer.
> 
> Extend this concept to the phy consumer API. A NULL can be passed to
> the release calls, the phy_init() and phy_exit() calls, and
> phy_power_on() and phy_power_off() and a NOP is performed.
> 
Hi Andrew,

I have tested these 3 patches on severals Armada 370/XP boards:
 - Mirabox
 - Armada 370 DB
 - OpenBlocks AX3
 - Armada XP GP

For all this boards without these series the kernel crash
during boot on v3.14-rc1.
With this series (and "ATA: SATA_MV: Add missing Kconfig
select statememnt" patch), the kernel boot fine on all
these boards.

You can add my

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

for the whole series.


Thanks,

Gregory




> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2
> No change.
> ---
>  Documentation/phy.txt  |  6 ++++++
>  drivers/phy/phy-core.c | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
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
> index 645c867c1257..56535253e50c 100644
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
> @@ -308,6 +320,9 @@ err0:
>   */
>  void phy_put(struct phy *phy)
>  {
> +	if (!phy)
> +		return;
> +
>  	if (IS_ERR(phy))
>  		return;
>  
> @@ -328,6 +343,9 @@ void devm_phy_put(struct device *dev, struct phy *phy)
>  {
>  	int r;
>  
> +	if (!phy)
> +		return;
> +
>  	r = devres_destroy(dev, devm_phy_release, devm_phy_match, phy);
>  	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
>  }
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
