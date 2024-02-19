Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E230224EC
	for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333679; cv=none; b=XskP8tpHoG0FJZOdLP+CDxoVPon/sSEhY+/5jDt1Q7X4sHB4oM6x3TJ0bKh/l/0CVWIuIAxxrkBd4BIOrCpHc7ic/9dUCpKxBspoChwuGiUzjgZt+Q4cOiIXkQC+rwwMatd8EgGl/uVLymEeKicgX5JZVafqORFDqzzWHdnJgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333679; c=relaxed/simple;
	bh=tRnAUD55yksVdxHuB0T/WrK0lH6aDVw5T82GrrE5A9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipvlgvypVHxbHusPxhFSZFBWLTxtUABy0EN1WtBr+sdppYD3xrzSCPfogObOl09APHxv1UvVWaP25u5KIEKjfb0KAONQi6mGdBTJLkJyazngXsixYkJ9e2TsFMBf/103rDzg6Vus3rxLg6En2q8eMMAATvMZCNEJhzz7xUeXXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZIFtvBUV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIFtvBUV"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d22d0f8ad1so15961571fa.2
        for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2024 01:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708333675; x=1708938475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6Xu1HAHZ9HRxjD9AT8qdpfBrvzwdj1aG2VVZhQOMJw=;
        b=ZIFtvBUVOqMV5bnEiFiA1M4mu9cEB4WyzSgdgfSWQa9nGbVR6RkuLAPdJJb2t3k031
         H1y6Igh2/7pPK5HnxJKXy/eg6xPa3D1S0dy5RANPAXVb62He8bUoOSZf2q2CUB1GWBdH
         9itL8HR4NGZ/flk+Q28iaShC2q6ff2G+Kt62g7w7IlNM/oMDALPeJftxEpzimq78kpnQ
         eRbMEqI4LI7nSpwp+8Vf/U0PdGIQJFjisQHXKKzKKT+ivtdUTQVt6Tt1ta47PNuk4rWK
         fntkFmN5Q4LxEoPHvBOMOj+H+EPoS98+RNbnp+vzLCkUVQvwMFXhyKFO0aZSO7LWpgVE
         QBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333675; x=1708938475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6Xu1HAHZ9HRxjD9AT8qdpfBrvzwdj1aG2VVZhQOMJw=;
        b=kM6xH6NU5OfcFv3pE5Ha3upv/Ule/B9gVvotT7asoQTDt9FP8S1mac/fqxUI3ggjX5
         dTv0NuuSdq4EGritWiCpddx1IbyYzBzAyY8PlvvvNN84D/BRDpGiq2q5SQNodgFSzxwK
         IyEv4qlctaZ9ltMWGsHZRfEY0hDSzVQuiTZGdOnqd5Swulqk6TOB8/nE+/KksYCDYLY9
         PtoVYb6hosdTx6BWOpBTkB2qkckSYH1mbvorjdtNxS218+/9rGGs5ZBt5qnxOddC8m+c
         DpXIQIK61XG1IzU6UF5ktrUVZAprfHlw7GZl5uJpu7vFnynL1nOFDTkP7L/5jBoPLy9G
         aUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4eodnOozpvTZaC3JUqAtpva3bmDHrKdxPb/OMJVyBJ0BYM+kKCIyiHnGgMp/OvsgVmOVwMshoEjDpivV0oG/RmSYxy9zvleEW
X-Gm-Message-State: AOJu0Ywmd81UuaJ3lS3UYXNYsrCDWCK+HLblMeXMa+hVEulrVv5sb6MJ
	cArAIsAVqNqsS3xUh+EnBZTKcYmaPlNKahzjH5iELQ4FsgwNn1tqnP2wggSY4pc=
X-Google-Smtp-Source: AGHT+IHKVEM/gaTzGxSC7rvNgeF2ynwsCj8mGyyotbBTNHns2GoyzBtLpoPiJwNRHV81I2/an5TDpA==
X-Received: by 2002:a2e:99c3:0:b0:2d2:3b20:72ba with SMTP id l3-20020a2e99c3000000b002d23b2072bamr994750ljj.50.1708333674873;
        Mon, 19 Feb 2024 01:07:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b0033d07edbaa6sm9725160wrs.110.2024.02.19.01.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:07:54 -0800 (PST)
Message-ID: <77a7223b-9407-4191-b53a-0bfc623f14bf@linaro.org>
Date: Mon, 19 Feb 2024 10:07:52 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: convert MediaTek controller to the
 json-schema
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ryder Lee <ryder.lee@mediatek.com>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
References: <20240213074747.26151-1-zajec5@gmail.com>
 <ZdMTx1CJzFR5uAzK@x1-carbon>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZdMTx1CJzFR5uAzK@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/02/2024 09:39, Niklas Cassel wrote:
> On Tue, Feb 13, 2024 at 08:47:47AM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> This helps validating DTS files.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
> 
> Hello Rob,
> 
> For device tree patches for
> Documentation/devicetree/bindings/ata/
> 
> Usually, if we see your Acked-by, we queue the patch via the libata tree.
> (If it is part of a series, usually you take it via your tree.)
> 
> We have a R-b from Krzysztof, but no Ack from you.

You don't need Ack from Rob. Rb or Ack from one of three DT maintainers
is enough. Therefore mine is enough.

https://www.kernel.org/doc/html/latest/process/maintainers.html#open-firmware-and-flattened-device-tree-bindings

Best regards,
Krzysztof

