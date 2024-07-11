Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DD157E93;
	Thu, 11 Jul 2024 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692491; cv=none; b=rj6TP6RPs7utmITChqPdxaIlqIbS5oLr8EOJoqCwBETnnb6apSOGFHn6D68cJYYQ9oy1AkaeRon9nlV7wDvMu7EfYIJfGX0xezuQNxW6SrBX5SfVr92ZAPV4lW5q3k5a4pFvGfYtWQcrspF+I8vMoLr6eju5tI4QzQy1ovYn5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692491; c=relaxed/simple;
	bh=IE7Jm2h3fvmnUl3/nVlvbq8s6bGeaVicXQrKPfE1cSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2H3lqmuI8uGtwQiarFdHYMXSf9gAkEkdJcJk/2DOdNIitWVoaBM+TOggc26s/eSF9OY21PkM2xxerudEe7xFL2kDhbl3SwSDP6bjkyAc5mv/pzbIwuegwQOgw9ScDcQ9fZmlfhumNDD5961e09OWXRMgGUjlMAWnKYuzy2T8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvqPdDVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvqPdDVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B5DC116B1;
	Thu, 11 Jul 2024 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720692491;
	bh=IE7Jm2h3fvmnUl3/nVlvbq8s6bGeaVicXQrKPfE1cSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NvqPdDVKwO19QqGj4Nfk9FXIzAOoZ3mMzj8HyRzSI1wKSx9N0uthK3aO+F+ODt7A9
	 zdwoU35pkkMO0XJfiLGHmJn39xwSUBVJ+PaoTf56vt6qKoiTUe+Ohw8Yahs4+LdkD+
	 rC0lv5xXJjd3cjd6SwxsCghWO/V5jb8r9UgCgcVFT26Gk3hGFv4IiBgpZYB4yxdYcg
	 nUvusoBvU71YRXLzGJm7VozNVj9UqeI+bsgVigDvW2VxlrdJoWc1bYybBZTj3YS6Ce
	 X2drBuHrKbHA0jvJFstNVpvuWeWquJt+1bOYS1krqvP+pJ+ZrxRIZQDhg2jqyLlCHu
	 rJ3f1ElzAHnrg==
Message-ID: <52cefeb5-49c4-4446-813f-df9c1b99ca55@kernel.org>
Date: Thu, 11 Jul 2024 19:08:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
To: Richard Zhu <hongxing.zhu@nxp.com>, tj@kernel.org, cassel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, kernel@pengutronix.de
References: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
 <1720685518-20190-4-git-send-email-hongxing.zhu@nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <1720685518-20190-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/24 17:11, Richard Zhu wrote:
> The RXWM(RxWaterMark) sets the minimum number of free location within
> the RX FIFO before the watermark is exceeded which in turn will cause
> the Transport Layer to instruct the Link Layer to transmit HOLDS to
> the transmitting end.
> 
> Based on the default RXWM vaulue 0x20, RX FIFO overflow might be
> observed on i.MX8QM MEK board, when some Gen3 SATA disks are used.
> 
> The FIFO overflow will result in CRC error, internal error and protocol
> error, then the SATA link is not stable anymore.
> 
> To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.

2 remarks:

1) this seems to be a bug/problem fix, so this likely needs a backport to stable
(Cc: stable tag) and a Fixes tag.

2) What are these magic values 0x20 and 0x29 ? Where are they defined (SoC
specs) ? Can you define the new value using a macro with a self-descriptive name ?

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/ata/ahci_imx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 0e9fddd02ee5f..9147cd14f587e 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -45,6 +45,10 @@ enum {
>  	/* Clock Reset Register */
>  	IMX_CLOCK_RESET				= 0x7f3f,
>  	IMX_CLOCK_RESET_RESET			= 1 << 0,
> +	/* IMX8QM SATA specific control registers */
> +	IMX8QM_SATA_AHCI_VEND_PTC			= 0xc8,
> +	IMX8QM_SATA_AHCI_VEND_PTC_RXWM_MASK		= 0x7f,
> +	IMX8QM_SATA_AHCI_VEND_PTC_RXWM			= 0x29,
>  };
>  
>  enum ahci_imx_type {
> @@ -466,6 +470,12 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
>  	phy_power_off(imxpriv->cali_phy0);
>  	phy_exit(imxpriv->cali_phy0);
>  
> +	/* RxWaterMark setting */
> +	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_VEND_PTC);
> +	val &= ~IMX8QM_SATA_AHCI_VEND_PTC_RXWM_MASK;
> +	val |= IMX8QM_SATA_AHCI_VEND_PTC_RXWM;
> +	writel(val, hpriv->mmio + IMX8QM_SATA_AHCI_VEND_PTC);
> +
>  	return 0;
>  
>  err_sata_phy_power_on:

-- 
Damien Le Moal
Western Digital Research

