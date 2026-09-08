Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670405452A2
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877710; cv=none; b=ex2vwTolxpvh1223FtPqmxApP0QgGahNthRJgfPCWsxNAA+A5GuF2QnKAoGavJSOfpg+7FaSBjeMWqAkth0ZZhSAGjoXWtKJjQO3X5PFp0HY4xe2tUswdKfa8d24TIi1sCaGEFLROedOhDAah+XmAEV85CtnWtXWTLrhihBZMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877710; c=relaxed/simple;
	bh=ZJc4zZdBiYLDUTTbmKFJB8yZ+ap5QWmfwIpg38qBqhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpIjmkosowBJv2cfYvneEyWweoTBkirNJqH5iiE3xs6vqo5qDkYIR/5Q8PU5qChGKnIX27psUE9Zy8iY2Q1Hk3QxUQ/YMLbUikPoKY/zuIbAdsmi+qNUTWf69sgs5gdqMF7dwE5+wDE2Efv3QPW6GTWOAQ1TZpYfA1ajgPEhWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihi+xz4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihi+xz4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BE31F00A3D;
	Tue,  8 Sep 2026 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788877698;
	bh=KLzSMlmZEmpd39YblIj1mbKwQtIMYtehukOXf+Lk4kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ihi+xz4nNSSe1AjbRdtNQpVJ9Q2JyMtH8taG290IrQFTr/86VK/9qgQuJ8lrfjVoh
	 5hIE4mhzqaFEFdtIuDGpMwbGH5DiSelmCaxm0iNUdhenZDbrPNbEVl3+LW6J6eXVD3
	 QGmovQhgk68cMmWvPVYdV9QRpRYmZYvzf2CHePnssYtTACzJgm3z7qroUS7HxrKHiH
	 lRPk824QyxqKJK9tPCTzybHbSjfv9Cc0pgRkuQcJrjjJDp0z1b7eXo3TApJkZJ37D9
	 14gFxIHDNaV2o5i3tdAzXZXRXBWEvwCNec6w9U86v0WJ1zv06iuEiQOJEd8xxud2WW
	 7HfM38V6uETTw==
Date: Tue, 8 Sep 2026 16:28:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v6] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Message-ID: <aqAbf2l7hn2H0cXT@ryzen>
References: <20260908125029.928660-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908125029.928660-1-lijun01@kylinos.cn>

Hello Li Jun,

On Tue, Sep 08, 2026 at 08:50:29PM +0800, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
> DEFINE_SIMPLE_DEV_PM_OPS. Use pm_sleep_ptr(&ahci_da850_pm_ops) to complete
> the API migration and allow the structure to be correctly dropped
> when CONFIG_PM_SLEEP=n.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> changelogs:
> -add pm_ptr for ahci_da850_pm_ops in ahci_da850_driver.
> -revise grammar and alignment issues.
> -Align parentheses.
> -change pm_ptr to pm_sleep_ptr.
> -Modify pm_ptr\CONFIG_PM to pm_sleep_ptr\CONFIG_PM_SLEEP in commit
> message.
> ---
>  drivers/ata/ahci_da850.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> index 4e53ff96d712..59b9ca26fd44 100644
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c
> @@ -218,8 +218,8 @@ static int ahci_da850_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> -			 ahci_platform_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> +				ahci_platform_resume);
>  
>  static const struct of_device_id ahci_da850_of_match[] = {
>  	{ .compatible = "ti,da850-ahci", },
> @@ -233,7 +233,7 @@ static struct platform_driver ahci_da850_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
>  		.of_match_table = ahci_da850_of_match,
> -		.pm = &ahci_da850_pm_ops,
> +		.pm = pm_sleep_ptr(&ahci_da850_pm_ops),
>  	},
>  };
>  module_platform_driver(ahci_da850_driver);
> -- 
> 2.25.1
> 

I fixed up the commit message when applying your v5:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?id=f091e60fc986eb12ff632f682848b88da824bccb

So there was no need to send a v6 :)

Thank you for your contribution!


Kind regards,
Niklas
