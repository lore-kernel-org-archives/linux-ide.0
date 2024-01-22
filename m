Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28939840
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912675; cv=none; b=EbDyjRN2hPDOQ8AiwxTWHBGrqjkkUTTBUscODvzBDvT/SbRC3J81F84ifvz87bsGWIZ57cEFQpqxyg0Pvh/EIMpTNfvVvYhpw1HG+JAYI8nuGFecmzlhZQywXlJl2cCWoH3b/6d99KEBCkwBrkZOwo1mAe3sMd+yxixVRlEKJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912675; c=relaxed/simple;
	bh=MwPaCJPw++E8PIn4Hqnux05BstFuVu+QoD5HGY5qUZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoAJ/bXQF+tjq4PPQ5zhWqWUtFsx1ALGxyYW3SBps8f+flej5hmaXgUDOHQjUWYoD5kvNe+LyV7YqGkHVHbhyviOniebjrrmqjED9JxODaPunMlMzbRqFAFq1sjMNgGOLDcIyUFV4xDGGk6cy3cMnc92Ew8v4ayTUy4wq+8Z4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=npus38s0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npus38s0"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-339289fead2so1991757f8f.3
        for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2024 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705912672; x=1706517472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4EXdpsgY4Ktaq7S3kqrhLz4Kg2ZClMQ4mxi2Kzi2GZk=;
        b=npus38s0l2MrQsqmNZfczASYAsVbZkqjGm01j34AQrwAKgV243PHFSTigLBrjBoz9a
         ALfdIuOcAXml4aj+NMY4kON/ufQQ/cq89DhBODJSEnePS8UCEE5yWZCqh4D9ZuTMrjwV
         6msmo0BsAhmkvZtLCi9ZugpGXuRX9WRWQDkoCBfoRPyuIjFRuPJjXmhzyPfl+XKQEjF3
         7bvF/ygxXBV4XRHuygNU8xiNNq7OOoOgjjkxMk11D1VqKPMk9bxXwkhDB+/12FloP5ha
         xZMpDLDxDSoBhH1aQjcHkA42K/u3ybw27BPCdjC6/6EUfB3fkT4hp3Q0kzHh4IulNAcy
         5A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912672; x=1706517472;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EXdpsgY4Ktaq7S3kqrhLz4Kg2ZClMQ4mxi2Kzi2GZk=;
        b=Nymm4RTV1K0/ZmO5lXGq2fOKtm1ZeueVWpKqFx0YG+38ISINtw+4lXbRwkaAHkG9Jq
         Y3E4B+JTDBWkV9hrwYIDGJQnlMSxgUAPwkuJHnb8K6XarXAEZ5IZL6dWHvyUk1oauqM8
         4K7RxS8alDZOHbWU8qdt+GwAN7rMK2pWk4UgMgwSu04Olcma76InO67EErqUbM5fY+Ov
         1RGvT96O/Rx97MNh+jWbfu7gxiVHhkcpJ/i48mPui4d3cQ6N7Fuzkq1vg0ewrTg+57KC
         hgOipeZ+dI3ePk/ZZQR8At3vB3yNC0R4wtWkX3ocbTOENr79oVt+y39cvSYopCVKsTh0
         oqog==
X-Gm-Message-State: AOJu0Yyjqs01+ZmIkbex6RwCDW8PUvwP/IzhAkGzXE7jMctk6xZAEagx
	0b6Xc1egg3FL/hWW2Ynt6B7eGLaqUq2fuvODuIpupTfopWQMLX5GR9ki1zIGZ00=
X-Google-Smtp-Source: AGHT+IEy0UeH8Xm2sFRTbxlsME68iEVkpyNkH2TnynIHzbzOg0KnzfcgBkoEvxHlOjjkwDPi4Mhf1Q==
X-Received: by 2002:a5d:6383:0:b0:336:7b79:3caa with SMTP id p3-20020a5d6383000000b003367b793caamr2196812wru.76.1705912672108;
        Mon, 22 Jan 2024 00:37:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q6-20020a5d6586000000b0033921f48044sm7892690wru.55.2024.01.22.00.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:37:51 -0800 (PST)
Message-ID: <92ee0b1a-f383-4a37-8758-a62b56ef0310@linaro.org>
Date: Mon, 22 Jan 2024 09:37:50 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, dlemoal@kernel.org,
 cassel@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 michal.simek@amd.com, p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
 piyush.mehta@amd.com, mubin.sayyed@amd.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, git@amd.com
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2024 12:36, Radhey Shyam Pandey wrote:
> As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
> controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
> DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and
> Xilinx udc controller maintainership duties to Mubin and Radhey.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

