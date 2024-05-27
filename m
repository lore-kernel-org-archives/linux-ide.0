Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCDD7BAE4
	for <linux-ide@vger.kernel.org>; Mon, 27 May 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799821; cv=none; b=ke6K2hU/gNeCGJgxWur9O27w1Wb8914Y0bs/xs2EaUZvnyPyovZJgqJMiy4p5sxnIRnGa/GD4HgYbnOvdKHdA9dW5qqAXVyCHX8yRtRFYoqyUj2xRfVCfICTfzXpGBQUfnCji/BRI/jmENsoD4SylhxVGUf7w93z9KkmDvMCHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799821; c=relaxed/simple;
	bh=au8xMLBy6bbtC2reAnHxFNewP6BYMpEfH5jka/TxPY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7YvNw6PgG0qtqC+kR8+5FTYak04BkTDU/9uLYqwC4w6HLtWwm+iwWD8Om8oPL0DMKB1YRC61LIu6Qvd0eM70DnVhgIZgCCBRFjYtlz27DNDyNN45r3jPlYAIQXqZUDwet3aGaUzw2NrSDOIJVw1od6qWJVuE5NvzksoaOqGMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRK1zuJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRK1zuJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBD1C2BBFC;
	Mon, 27 May 2024 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716799821;
	bh=au8xMLBy6bbtC2reAnHxFNewP6BYMpEfH5jka/TxPY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gRK1zuJPp/cPjTLfI0DlTIacfgSu6XCdfgKruCdJPpcvY3qslFlivS9qveTUI+X/Y
	 4QNUB6ClKP1rXSCcjolKGx96y/OhCZ6gumFA5OfQm4ryO2GXa7D5GGbRLaNYS8Fty8
	 dKQH2b7qIfxUB/CelMGqL/Zroi8wOZ4FXxfexM4LeNXNob6p5YF+T6CDkxVLHFv1FZ
	 ZjBcEkbie69nd57tcQ/dfxVMRiFyIftlmy+9np3OYQuFy+M2JQngdwao9LX70pm9va
	 B/x8A65ORMnZlVFhO1BBnzELYHMAcfRuRj3cmjkOrJb36KyOBO8z7Amg2doOwoiBvb
	 4J0A7SgSfcU9A==
Message-ID: <a472bed3-f0df-4fd2-99e8-cd89064c3bbe@kernel.org>
Date: Mon, 27 May 2024 17:50:19 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Kconfig: Update SATA_MOBILE_LPM_POLICY default to
 med_power_with_dipm
To: Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-ide@vger.kernel.org
References: <20240502092652.450831-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240502092652.450831-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 6:26 PM, Niklas Cassel wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Historically this was set to "keep_firmware_settings" to prevent problems
> with power management on very old drives. However it's been observed that
> almost all modern Linux distributions either set the policy to
> "med_power_with_dipm" in the kernel configuration or update it to this via
> userspace policy changes. Update the policy default in the kernel to
> "med_power_with_dipm" to match that behavior as well.
> 
> Changing the default was previously not a good idea, because LPM disables
> detection of hot plug removals, however, since commit ae1f3db006b7 ("ata:
> ahci: do not enable LPM on external ports"), a port marked as external
> will always be initialized to "keep_firmware_settings", regardless of the
> SATA_MOBILE_LPM_POLICY Kconfig value. Therefore, changing the default is
> now considered safe (external ports included).
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> [cassel: rebased and reworded commit message]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
All distributions use this, so doing the same will potentially allow us to
catch buggy hardware earlier while in linux-next testing phase. So yes.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index b595494ab9b4..e00536b49552 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -118,7 +118,7 @@ config SATA_AHCI
>  config SATA_MOBILE_LPM_POLICY
>  	int "Default SATA Link Power Management policy"
>  	range 0 4
> -	default 0
> +	default 3
>  	depends on SATA_AHCI
>  	help
>  	  Select the Default SATA Link Power Management (LPM) policy to use

-- 
Damien Le Moal
Western Digital Research

