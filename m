Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF53644C9;
	Fri, 12 Jun 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262679; cv=none; b=UylR8tDGaWU8wdrcfhAZ10Pxs5S1X/KWVzz0RowqfBMcoc15zFjCFHQh+U4W6NusFTspF3+cH1we8rpiES9to5GjAXlkO5+PpgnIegVbGMwWab9Q+0EmK2j8MfDy58yShwuyqtrkEpSKPI++Gk+EiG32dhT6RvpfoV2LBuTMK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262679; c=relaxed/simple;
	bh=TLuOevenaeN+a08a4YLp1Mwjg/2mbDuqk4rL/6NmZHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVk6Hjo9Xxl2NrCMiAIKDeJmCSvyJeQQ9do/moVyMWuDpu/v3tU1cViKV6t8sHk6+rh7hpnShfXjIMFLvRQ8lmdwVz8LGHMjtzT2Mdu+H7/Hy+5aMxRcyGq/7CsBGq2KmXO8DVyWoEocMeIV8g1JpBGe35S41R93Q2gntIQpswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP8ky70C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP8ky70C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3C21F000E9;
	Fri, 12 Jun 2026 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781262677;
	bh=AMgp4XOiM0vIqw94s31Cn9K2xUheK01R2wr1WAdL6AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EP8ky70CODss9uVgAfzQYCZbqqoM14CEgTEN6+7RnBpKQpvtb1Xoi/PR2OrzgcHb0
	 apr0VqXe8K2+OpMMwT0a72QeSFDacIAqQkmkSg9pPK1mQ/zKcfPR/Lg3d6qd7NcIoh
	 Yfa+z5xnJ7R9SvlqMkhGYQB4FeEz2KFDf6t0dun/wuzW8ChpgNQm5gT3IDoAGh3+Co
	 7HLkAnbLyvPTy1PAOpdIN5KOiy8GqaUsB2hma+LMpRBa3CfCQ+0+f1zxQ1/uoxv5jZ
	 cn7sqfg4lv2pYGXwcDIxtD+UsCYOm78OgEdp8gR7mSD7JjcmbO9yP/cvPRkAaMoHRy
	 3Zq52BtQR62ZA==
Date: Fri, 12 Jun 2026 13:11:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>, Julia Lawall <Julia.Lawall@lip6.fr>,
	open list <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCHv2 0/5] ata: pata_mpc52xx: fix cleanup ordering and
 modernize
Message-ID: <aivpUWQXowVC4E00@ryzen>
References: <20260609194311.6217-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609194311.6217-1-rosenp@gmail.com>

On Tue, Jun 09, 2026 at 12:43:06PM -0700, Rosen Penev wrote:
> Fix several lifecycle bugs in the MPC52xx ATA driver:
> 
>  - The BestComm task IRQ was managed by devm, creating a use-after-free
>    and teardown inversion.  Switch to non-devm request_irq/free_irq so
>    the interrupt is unregistered before the task is freed.
> 
>  - The error and remove paths called irq_dispose_mapping() explicitly,
>    duplicating the one in bcom_task_free().  Remove the redundant calls.
> 
>  - Replace irq_of_parse_and_map() with platform_get_irq() for proper
>    error handling and integration with the platform device model.
> 
>  - Replace the open-coded of_address_to_resource()/devm_request_mem_region()
>    /devm_ioremap() sequence with the standard helper.
> 
> v2: add extra patch from sashiko review.
> 
> Rosen Penev (5):
>   ata: pata_mpc52xx: fix NULL pointer dereference in IRQ handler
>   ata: pata_mpc52xx: switch to non-devm request_irq for proper ordering
>   ata: pata_mpc52xx: remove redundant irq_dispose_mapping calls
>   ata: pata_mpc52xx: convert to platform_get_irq()
>   ata: pata_mpc52xx: use devm_platform_get_and_ioremap_resource
> 
>  drivers/ata/pata_mpc52xx.c | 70 +++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 47 deletions(-)
> 
> --
> 2.54.0
> 

Will wait with this series, as it seems that Andy's review comment on V1
that the irq should be requested after devm_kzalloc() is still unresolved.


Kind regards,
Niklas
