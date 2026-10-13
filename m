Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71797384CE5
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876546; cv=none; b=mVfNfDG616s/ptQPXLVrsUKW5dRWpaE2ebWWI87JJrKFH51SwdzhYQCZCYayU063094jFVIxmGJoFpy9Tj7r5jPwTLREE3ByrbruHooYk0hL5a5vVwO0wRNYemkPiTjPsUb/7lWXsS5pnmvZVtE7rL4d4Qq3gcuHIo3+nBqJeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876546; c=relaxed/simple;
	bh=j1Df3XDx91fCpO/y1I5uH9jxjhfHjIH1HfR6IdMiwUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU9pkL0lg1WHHYffX/1bti/TzZNhEarFhTgsZOD+mQKCAiXI0BH214bW6iJPukzD3jQt7XwWunjMkuurjNBKBcdrv0ed0SwmQaaDwtT7NLnlcslZ/e/vmdhWf9+fBthM9ccuHuJxwepWRp0sN8tAGQfRboB2sQj4VwRc4nVUU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3SyC39t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3SyC39t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522821F00898;
	Tue, 13 Oct 2026 07:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791876545;
	bh=KgaPVajOSymMp1aHonnpqpoB9MirGvhBeWw6VTMyCWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3SyC39tcUYe97o9/Derk2nf2rooBLvVtt+Zb4+x0Yd/sZYdmc0IOqHO6s3S6ElV5
	 35+Vks+hk66gauiOiilkuSOvpCSnSylSiyIlgiTpdlDhyaOv3fmKUToSAqa8rUqES7
	 U9V1gCULeSSluXAXnVzN9U4Po+/nQzpvZSc2BH6bQCrr+oMTO3vR4hJ0Y3S12+exCU
	 L4H9ZvUKcmQRaUuAS5aBSeqoTah3bopcLFAqk81/E/auyk3rS485j8GbdCN2eWqjb4
	 tGFby8ZcBBKQHA6Cmi9L/9+LPS0QP96fJkDRHcNr9p/P2LajebYS2GRfB+X8J80Dg3
	 cy94YWwvK0fcA==
Date: Tue, 13 Oct 2026 09:29:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ioannis Barkas <jnyb.de@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH] libata: Fix wrong HPA horkage
Message-ID: <as3dvdomgdOl5bBI@ryzen>
References: <20261013042146.76467-1-jnyb.de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013042146.76467-1-jnyb.de@gmail.com>

On Tue, Oct 13, 2026 at 07:21:46AM +0300, Ioannis Barkas wrote:
>  Code wrongly filters disks by their serial numbers
> 
> Fixes: 16c55b038033 (\libata: implement BROKEN_HPA horkage and apply it to affected drives")

This should have been V2, as you have already send a patch for this.

Like we commented on your V1:
https://lore.kernel.org/linux-ide/40630ece-de85-48a5-8683-93be32e5d644@kernel.org/

The Fixes tag is corrupted, there should be no backslash.


> Link: https://bugzilla.kernel.org/show_bug.cgi?id=8888
> Signed-off-by: Ioannis Barkas jnyb.de@gmail.com
> Signed-off-by: Nick Barkas nickbgrk@gmail.com
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 59e87b987d..b23e1c3e4c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4248,8 +4248,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  
>  	/* devices which puke on READ_NATIVE_MAX */
>  	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD3200JD-00KLB0", "08.05J08", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD2500JD-00HBB0", "08.02D08", ATA_QUIRK_BROKEN_HPA },

You need to explain why the previous FW revision in not correct.

I think the simplest thing here is to simply omit the FW version field,
i.e. change it to NULL.

However, as pointed out by Sashiko on V1:
https://lore.kernel.org/linux-ide/20260913140806.546C91F000FF@smtp.kernel.org/

There is already a wildcarded entry:
    { "WDC WD3200JD-*",     NULL,   ATA_QUIRK_WD_BROKEN_LPM },

So you should probably drop the "WDC WD3200JD-00KLB0" entry,
and modify the "WDC WD3200JD-*" entry to have quirks:
ATA_QUIRK_BROKEN_HPA | ATA_QUIRK_WD_BROKEN_LPM


Kind regards,
Niklas
