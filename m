Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB592232A
	for <linux-ide@vger.kernel.org>; Mon, 27 May 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803071; cv=none; b=eOs/8KJK9yDC+lPNun5Bdjs5cwXAC5ObsVNygmRfgGn7u9kxJWHkbwyCUZ/STQibldD6KNt1mUUVUN+2mTNgj5Zyjezd8c64vtYxGFb6vz57ZGb/ON59KHcdcvcMNa1iDY7MHI5rbYrN/n0SinykM4BopVxSvgB+xD2K5TDwwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803071; c=relaxed/simple;
	bh=KgNmO0mJrfHNDVtZGZQX6MgHfj4t6+w+Qo9f11cu3/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6ZMT1ZWgt1U92CPUJ7u9sa0PQcnFO5sfseKxfGxQQfo6wJ60doiqqxdYcn8JvVnPO0uoTpJshTKFEcHt4rihBcwUQyHJA0o4vSp66rApVb5Qhf84WrUZATasJcrwqC189mGmec8iAdIDxgODyYGdJRAkmatjWKnrv9cQcyyHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MubZ+Z1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MubZ+Z1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D8BC2BBFC;
	Mon, 27 May 2024 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716803070;
	bh=KgNmO0mJrfHNDVtZGZQX6MgHfj4t6+w+Qo9f11cu3/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MubZ+Z1A2gueKBNwsSxP0Uup+3dDkiiZNuI05/1jdyPGBQqE11OUdXR2CAFwX016o
	 tYMR2GRYsVxGQM2ig+xVvRRy0cvnPE8iPjNVEWi1HW3bt91eyUDIvEknshDEf8fGt1
	 RA1uCDcoQXzbp60F4RrKmpNIJ6srkqCHqzUdXpcaEvuxcC1EPGCgF2cPBivvxAQEXW
	 VI9McKJlpg+wTtC5W7pGYozq7w6V0XudOVsq5azDgIQtAWL4OY3ztM9+bhjHEdwRMA
	 hdgwO82ymFVgTonZUkubeaLnPNKzVQSWibU1kMWz0V01sz1nCpFrVTYBzdMg9RPl/+
	 J1+79qscltbUA==
Date: Mon, 27 May 2024 11:44:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: Kconfig: Update SATA_MOBILE_LPM_POLICY default to
 med_power_with_dipm
Message-ID: <ZlRV-jA1ARtVGrpa@ryzen.lan>
References: <20240502092652.450831-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502092652.450831-2-cassel@kernel.org>

On Thu, May 02, 2024 at 11:26:53AM +0200, Niklas Cassel wrote:
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
> -- 
> 2.44.0
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.11
