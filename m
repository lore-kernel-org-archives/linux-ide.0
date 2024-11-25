Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A3624;
	Mon, 25 Nov 2024 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732497141; cv=none; b=grAFery+WPnR+hkq+O4j5gPGeUYGdsXnvFi08PSrnQOcPEz+Px0FmTGKiXfUNFUMkX6B2DmLc0EVQCVHv6wO2IdI2YTQ+YOaf/pabZ91ASH08ZsnOcHpB2lFMVDHf2vOdfULWJlC7qHkCMAx/mMs3m/4eay9Oum7jhgqpPJGkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732497141; c=relaxed/simple;
	bh=7Khz0YV/QMX/+KytrGaz9YGDYG82vqLc5hFXwricj5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNGNGN4V8LDXLyWbWe4lExVfKF/CseWvAW7haljCB6/1SfTO3ufoouoEn7x3BzO4Vbu2He8NAjsous2mF9FQSIsDMdm6LfkYmktucTip5dCehzVE3oKJivoWa/yqxal5tBSfmUqdVhrQZf7vOF4NoIvr6qb8NJDDmhm05Z7TDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyRiIf62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyRiIf62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B142C4CECC;
	Mon, 25 Nov 2024 01:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732497140;
	bh=7Khz0YV/QMX/+KytrGaz9YGDYG82vqLc5hFXwricj5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TyRiIf6290ysu3cL8x1wYsW4feRBA+Puz3JoXw8viAtzpdNEyJZDTr6yX9T7KI1Go
	 h3jjoB0NUPhRkGZeu8fy2BzBFqdp5J3XwubAAlhonzFz6XFL5vE9h+q5ePMSFcwmRj
	 Nv+PTlysf1uKNw3fcoDrN8PFIP4oyi9SVPJ0Kty/ARZN70xZ/OVOcXdnWc01JwvFPW
	 2EDoO03GxmOzkbaLnfKA+XamgbfYgJZDoCUt9r3OA1Qe5MUBfGGMdbkmzid8QUmxia
	 yb9x549gi4pg+hXsjMYKGBrm6ua3iAlcACg/1GitSSIkG3f6x8G2TaLtVj94VQgEfn
	 cNKSMdwiwc+sw==
Message-ID: <e767272d-1cc4-4945-82d1-efd88c724e06@kernel.org>
Date: Mon, 25 Nov 2024 10:12:05 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] ata: libahci_platform: support non-consecutive port
 numbers
To: Josua Mayer <josua@solid-run.com>, Niklas Cassel <cassel@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121-ahci-nonconsecutive-ports-v1-1-1a20f52816fb@solid-run.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241121-ahci-nonconsecutive-ports-v1-1-1a20f52816fb@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/24 12:05 AM, Josua Mayer wrote:
> So far ahci_platform relied on number of child nodes in firmware to
> allocate arrays and expected port numbers to start from 0 without holes.
> This number of ports is then set in private structure for use when
> configuring phys and regulators.
> 
> Some platforms may not use every port of an ahci controller.
> E.g. SolidRUN CN9130 Clearfog uses only port 1 but not port 0, leading
> to the following errors during boot:
> [    1.719476] ahci f2540000.sata: invalid port number 1
> [    1.724562] ahci f2540000.sata: No port enabled
> 
> Remove from ahci_host_priv the property nports which only makes sense
> when enabled ports are consecutive. It is replaced with AHCI_MAX_PORTS
> and checks for hpriv->mask_port_map, which indicates each port that is
> enabled.
> 
> Update ahci_host_priv properties target_pwrs and phys from dynamically
> allocated arrays to statically allocated to size AHCI_MAX_PORTS.
> 
> Update ahci_platform_get_resources to ignore holes in the port numbers
> and enable ports defined in firmware by their reg property only.
> 
> When firmware does not define children it is assumed that there is
> exactly one port, using index 0.
> 
> I marked this RFC because it was only tested with Linux v6.1, Marvell
> fork, CN9130 Clearfog Pro which has only port number 1 in device-tree.
> Further I am not completely sure if it has severe side-effects on
> other platforms.
> I plan to submit it again after testing on v6.13-rc1, but do welcome
> feedback in the meantime, particularly whether this idea of supporting
> non-consecutive ports is acceptable.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

[...]


> @@ -539,41 +544,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		hpriv->f_rsts = flags & AHCI_PLATFORM_RST_TRIGGER;
>  	}
>  
> -	/*
> -	 * Too many sub-nodes most likely means having something wrong with
> -	 * the firmware.
> -	 */
>  	child_nodes = of_get_child_count(dev->of_node);
> -	if (child_nodes > AHCI_MAX_PORTS) {
> -		rc = -EINVAL;
> -		goto err_out;
> -	}

Why remove this check ? Your platform may not need ti, but it is still valid
for others.

> -
> -	/*
> -	 * If no sub-node was found, we still need to set nports to
> -	 * one in order to be able to use the
> -	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
> -	 */
> -	if (child_nodes)
> -		hpriv->nports = child_nodes;
> -	else
> -		hpriv->nports = 1;

Same here.

> -
> -	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
> -	if (!hpriv->phys) {
> -		rc = -ENOMEM;
> -		goto err_out;
> -	}
> -	/*
> -	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
> -	 * target_pwrs after devm_ have freed memory
> -	 */
> -	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
> -	if (!hpriv->target_pwrs) {
> -		rc = -ENOMEM;
> -		goto err_out;
> -	}

And for platforms that actually have a valid nports with no ID holes, the above
is OK and uses less memory...

Why not simply adding code that checks the ID of the child nodes ? If there are
no ID holes, then nothing need to change. If there are holes, then
hpriv->nports can be set to the highest ID + 1 and you can set
hpriv->mask_port_map as you go. With just that, you should get everything
working with far less changes than you have here.

>  	if (child_nodes) {
>  		for_each_child_of_node_scoped(dev->of_node, child) {
>  			u32 port;
> @@ -587,7 +558,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  				goto err_out;
>  			}
>  
> -			if (port >= hpriv->nports) {
> +			if (port >= AHCI_MAX_PORTS) {
>  				dev_warn(dev, "invalid port number %d\n", port);
>  				continue;
>  			}
> @@ -625,6 +596,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		 * If no sub-node was found, keep this for device tree
>  		 * compatibility
>  		 */
> +		hpriv->mask_port_map |= BIT(0);
> +
>  		rc = ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
>  		if (rc)
>  			goto err_out;
> 
> ---
> base-commit: adc218676eef25575469234709c2d87185ca223a
> change-id: 20241121-ahci-nonconsecutive-ports-a8911b3255a7
> 
> Best regards,


-- 
Damien Le Moal
Western Digital Research
