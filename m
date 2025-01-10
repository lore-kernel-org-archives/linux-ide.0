Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD93A1CD;
	Fri, 10 Jan 2025 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486348; cv=none; b=n44oZ+BwEIz7+lIbA0jRU29UjHZtQxBn0OavzaNy1BvUQftGx9nmnr7vX0VZrtGRrtJl66RgPmLKCfxFEplaSbQyHBW3ZeX5t3fiVVyDpfBg1MMYFn0pkEsViY3HdO7clNQZ9jgY6j1cmFcb0nN8WMIFmmrqWaLePUbhw/n8igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486348; c=relaxed/simple;
	bh=lJGsVXqUs2Eum4m3O+xfSSfo97fQH+EomtGAdP5lDBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pof9JSI0gTAMlfX49KC2Fw3OP8lUONQv20bqa9XNI75xwU8n4s0HFdv2thV9a3GTD9rSXZrq+TyvW8scv/WjYBBA6h9RkgwVwMNi5sHFNPpTf35qd/or7KdK+QeHR1E+IFmotu4ymjoU+WV1JV4mIfkRXbq4/qO9ZM8uaDI6kV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnsmWvE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnsmWvE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAF9C4CED6;
	Fri, 10 Jan 2025 05:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736486348;
	bh=lJGsVXqUs2Eum4m3O+xfSSfo97fQH+EomtGAdP5lDBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nnsmWvE0lXNfmv0ghEdPUHR9HfU53nEAyBAGwI4Q050cOIaP/GotVhKGXUVcTVgFp
	 mx/ut8uxQYR9vL7TF/F/aKMecVGEWJsxoYZ1mgj6W/H99h4xR6BWqde2a4Nc+2/Zqj
	 1zqlPphm+9BhVA/K0MYlSTp7cUZOiteNSVxpmBcsIuv3mJTcnzzl6V6GWU15fLfP+j
	 MWC8EG8XSH6PnbAH8AyCA/xGt4gUJAPSa8CxPjnJG3Lfl5OVLOGhHytZr7SAKud4dd
	 Z1xThh4OSOo7mJetLBpCHDwn+Jnu4p/oy6KP7q9mevf8pUE8DnldHtkP5ZiCKUhic2
	 CPIyqEN4XngxA==
Message-ID: <07a7177d-7705-4eb5-a11e-02a9429ffac2@kernel.org>
Date: Fri, 10 Jan 2025 14:19:06 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250109175427.64384-1-rgallaispou@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250109175427.64384-1-rgallaispou@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 02:54, Raphael Gallais-Pou wrote:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Changes in v2:
>   - Split serie in single patches
>   - Remove irrelevant 'Link:' from commit log
>   - Link to v1: https://lore.kernel.org/r/20241229-update_pm_macro-v1-4-c7d4c4856336@gmail.com
> ---
>  drivers/ata/ahci_st.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> index 6b9b4a1dfa15..4336c8a6e208 100644
> --- a/drivers/ata/ahci_st.c
> +++ b/drivers/ata/ahci_st.c
> @@ -176,7 +176,6 @@ static int st_ahci_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int st_ahci_suspend(struct device *dev)
>  {
>  	struct ata_host *host = dev_get_drvdata(dev);
> @@ -221,9 +220,8 @@ static int st_ahci_resume(struct device *dev)
>  
>  	return ahci_platform_resume_host(dev);
>  }
> -#endif

I do not think you can remove the ifdef here. Otherwise, there is going to be a
compilation warning when CONFIG_PM_SLEEP is not enabled. No ?

>  
> -static SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(st_ahci_pm_ops, st_ahci_suspend, st_ahci_resume);
>  
>  static const struct of_device_id st_ahci_match[] = {
>  	{ .compatible = "st,ahci", },
> @@ -234,7 +232,7 @@ MODULE_DEVICE_TABLE(of, st_ahci_match);
>  static struct platform_driver st_ahci_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
> -		.pm = &st_ahci_pm_ops,
> +		.pm = pm_sleep_ptr(&st_ahci_pm_ops),
>  		.of_match_table = st_ahci_match,
>  	},
>  	.probe = st_ahci_probe,


-- 
Damien Le Moal
Western Digital Research
