Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A70174EE4
	for <linux-ide@vger.kernel.org>; Fri,  9 Aug 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217131; cv=none; b=V7WUZUwq6+bP5Zll32isxQI00vQDCzWhzfhoE8xDx9/Tb62TRd7//J47MHgUxZIgO0zoxDlEQOqcuW87z0L3i+m4oGDYvGhhnrb81C35qLFIqaZz+o4NLSVmPnlJZMaklV7Fyjbj7djijgAJ5EQG08Fd37K/LKgDMd3Uh6b8Jz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217131; c=relaxed/simple;
	bh=SFHmEof4R2t0kVGYMl2CPsCNGwhtVA9ARVbLm40Gu0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ESu2jmij8eWNQ53sIoaPw+u1vZgzSHGOuFSFnEiKyOaCt/ZLLMyZMGcMM8QCfVlNuAlwd20HEkA2gVFPH4Ul1wTGb9tMWa6Nx1WMy7S/8Kqq42IqQBrgrkK+z2FYzMO6P8HinsLE+DM047eC3qmmPowE8wszk5KAjGjkC8v1RGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teXUxV+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teXUxV+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198A6C32782;
	Fri,  9 Aug 2024 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723217131;
	bh=SFHmEof4R2t0kVGYMl2CPsCNGwhtVA9ARVbLm40Gu0I=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=teXUxV+PSzux0itQ3GH2fuXFcjHcjVTWdqcPTHBlpBd2Y+0h3LcHS58DKv1qpM6NN
	 pFP473Wt63AD00IP5wQaQ1jBdJHD1Scu9Nh4vr/O/nA/u6TvdNezy3an2j8BRpQJ2f
	 eOb4uDNlFtXR56oo3dfgm3Yl+XGYSZp+QbyYqnYkJg16pmuVI2cqRyZ9lyNrHi9VPS
	 8vKEHsUZRBrSIV5FDcgl49FHIfuJwZMI+Zi3GwJiqshfYNYH7MlwBf/8Qpu16QSHmb
	 /yAV2v9nX+YUh52lLDkQF3TaEnL8WqiOtZgpns5ewEsUG15khTMdT+qsI/v0UUBkSu
	 3b0qd38aQoAzw==
Message-ID: <5c5f5501-1b91-4c83-87dc-db0ce8513b8d@kernel.org>
Date: Fri, 9 Aug 2024 08:25:30 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libahci_platform: Simplify code with
 for_each_child_of_node_scoped()
To: Zhang Zekun <zhangzekun11@huawei.com>, hdegoede@redhat.com,
 axboe@kernel.dk, cassel@kernel.org, linux-ide@vger.kernel.org
References: <20240808013003.116211-1-zhangzekun11@huawei.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240808013003.116211-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/07 18:30, Zhang Zekun wrote:
> for_each_child_of_node_scoped() can put the device_node
> automaticlly. So, using it to make the code logic more simple
> and remove the device_node clean up code.


s/automaticlly/automatically

And in my previous email, I did suggest a change to the second sentence. Please
pick that up as well.

> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
> v2: Improve the patch subject 
> 
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

