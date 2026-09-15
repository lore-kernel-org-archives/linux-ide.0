Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4D35B137
	for <linux-ide@vger.kernel.org>; Tue, 15 Sep 2026 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444627; cv=none; b=EZeqmpo/07uhzuJS0K7cpj0zqJ91jYbK43GERt4fGXnttThZG/wPX5xyZMR205TX0Hcik1Y18bvlhGVWqKR1+I2Lg3dC2dK3GKVQDt9lSA38y6mGBRLwB7fGfJoz+ezGNIl4i7RbUAradJcanQepHeigJwWzjPsYUhh/S/8QVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444627; c=relaxed/simple;
	bh=K/ac7gwAcFIZ5qN2jXMncwlgvFhAAO8JmgIUEze8YjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fx70STIdTSi85sxY89CxoVPqFtAJnPa+AMlQlcDT74IpAALKVnHjmJmbX4xWo+rFg5dwjUi6fJ9PLpLFQoZwRfCYzMTU6/uryA6jsoOqwFjNDiwQgo5AUAeYj/ymkDK9KY98bf5JSvYATv+CP+PnIU6XX3O9OlJ9J5P168AQGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALKXEs9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALKXEs9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB8E1F000FF;
	Tue, 15 Sep 2026 03:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789444624;
	bh=quo6a5khn+SQn9lAN+JI4udXCYbLH5cGSCyBweeii/g=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=ALKXEs9dgsqdnQmXfJi+g3ny9UYzPAyBnntRHd5rWEzuDbnftpsHbr1VRltRC990M
	 ba8iSDldbT4EbioC3dJ2+ZWp4aeEuFOcJDNR2+Ml9m25lRA+XDecklrT540c1LOlq0
	 8zmgp7dHKN9LjtxbMrfxJwViumHgeeOjxRcybDGSokE6H/Jz5DZQa2e2MjE3B7SMaC
	 RgKVTG/OdwJ3X4nYO0peftE53dv1Nw9LkRXbrJG3zXOlNhSuTRJuPT1snGJH6TPDiS
	 KO80USqE/1Sr7bjKdZjDhJ7KL3dK4bdfP/g5LJKIvPv1jyVCcjUIvAt1vl9gGTWdQJ
	 ynyP5XmnWLbhw==
Message-ID: <40630ece-de85-48a5-8683-93be32e5d644@kernel.org>
Date: Tue, 15 Sep 2026 10:57:01 +0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libata: Fix HPA horkage to target whole model series not
 just a few devices
To: Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org
References: <20260913135650.14244-1-jnyb.de@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260913135650.14244-1-jnyb.de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/13 20:56, Ioannis Barkas wrote:
> Fixes: 16c55b038033 (\libata: implement BROKEN_HPA horkage and apply it to affected drives")

As indicated by Sashiko, this is not formatted correctly.

> 

Drop this blank line too please.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=8888
> 

And this one as well.

Also please write a proper commit message that explains what you are changing.
Because saying "target whole model series" in the commit title but changing the
quirk entries to still have a FW revision does not do that at all.

> Signed-off-by: Nick Barkas nickbgrk@gmail.com
> Signed-off-by: Ioannis Barkas <jnyb.de@gmail.com>
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
>  	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
>  
>  	/* this one allows HPA unlocking but fails IOs on the area */


-- 
Damien Le Moal
Western Digital Research
