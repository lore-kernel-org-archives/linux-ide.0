Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0750620A5F4;
	Fri, 10 Jan 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501086; cv=none; b=aEWGlod51kaQ36JJNC6jwkobPpFB73L+N24IePEjjQfpM9qqa83egYIedQ5/2+wOjOnKIX5k1kJXZOyGLYxdAhjjBR5NezHg/HrqUCsUQAwqoSx4NonHXI6+fCUPdfXshy4h+w8CLa8WFjBKTDXTiv8E9uJgVJRJnfKhx1ydZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501086; c=relaxed/simple;
	bh=VGg/za38aDFEUVaa3yfJh/w+cRWIIpOaC9tbMCA+MC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnE00iVFw/865yM8XPRJ6ya/x0/m1knWdibwhqIhPgw8T5WdrVHTpHRDpDGKdjfmK4+LxLIl/3aBsalITcc4hFhMh0Vr3rcL3q6CMGKErRSJZFRyK+iOQOHV5Dd/8SBiRRIOw4rxaOXm7UiKyJRbBxMayZBo3vGDcrEIFfBA9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0Ga4uhI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0Ga4uhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739BAC4CED6;
	Fri, 10 Jan 2025 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736501085;
	bh=VGg/za38aDFEUVaa3yfJh/w+cRWIIpOaC9tbMCA+MC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e0Ga4uhI6otVpvROXLYcjC2lzsMf+YlZMwnTa+qovH8sllnkIYwVTfCEpdvzFuycN
	 1vSZfrAm4XVXDmhfLCcV18aEUzUMRwA5XBOeHUPQEGWQfPSMebBSV1WgwkJgQDSxm9
	 vtugEYYlKMBXaNSmWFGvV5y+2NKSMkKeYj0+y8SPLMwjdIn2Ss6AkfdWurZp6NFfXo
	 ZpzFp7OgqGtASjiJrf9BeO8dcsQnJADfcD2HQv2XalG7TDP+MPRu0wis5v/66JLPpz
	 lAiQDKDokAIsx7vZWu59AmWsUHNbvms88ZyF56hhlhFr+d3P47CRp97OeFxM3QiFXg
	 SDqr5l+n/2ajg==
Message-ID: <d1b79f57-9e77-4b2a-9dfb-f86cdcffcb0d@kernel.org>
Date: Fri, 10 Jan 2025 18:24:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
To: Christian Heusel <christian@heusel.eu>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Niklas Cassel <cassel@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/01/10 18:04, Christian Heusel wrote:
> Hello everyone,
> 
> we have recently received a report by a user in the Arch Linux Forums
> user that their Blue Ray player, a HL-DT-ST BD-RE BU40N stopped working
> somewhere since kernel version v6.8.0. We have then bisected the issue
> together with them within the mainline kernel sources to the following
> commit that changes the default power policy:
> 
>     7627a0edef54 ("ata: ahci: Drop low power policy board type")
> 
> The user reports that adding "ahci.mobile_lpm_policy=1" as a kernel
> parameter fixes the issue for them.
> 
> Additionally fellow forum user @loqs came up with a quirk patch, that
> sadly was reported to not work:
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c085dd8..ef01ccd 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4118,6 +4118,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_QUIRK_NOLPM },
>  	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_QUIRK_NOLPM },
>  
> +	/* Hitachi-LG Data Storage models with LPM issues */
> +	{ "HL-DT-ST BD-RE BU40N", NULL, ATA_QUIRK_NOLPM },

Looks like "BU40N" may be the FW rev ? If we can get a dmesg ourput of the
failing case, we should be able to sort out this. Likely it is a bad string
reference here.

> +
>  	/* devices that don't properly handle queued TRIM commands */
>  	{ "Micron_M500IT_*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
>  						ATA_QUIRK_ZERO_AFTER_TRIM },
> 
> So if anyone has feedback on why the patch does not work or any
> alternative ideas for a solution that would be highly appreciated!
> 
> Cheers,
> gromit
> 
> [0]: https://bbs.archlinux.org/viewtopic.php?id=302334
> 
> ---
> 
> #regzbot introduced: 7627a0edef54
> #regzbot link: https://bbs.archlinux.org/viewtopic.php?id=302334
> #regzbot title: ata: ahci: Blue Ray player broken since power policy change


-- 
Damien Le Moal
Western Digital Research
