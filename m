Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38208485
	for <linux-ide@vger.kernel.org>; Sun, 10 Mar 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710081256; cv=none; b=AuBgq9WrpUS7/79AwmdhuIg10XklniQ5Hx6Aq9Q06TOOg/w9WfCWmgft/oZD2GmZx5Mg8AKncZlQOS0Ty02K3/FvQGj4ZL5g8/TjcJdwaLHnnx3v5OHRMp1YVE9TJrO9UtPZJEKZLaPTqpQSb82QcB2MIV+Pr6P2egphNS4z2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710081256; c=relaxed/simple;
	bh=3pCYoj0Xo+mY1ZJs3a1PwScqciz4Fnq23XZcuDVyuFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXy5tE9otUnbh3E6DLM9kMDvHzzetD2LXh2O03v9QAZ8GFF7CQSIe0Rs5zo4ISmKBBek5wCnf4HUeKH4IrKjs8w7AgfNRgb127t76PKt2jK7NFpWC5D2j+pleFs1rSMZXn4xaxISOEye2IB+BworymgaSz45DwoQo63vJjBBMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dRtWTvcs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRtWTvcs"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e9623c3a8so147903f8f.0
        for <linux-ide@vger.kernel.org>; Sun, 10 Mar 2024 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710081253; x=1710686053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4YM8nn+gwNhKNb13sGum9VdDxUI/DDISGOTUbgSJ+c=;
        b=dRtWTvcscz44yr6dPGKqEu5B9eVqpswF9QMfiCU523T3F3KzOaHcn5qdi7uDBV9d+6
         BM2L0deG0/x0SzgnIuFhZOCQ2MElRipQonLn4Jwlcmr7aqt7oXe7tL5DS+4GeADFGQWQ
         79epOTWc0/qDZlPNUqNYE5bSxSvdnRxPq6ve2FEYnNzWzVtv1553Y94RFUouaxyO5xKY
         n9RH8T9bVOKgYrJrxeGptwaCnvTDbBCXCr9JISEyt1Q+Ofdz9JJjn7CH/gmUbJS5z2sW
         wjgNmmzIYK6GXg+xVTTlMwdDe03SJrVwEXQK95F3VpdpbC5SGOHd/2nZUOxsDt/6jVem
         iKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710081253; x=1710686053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4YM8nn+gwNhKNb13sGum9VdDxUI/DDISGOTUbgSJ+c=;
        b=Q58QIX1pX7VgaUwFqTTyafuPadJIk8cqtEz+pc67m1SiS+uHZXSvFVq+z6l2fAA5Xn
         nfGSwX9bYGtyWI5PmpfNMl5n4lO7izi850Mn6z9xZH3ouj9xLmsZkhn8ChKPxTEmZ36Y
         Fose3VQwFdf2tLAuGqMdJAt6/QVvaVrlvyBQ8FKucuon4HTZP8KVXrUDGmTi7fEytVzl
         hgioU0osqpAugzOerentotX/iqm0YK7SUpSOQqwstRq0uox2HAHDZRtoEkCpchgR/ikn
         ORqRrp3qFEU8BCvmRasilK6QxhVIzc9+UN8zucBb+iTLAi4PNOD2KBQTCYgyjRZX2rxP
         lJWg==
X-Forwarded-Encrypted: i=1; AJvYcCUyoiUgNxKXcdF1rnHRtaeqZ/PfvcyLK+5CS2OS4GRfqAoMNPL+0mmicZgsWafxo2gD6fEFY/w8E2Ih8yyvVmJKb4qjaCl6bV7J
X-Gm-Message-State: AOJu0YzY1laJGl8QsMf0lEgNX2mdPWntY5Iazz7EIlIegutdXGh5nVtO
	aj1MuuGmoQroy/rOvaNxi2GztCQv1kp8SBT2yEB0onE3HhqJItGtv7eSezDbDMg=
X-Google-Smtp-Source: AGHT+IE1ACpa17cb3bHbmnb1y9+NlMwOwJZLo414I/MyKOVC3lDj59agmNDg6uxe72YQEuSUnanUtw==
X-Received: by 2002:adf:cd8b:0:b0:33e:7cdd:b559 with SMTP id q11-20020adfcd8b000000b0033e7cddb559mr2979995wrj.56.1710081253018;
        Sun, 10 Mar 2024 07:34:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id by19-20020a056000099300b0033e8c50fc3fsm1940293wrb.90.2024.03.10.07.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 07:34:12 -0700 (PDT)
Message-ID: <f7d94072-eb4e-4d67-98d6-8090362a01e2@linaro.org>
Date: Sun, 10 Mar 2024 15:34:10 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: imx-pata: Convert to dtschema
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
References: <20240309160741.54096-1-animeshagarwal28@gmail.com>
 <a26689a4-1c8c-4458-bb82-137cd1ac21d0@linaro.org>
 <CAE3Oz80TByuu6=U4PTOHO6k1=KjjRKtPPf7ayhSMZareXP8vdw@mail.gmail.com>
 <6b065dce-5271-4ea0-b291-a7aae8e71d20@linaro.org>
 <CAE3Oz83uiCyxV3u1C-5=vmBt6RxnTM+LJCw4KWyJDB2OLn-dRw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAE3Oz83uiCyxV3u1C-5=vmBt6RxnTM+LJCw4KWyJDB2OLn-dRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/03/2024 14:36, Animesh Agarwal wrote:
> On 10/03/2024 at 18:37 Krzysztof Kozlowski wrote:
>> Please respond inline, instead of top-posting, because it makes your
>> emails hard to follow.
>>
> https://elixir.bootlin.com/linux/v6.8-rc7/source/Documentation/process/submitting-patches.rst#L340
> <https://elixir.bootlin.com/linux/v6.8-rc7/source/Documentation/process/submitting-patches.rst#L340>
> 
> Already taken a note of it, will follow inline here onwards.
> 
>>> On Sat, Mar 9, 2024 at 11:38 PM Krzysztof Kozlowski <
>>> krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 09/03/2024 17:07, Animesh Agarwal wrote:
>>>>> Convert the imx-pata bindings to DT schema.
>>>>>
>>>>> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
>>>>> ---
>>>>> Changes in v3:
>>>>> - added fsl,imx51-pata in compatible property
>>>>
>>>> Please explain the differences done during conversion in the commit msg.
>> How did you solve this?
> 
> Added proper explanation for fsl,imx51-pata addition in the compatible
> property in commit message of v4.

I don't see anything about this in commit msg. Commit msg is exactly the
same as before. Try yourself - use b4 shazam to apply your patch and see
if commit msg contains that information.

> 
>>>> This allows only imx51 and disallows imx27 alone, which is not what old
>> ------------------------------^^^^^^^^^^^^^^^^^^^^^
>> How did you solve this?
> 
> I will resubmit patch v4 with more explanation.

You mean v5? You need oneOf allowing usage of imx27 alone.

Best regards,
Krzysztof

