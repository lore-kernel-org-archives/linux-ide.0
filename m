Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75643179211
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992393; cv=none; b=DDOwO9aOndQaYq0go2KueiBjSXPBdqE+Gcl7Qogu8O+1odsC6rqTEWGL2SptxzQglBwVywjNxpO7lfNj+CcAN4pSI5AE7F4QKI2HuqAubwTCsAFuIlKXayWU07+7GkghSCHgzXQ2wP9i4NxYBL4vbTZWAP3lfrBqqcfF7SwELxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992393; c=relaxed/simple;
	bh=8CKUrx77zRc9qIyY8gPn7faGadCnw4gx4DCW2ExAUSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIdIA7Q8kQj//0zNP72C7+NPnTeheHL9t3SNjEbcH6qMuAQRjci79ZppTySG1VcrnGM3nw2k6sHE1q76SnT75KCgmMJrmJkSIgKewKsraEijqIPJ0F6AJkFqMtfDbWp2LMsbSX1vTwXGQHD6wA9FNx4Wzw0OufiTikxaylu/efw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta0SboJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta0SboJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DAFC32782;
	Fri, 26 Jul 2024 11:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992393;
	bh=8CKUrx77zRc9qIyY8gPn7faGadCnw4gx4DCW2ExAUSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ta0SboJyEH1BK5+rWoF10l9GL4lLwB9BCvUYFmYu4Zrisd1Teq46qsGFE0lJy/VqP
	 X9Qfz10RZ010t3/+d0PqVoctTgY8b218VGS4dg0+Gfypyq6AUrHv4wBji2Nx6ZT09o
	 e+4u1zpW3QC9Yz/Z9vCv3AJkiCtgxMByirSYhA0VcNh3s+5uKJk/gRlT2DoEXSf14d
	 JnkcMlzJQaP5beiLehqZXkCxaabvgf/WrEQc/Vj5oB5aFk4G6JPtRyxNl2+8YbPcs6
	 +1VURYfkK4Kpl+GIqYtZvqoK2pmG5J8ppRHjcORZB2NkaIammEN5Fy7NYZPfRhpQnE
	 0Jh+PsPxRYurA==
Date: Fri, 26 Jul 2024 13:13:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v6 07/11] ata: sata_sil: Rename sil_blacklist to
 sil_quirks
Message-ID: <ZqOExSwwrG5LM0ul@ryzen.lan>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-8-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:50PM +0900, Damien Le Moal wrote:
> Rename the array sil_blacklist to sil_quirks as this name is more
> neutral and is also consistent with how this driver define quirks with
> the SIL_QUIRK_XXX flags.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/sata_sil.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index 354b68ef91bc..3a99f66198a9 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -128,7 +128,7 @@ static const struct pci_device_id sil_pci_tbl[] = {
>  static const struct sil_drivelist {
>  	const char *product;
>  	unsigned int quirk;
> -} sil_blacklist [] = {
> +} sil_quirks[] = {
>  	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
>  	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
>  	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
> @@ -600,8 +600,8 @@ static void sil_thaw(struct ata_port *ap)
>   *	list, and apply the fixups to only the specific
>   *	devices/hosts/firmwares that need it.
>   *
> - *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
> - *	The Maxtor quirk is in the blacklist, but I'm keeping the original
> + *	20040111 - Seagate drives affected by the Mod15Write bug are quirked
> + *	The Maxtor quirk is in sil_quirks, but I'm keeping the original
>   *	pessimistic fix for the following reasons...
>   *	- There seems to be less info on it, only one device gleaned off the
>   *	Windows	driver, maybe only one is affected.  More info would be greatly
> @@ -620,9 +620,9 @@ static void sil_dev_config(struct ata_device *dev)
>  
>  	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
>  
> -	for (n = 0; sil_blacklist[n].product; n++)
> -		if (!strcmp(sil_blacklist[n].product, model_num)) {
> -			quirks = sil_blacklist[n].quirk;
> +	for (n = 0; sil_quirks[n].product; n++)
> +		if (!strcmp(sil_quirks[n].product, model_num)) {
> +			quirks = sil_quirks[n].quirk;
>  			break;
>  		}
>  
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
