Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66886323D;
	Fri, 25 Apr 2025 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543670; cv=none; b=GPU/JLdjvcQcZR923uQYLNGFTz7/K6PpXt9yPwzB6vloMjGWWFQjIOTdQZzSV3st/Ggheo2IaxJPwfVsyS0Hk7w/oGF0S5lKI2/+MqrVnf+gM33yKRZ73l/YESJjS9uxvQ097uddFpksBikCUio40UWr9wO7rgsmMS4pvq0lD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543670; c=relaxed/simple;
	bh=iA7ur5jr+Ij18pQxtEEBC4oOx9yaqy4XI8FUIfaR1+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7LX+IU4AXV1Arw9ACYLuLaoUjXiWKRzRfh802MatmB1b63ekN5WOATTiF9rJZ28xY6YiFumN6iM7HbcOWox5RhO89tMRhLNjwJ18Gu76Nvj7vyajxAd9Eu3VNVpBFCiPtDhcE3THU4yIA56xihVv4Dcarm0dJdnicDPXESIuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocKvN4OL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocKvN4OL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312ABC4CEE3;
	Fri, 25 Apr 2025 01:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745543669;
	bh=iA7ur5jr+Ij18pQxtEEBC4oOx9yaqy4XI8FUIfaR1+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ocKvN4OLqc83/LctCTGBz5x8TaqUdrosvtOn6I9GGhbYRIy1HS5fLjVkcIhO+6Uoy
	 5cmZ6DK0yL9Bqx7YjsRM9cdDgWzWOadJf5AEumHtmO6RHrBmlAC+E0cfYnHrmk5IJ/
	 IlT68jJNdB4LlCNFLx0mM/odJn0gLKFywryn9JXxYXyUtoUdHZaLwef2iZJvCYSTdr
	 /3n5ZX/pkGdsKPKQ9wuyNaTQXJTJX6OOlswzMZ+FZwh0s9Z2ppWepY9CPgz+9NIFC5
	 H2ryezmlZb5UDZvyZgy196/gO+E8JPYdBLMV+ADTB5SkHvoo/39DbVTe3nA0j+lX/i
	 877C52zkJlxxA==
Message-ID: <5f7a1675-1386-4ca5-8614-99b4847742ab@kernel.org>
Date: Fri, 25 Apr 2025 10:14:28 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard
 drives
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAAZ0mTfQ+feHUeRjC3aH9z=sM92XmXASY+3ELzwXJLfk30h_6A@mail.gmail.com>
 <62cfcebc-3280-448c-9fe6-ef6df0b3fcb0@kernel.org>
 <CAAZ0mTdUkG5yp+XkBGE9Wc2V8np6r-DyNJSCa7Yo0k2bNzuq9w@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAAZ0mTdUkG5yp+XkBGE9Wc2V8np6r-DyNJSCa7Yo0k2bNzuq9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 05:43, Mikko Juhani Korhonen wrote:
> Make WDC WD20EFAX-68FB5N0 hard drive work again
> after regression in 6.9.0 when LPM was enabled,
> so disable it for this model
> 
> Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>

I still cannot apply this. I get the errors:

error: corrupt patch at line 10
error: could not build fake ancestor

Your base-commit is Linus tag for Linux 6.14, which is not appropriate for new
patches. Please rebase this on libata for-6.15-fixes branch or Linus latest tree.

Also please properly format you commit message to use up to 72 characters per
line. And terminate your sentence with a period please.

> ---
> drivers/ata/libata-core.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d956735e2a76..c429ba259548 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4208,6 +4208,11 @@ static const struct ata_dev_quirks_entry
> __ata_dev_quirks[] = {
>        { "WDC WD3000JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
>        { "WDC WD3200JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
> 
> +       /*
> +        * This specific WD SATA-3 model has problems with LPM.
> +        */
> +       { "WDC WD20EFAX-68FB5N0",       NULL,   ATA_QUIRK_NOLPM },
> +
>        /*
>         * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
>         * log page is accessed. Ensure we never ask for this log page with
> 
> base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
> --
> 2.47.2


-- 
Damien Le Moal
Western Digital Research
