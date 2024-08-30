Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF368481AB;
	Fri, 30 Aug 2024 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724993477; cv=none; b=EN/JfxNDgiF+H3TwYaoV0WZfH5bx9HR/4w5qXwl7S5YPZXi83W136cpHlB6NXQ0C6IbgyC22pYf1AHqvNQcQ/qTFRTjqLcZm0WloF07aV+Mghw4FhIIPvB+qo/L5818NedwG7WgKFKlgE+Z4LLbYV/MBHOvR3SFyDqk/Z1nQyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724993477; c=relaxed/simple;
	bh=6JXLuomAdY/ZqnXAe3Cw7Q3pOOueFtiVnZ5g+koy2/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsmTDuvgOj+WUqtNA/XTtDhdv8efAtl/uBVrIJC1PsA0UutoIkmRqZ6VP4zpnyMiOpncsKR2QzMRKZFLZFNEbIuEzZR7ffbgsvEoBWHuFOrkB/ECePYV8WKRdLA3G2Ag1Q3JJb6lkCV0lBJ/kJu83G7ckhc81bzFfUTPFJ0CYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxiP047j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxiP047j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D6EC4CEC4;
	Fri, 30 Aug 2024 04:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724993477;
	bh=6JXLuomAdY/ZqnXAe3Cw7Q3pOOueFtiVnZ5g+koy2/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lxiP047jRlZR3ZmH3H7FIIQfTSwDm/45l3fc4GKQF6n9uGPGgpcOJbMXyRAO7d+D+
	 9zvqvicPz7pqS9EDFhRsMBWQoyVGf7W2KChdUm7Hs5soljk02muU/5GuI13YMCsFox
	 jW6ruR9a68Wn6bgZHz3WOLHNcBHx8d6PsPh/2e0JBdqT1BA23ZXX2WPWHbMjbppR/M
	 s/T2Jn8EZjcC4pM2E8zeVpvukmcYyfcsfbjCMiDuRDzkqHEF9ZQLs8BGzW1OIk43Pu
	 HUiO6b3bMse5WrM1gCC8EwQkBlX7meYL8ddtBfs/iN9c+RNRnoztFIH8DST8NEQO1e
	 wXC1/VvLU9Nvw==
Message-ID: <6a6e269c-255c-4cca-b389-e54c0e7e571a@kernel.org>
Date: Fri, 30 Aug 2024 13:51:15 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] ata: pata_ftide010: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, s.shtylyov@omp.ru, cassel@kernel.org
References: <20240829131907.541466-1-liaochen4@huawei.com>
 <20240829131907.541466-2-liaochen4@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240829131907.541466-2-liaochen4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/24 10:19 PM, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based

s/could/can

Same comment for the other 2 patches. Other than that, looks good.
Feel free to add Sergey's review tag when sending v2. Thanks.

> on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>  drivers/ata/pata_ftide010.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
> index 4d6ef90ccc77..73a9a5109238 100644
> --- a/drivers/ata/pata_ftide010.c
> +++ b/drivers/ata/pata_ftide010.c
> @@ -549,6 +549,7 @@ static const struct of_device_id pata_ftide010_of_match[] = {
>  	{ .compatible = "faraday,ftide010", },
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, pata_ftide010_of_match);
>  
>  static struct platform_driver pata_ftide010_driver = {
>  	.driver = {

-- 
Damien Le Moal
Western Digital Research

