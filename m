Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35193347DD;
	Wed,  4 Mar 2026 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772585563; cv=none; b=tlACmMqEAZv3y4DwwWUkFwwwPOj0h8vcB/pSiEkEdjc1lU5wXpHylkZ2h+BYD8EM+GCWrOfX1wyIWyMcjwrRY4g/d4fkRxWJJoQg64ZMw1o2ZEplua+LwAyaxMcdbyvTDB4QintQ2mFoi3FLBG+9unZ+y5H7ED8qvyHsIq8gLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772585563; c=relaxed/simple;
	bh=BhgHjqBrpD4tKo9sHdWPfVTzNuEeTOPr1ugk/pRikWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdQ5G7X+kBYHaMuGA+G2OTrL1i0dd98rH/BpFYtXNlmKK2dTmeiYwqfAgrcichsPEGWkGJsnV2wEz8FNfpbp20fHwJWR7/NqxFCha0PSAXKyFV6O5T8gzr+HfCiWyubEcDhJUE+irJujr+0xKE4dNp0WYMqEs5NRqYovpy1R0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pANpF4rA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pANpF4rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D47C116C6;
	Wed,  4 Mar 2026 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772585562;
	bh=BhgHjqBrpD4tKo9sHdWPfVTzNuEeTOPr1ugk/pRikWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pANpF4rASVVDJpvmBkQT8AWiYGSUqMR1siPkmYvTE2wSolVaR9TeG9Iylo5435GyW
	 M/fdb4xLalug7L3Mb8IvDPJ5CqQAQAcpcpmfRCggQFVhj/5Y8AEBA/ZN2la1/JrBql
	 8JhdCKbn5RdRu74HnlsxS+bLMygqJJCVm1qsti7LG39spSjMra4ToOXHTQGEEg08kN
	 1P9yMX5CvX5b144JuaaLsV4IuVu6p398peGTafGiyjCDtWUEcCkop58lAUIX81HdW9
	 wIbjHF0Zu9wYGZliTHY72usy0OrFmVplM9JCjRc6snsOT596hTHBRM1I//VkOLlA3F
	 6YIR6eQiMxpnQ==
Message-ID: <9834e067-9018-4a47-9591-d5784dcca26d@kernel.org>
Date: Wed, 4 Mar 2026 09:52:40 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ST1000DM010-2EP102
To: maximilianpezzullo@gmail.com, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
References: <20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v1-1-40d5db367f67@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v1-1-40d5db367f67@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 07:52, Maximilian Pezzullo via B4 Relay wrote:
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> According to a user report, the ST1000DM010-2EP102 has problems with LPM,
> causing random system freezes since kernel 6.15. The drive belongs to the
> same BarraCuda family as the ST2000DM008-2FR102 which has the same issue.
> 
> Reported-by: Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221163
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

Seriously ?

> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/ata/libata-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ccbf320524da..76b012f544ea 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4189,6 +4189,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  						ATA_QUIRK_FIRMWARE_WARN },
>  
>  	/* Seagate disks with LPM issues */
> +	{ "ST1000DM010-2EP102",	NULL,		ATA_QUIRK_NOLPM },
>  	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },

Note: if we see one more of these, I am going to be tempted to replace this with
a big hammer :)

	{ "ST?000DM0*",		NULL,		ATA_QUIRK_NOLPM },

>  
>  	/* drives which fail FPDMA_AA activation (some may freeze afterwards)
> 
> ---
> base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
> change-id: 20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-b0b85608e034
> 
> Best regards,


-- 
Damien Le Moal
Western Digital Research
