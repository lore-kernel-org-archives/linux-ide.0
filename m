Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F222D7A9
	for <linux-ide@vger.kernel.org>; Wed, 10 Dec 2025 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330958; cv=none; b=ts+pvvJzbzmCTCR4i14aY6dW85oIsG5FVq8USOhNHp53mrtkR0oR5ctTSpEfLpHjPUN/Pw958J4OqCtHwU3aDZnwyiGbD/z6QlX3mX2+u8nWXS36d+03YVB+5SHhO7nfCLM/fj7qTObUKUdVTTIejMe289Ortw0WywMLfqTMR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330958; c=relaxed/simple;
	bh=Hn9FywHEGyO3DWn1YtUNf3m4xq9bHbA77UL6drw7OYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iok2BXiHcR2XgODFwSPXHjikcfTf3z/vsi7lzRMuPmw1H9I537o53y1fqyDhmLZftZO+CMuaBTaP3qBrzQDldyfdDE2APi85w7cMyqkUqENKS8LFL2TD2BYjBdBiZ11UKVr0lxmiVpUeEqpQu0YdVf3FwlD3QUzhGBVy+qaPiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7B1CvN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7B1CvN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C5C4CEF5;
	Wed, 10 Dec 2025 01:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765330957;
	bh=Hn9FywHEGyO3DWn1YtUNf3m4xq9bHbA77UL6drw7OYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p7B1CvN8JICIytrMw45drOrYL8t7WF/f2fdOoCf67OQChxMYeLEf/Yg9l2Qea+HBP
	 Ji6KyX++9l7YLQ9h3fI0R/isyG/vp/r/5dEFUtlI9x+utNa3T2+7tenlyxqqCS+3oD
	 svp9xWwoLMWXDmP+FpinWiYrkYWgqkJrl6mO6xiOhQF2akm3cOvW1GyvuOEOkhZFO+
	 Xy1TnNGuVGGZZ2pzrpXOh3iFiQLCV0q9JQ5J2a7tlSHBfsvLfr6eqrfMdFcwSm5eeD
	 IVUPlyLr+jrEOz1hisCS/6Q0T/+kcTf4fSNCbxxMV+WQcTJ57IKq9uW8ZQ4EqwjFQA
	 MmKjn29LwJ1Vg==
Message-ID: <de7c9e53-b153-4e29-a841-99802cabf44b@kernel.org>
Date: Tue, 9 Dec 2025 17:42:37 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ST2000DM008-2FR102
To: Niklas Cassel <cassel@kernel.org>
Cc: Emerson Pinter <e@pinter.dev>, linux-ide@vger.kernel.org
References: <20251209042359.1467124-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251209042359.1467124-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/12/08 20:24, Niklas Cassel wrote:
> According to a user report, the ST2000DM008-2FR102 has problems with LPM.
> 
> Reported-by: Emerson Pinter <e@pinter.dev>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220693
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b96105481784..94c0e0ff981f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4187,6 +4187,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  						ATA_QUIRK_NOLPM },
>  	{ "VB0250EAVER",	"HPG7",		ATA_QUIRK_BROKEN_FPDMA_AA },
>  
> +	/* ST disks with LPM issues */

s/ST/Seagate

Other than that, looks good.

> +	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },
> +
>  	/* Blacklist entries taken from Silicon Image 3124/3132
>  	   Windows driver .inf file - also several Linux problem reports */
>  	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_QUIRK_NONCQ },
> 
> base-commit: a26a0b4b48e181ff5ff340f9dc83612c74f2ccad


-- 
Damien Le Moal
Western Digital Research
