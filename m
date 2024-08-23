Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20D16BE2A;
	Fri, 23 Aug 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407951; cv=none; b=fGqOsTkxW9uYM70pHujrvEyPCkh3hFAanFTRdqTXZQH6KO1cvsi/wYU52j4BRoOPCR22/pz4yI1KT609YQ8gVTQYpGdyhbZw9h52uFF2HekNozgK9QxUGA9zkgH6ZIZGh+ZJD5ifQ+tclogLn8FZlRihd99UaKBoAlYiSJ190wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407951; c=relaxed/simple;
	bh=ziCiAI0IhosMoGUeluz0BvN2Y4wzxViOLL3PfeejSfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2CSo5WSvPuT3zn9IWE919V0XGBJUg1jSFUuU6DZH1smT/0wTRHvopYtC43JRHD3V3oy36KcPt3O6ZhpnlB91KbwrC/lX7eYUPBEHRwQDeUy6HwHzYkAxGlhDsmrkNfYR62leZsBvPGji/i9n441WCG47R4jhtiodBxDPV6zqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WohhG2N6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WohhG2N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E81C32786;
	Fri, 23 Aug 2024 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724407950;
	bh=ziCiAI0IhosMoGUeluz0BvN2Y4wzxViOLL3PfeejSfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WohhG2N6xWFt5kCS/+xWf5opyr7Dum1KsuUUxPQvWMJmNqgwmQ+E+vEZUStoU63aD
	 up9jm4+D1bLB9UcaYUbrA5CdSZKFZAZFvDYyQQhaUb4oMdl9Fomnv1j8cWUa4wXL7Y
	 fjSrs86MR64h7DhxaFA0XvFku3hXropRd2AX4h3hmpwr4jDDJqjFM8JJnOt/9oEmaI
	 ht5nV6B4HBKtyOW4d8tfT5Y9Eo5zsPwcwAgRJsa8IDNn/gCO42bBJSjk6EUyn2cOnp
	 skDgd1PvYUXXqbff3JVT1X0MBMzC/qyCoHxZuCrbwo0GqJdCeHyGYXLriGrLYh2rEW
	 PV/ZdHo8ZQRcg==
Date: Fri, 23 Aug 2024 12:12:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH v2] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
Message-ID: <ZshgieaM0VaMkjBj@ryzen.lan>
References: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>

On Thu, Aug 22, 2024 at 11:30:50AM +0800, Zheng Qixing wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
> for a port, the allocated 'host' structure is not freed before returning
> from the function. This results in a potential memory leak.

This sentence is wrong.

If ata_port_alloc() fails, we must have already called
devres_alloc(ata_devres_release, ...);
which means that when:

	ap = ata_port_alloc(host);
	if (!ap)
		goto err_out;


...

err_out:
	devres_release_group(dev, NULL);
	return NULL;


devres_release_group() will trigger a call to ata_host_release().
ata_host_release() calls kfree(host).

So we will not leak "host" if ata_port_alloc() fails.


> 
> This patch adds a kfree(host) before the error handling code is executed
> to ensure that the 'host' structure is properly freed in case of an
> allocation failure.
> 
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
> Changes in v2:
>  - error path is wrong in v1
> 
>  drivers/ata/libata-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e4023fc288ac..f27a18990c38 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
>  	}
>  
>  	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
> -	if (!dr)
> +	if (!dr) {
> +		kfree(host);
>  		goto err_out;

This code does free "host" if devres_alloc() fails, which looks correct,
as "host" will currently be leaked if devres_alloc() fails.

However, that is not what the commit log above claims :P

Please update the commit message to reflect reality.


Kind regards,
Niklas
