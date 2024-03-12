Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DAD7D3E9
	for <linux-ide@vger.kernel.org>; Tue, 12 Mar 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260751; cv=none; b=lxwVjbSrb+jN+z61UmJIBazH2GO7KDrWiPadVje6CmOKAa9uFU2oogxosbPGYRSP+Pke5wcxTDu+RDNqpaVlG4nGqKofWHC4TZWP3+nvgx8CtQHbIK/BtUNwegrUrKqyPe/+hY8O0xL+g8snKZ5g6zk59OZcBkKENb3pJaMEqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260751; c=relaxed/simple;
	bh=a5yUmWg3PuB3kxVcncy/ATZ1Opx/Wz/lrRRiAU0sPho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMzEWFDL1q7Uvt9xy/bIcfFyoQoqahw1y/M+3FSpJn+PHJkOrcC2TDRbI+3o9Y5C8cdNfwbtqcUJ207VuoYi9m0l5h/ByN/5sKE20L8PCcmsw/dlDyy4bzNT5G784focP98QeiqS0eMBqTn0in8rsHkPYKv8GhAelMhj+9rurXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4fYCj3r; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4fYCj3r"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e92b3b5c9so2882469f8f.2
        for <linux-ide@vger.kernel.org>; Tue, 12 Mar 2024 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710260748; x=1710865548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6QeprWJf0xqFTyeumMEAcPNK1ASh8edQh0OGbiGlgY=;
        b=T4fYCj3rDwHZLe/D/6Dp6nUowL0ncQ5Po3LQekLxJGH2ZykgPcuof5iqCVBZzd2VcY
         EcPeLX6hxpzAxRqSInTdlhRiMF2/LXcyW7arHtCU0p1jiBoW9tJiJ07En4jsvOhTC9X3
         TAxmco3oEvl8b5qwHB9q5LM4vgifpjyDFViR3zNhQbx+T9MGOxyQOjtwH0tDdYO5CPdT
         GepdoAbEhexkocWbX/qubukhj14tUA+HpezkXmdhGduTBfPXgE2ppcWS+SvolzuVUo4s
         DETisysmROcWwdJctlQrXdTf6xLFYB2ZhLKf2SP+2iVXK3tpuUkEN5iSrnBWU5ifUKo1
         owCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260748; x=1710865548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6QeprWJf0xqFTyeumMEAcPNK1ASh8edQh0OGbiGlgY=;
        b=xAG/8dyOCe2CicQO6s3wSBLTyKzyHuYE9YEoHl3xaL8YlvBHiLLhf/IWOfNfUs1vh5
         a1XISgVplorTaVQO1FD7ugMVSbvSjnW6WdlNLNFrzxgVgvx6St0KCXpUYTM5W6XW6ksM
         kqW8SplhSy3xZyLDshXJXIjVqgyw7NRdPFkt//ATlQY0F+PUT1ouhcOrDa97Nuqikz1h
         VeIAUHwD1ksFL7hyxL0+0ist0N/ZDIvl0K9aFP+Esm0P/4ivswK3S5q6gGf56Mh84F70
         h8NbxP+Wq5YWGMiKKH9gy9iTf1fN+nJJik6Bb9qcBzpCXceGPB3ZvAI8V7XKvVCZsu7j
         ziJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmJfvT9tWl+36w+KOksd+AswT+bhCPWB4mXNEpSI+JnO6KGuoCOlKl9qsyAC+QzFGgdxvoUAH1v3+ZiL8fFLeNGAInSdz8c/4/
X-Gm-Message-State: AOJu0YyBWbFTQXX3wlFGAArlzN5sLBIBie+F15l1ztOTY+Npneg4RkPM
	ZCrfTSjvB1/th1uLgSizmlZM1eW8dsqH6xDmYCZkxtnRcovRfu5pVT+lVa//YBccSh6OVoHbru5
	Q
X-Google-Smtp-Source: AGHT+IFwa/HbTSCHec82YU09bq8R8iPUHCO3MYxSBp4Crmr1hnSLrcAEEeQ5rZN2kumv8wNFIs2EdQ==
X-Received: by 2002:adf:9792:0:b0:33d:6ede:249a with SMTP id s18-20020adf9792000000b0033d6ede249amr7456489wrb.69.1710260747722;
        Tue, 12 Mar 2024 09:25:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id l5-20020a056000022500b0033e712b1d9bsm9466780wrz.77.2024.03.12.09.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:25:47 -0700 (PDT)
Message-ID: <045ae9cf-104d-472e-94f0-ea7cd5298214@linaro.org>
Date: Tue, 12 Mar 2024 17:25:45 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] dt-bindings: imx-pata: Convert to dtschema
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
References: <20240311140435.34329-1-animeshagarwal28@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240311140435.34329-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 15:04, Animesh Agarwal wrote:
> Convert the imx-pata bindings to DT schema.
> Add missing fsl,imx31-pata and
> fsl,imx51-pata compatibles during conversion,
> because they are already being used in existing DTS.

Thank you for improving the commit msg. It looks a bit oddly wrapped. In
the future, please wrap commit message according to Linux coding style /
submission process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

No need to resend just for this... but...
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> 
> ---
> Changes in v7:
> - removed blank space at the end of file.
> 


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pata: pata@83fe0000 {
> +        compatible = "fsl,imx51-pata","fsl,imx27-pata";

Oh my... missing space after coma, but more important: what is happening
here? The space was here before in previous versions, so you removed it!
At least till v4 it was correct and bam - now it is not. Why? It's the
same confusing as new line appearing suddenly in v6.

It looks like between each revisions of patchset some random changes
appear in your code. How is it possible? Don't you work with Git? You
change file, git add -p and git commit --amend. Why unrelated changes
keep happening?

While the actual space is a nitpick, it points to the fact that your
patch experiences some changes in an unexpected way and we cannot trust
that you did only what you claim in changelog.

Best regards,
Krzysztof

