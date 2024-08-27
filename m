Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E443AA4
	for <linux-ide@vger.kernel.org>; Tue, 27 Aug 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745217; cv=none; b=njZj5SjInWCNMYMxmK/3YjW6tPTPi1SaSb4+N6MCl0fjHvaEsntX07Ffh6doMAOZh3XjnX1602hxr5ss09tAzn19sp+m2BDFDoYg6uVT2TB4vv/Cw0e1sVMVgPW45BVOQ/dxmXljaR9S7x4aur2VqnyZmhC4b4cJQTh19tb1u/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745217; c=relaxed/simple;
	bh=4iXgUTqZJBG0w9sKPz3+UeTjFYdYj8v+iNqp4O93c7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y5JSDzmrTyg92Tul4h61AfDa7vYSHw9SurYaqHBs0gJyXizobpty+N3wzbpfhAEOxBwqjRdW+yIQ7ulLF4I3jrcHmy76ukFHNYg0cuvJEToCwi+wQkm87ZoqOKCzTDmW5hJjPfsP84ZPlslOX80rk3Qn6C4VWMVLPVDoNBxau3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfdBQ9eQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfdBQ9eQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35D4C8B7A1;
	Tue, 27 Aug 2024 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724745217;
	bh=4iXgUTqZJBG0w9sKPz3+UeTjFYdYj8v+iNqp4O93c7A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VfdBQ9eQobiqmQJm4DUhRFeJ9rGmkyXptnjwzbGu5PhHizVa7FRPXEv9tBhpKBeoA
	 zQDwpRCLabGk3PDAVrkzJ+r0rLo6RDw/Rcc/MRPfokvA2o+tldlxd9wOmuYbsJBINb
	 XABC/sFespwjfMer6/jbmClJSLQKXLv2VQNxaZ4Vae2PERbuvJl/hJVErnCxNm/uD3
	 WlQalIP0SADT1GpL2NGbViL9EngV0dPzNW7IPVRccEMbrilV/WP0nA9xadALpabnV7
	 FTEkY7ngwC7bwaUpE+YX5iG3jE1AaWBsvGiJs2uLBVE05sZyDrCZOWq+0VxZ8FnUc1
	 T7vMV5JNmdLYQ==
Message-ID: <f405e1fc-26e2-4846-aed8-d0fdea3efb78@kernel.org>
Date: Tue, 27 Aug 2024 16:53:35 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: Use devm_platform_ioremap_resource_byname()
 helper function
To: Zhang Zekun <zhangzekun11@huawei.com>, cassel@kernel.org,
 linux-ide@vger.kernel.org
References: <20240827072005.45181-1-zhangzekun11@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240827072005.45181-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 16:20, Zhang Zekun wrote:
> platform_get_resource_byname() and devm_ioremap_resource() can be
> replaced by devm_platform_ioremap_resource_byname(), which can
> simplify the code logic a bit, No functional change here.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Looks good, but since this modifies the ahci_brcm driver, the patch title should be:

ata: ahci_brcm: Use devm_platform_ioremap_resource_byname() helper function

Please resend with that fixed.

> ---
>  drivers/ata/ahci_brcm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 70c3a33eee6f..2f16524c2526 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -437,7 +437,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct brcm_ahci_priv *priv;
>  	struct ahci_host_priv *hpriv;
> -	struct resource *res;
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -451,8 +450,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	priv->version = (unsigned long)of_id->data;
>  	priv->dev = dev;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "top-ctrl");
> -	priv->top_ctrl = devm_ioremap_resource(dev, res);
> +	priv->top_ctrl = devm_platform_ioremap_resource_byname(pdev, "top-ctrl");
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
>  

-- 
Damien Le Moal
Western Digital Research

