Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAE1804A
	for <linux-ide@vger.kernel.org>; Sun, 10 Mar 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710058323; cv=none; b=NyLsVHcNEm+SQMO6oKn3klimN070V9reLIpUjnTB5rrTU3acpWJ966pL5I+RKI/Iy1fEW+/qIZcZCguO8+h3abgmC+XYybF63Z30KrGE/45bAySy8InPKdii9igEWyD0QH8hI0vYcSue8Z0lJ9vyEO9Rw9ip96G7a7wPHMpG4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710058323; c=relaxed/simple;
	bh=a7VHCxVgCA9NIGrobg685jzYlcPde/yONbPeuBZpkpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxLTPaNf9OgAzKBLY+LAmBDHdtHg8g0Kx8ezxWrQWPiKc9FgG/ux6QEY5NYuTyH5MO/cx5qS/7sMi8DyEAIPb6shASDH+HwBWP4ViaP0fyofsK25p0dQoAn5SnaQpbtuu74bED0Kz+fkgY5eIKz98EHeivn3cp3i5MWsWhyEO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7nC1Epb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7nC1Epb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a456ab934eeso466140866b.0
        for <linux-ide@vger.kernel.org>; Sun, 10 Mar 2024 00:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710058320; x=1710663120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmakKdQIuqHSmuTlD4J9+Apajr0QrZ54760GJSqDt2U=;
        b=F7nC1EpbKwEVSlR0KifZMzUWFb8yiz2NuMkfSo9XWNJRRrnhlbpHjhgdzlL0IVIDOu
         OhnWgBmUQYoYr331t2v+7n84U2cOBRc+KIQTSEuK8AP0+NGVJLvK0pnZebhHeKfhoKRw
         d11Gfh6KjhairzXY264JLJeBVI6zivJ14tADL8oBlXRV0o8xYCjGYnv178IfCWrQxwzZ
         LuQRtWuPRVOL2iXGg/QUXjMLHRQZA38436QfqRMOMRVEdNiyBzchWzeLq2b27k4RkCqH
         nIwL+5KcbtQD2Lt/GrIYHatEFTCXPwRRBX6rQyd6hLJjBIiALvKsPDH+PyZjP9zKuW2W
         86aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710058320; x=1710663120;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmakKdQIuqHSmuTlD4J9+Apajr0QrZ54760GJSqDt2U=;
        b=mdVl1euG/qlNdqEF1jmfVng1KIFH8Kevler/9bNuPAyBO64HtafVV5StSsYtt05Rko
         ozcz8l18EOOSjvyIVm5ML3OwoC84ChdsZq7GI+HDMICsxzCWsOMYaPBfTSGHi5TwYS23
         7PgFgLzfZR2az+UtBnH47FdJPJO7ZkY/vVb1RhThp0EGx9kSOc+plub8AHJCs/uaWLwH
         Dgzz8jGz0rLL9+q4/BZe+DDyEbR3kBAqHYifY1dSP5dqFSnUzA3/PnZLlGv5s2FavMtg
         QjyxjZaPXARlCKWEsuljAxR0cOGpBngyAEAzSDMRV30vaDMgEb/zRgKV0lXxzPb0cufV
         cHlg==
X-Forwarded-Encrypted: i=1; AJvYcCWzBhjm4pwhZHp7fGsn/zE67TzOaXyIAbPC9+L90AX1HlA3N65f7zudUs3Xp1QxQ7cc503K4xdRjzQWuqJXi+NXUqFV1DnTYMJ0
X-Gm-Message-State: AOJu0Yx+OHs75QiUtD+v5YMXU2RkqSuoNXrnJvsgaKx4rXTymqkljKSN
	F2bLuGeWSkCabOvlXasVlqVteXjXcPWgTkiTh4km2x9QCHWklX8/uvUYyu03NPA=
X-Google-Smtp-Source: AGHT+IH5RriZNGNPH706+Wr2p3GWlBhGl9P35WK3FpRC40nTxpvdZsDxD5PP2nLY3JQyUUWXp/OaXQ==
X-Received: by 2002:a17:906:9c87:b0:a45:ba06:e512 with SMTP id fj7-20020a1709069c8700b00a45ba06e512mr2555644ejc.6.1710058320054;
        Sun, 10 Mar 2024 00:12:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906231300b00a449d6184dasm1685774eja.6.2024.03.10.00.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 00:11:59 -0800 (PST)
Message-ID: <5572ba82-25ce-4216-a1e9-3a7def42cb28@linaro.org>
Date: Sun, 10 Mar 2024 09:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: imx-pata: Convert to dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240310051914.153193-1-animeshagarwal28@gmail.com>
 <8a822699-aca5-4bcd-9bbf-86104a98f3f8@linaro.org>
 <CAE3Oz80eZffUp9NCdkGYzt-uin8aevVx6w9Zxye6R1CURQjrhA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAE3Oz80eZffUp9NCdkGYzt-uin8aevVx6w9Zxye6R1CURQjrhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2024 09:03, Animesh Agarwal wrote:
> 'enum' is applied in a list compatibles which is equivalent to 'oneOf'.
> Followed by 'const: fsl,imx27-pata' ensuring 1 enum and 1 const value
> matches.
> 
> Should I use oneOf instead?

Why don't you respond to the comment?

Also, you ignored my other comments. No, that is not how it works. Go
and respond to each of them and answer how did you implement the
solution to my comment.

Best regards,
Krzysztof

