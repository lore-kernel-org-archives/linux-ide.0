Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0220C02B;
	Fri, 10 Jan 2025 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508293; cv=none; b=O0OtENtYsChtWlgKwwOYJ2aAZ1/pEyg1Rkx3uTnZ4FUiPdGpuodnoIiFqLIjw7fhm/izjPyNL1MidPDhtkl2j7G6BCrwASkWbGVirf6+183ouQ5LTP5uodfttzULSoLpY4Q75sn8kH+d6n5kQFtbyzvmX3s6q5Mj6hysQ5FUsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508293; c=relaxed/simple;
	bh=DHGnjopH6C4NMV+3lFpgBWFUy5Du06runOsZvrEz6oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaAU76W8z2EKCBowyYsbsGlBrzAZDEMIjEXmveBSMO+UW7aKmqrd6lN7ymgfSSFZloBOHGA54Y7CL7klBcy7PD17wh7Erjfw44fxT6LujxNqbXj60UMhUmT1n4PlwPlE+Mss7InLFqmJDtgOZD8IKqoJwqeMvpHmubMu7eDXj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2sj99Fa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2sj99Fa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88380C4CED6;
	Fri, 10 Jan 2025 11:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736508292;
	bh=DHGnjopH6C4NMV+3lFpgBWFUy5Du06runOsZvrEz6oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2sj99Fa6m8krVxYtbkeLN92EtZ7b3ys8x6DOPc1oknJv26PLbXasu2lT5dGbDgnW
	 tbA/VX/vzjVzQh+6HLCNLw6NFjd0OKAyR7exvTFHatrGpNwrsUOW+MWAkwFv4NeLHT
	 5uOzSB38RqrtV2oASlNkiKIBpu1349K9DZEEcEmWS+4UjuphoDJgdP3VCUs/0l5Mjk
	 E3a+8h1psni4YhusYvSYf2J5bEzgF+DPOAXk88q9MchxtLk5RFIvHa248PQcYF7UXS
	 YuKg+bpxW3S6Jaurr5LZXx6cSCPl4OAVJBdLUHsir06/bCp60qhCtI5m5xNjyYyllY
	 2WFFsCHulNm3g==
Date: Fri, 10 Jan 2025 12:24:47 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <Z4EDf4ecHyfTq3Hp@x1-carbon>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>

On Fri, Jan 10, 2025 at 10:04:46AM +0100, Christian Heusel wrote:
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
> +
>  	/* devices that don't properly handle queued TRIM commands */
>  	{ "Micron_M500IT_*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
>  						ATA_QUIRK_ZERO_AFTER_TRIM },
> 
> So if anyone has feedback on why the patch does not work or any
> alternative ideas for a solution that would be highly appreciated!

It would be nice if you could share a dmesg.

If you have applied the quirk properly, I would expect to see something
similar to:

[    2.989363] ata2.00: Model 'QEMU DVD-ROM', rev '2.5+', applying quirks: nolpm


Kind regards,
Niklas
