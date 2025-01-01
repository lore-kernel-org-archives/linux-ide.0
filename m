Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AB6EB4C
	for <linux-ide@vger.kernel.org>; Wed,  1 Jan 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735737470; cv=none; b=PJakftdFLxw7TJbrRnd9rt+iLZE+vL9Zb5GyXdmHgQh94tZw1tMcbtywZ/2J1TR5N+uAmoGElf0h86br7nWkmfA2zN1tNYwLmTKNhxSdRMjohrpIw/eIX5LaVJhFySkXpLqELP0zfLFgtFttAOUQ/bpKvW2C6aC1ZGIFKvy0cyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735737470; c=relaxed/simple;
	bh=ixX7qyjxqZ/skPuOAARHF/wKpY4NVvwN2fVdlCvcTEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CX/6gbLOOmIMa3HlzzCl6GJqxoCkIhVx20ADx2Ecea1+9NtGXLgrejLc4zYQqcNFt/SmPpzzI05KBZ12vlPQfvtADStqZpyaEwkmFNPkgimDFSHSHko+cebYmOWgP7yOb4cVq2gHi6cUaAI0UargLYrdyWfQlG0IvqyKSqpEyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZemmI30; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZemmI30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735737467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdtH4xMgq79NWqmc3ENKcTXjEF87R3+/z7Jf7Zna/mA=;
	b=cZemmI30mZErGipM8X2xvcBWV2wf09FQ+eTWSlKE2WXi1x36eAQBfCow0w81k62G1YZYQm
	KbHt7JdMkZlAfCTPuZoQf0ZKClCCk5m9VNu+ySuQkNzIXaiazhAs3ol/DlLq7691k1g4Wn
	W8tM5jqTBvybSsuQYT5zQUkacHtwMHs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-Nyb0mT-UOUmQ5IpgWv-cnQ-1; Wed, 01 Jan 2025 08:17:46 -0500
X-MC-Unique: Nyb0mT-UOUmQ5IpgWv-cnQ-1
X-Mimecast-MFC-AGG-ID: Nyb0mT-UOUmQ5IpgWv-cnQ
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3eea3b9aaso8655990a12.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Jan 2025 05:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735737465; x=1736342265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdtH4xMgq79NWqmc3ENKcTXjEF87R3+/z7Jf7Zna/mA=;
        b=B/xRyL06Vb5oLPRebcJirhi8urKWuXcIUKJzj1t8FcbU/MXTpQunqMmrt5ij/t5SiP
         Opp7skaCXFZ4r6ptTU6pvIbL3zfTpuD8l19voo8f7WoLlKmb/1d5XbS9AK6cvKjctD2O
         P+KTGefQE5YVil0M3u2PvfhTfPOQq1avf7TW/zRkYEF8lMQkJjNzk/wCpqSVhj6RtdFp
         osfKjdeCNz5gBMeC/CWWYILaDPlJfvXL3nKeqAQaymn2sIMUT1TxEKn/oEyf4jOwbL8N
         BxAKmfuUthO07zVfMl/NcSOGG1HdCjPs36KFp6LZJw81//3lc8Jv+IIPYHW13/hm2tuY
         6D3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCllfB1gZzZSNMugbUey5m4J37LdgNhJ22fPcTzh5YyAOuERiXHhAiNrh9OJZAcD3NdoNAucbpTUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvn/zdBy7OYOQscOnbbQW0pbTFJ3ozDtbCblflMP0PYU5trVVb
	N/DyT4MkwWrjPMMRTvTeR7KP4j5DFml1blWHaWoI+y63yxTdVFHq8sZCTl9f3yjjZ/pNX5oXM7f
	2EBEHC8z8FPJNG7bUEpLt5pxB4PhvU6pb03N5YNBzGSZcBPm6FtqDgvuvFA==
X-Gm-Gg: ASbGncuQjOBCUpdib0x+TyuPZza5qol1qhYGFMlmXnyQ6OjLupuPuhFs9AUUjQCdTtg
	k1HlUWu/A5QTxX61qbClrocXcj8mdQ8999MhYVmXzF/p8iyUjGkoPh/6dbBxUfvivHlIDTmQlu7
	AXterH2QmIF+owOefGlpVcoasQHynX7Y4b+ZEWNoex5/nPAbv7QIGr62A4DwKXF0NGNS9gLwpxS
	FLh3bfk7o73h8wbYOY2WO8GJNCjRrqN7QVQfwoFTtVbN8YBcrjQIPvVkY1NWYA6vqfVa4sjJWxt
	8/BJ25bY3j2roUFM0XIzwF9eWcz/PyCRZMaBH8GKdVOiAg04CwLC19XVHeCN0oQ5FMGTvLuxh8G
	rUdTojjCCsEOGPjMkD0zC3Dl/mey3+RA=
X-Received: by 2002:a05:6402:348d:b0:5d4:55e:f99e with SMTP id 4fb4d7f45d1cf-5d81ddc09abmr103470001a12.18.1735737464645;
        Wed, 01 Jan 2025 05:17:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdCBwtw97xzPOk9qyTTaI2maqcHkPkM+Pgw14Sq2jlL5CfdRtD/bzo6aazyjdwlErmyY9tEQ==
X-Received: by 2002:a05:6402:348d:b0:5d4:55e:f99e with SMTP id 4fb4d7f45d1cf-5d81ddc09abmr103469931a12.18.1735737464173;
        Wed, 01 Jan 2025 05:17:44 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c6dfsm17321709a12.37.2025.01.01.05.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2025 05:17:42 -0800 (PST)
Message-ID: <b3d1fbad-9fb2-4253-9180-46fa909a4b86@redhat.com>
Date: Wed, 1 Jan 2025 14:17:41 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
To: Josua Mayer <josua@solid-run.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1-Jan-25 1:13 PM, Josua Mayer wrote:
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
> Update all accessesors of ahci_host_priv phys and target_pwrs arrays to
> support holes. Access is gated by hpriv->mask_port_map which has a bit
> set for each enabled port.
> 
> Update ahci_platform_get_resources to ignore holes in the port numbers
> and enable ports defined in firmware by their reg property only.
> 
> When firmware does not define children it is assumed that there is
> exactly one port, using index 0.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v2:
> - reverted back to dynamically allocated arrays
>   (Reported-by: Damien Le Moal <dlemoal@kernel.org>)
> - added helper function to find maximum port id
>   (Reported-by: Damien Le Moal <dlemoal@kernel.org>)
> - reduced size of changes
> - rebased on 6.13-rc1
> - tested on 6.13-rc1 with CN9130 Clearfog Pro
> - Link to v1: https://lore.kernel.org/r/20241121-ahci-nonconsecutive-ports-v1-1-1a20f52816fb@solid-run.com

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/ata/ahci_brcm.c        |  3 +++
>  drivers/ata/ahci_ceva.c        |  6 ++++++
>  drivers/ata/libahci_platform.c | 40 ++++++++++++++++++++++++++++++++++------
>  3 files changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index ef569eae4ce4625e92c24c7dd54e8704b9aff2c4..24c471b485ab8b43eca21909ea16cb47a2a95ee1 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -288,6 +288,9 @@ static unsigned int brcm_ahci_read_id(struct ata_device *dev,
>  
>  	/* Re-initialize and calibrate the PHY */
>  	for (i = 0; i < hpriv->nports; i++) {
> +		if (!(hpriv->mask_port_map & (1 << i)))
> +			continue;
> +
>  		rc = phy_init(hpriv->phys[i]);
>  		if (rc)
>  			goto disable_phys;
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index 1ec35778903ddc28aebdab7d72676a31e757e56f..f2e20ed11ec70f48cb5f2c12812996bb99872aa5 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -206,6 +206,9 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
>  		goto disable_clks;
>  
>  	for (i = 0; i < hpriv->nports; i++) {
> +		if (!(hpriv->mask_port_map & (1 << i)))
> +			continue;
> +
>  		rc = phy_init(hpriv->phys[i]);
>  		if (rc)
>  			goto disable_rsts;
> @@ -215,6 +218,9 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
>  	ahci_platform_deassert_rsts(hpriv);
>  
>  	for (i = 0; i < hpriv->nports; i++) {
> +		if (!(hpriv->mask_port_map & (1 << i)))
> +			continue;
> +
>  		rc = phy_power_on(hpriv->phys[i]);
>  		if (rc) {
>  			phy_exit(hpriv->phys[i]);
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 7a8064520a35bd86a1fa82d05c1ecaa8a81b7010..b68777841f7a544b755a16a633b1a2a47b90da08 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -49,6 +49,9 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>  	int rc, i;
>  
>  	for (i = 0; i < hpriv->nports; i++) {
> +		if (!(hpriv->mask_port_map & (1 << i)))
> +			continue;
> +
>  		rc = phy_init(hpriv->phys[i]);
>  		if (rc)
>  			goto disable_phys;
> @@ -70,6 +73,9 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>  
>  disable_phys:
>  	while (--i >= 0) {
> +		if (!(hpriv->mask_port_map & (1 << i)))
> +			continue;
> +
>  		phy_power_off(hpriv->phys[i]);
>  		phy_exit(hpriv->phys[i]);
>  	}
> @@ -88,6 +94,9 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
>  	int i;
>  
>  	for (i = 0; i < hpriv->nports; i++) {
> +		if (!(hpriv->mask_port_map & (1 << i)))
> +			continue;
> +
>  		phy_power_off(hpriv->phys[i]);
>  		phy_exit(hpriv->phys[i]);
>  	}
> @@ -432,6 +441,20 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
>  	return 0;
>  }
>  
> +static u32 ahci_platform_find_max_port_id(struct device *dev)
> +{
> +	u32 max_port = 0;
> +
> +	for_each_child_of_node_scoped(dev->of_node, child) {
> +		u32 port;
> +
> +		if (!of_property_read_u32(child, "reg", &port))
> +			max_port = max(max_port, port);
> +	}
> +
> +	return max_port;
> +}
> +
>  /**
>   * ahci_platform_get_resources - Get platform resources
>   * @pdev: platform device to get resources for
> @@ -458,6 +481,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	struct device *dev = &pdev->dev;
>  	struct ahci_host_priv *hpriv;
>  	u32 mask_port_map = 0;
> +	u32 max_port;
>  
>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
>  		return ERR_PTR(-ENOMEM);
> @@ -549,15 +573,17 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		goto err_out;
>  	}
>  
> +	/* find maximum port id for allocating structures */
> +	max_port = ahci_platform_find_max_port_id(dev);
>  	/*
> -	 * If no sub-node was found, we still need to set nports to
> -	 * one in order to be able to use the
> +	 * Set nports according to maximum port id. Clamp at
> +	 * AHCI_MAX_PORTS, warning message for invalid port id
> +	 * is generated later.
> +	 * When DT has no sub-nodes max_port is 0, nports is 1,
> +	 * in order to be able to use the
>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>  	 */
> -	if (child_nodes)
> -		hpriv->nports = child_nodes;
> -	else
> -		hpriv->nports = 1;
> +	hpriv->nports = min(AHCI_MAX_PORTS, max_port + 1);
>  
>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>  	if (!hpriv->phys) {
> @@ -625,6 +651,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
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
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241121-ahci-nonconsecutive-ports-a8911b3255a7
> 
> Best regards,

