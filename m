Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54072199FAC
	for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268461; cv=none; b=sT3hCP4ygdJ13qHCpzWT/ttwck2IeIPaQ/S9Q03J+xzIGWWqR0atBVzVJa8ZUyjjQsooACaHVRfSC9F22Fkm87V/E9iqH8i0Tb/9ndzs14gz4FjWyxP8IFBsUdeMnXHUFY02vLHwBKC6ffy1x4yHkIRPSe90bbSEYbphhJqsrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268461; c=relaxed/simple;
	bh=0+Dy/VfOu4qClGxMRiPJ3hNwhWMbh/OmyZUDqplbmZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4Ln6gidye5ERrIZP4EB2GdquKmpwOzpNzlfexC7ZxdhYBfzLoHqhjMLPDeizvauGP4eY0WQr2uhODWkt/ln7Go1afLgX+mtNUEqdv5BykaVmpA81xEEkKEHgjOsRxzytUZLYO/lDXAHBj/O7/9ll/5Fs+unQNRtFK+PgpoOgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGKO4KqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGKO4KqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748268458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8m8ijweaoU+8LMzuYkxM7ZGrr39vrMzgoGwf/XopVos=;
	b=EGKO4KqLVVSgFsoAcoIlMTOFrXZ11MoDl5gaqPg9MMqQ/o9+97cIDLMV4lzjN4Op5AytbY
	BL1Zv7Yn/js7e+PkIjh9AdQwW6Z7UF4ohgxR1O68NiQvADQGXaKeYdriTnCUix4ja3OXuU
	SBhuUpIEKqC3yDzfCNoqlegVt4Yl3VI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-jm0aeDnnNFyKY9cD0xjuXQ-1; Mon, 26 May 2025 10:07:31 -0400
X-MC-Unique: jm0aeDnnNFyKY9cD0xjuXQ-1
X-Mimecast-MFC-AGG-ID: jm0aeDnnNFyKY9cD0xjuXQ_1748268449
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad5271a051eso214507766b.1
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 07:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748268448; x=1748873248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8m8ijweaoU+8LMzuYkxM7ZGrr39vrMzgoGwf/XopVos=;
        b=aNYIU/CbOC8j4/SWXPWLqzWJuKeCyrKwCv+n4amfiaC3b0ztKckLuCC6kWjgOjDRqL
         bhy+zVaFquiv1+kkfunmdgVwVHFVOeXsU0dbOcvYy0fJbXy/krjCv9cXO57R3Hj1zJDT
         +3dA7Bie2flgf49QV0hTMspegYUlYcE2IuNwlp+/6nF5DuoMbhOx9Dj9nx5FtPfK0Ho1
         rmzqJE8nkRJH24aQxCsMAN+f0+5puLsZvGNoeQB8ouWJLVXPeERs6LGTPQcig34ToHuu
         SbEj4VFOqa3MBxAHDFaBwyyuVmRlc6LYSOBOBXSiz6Zn7yIskcNKXJ7huBOtP15HJlpu
         EDfg==
X-Forwarded-Encrypted: i=1; AJvYcCUALv1J2o6gGABruVuDPVJfgWwQKkD+Fa6QMAigkBZh3/zUwTfsFmm8X1r1EDfqU99NTzeY/Mnv9gU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4k0iNRyPplGA70Gd01wGOSHeDTvKr4GJmZakfqL3MTipMUJ3V
	Gpb9iubR/XOgkfCBFcgWD6Qlh9Od9xSV6UdNwS4+hQP4hCf+ah3ecXnHOUEb6fshej21AFvnG8d
	CFKOzyJs69l6F15Hp2kHzVpH4iSCFvoGM7AhSr/H/avHvH1KeBVK9kR+P3A6ihA==
X-Gm-Gg: ASbGncvKr/dxsPYR8bhwEXGMCTg1aC0V4ovpMIO40LDj8ixxjjPTGXDLzLsIbYKGuEQ
	3DUlcXN0G5MS7J9qImVqH02tVDg9r1KtttQtE5/7IgXOI3ya0NPaSLRCIFa0SfBjXexAw6teZu8
	hYO52ycTrmvEooAtCVvdjNCEiVGD2PXQDuIheAl4vAS2qWuA94vQfWT8jrVxrFfGrGVkaUB7nF2
	iFpjJZ0ACpkPF75zH7M/7sNJq3B2ziSIogEF7xZzTQQjM8lLA99b2M2hA3lou09IvxN0MoQ0Cef
	WOwYtQuGXUihxQg=
X-Received: by 2002:a17:907:d92:b0:ad5:3746:5906 with SMTP id a640c23a62f3a-ad85b319916mr871952766b.49.1748268448519;
        Mon, 26 May 2025 07:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxs+SqTPc9z2xdseHU44sW/PIhCH97QitvBgtFiGNCl3hUtl5NEYpg0eAJF92OCqA/atZZrA==
X-Received: by 2002:a17:907:d92:b0:ad5:3746:5906 with SMTP id a640c23a62f3a-ad85b319916mr871948466b.49.1748268448063;
        Mon, 26 May 2025 07:07:28 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4cc5dbsm1677599566b.169.2025.05.26.07.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 07:07:27 -0700 (PDT)
Message-ID: <42261be1-ee42-4508-a282-87bc543d4b88@redhat.com>
Date: Mon, 26 May 2025 16:07:26 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>
Cc: kernel-dev@rsta79.anonaddy.me, Andy Yang <andyybtc79@gmail.com>,
 linux-ide@vger.kernel.org
References: <20250526140312.228894-2-cassel@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250526140312.228894-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-May-25 16:03, Niklas Cassel wrote:
> A user has bisected a regression which causes graphical corruptions on his
> screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
> type").
> 
> Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
> board type") makes the graphical corruptions on his screen to go away.
> (Note: there are no visible messages in dmesg that indicates a problem
> with AHCI.)
> 
> The user also reports that the problem occurs regardless if there is an
> HDD or an SSD connected via AHCI, so the problem is not device related.
> 
> The devices also work fine on other motherboards, so it seems specific to
> the ASUSPRO-D840SA motherboard.
> 
> While enabling low power modes for AHCI is not supposed to affect
> completely unrelated hardware, like a graphics card, it does however
> allow the system to enter deeper PC-states, which could expose ACPI issues
> that were previously not visible (because the system never entered these
> lower power states before).
> 
> There are previous examples where enabling LPM exposed serious BIOS/ACPI
> bugs, see e.g. commit 240630e61870 ("ahci: Disable LPM on Lenovo 50 series
> laptops with a too old BIOS").
> 
> Since there hasn't been any BIOS update in years for the ASUSPRO-D840SA
> motherboard, disable LPM for this board, in order to avoid entering lower
> PC-states, which triggers graphical corruptions.
> 
> Reported-by: Andy Yang <andyybtc79@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/ata/ahci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 163ac909bd06..03f24bff040c 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1411,7 +1411,10 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
>  static bool ahci_broken_lpm(struct pci_dev *pdev)
>  {
>  	static const struct dmi_system_id sysids[] = {
> -		/* Various Lenovo 50 series have LPM issues with older BIOSen */
> +		/*
> +		 * Various Lenovo 50 series and some ASUS boards have LPM issues
> +		 * with older BIOS versions.
> +		 */
>  		{
>  			.matches = {
>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> @@ -1446,6 +1449,13 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  			 */
>  			.driver_data = "20180310", /* 2.35 */
>  		},
> +		{
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA/D840MB"),
> +			},
> +			.driver_data = "20230208", /* 320 */
> +		},
>  		{ }	/* terminate list */
>  	};
>  	const struct dmi_system_id *dmi = dmi_first_match(sysids);

