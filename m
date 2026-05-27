Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FE3DA7E5;
	Wed, 27 May 2026 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887428; cv=none; b=iSPHYPQrp4yOuwxHOfch+ixO3jF9rlNRs3VbpwOArPTCJSeOxkboE8vjpzedNoEFeKF/MMARfRZQKuOvL5rNwv/GobAE3VUqYRggmDF8+LOy/lFjTfVNNEdehJtMl89IaI14hC//bogIAjqyAd4TGlRnMCD5gIUewZVLi+fKSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887428; c=relaxed/simple;
	bh=rNn3bUBZCMOE3efrqE0QGlHDBSXbh5WFil8vibvH70c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpBv7RCFARul98E0JZUgpemH/XQjQD7WtNTzBOaMoA8AuE9HJBO5FV1nG73yQMDT/mH0oNTqlVd4Bfd2p31tIi8qI+6XWcTRkYzwOfopSgaUbIOXtyjmaOwPJNL3gjuIjFlsEY+GwSUYySFYLeWItFdxx6d25GFCbsrvZM6/ZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLr6Zaxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLr6Zaxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3D41F000E9;
	Wed, 27 May 2026 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779887427;
	bh=pE1iGruh4x2UlBMKSzBasUDZ1ZzSXl9WUwrnx7+Y0IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TLr6ZaxrVlZB5/GGF/YXUG5/Uwjp3C0TxygUrTFog883zoAxL3M0WROwfvZyPCuwS
	 CX/fN+LeHStTrSJD8DbrTaasWkr0HVpJbp6dQPHuT9vtq33/XK1OdjKN/VmFKbQIEc
	 sbFPBG8+knbwENY1edkFUnLgdSOZ5MpLP+wxfuURkoM/2oG9+XhcrUkCRCDfUFXMZ1
	 gx1vY0J60h0yNhnYvpnQgbbjCHD9DqU5wBgMXZwnykWUV5NnmhKwV/TW6PTkpjdgZB
	 svMQ16ZehtWnwEZpW6RO/yX2hhJ0co7Iep/Vqkwp1vKGf3Scq/7GPP6ApFJGAddJJg
	 r9763krBfOuAg==
Date: Wed, 27 May 2026 15:10:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: kensanya@163.com
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, TanZheng <tanzheng@kylinos.cn>,
	Michael Lazin <microlaser@gmail.com>
Subject: Re: [PATCH] ahci: use hweight_long() to count port_map bits
Message-ID: <ahbtP36yIfbPHcut@ryzen>
References: <20260527091729.266582-1-kensanya@163.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527091729.266582-1-kensanya@163.com>

On Wed, May 27, 2026 at 05:17:29PM +0800, kensanya@163.com wrote:
> From: TanZheng <tanzheng@kylinos.cn>
> 
> Replace the open loop used to calculate the number of set bits
> in the port mapping with the `hweight_long()` function, which
> simplifies the code without altering its functionality.
> 
> Signed-off-by: TanZheng <tanzheng@kylinos.cn>
> ---
>  drivers/ata/libahci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index c79abdfcd7a9..15d44266c9df 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -552,11 +552,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  
>  	/* cross check port_map and cap.n_ports */
>  	if (port_map) {
> -		int map_ports = 0;
> -
> -		for (i = 0; i < AHCI_MAX_PORTS; i++)
> -			if (port_map & (1 << i))
> -				map_ports++;
> +		int map_ports = hweight_long(port_map);
>  
>  		/* If PI has more ports than n_ports, whine, clear
>  		 * port_map and let it be generated from n_ports.
> -- 
> 2.25.1
> 

Hello TanZheng,

Is it a coincidence that you send this the same day as Michael pointed out
the same, or was this sent as a response to Michael's email?


Kind regards,
Niklas
