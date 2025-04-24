Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35F139B;
	Thu, 24 Apr 2025 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473448; cv=none; b=E2VdK1cYX5O3E+ksbADO3FhoaUTN9dIxMUsG3XgZqIvjMmVpH0sw3p6nI34J/u3+917edI23F1sKeE4/aHj07dNwaxVSw9bGp4zIRyX4jP9yFX/XL7hP/bsgjGwFfbh3whkmAqoK2m6pyoWo3g0h0x3Q8FVAMaYNwJXbVtV5lA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473448; c=relaxed/simple;
	bh=Ei5s8CyZRPbJiS3A9xmW0b8dJC52Fb4Ssy01YhH/pU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=McBm156tt8UmtDHkFArerGk3ppkxHlNJ93fAQVIGxbLA+UQ7LpIyUobSuK1+IJLfnnU84gjlY3wo6opSLn6ehHnq0hfKnGX/5JVyox0hc7QrGIqQOmwRP6PJb9abvwpknOguXT3Jsv6jxo0QcpNRHkAAlJ8a65WY8ZjN+R4hN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYzltdpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYzltdpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CF4C4CEE3;
	Thu, 24 Apr 2025 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745473447;
	bh=Ei5s8CyZRPbJiS3A9xmW0b8dJC52Fb4Ssy01YhH/pU4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iYzltdpk7IueGGSpT5MNjvG559ELui5w27k8lJxseWyyFA6j7DJvkQUCMCR1s/bcI
	 QnSWnaKVVBhPg3FS3rbk2zKzgakyrQKpm94/kRrnpAZbBGImZc5L7TraVI/RRM6C4y
	 fjHzb80NgjrCFrqeL/jEYmm7XJ4FWSvJXsXvPIZJ7Tjg27f5LTXEzCQjTolfNzrKMS
	 9bViFtBYeBU+rTcKP+r3g2OGanILAyE6hH3qYailYa1vUyib2ZkLjqFNj+QsT5R+75
	 aQ7JMjLm1jsBt+K+A4OILvUSMIi8lTqtH2NGl3Dbp1EDCIKLJryYRnDeA4V8fWAx9M
	 wEVC3YrKY2liQ==
Message-ID: <62cfcebc-3280-448c-9fe6-ef6df0b3fcb0@kernel.org>
Date: Thu, 24 Apr 2025 14:44:06 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drive
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>,
 Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAAZ0mTfQ+feHUeRjC3aH9z=sM92XmXASY+3ELzwXJLfk30h_6A@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAAZ0mTfQ+feHUeRjC3aH9z=sM92XmXASY+3ELzwXJLfk30h_6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 02:21, Mikko Juhani Korhonen wrote:
> Make WDC WD20EFAX-68FB5N0 hard drive work again
> after regression in 6.9.0 when LPM was enabled,
> so disable it for this model.
> 
> Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
> 
> diff -u linux-6.14.3/drivers/ata/libata-core.c
> linux-6.14.3-mk/drivers/ata/libata-core.c
> --- linux-6.14.3/drivers/ata/libata-core.c      2025-04-20
> 11:23:22.000000000 +0300
> +++ linux-6.14.3-mk/drivers/ata/libata-core.c   2025-04-22
> 16:53:52.341934384 +0300
> @@ -4238,6 +4238,11 @@
>        { "WDC WD2500JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
>        { "WDC WD3000JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
>        { "WDC WD3200JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
> +
> +       /*
> +        * This specific WD SATA-3 model has problems with LPM.
> +        */
> +       { "WDC WD20EFAX-68FB5N0",       NULL,   ATA_QUIRK_NOLPM },
> 
>        /*
>         * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY

This looks OK but the patch seems broken (missing separator after sign-off so
this does not apply.
Please use "git format-patch" to generate proper patches.
Also please change the patch title to:

ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives

-- 
Damien Le Moal
Western Digital Research
