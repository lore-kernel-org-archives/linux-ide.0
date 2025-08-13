Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39301283FC8
	for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099954; cv=none; b=CnlpCsFqC4zPr8y9fvrBRGsteypQ0vDULalP9UKMybbdgwRi+4u3D5/S0EjPAzuBrXNuzNlJFwuUfJoO42uXgjhIGOXfEUdZmDurzH+K17wMkMO7xKk5xwT/zdFIzoUSn+ASZvoXSHXWhk7MEZY1Ry1KTV4CUgrsIs0Sgcff44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099954; c=relaxed/simple;
	bh=CyjKM3FAGIcarIfEVSPRWFUSruBznu/jL9+iu5VyYWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE09ZR+63PwwMy0/MSFspkwNoxPVmf4py25AAqYfkrVzjQ8ng1pe2avEVWTUN1dohZspqFLkBIf7d+D7nj+HhaIiieCpa1hH1RJ7IEwk4dxEUGCvzYBe4hUq9T+c0UPHLWH8/9SFvexL3py90VEvukWRCGYHqXAPEMBay7xVwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGN7CU03; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGN7CU03"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso6953894e87.2
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2025 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099951; x=1755704751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9T6ss3lClm8rmsy51ZMwH+Js8ZJsClejp2NgssssVQ=;
        b=nGN7CU03pcw/h1YhVQE3sGAEQqLPc9pFp9egKKjPEtt3aLuu0gdkdf0Leirj3hJQ0X
         1eue2kgicJuMnppa8jAW2O46tfT79/3u3oJwqXAip2yP3AZ9D0xETLfUX4tdfGMT6cZi
         kls+zD6FgIJGoAhYorWx9KylzWKJO+dtugntWD3iHiL9MLDFbLGYn9nX5WhWOnrPMDez
         si5C58vXU3lyKDd+153pxxEzwGQDOneV/cNaOSsIkL07tkY2+NlJExVoZMTaDiy5mZLR
         G/vlozvAKDMZzP6U+MNs1hr5/wCQWSk7OlwdmofhBZEHecj6UiJO+GrzQzBzabXqiRAG
         4Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099951; x=1755704751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9T6ss3lClm8rmsy51ZMwH+Js8ZJsClejp2NgssssVQ=;
        b=awesnhJtn9rH26myBMWXBYdP4glX6u2tNSXhfZ/SSmhm7R2x/bp5rVY3Hgf8VXTMoT
         VniCDlyJZr6GY1/A8atfBuDDx3fdqcrqbeIbBMJtF+dfvh+kGKJcSJd0NTurcoKBaHU+
         QoNLwHRbrnpSoOISNraloVOUojN0StjtMeq0yf1aEj8DCa0zAdrE8J4AHh6u7JJt+PPf
         E55LccmFiKGdf0V0dVh0we0lbtIN230nbRv9oI4pLt83vMh9s4XK/LZeP6CE+/0a2CID
         AFAIr8pHWYkKsHA8bqucX2mSici5IVX8bCAdkxJ+/ULGPCqULiyirTF+GGGnZG/jyjao
         8yBw==
X-Forwarded-Encrypted: i=1; AJvYcCUFBHuADZm8+Z4ebQ9t/lOKa4USQ/R2oOAnv2Qn/5aQZOJnkffJXn0zprm49f0DdgPR3Pw+7JSYLCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0J3hiFteR50bH5gLe3aajPqrgmi84dLPFi+mkAJaQpQb4rG9F
	hIMupW3X8leA5z9aTmVmy8S0PLJ3EFQ4KiII/P7VR4hWpvm4f/B5wSHo
X-Gm-Gg: ASbGncsou7UkIjr+OgS/3X7bOFR5sIsp+UmStPTzv0TZro/UiZ/bSrnK3CPjeoa5jTp
	FA/fyNoOSSiiagguis7f8VHLXH9gyF9S5IGvIatM+siJKLsJoEVi8kMxNd8w9hmBTJknJJ6GGtd
	QQhMQ+aOnjPvg3JL2RMkNX//1uTvzO7ZefCIsAKGOygeljVTds9s53Ag2xIil4x2JkDB3cE5s5e
	7IatYP2aiuXqcnMfEvq4iIr/YqPJc3dFCZ7qUlpZFytaWlpx7fyKoFNu4F8flN02DmeQhKYbMU3
	vM50BzYGQVIXUXhsEyD+6sMJo8WAIg+QQWOa4Ae9IWrWMNwhQlhTpFI8m28+pN7WU/Wh5+UB6Vm
	pQ/tTufTa/OUVj34fx9H7FpwR1QO39KLReSWmDlZssSKABwcCekiaun+Q+5eT+iolxogRkzt1Iv
	wPtG16
X-Google-Smtp-Source: AGHT+IGKRcAmMXidUxd/7yF+CNyaGtLOi9Ntwslj0/5ITde40SaD8L1RcxBwCoFhQm72Cx7EJO1fEA==
X-Received: by 2002:a05:6512:3091:b0:55b:8a71:db1d with SMTP id 2adb3069b0e04-55ce012f67cmr1246733e87.14.1755099951005;
        Wed, 13 Aug 2025 08:45:51 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:44ba:180f:564e:6201:fd15:9c38? ([2a00:1fa0:44ba:180f:564e:6201:fd15:9c38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beb4sm5395603e87.30.2025.08.13.08.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:45:50 -0700 (PDT)
Message-ID: <1dfed1b7-3686-4e9a-a276-f53d3ebf1146@gmail.com>
Date: Wed, 13 Aug 2025 18:45:49 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: Fix link state check for IDE/PATA ports
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250813092707.447479-1-dlemoal@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20250813092707.447479-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 12:27 PM, Damien Le Moal wrote:

> Commit 4371fe1ba400 ("ata: libata-eh: Avoid unnecessary resets when
> revalidating devices") replaced the call to ata_phys_link_offline() in
> ata_eh_revalidate_and_attach() with the new function
> ata_eh_link_established() which relaxes the checks on a device link
> state to account for low power mode transitions. However, this changed
> assumed that the device port has a valid scr_read method to obstain the
> SSTATUS register for the port. This is not always the case, especially

   Hum, another nit... Don't the SATA specs call this register SStatus?

> with older IDE/PATA adapters (e.g. as emulated with qemu). For such
> adapter, ata_eh_link_established() will always return false, causing
> ata_eh_revalidate_and_attach() to go into its error path and ultimately
> to the device being disabled.
> 
> Avoid this by restoring the previous behavior, which is to assume that
> the link is online if reading the port SSTATUS register fails.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 4371fe1ba400 ("ata: libata-eh: Avoid unnecessary resets when revalidating devices")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-eh.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 2946ae6d4b2c..354d2c0abcf3 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2089,8 +2089,13 @@ static bool ata_eh_link_established(struct ata_link *link)
>  	u32 sstatus;
>  	u8 det, ipm;
>  
> +	/*
> +	 * For old IDE/PATA adapters that do not have a valid scr_read method,
> +	 * or if reading the SSTATUS register fails, assume that the device is

   Same comment here... 

> +	 * present. Device probe will determine if that is really the case.
> +	 */
>  	if (sata_scr_read(link, SCR_STATUS, &sstatus))
> -		return false;
> +		return true;
>  
>  	det = sstatus & 0x0f;
>  	ipm = (sstatus >> 8) & 0x0f;

MBR, Sergey

