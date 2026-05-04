Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFD318B9C;
	Mon,  4 May 2026 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882198; cv=none; b=gEfhNQMAmgZbBRBcz076rID2uk7/vXw+e6lwXDxC+iYeenp8d4w46G79jhqbS22eKPeXsojimWYnaczYrQK0wOagltP3HveHGFibvSw67iT4vAtxppBBuCKM0vVsAc7BR+bzCM1IVO8SFq/ax6KmnEWgI3LOK6TKQ8gO5B3aLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882198; c=relaxed/simple;
	bh=iWRn8a9Y1mjUgeF6gGyOQxWDXjpbmQbGW3A5O/cxuZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggIL0vXJeQ1vpgsmPPTWbUFBMdC7UrqElcQKxRp4PG4MywYhvPNZXlFMmwVsQ7AcUG1qBm7qiyAXuAtsJeUf0pfioDE1yrLokk97G4y6TJCaV5DU1OrHM/ZVKsd5HwYgqssho/nO6s1FSBKZ3lZ80VXC3MpiXlayp4mFOP+gGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8jDnQ8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8jDnQ8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69669C2BCB8;
	Mon,  4 May 2026 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777882197;
	bh=iWRn8a9Y1mjUgeF6gGyOQxWDXjpbmQbGW3A5O/cxuZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K8jDnQ8yHHG3rBBo5A6x955Bf+P29Eh1KITLihRnUnzL0nmDAs85LLt5Cdh5C5DFM
	 JMf46St/3mKddxZSVZkCS6r9NrTBx+MAy9cZZ1HrWvk2/oKmx4EncuvFw6Tw/dP7F8
	 YpPhpBZOcAmjoHUCPBPsd+BI802zoiNy27FGpnWHx0xqvOrXew03YS68AVd9rfdtoB
	 G7MWv3gW/EuM2G8F8YXyIPpYFv+5llE54ycfTdRCPhhCZkAbq+VjLFBTGjzeylWHY5
	 oSa/+VhheCQCx5MEeIGjrhnNSoGKPkzcfVz9p1PIUzTfeX5XuudTXJ6pNX8tF/9xqE
	 W9y1//41iGMNw==
Message-ID: <b06a2fec-441f-4be2-aae6-3796c1e45cfc@kernel.org>
Date: Mon, 4 May 2026 10:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Consistently define pci_device_ids using named
 initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Niklas Cassel <cassel@kernel.org>
Cc: Mikael Pettersson <mikpelinux@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
References: <20260430170612.510869-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260430170612.510869-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/30/26 19:06, Uwe Kleine-König (The Capable Hub) wrote:
> ... and PCI device helpers.
> 
> The .driver_data member in the various struct pci_device_id arrays were
> initialized mostly by list expressions. This isn't easily readable if
> you're not into PCI. Using named initializers is more explicit and thus
> easier to parse.
> 
> Also use PCI_DEVICE to conveniently assign .vendor, .device, .subvendor
> and .subdevice where appropriate.
> 
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
> 
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

This looks like a nice cleanup to me. A couple of nits below.
With that, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

[...]

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 495fa096dd65..fac1266f7fa6 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -154,184 +154,186 @@ static unsigned int in_module_init = 1;
>  
>  static const struct pci_device_id piix_pci_tbl[] = {
>  	/* Intel PIIX3 for the 430HX etc */
> -	{ 0x8086, 0x7010, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_mwdma },
> +	{ PCI_DEVICE(0x8086, 0x7010), .driver_data = piix_pata_mwdma },

Please split the line before the .driver_data like for all the other changes.
That will make things consistent...

>  	/* VMware ICH4 */
> -	{ 0x8086, 0x7111, 0x15ad, 0x1976, 0, 0, piix_pata_vmw },
> +	{ PCI_DEVICE_SUB(0x8086, 0x7111, 0x15ad, 0x1976), .driver_data = piix_pata_vmw },

...and avoid long lines like here.

> +	{ PCI_DEVICE_SUB(0x8086, 0x2828, 0x106b, 0x00a0), .driver_data = ich8m_apple_sata },
> +	{ PCI_DEVICE_SUB(0x8086, 0x2828, 0x106b, 0x00a1), .driver_data = ich8m_apple_sata },
> +	{ PCI_DEVICE_SUB(0x8086, 0x2828, 0x106b, 0x00a3), .driver_data = ich8m_apple_sata },

or here.

> diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
> index a2fecadc927d..b8ae3eb0992b 100644
> --- a/drivers/ata/pata_amd.c
> +++ b/drivers/ata/pata_amd.c
> @@ -597,27 +597,27 @@ static int amd_reinit_one(struct pci_dev *pdev)
>  #endif
>  
>  static const struct pci_device_id amd[] = {
> -	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		0 },
> -	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7409),		1 },
> -	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7411),		3 },
> -	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_OPUS_7441),		4 },
> -	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_8111_IDE),		5 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_IDE),	7 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	8 },
> -	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	8 },
> -	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
> -	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_DEV_IDE),	9 },
> +	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		.driver_data = 0 },
> +	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7409),		.driver_data = 1 },
> +	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7411),		.driver_data = 3 },
> +	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_OPUS_7441),		.driver_data = 4 },
> +	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_8111_IDE),		.driver_data = 5 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_IDE),	.driver_data = 7 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	.driver_data = 8 },
> +	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		.driver_data = 9 },
> +	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_DEV_IDE),	.driver_data = 9 },

same comment here, and for a few other drivers after this.

-- 
Damien Le Moal
Western Digital Research
