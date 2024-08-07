Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30281745
	for <linux-ide@vger.kernel.org>; Wed,  7 Aug 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046760; cv=none; b=mgCms3Q/VusUZ9Nym+RmBrnEkowq97nKcxaVTd8bi8oIKxDv3qISC4hiU6d1VDTQmhwbnM+vO8jWhVopzGf2UxofX0lsLN50obssrOL3EpV72nLBiwE6/5YL4YtaADWb22hpxSmNuRkKA3PNnQ/j19sAlwRpMW6d3LWtcovERxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046760; c=relaxed/simple;
	bh=S+QQGREIVVlNEtRYepEWwSkE34U5o4bK79XvbOdtTcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UnBYFszBemm8OILn1ScAd8UtVgN8qjIO6Cr0Y9QjB+HQIcObBqMc5qCmMTn8S2kPG6Wjq8YyVRSJSQfPFSFNla316GWD7MfuOfUu+mNWLeSR7TZ8ohq5/uc0lFJvssnHkv7mex8yuRw+zl7pPkZ92NQNL+pbgbGanEAf/Yc166A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvYImScs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvYImScs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D8BC32781;
	Wed,  7 Aug 2024 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046760;
	bh=S+QQGREIVVlNEtRYepEWwSkE34U5o4bK79XvbOdtTcs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TvYImScsSx7LtyBSBNuA95AFw71zLWlZrjPKC5veZ/7IrODLY2ampw56mU/4NXYqO
	 Q5ytepp2DS/h3OICJEd1P4MidBBdytCHYaI6kNtyrDHyokesu8q5aasodxrWqrfr/W
	 d4XUjJ5sos9vytMsIV1JRv6vUGh9slUqFEZiFztWX8CSoRfOXnLrnAkdlUoDjDGBC3
	 rHm9702lderg/FAowIaSC/zUQ/pPg6Htjmj7VMXzBC+iN7nFun2jOuxarLGPHyw9pm
	 thrnojbVrJDD7+5lGc/slrSDAXgJFIKcypuufcrC6Wrq0vpTnZSw+cLua3Ge8WUkwV
	 zTM2jvMN77e3A==
Message-ID: <d38f6047-ea94-4836-99e9-95ed9ff6b12a@kernel.org>
Date: Wed, 7 Aug 2024 09:05:56 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Using for_each_child_of_node_scoped()
To: Zhang Zekun <zhangzekun11@huawei.com>, mark.rutland@arm.com,
 hdegoede@redhat.com, axboe@kernel.dk, cassel@kernel.org,
 linux-ide@vger.kernel.org
References: <20240807081631.37147-1-zhangzekun11@huawei.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240807081631.37147-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/07 1:16, Zhang Zekun wrote:
> for_each_child_of_node_scoped() can put the device_node
> automaticlly. So, using it to make the code logic more simple
> and remove the device_node clean up code.

So let's use it to make the code simpler by avoiding the need to
explicitly call of_node_put().

> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Please also change the commit title to:

ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()


> ---
>  drivers/ata/libahci_platform.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 581704e61f28..7a8064520a35 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -410,7 +410,6 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>  static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
>  				      struct device *dev)
>  {
> -	struct device_node *child;
>  	u32 port;
>  
>  	if (!of_property_read_u32(dev->of_node, "hba-cap", &hpriv->saved_cap))
> @@ -419,14 +418,12 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
>  	of_property_read_u32(dev->of_node,
>  			     "ports-implemented", &hpriv->saved_port_map);
>  
> -	for_each_child_of_node(dev->of_node, child) {
> +	for_each_child_of_node_scoped(dev->of_node, child) {
>  		if (!of_device_is_available(child))
>  			continue;
>  
> -		if (of_property_read_u32(child, "reg", &port)) {
> -			of_node_put(child);
> +		if (of_property_read_u32(child, "reg", &port))
>  			return -EINVAL;
> -		}
>  
>  		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
>  			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
> @@ -460,7 +457,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
>  	struct device *dev = &pdev->dev;
>  	struct ahci_host_priv *hpriv;
> -	struct device_node *child;
>  	u32 mask_port_map = 0;
>  
>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> @@ -579,7 +575,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	}
>  
>  	if (child_nodes) {
> -		for_each_child_of_node(dev->of_node, child) {
> +		for_each_child_of_node_scoped(dev->of_node, child) {
>  			u32 port;
>  			struct platform_device *port_dev __maybe_unused;
>  
> @@ -588,7 +584,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  
>  			if (of_property_read_u32(child, "reg", &port)) {
>  				rc = -EINVAL;
> -				of_node_put(child);
>  				goto err_out;
>  			}
>  
> @@ -606,18 +601,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  			if (port_dev) {
>  				rc = ahci_platform_get_regulator(hpriv, port,
>  								&port_dev->dev);
> -				if (rc == -EPROBE_DEFER) {
> -					of_node_put(child);
> +				if (rc == -EPROBE_DEFER)
>  					goto err_out;
> -				}
>  			}
>  #endif
>  
>  			rc = ahci_platform_get_phy(hpriv, port, dev, child);
> -			if (rc) {
> -				of_node_put(child);
> +			if (rc)
>  				goto err_out;
> -			}
>  
>  			enabled_ports++;
>  		}

-- 
Damien Le Moal
Western Digital Research

