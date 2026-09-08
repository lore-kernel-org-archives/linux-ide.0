Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B30376BD9
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848042; cv=none; b=VhGCQapU0RKkkExjbu710w2FdhEbrblcFMSi1TiNnLkZ8CtQAcosDJhukPp2rRJYTiRPza/BBrYyhFPmcqvRYaSWftU9iDnAZm6jBC0gMnfH+K55IB5ZKhrOZ5E/kKUPlavxWTfdK9qo6ZSMP5k+ELT/c/OwQOPpYYmtK6Jnr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848042; c=relaxed/simple;
	bh=VgdneZKogJb/wFIuEYgaukspdWs8qdPSnxlEMbg7010=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DQEnCy6gG7V21EP6Mmh9lYIDHPHEhOGJUiaRhzxXSEdddudN0ZhM0nCZM4WJU/6Lwf04QxHgWkl1VYV1J8cfNeeY9qwDdzgsyGeE5IqBnQQ6+kIVXYUoklNoqrqKkl/iyphLzW/rk7HBfY9uDtMbyxyBrn3yW/NAv65bzphZxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjhQuuG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjhQuuG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823FF1F00A3A;
	Tue,  8 Sep 2026 06:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788848040;
	bh=pGl4qeX9YHL7LovHTr42dyjVb4Kh+JP86/KTn71sCro=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=hjhQuuG4vNrFZ5gK8LU8Enb8sSPUHoBc0lq8C2GzNk1xmgZ4w5MQm58Bvv9ZZWkQn
	 I+J6g/Vxnvmrb8a7c0UjIinIWRVeAVzxYjXGJO67CEH/6BALsrwykgA6JJopPZ4ese
	 qJv21YXB2bS+i0P3QfV2YSY1tnJTGvGRuB6WDouoDgQ+894xOrASfLwbUQ2CAcJBQS
	 /ifMNPQT75yyUldaRYRpwIenC2FKUeRK6jRBURvgEaubcumfVNk4oK1qjeIvqhwfb8
	 AQVMBvFjrBfjcA19E5dqePyGNf2JX4uyHYEMATyWg0OKaXYKCBprvDU11HaCnKkkP0
	 Ur4d9UqJ8r8vQ==
Message-ID: <e0412d20-6503-4737-8c9c-94f44f2c397a@kernel.org>
Date: Tue, 8 Sep 2026 15:13:49 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
To: Li Jun <lijun01@kylinos.cn>, cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260908061025.3580261-1-lijun01@kylinos.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260908061025.3580261-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 15:10, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
> DEFINE_SIMPLE_DEV_PM_OPS. Use pm_ptr(&ahci_da850_pm_ops) to complete
> the API migration and allow the structure to be correctly dropped
> when CONFIG_PM=n.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> changelogs:
> -add pm_ptr for ahci_da850_pm_ops in ahci_da850_driver.
> -revise grammar and alignment issues.
> ---
>  drivers/ata/ahci_da850.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> index 4e53ff96d712..469cf015bbf0 100644
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c
> @@ -218,8 +218,8 @@ static int ahci_da850_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> -			 ahci_platform_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> +								ahci_platform_resume);

You resent the same v3... Did you mean to send a fixed v4? Or is it me for some
reason getting the same patch email twice?

>  
>  static const struct of_device_id ahci_da850_of_match[] = {
>  	{ .compatible = "ti,da850-ahci", },
> @@ -233,7 +233,7 @@ static struct platform_driver ahci_da850_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
>  		.of_match_table = ahci_da850_of_match,
> -		.pm = &ahci_da850_pm_ops,
> +		.pm = pm_ptr(&ahci_da850_pm_ops),
>  	},
>  };
>  module_platform_driver(ahci_da850_driver);


-- 
Damien Le Moal
Western Digital Research
