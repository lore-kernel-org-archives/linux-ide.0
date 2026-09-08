Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509CE339875
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839034; cv=none; b=fZcDolvUfAqTcIeHLyaLoRmeYSmnmzbE3deS9i6WPv/UbKFozKOzfybP7xS8syYlFcr1ImqByZgCzxNpEQJzOIky4hk75y21kKnU5xs5hvClXsPnPJRXVT21VuoRLd6XhGUQMcevSBT43hgSOQsAJJDJOvLK0RK+oGS5TkGU5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839034; c=relaxed/simple;
	bh=x90hTFtavXAkDDvoAfESNR/8HQXEEkyANCimGgj7BJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DU89eFwrTy2wUY8PuiL1TU5e8iqKYIA+4rkPnnJPR0KOdBdJqOD9ytpXbgav5rOd3F6ZDPaInrVVUXXQA6b2KoAcYnbY9f/j+p8OmhcKbljLKPP18oJyhHzwKQi28unpCKcP02aLbBd/CBVzLayGn5/urbh7yRW+JwwWMnx8w7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck5bUxcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck5bUxcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB441F00A3A;
	Tue,  8 Sep 2026 03:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839022;
	bh=w7eDQn4GyA2ZYRJIGWAo/GqneViKNRHzm0I3MA+L68g=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=ck5bUxcA3wWG66/rdGpsQWwVI6v3xZU17eDkSUdapvTySjvhxWYxMH7ZM/UeanhjE
	 2NC8R7yKIqJqH/DC4mDqerXBlaYpr0/AHZARunY59dPOpD5g26YPpQ6UUdcmi+RH6S
	 rlNJ5yMMN0BZekoyVhh77FyttlR/ZkTYHAF9Iz5SYAWs1cr9ovuliiu82pOFSol/gI
	 2Lyd7dQcCiVGPM3PzRJpImbpVdo8sFHheMgs5koTiKmynOnA3AJlnuMDWlP7ax8aDb
	 /hakG0qRx6qb02Qqn0LKgKeVVRvabq22p15XxLB/mwlwABsVfb4TO1mh+hnfKbbCWp
	 L4fXCH8qlXnPQ==
Message-ID: <e67aace9-3326-40bd-b8a7-e0bbc109d7f2@kernel.org>
Date: Tue, 8 Sep 2026 12:43:30 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
To: Li Jun <lijun01@kylinos.cn>, cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260908025915.955528-1-lijun01@kylinos.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260908025915.955528-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 11:59, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
> DEFINE_SIMPLE_DEV_PM_OPS.use pm_ptr(&ahci_da850_pm_ops) to complete

Please add a space after the period and capitalize the first letter of the
sentence:

s/.use/. Use/

> the API migration and allow the structure to be correctly dropped
> when CONFIG_PM=n.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
> changelogs:
> -add pm_ptr for ahci_da850_pm_ops in ahci_da850_driver.
> ---
>  drivers/ata/ahci_da850.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> index 4e53ff96d712..0b390395679e 100644
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c
> @@ -218,7 +218,7 @@ static int ahci_da850_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> +static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
>  			 ahci_platform_resume);

Please align this to ahci_da850_pm_ops.

With both nits fixed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

>  
>  static const struct of_device_id ahci_da850_of_match[] = {
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
