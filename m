Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA04755783
	for <linux-ide@vger.kernel.org>; Thu,  2 May 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642813; cv=none; b=OZYAR0b9PDI4ApHa1MkYQ3tASnVvWxMADDCMKe2coQeSJNWPZ4zDDxyeRS2QIKCA4x3RZowx+TudCO1Ulb7V84fRHWANlTXA9Ttuz5fR9GqNlQysMRi2L5HmKjqvcAYrB7Ya87AeimbGIwqBVNXl7Gp5MZRI4tyNg2F806u7ubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642813; c=relaxed/simple;
	bh=OkMcVz9Ph9vNEzSVPGTwvaSKXHn24/TbWTltzo+Vjzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6Q76gAsWMeXXHZVQqJW70y5RPOvMRQAvLvvv60Eng9QxtdsBg0I57hktz1GACWXDOqbfzgO38dulTBONHOWcXtGc9UNyqgWQfFFjq7rh8736Rba4vudAcdnmgIVXAfHIDVhoGGOOcMyyaUgsdyc8t0o+pnwGptCqjX1oDQFoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnSE/xLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnSE/xLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0D9C113CC;
	Thu,  2 May 2024 09:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642813;
	bh=OkMcVz9Ph9vNEzSVPGTwvaSKXHn24/TbWTltzo+Vjzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WnSE/xLhZ6B5cvDsyMb176UMUHB08qcF6lOFakBjnP8Wmmw5VetKsD6NqeBZnlMfl
	 5Z57H0z7jheLWqjA7Otdwt2YjveDCJcnR57gLsU4rRGSfbTJMkgbEY6WOFnGxVUsQb
	 hMbxOa7/K6gsJLGlumO648prB5HyP2i4pyG5Hz9Ir0lZVFMGCIfNb2/6sjhSXA2HYv
	 SYlXidnTQuiYvpDjJzlUQxVbFPvZnBYXFdvL622nhC3XQ3P3uYdlFKWz6834oLs/Zc
	 9w5ZV6+zAvPy2qQRVCNlMgvWhUp8Tpt+S0gQP0QZcjJglnE/qnjLkPdaf0GQ9isfxX
	 bQ8Syx9Y9eJ7w==
Message-ID: <40e63d1c-09d8-48b8-b08d-6f4be64013ff@kernel.org>
Date: Thu, 2 May 2024 18:40:11 +0900
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

On 5/2/24 18:26, Niklas Cassel wrote:
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

I am OK with this change. However, for this one, given that we already are at
mid-rc6, I really would prefer waiting for next cycle to have this spend more
time in for-next testing. So let's apply this once 6.10-rc1 is out.

-- 
Damien Le Moal
Western Digital Research

