Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5A179206
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992403; cv=none; b=uBIewyIYgWGJgiV4iL5QBVu4nh4xjetHxG/kTHPKFobrJb8VUPTIuOp7rXPlKLcPWkOsYKOng/UUvzO402iCq+oeoBnJTXmD65upZbT64caaDk9/QINWYmPgH3jzK5Ytcc99omHysIU830m2FF1jAmFSCxkCDkx9IsOQqKYlI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992403; c=relaxed/simple;
	bh=iy1SDyfWP0/UHvMnofuPClji8gcBgQGE5bk6jeAtBP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY/AgZuB5HyvId/ytmqNVpUSBHd7QVMrJmLWPWDRGmI6wrmeO8JPYi/VfHQorO1d4wat6y2a7ojTsz9NR/S5BYHL5XOz0A3o4yZZ9IQMecxhx02RxA/Nm6UU8hbdCUZBacdcnMgm17W/OKLbwa6zIkN7AD01ujva2rG2VDXNl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaWgLHYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaWgLHYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D15C32782;
	Fri, 26 Jul 2024 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992403;
	bh=iy1SDyfWP0/UHvMnofuPClji8gcBgQGE5bk6jeAtBP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaWgLHYy1aP3g13dZtbPpal05QYjiDVzii4kSZDTnAelitqj8GWdl2VljEJiyNCP4
	 L35EUoriUxyTBLyz7MPmwg8RhTKZCv/Gg8RtRftZ98Fr4V41OIf+R/r1Nc4UOPpj4i
	 h4lP2oVsriPmE4a0/iUBM5TNIeroqKnvQfkKofFbT7kPIvBACpN1Ij7XJHcNprx3PM
	 K9YnXBk0QHVlbDJBwmvQrGcmOsNtoH1w10EvagcqqN8+8Hsl1zVIOOf+gizwXbDgND
	 xOyFbu1vbfCl6HcE6kt41cgoOM9wgDO/z9e/Wl3y9F+7PrseXAa/Of7QddSn6EoL/H
	 dY/6ysb/55yQg==
Date: Fri, 26 Jul 2024 13:13:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v6 08/11] ata: ata_piix: Remove useless comment in
 piix_init_sidpr()
Message-ID: <ZqOEzxv0qnJwEeTw@ryzen.lan>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-9-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:51PM +0900, Damien Le Moal wrote:
> Remove the comment using the term "blacklist" from piix_init_sidpr().
> That comment is useless given that the function piix_no_sidpr() name is
> clear about what is being checked.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/ata_piix.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index ec3c5bd1f813..093b940bc953 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1446,7 +1446,6 @@ static int piix_init_sidpr(struct ata_host *host)
>  		if (hpriv->map[i] == IDE)
>  			return 0;
>  
> -	/* is it blacklisted? */
>  	if (piix_no_sidpr(host))
>  		return 0;
>  
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
