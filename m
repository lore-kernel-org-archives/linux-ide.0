Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895C27C866;
	Fri, 20 Feb 2026 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594054; cv=none; b=jmtOA7IqsRpr6irPpbTgX03x3ezGxI7JwIhFDJ1jgeyxLfbOahBYnnEyJfqKUS5m1fXruDA5mziWjp2tscOpjYyo7IiyxgLbt0lnOhoObmSSBGEQXDpp60e64H8ZJaugAfrRgQmXJpjAMYlRLRkysCF4NEJS3fA6wsLPEmbwV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594054; c=relaxed/simple;
	bh=fQVzbJxdruPoy7jNB1j35Q073nlqC4U5R8T1pr5ZpVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLmpXYvS3VgGU+90xCM5OK9p3s6lqH2JHSTLoDr3uGUt2MyGwHvFrBLoV+GAB5fpFOsMngos0OelcWg5NxXqxlYFjlt7BELiCtfaPT2DSMwApl7Hn0jDjCo0RjQAnyStaksWaBKWsihc2GQA10hx8gjeYP+2mNvzmRbtGx6aScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7XDmXy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7XDmXy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FE0C116C6;
	Fri, 20 Feb 2026 13:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771594054;
	bh=fQVzbJxdruPoy7jNB1j35Q073nlqC4U5R8T1pr5ZpVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7XDmXy8os5TDCABA2ycUdcLp8rkGPyQs12HAyx7qzkfdSzsfG+ONx74MW47VfHqZ
	 pqQ3VvdrdR9fc9SGsfWbE21CMzU2YsWHbT+6ooLMvCD7rYcF7TLkflbiEb5389tbUw
	 K1icZdjmrVjO3qJW8nFze3mCCk6Tlux9EyQEskhbkmYICv1xFdIsSpvNUO9E2zHT4A
	 WJHUcQrykq86EvU9GPyCs8lMD+I8j1z80TSvKSRWPD8M2F94loUjldRI/hFuqQH4EE
	 ZU2xzWcvLC+HF+mPQ04aF6QnyumaW+BPHv8z5oiRXizIaDDuYp0LNiD5BKoHbZARRp
	 VpORl56IrCJOw==
Date: Fri, 20 Feb 2026 14:27:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ata: ahci-dwc: Remove not-going-to-be-supported
 code for Baikal SoC
Message-ID: <aZhhO5lMa0p41_VR@ryzen>
References: <20260220104208.2326568-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220104208.2326568-1-andriy.shevchenko@linux.intel.com>

On Fri, Feb 20, 2026 at 11:42:08AM +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ata/Kconfig    |  1 -
>  drivers/ata/ahci_dwc.c | 54 ------------------------------------------
>  2 files changed, 55 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 2349bca136e0..fff305ec1e78 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -194,7 +194,6 @@ config AHCI_DM816
>  config AHCI_DWC
>  	tristate "Synopsys DWC AHCI SATA support"
>  	select SATA_HOST
> -	select MFD_SYSCON if (MIPS_BAIKAL_T1 || COMPILE_TEST)
>  	help
>  	  This option enables support for the Synopsys DWC AHCI SATA
>  	  controller implementation.
> diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> index 64abf865bb67..436041c57f73 100644
> --- a/drivers/ata/ahci_dwc.c
> +++ b/drivers/ata/ahci_dwc.c
> @@ -13,7 +13,6 @@
>  #include <linux/kernel.h>
>  #include <linux/libata.h>
>  #include <linux/log2.h>
> -#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>

Since you are removing the, from what I can tell, unused syscon.h, I think
we should remove the, from what I can tell, unused linux/regmap.h include
as well.

(snip)

>  static const struct of_device_id ahci_dwc_of_match[] = {
>  	{ .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
>  	{ .compatible = "snps,spear-ahci", &ahci_dwc_plat },
> -	{ .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },

If we are dropping support for baikal,bt1-ahci, then I think it makes sense
to remove Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
as well.


Kind regards,
Niklas
