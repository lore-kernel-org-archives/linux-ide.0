Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F338F250
	for <linux-ide@vger.kernel.org>; Fri, 18 Sep 2026 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735764; cv=none; b=IqBaUTuDAUhZQZzimDKvMRM0G9XVmglT0dqx80BlTOD5NZyDXzWHOK6sydZX6/q9t3dHn4YgSygq42fHCz7J6ZqUzJ1d42SEseoPuZHob83FnujBJUGVQhmDqkMMx8b3g3+OGxlekPuitTFjRSetq6ep2PxBfO1ERTFMMmoXEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735764; c=relaxed/simple;
	bh=tdqjso3In5G0n16BKmUTaVNZyZUzB1CNAn3Uu9P1Ie0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl2PDtwVHH/2FZUR5+CboJ2IF5YwB2z8bVuGAkDSi5XCCqNjyM1xgn+AjVo6VxGekDr5oDJX9qz4bqSV/OUS+cSTx1J87mNLbXjxR/q69uA3f/oI9cimMps6NOw7JpAy68mvctvOsEtXT0v+/ZKJT5V2z/u8g/B8uitfOYTEXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFlAKsWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFlAKsWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E301F000FF;
	Fri, 18 Sep 2026 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789735762;
	bh=VKzPPWVOBhRkoUOwQsWoCNV2s0WlXgE2OhqCHt06Ccc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RFlAKsWcvNL8JwJdYN+G7cnGvad9v2CPyXn//RyQcdFpJ/iZlYYItS3WNhlxnbeH/
	 XumAn2QWsGqu8ruLtaGlGKGpyvbX0+d9HFjUjkygqS1uVIhshdwcyY6YHkzO0z85pP
	 Saxs8WOTxV1TjchRpfG73GK0OOSL5m+IeTAnOiQ9RR2sL5D+jCBIdFL+/A2meIEXbC
	 EBmsdSZlxkkig9Adl36awa0t8ACgtwDmiGgXV5vaeqQaxjpKVHIdKMbm7Kqvfp+l0T
	 GcU/pFbWXVnePlvI896nabZCGax5lucOcO2tYkoXO4fSmOt5z/xn4Z58rdxh47RE47
	 AQHww7mzlR6ww==
Date: Fri, 18 Sep 2026 14:49:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, grandmastertriplej@gmail.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH 2/2] ata: libata: Correct libata.force parameter
 documentation
Message-ID: <aq0zTqvUzopOdQwF@ryzen>
References: <20260918124030.1962773-4-cassel@kernel.org>
 <20260918124030.1962773-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918124030.1962773-6-cassel@kernel.org>

On Fri, Sep 18, 2026 at 02:40:33PM +0200, Niklas Cassel wrote:
> Align the documented libata.force options with their implementation.
> The force table accepts PIO modes 0 through 6, not mode 7, and ncqati
> controls NCQ generally rather than only queued TRIM.
> 
> The max_sec_1024 and max_sec_lba48 options only set transfer size
> limits. Remove the misleading claim that they can also clear them.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 33cd30996e47..24459f7ff810 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3491,7 +3491,7 @@ Kernel parameters
>  
>  			* SATA link speed limit: 1.5Gbps or 3.0Gbps.
>  
> -			* Transfer mode: pio[0-7], mwdma[0-4] and udma[0-7].
> +			* Transfer mode: pio[0-6], mwdma[0-4] and udma[0-7].
>  			  udma[/][16,25,33,44,66,100,133] notation is also
>  			  allowed.
>  
> @@ -3509,7 +3509,7 @@ Kernel parameters
>  
>  			* [no]ncqtrim: Enable or disable queued DSM TRIM.
>  
> -			* [no]ncqati: Enable or disable NCQ trim on ATI chipset.
> +			* [no]ncqati: Enable or disable NCQ on ATI chipsets.

Hmm.. I guess we could theoretically remove the [no]ncqati parameter from
libata.force.
If a user wants to enable/disable ncq, they can use the [no]ncq libata.force
parameter.

However, since this libata.force kernel parameter already exists, I guess it
might actually be used by someone, so we can't really remove it without
potentially breaking existing setups, so I guess the easiest thing is just
to keep it, even if it is not strictly needed.


Kind regards,
Niklas
