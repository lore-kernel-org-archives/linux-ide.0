Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADA4C92;
	Thu,  9 Jul 2026 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561565; cv=none; b=SGMznsSaJEY53whZgw9mjaqhAIjBP2hyPGm/0EObL4p5iS8eEH/uYVuGaQMTPBM5Myq1M6C2rlWvJwKoIBU3xOYaoWurSJcl14ur8P197lb2p2ZTdo6cEzgGJRKifTgMHHA7MONd2yfFJKHoU2UaK2yNFwx7expr5AidbHih+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561565; c=relaxed/simple;
	bh=DR8X5zaNrKf6BYWhCCetz0BnEZVpPGDUjNGzMEg3f6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1Am7vNjWxFi+JUYWXi0guJO0mcKY0mw31ooAKmem/Y6hg2tY0koBvNrBxWQx8teOmp4EGLYj5YXJAxndaBfACZuGMhKU1VHBcD/I2+gq1sTNDy52JB8gcEkw2QB0sgJbHbtKxjL0JdvEqFYkfITCGvKp/0mwBaQm73MgVGk5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi5NpEkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi5NpEkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126951F000E9;
	Thu,  9 Jul 2026 01:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783561563;
	bh=38lzQVtLK1f896sVDna6Kx/bR/F+pTnKgLwVlMoTKSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zi5NpEkSqtWtRh2ITrpUWJOH7vGSQVm7we2tvwQe7hawfo1u1jByGsEblN+t5JpTt
	 EDSZEeA6r6xDN5STYftpSleH6DsX9Sb98AUgvnkqi0PXqqsPpYKz8vnTKMNSNaB7BO
	 tftp32kfFtIBPTcuK+1U1fga/8ownuh2QHJ5E8C4m5eT3hFuO9GTe81X1CdvJon0Ef
	 NBaGvn1oG41QgfG1ZZ0k0Rx4Vxi+fIn81bIk5eDfWW9cgFIsEaCqrF/AQ1K4/m5EZT
	 OJ0fLl1tJ9+gycJfliZaAgvhaxqfkYYxwy3Jaa4wGie7g9q6DSERcWYSWxRPV/zZ10
	 vXuIyCWqzyFlQ==
Message-ID: <261cd548-8e48-483f-8469-9155988b284d@kernel.org>
Date: Thu, 9 Jul 2026 10:46:01 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci_platform: use of_platform_device_create()
 return value
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260709014230.1905756-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260709014230.1905756-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 10:42, Rosen Penev wrote:
> of_platform_device_create() already returns the struct platform_device
> pointer, so there is no need for a separate of_find_device_by_node()
> call. Use the return value directly.
> 
> Avoids having to free the reference from of_find_device_by_node().

Looks OK to me, but how is the above comment relevant? I do not see any change
that can be described with this sentence. Maybe remove it? (I can do it when
applying)

> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 6e072d681341..2aa3df58fc9a 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -617,10 +617,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  			mask_port_map |= BIT(port);
>  
>  #ifdef CONFIG_OF_ADDRESS
> -			of_platform_device_create(child, NULL, NULL);
> -
> -			port_dev = of_find_device_by_node(child);
> -
> +			port_dev = of_platform_device_create(child, NULL, NULL);
>  			if (port_dev) {
>  				rc = ahci_platform_get_regulator(hpriv, port,
>  								&port_dev->dev);


-- 
Damien Le Moal
Western Digital Research
