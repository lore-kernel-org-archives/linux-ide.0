Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF820B1FB;
	Fri, 10 Jan 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508044; cv=none; b=A0pJkDUMdwuWUIHl53AN6Wz6BKap6seadYVWINiP03RS5DjeA8x8Uo1TCg0NRbrHyfPoo/gfMMzPdmq39taRMkZpOkSOUGpsVg2HKsHKrrGX2kJRZPVe1onwMfbBm+RVhW0TpqFdK8QDzBoKRBXDFBhTbyZ7GxtQpiutQ9roouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508044; c=relaxed/simple;
	bh=CnVu8Rrlov2McslMdQFWTwwznk9jD78HlW8nvi+ZtrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXGtMdY2mHcSsSQaduXp0yntZs5Vr9j/IsmFmicIJFfV3mjVJKoPKZq9C12k7/v16CFS6UtcVL+hw8Mavz5EKt+4kCo1oSnMBxhCMmNuAnzFyqaff5sxM9K9Wkf7HVJ488CWS1iB1NG8wM3E4YhYbAQhwyVqqDmIqdf3ykUFDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu9mj9HJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu9mj9HJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABDBC4CED6;
	Fri, 10 Jan 2025 11:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736508044;
	bh=CnVu8Rrlov2McslMdQFWTwwznk9jD78HlW8nvi+ZtrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cu9mj9HJV4evYEMzlEc18dxiPFvM+JpC5aN9F0WIsvjeL/6MMoUA55Lk6IvneFdxB
	 wQPk8XpAaLmPQPOWTaDrFalVkb4P4ySL+Hwfxjm/4ttBx9kVThJTpqj27RyWIUE7od
	 T0ZCvrYit8TADZFMMxM01DcqlVwhOvsLlljapZajCPFxvc2+JH9RmTMJYrbXOXzfCM
	 m015FXjGzCTnxbRkA0gukwwypRDirMYKxm50N2jaQCH0xJpS/W6WNRYckKdoRyaFWO
	 wSTmiKEDCI4tTrif2Z48hwBk/ZuebkT0pmMKuUg/zF/qvxkTx0rTzeN3GCO8pbzAVQ
	 Zi5lD+YUG8F7Q==
Date: Fri, 10 Jan 2025 12:20:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-ID: <Z4EChupSfaDEuIOI@x1-carbon>
References: <20250109175427.64384-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109175427.64384-1-rgallaispou@gmail.com>

On Thu, Jan 09, 2025 at 06:54:27PM +0100, Raphael Gallais-Pou wrote:
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
> -- 
> 2.47.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
