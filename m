Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294180;
	b=FeXqcQlA78JMr6LT2NAAEJpFCbp09RfaxRfBkufX9touG2Jwzp016UZO+IILZ5qWW0Qi
	 5+fXv2Gb2W8T5SMtx+OAy3dOawNHoIKV49LzxrcQtd8D36LlB6xcUWpYCRwDnO+Yqg9eQ
	 9Np8HUDywvx4+jCA6dcUKk0iKkdjVPMz/IKeFfk5n7+6SMvVRUfigSx2QULSo4YnW5IYL
	 DAxhJyOuLlWcxp88yrNNNmxhojhL5m/fpGk575HcqmwUn5gT4evBCLKfmR4PcG5oYThH7
	 mTvpHwhndjkdLxvd46qajnyxJAvgSMUVk8ZD57F2M4EcIsiauUTXH7TC/tQK2Q8gcbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294180;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=lE2uSXffLzacbrPa786MlXxJ3B9g3YGKriI1oE9ksSc=;
	b=yq8or7nuPORAuHqVM2b2treBmYtg3d7jwm7QZM22gogoP/+keYUPUUfqs/3V+UZrgUGp
	 9c+va5IeMktVABsNEUgoT4NCiJ/Zb/mI+Biu8GZVChQUQjLET5gys1d1UIQNKmmuVNY1n
	 5nOkuHz8TKX5ejKTSFHQ0D8HkUOfSRG9bnRaPtzaPwUdJqt5IthBGkeY1LiDAxBO5BAq0
	 HbQSNp9muXLtBQ7pUEA9WyK6pG2k6Dpo96qyJ+Uo6a9qVEILc5XPZluiCX/Yp353L0rk7
	 73pXrWMW1ecO3oIDpusopR2qMfJXBBSV7U8cL5wY3hHPHYRI5Ja79L+2vqp/tDqHZLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Xffpx+5Z;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E796606A31D
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 17:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E796606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Xffpx+5Z
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1083112a91.2
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 10:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294179; x=1793898979;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lE2uSXffLzacbrPa786MlXxJ3B9g3YGKriI1oE9ksSc=;
        b=doqEX0JT6vw/Sjam6xaTzlr+ArIr1XBuda5rCaJNytQkPHW8vyNcaC/LuKHWR7nWAE
         DpenHlfK09TFXmKdcmXBHc/ujYPf/aHYH+mr/cz2zmIiDiGmV6kVMMphn33hrPGdwoKf
         +2LFYX6QeF/PQJ/dL09ere02FkAnKRgMORJYFHy6P92w27jD8pZ+/cdiRMU9iBCUpMlH
         G8nhb00iG00AtMF8mEpMg8vDmbE0s1C+sP106pXKHoWVUs017BDiz6zZfiz7F5pVnAEx
         EA1TJMt/MAJsxuBE6XSvG4p7nkE+pqX8L2EyOpPJGV+8OsMXUlzL6ZwUfswqsUItvdnN
         JIEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpE5TkeEQLDFWGZA+koY2tdxEGA3/Zvf9wyBYo7u+WxNVjB0urZQKVEqCU0i/e6HP/7bXjF0F5Hd4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQyPkGjZj3QVMuHgroaVmeEkrZR13YOaHumh6SpuPr07fiPKFz
	d92ubWfzufTeALNhLrKtEZdPtEkbXlLu5U0TQKFdAF2MZqPv16NoT4v2JIfU3lo/mEbkanzg4P+
	x5fXw5LHtq/BiiiireAlDO+YNW3FlNja38JTV8r/EtzM7CmzZeLuYUDwuwoQiyCJEFRoa3bTo4T
	0g3LQcS9CAtZyt72xZABd25FglTSVD9cayC0VW9oOHDsrzzxK35gZM9+DVHi6eBxQ2AUKwddpEz
	MQnifqWbYxkW1xV7MABxxY=
X-Gm-Gg: AYBFou0dGhukA37hXCfM2aBnmAiTGYGGtSTzxI60VfT6d2a1aT9hYBgy5+iS+J5ChnX
	uIh3SyVbG+hMYMAmzPfB/wCeSkYqlzLHDUS6k8snd8zAs2qdzCc8Os5xe3lXr5Ut/ClzBywDBjL
	F8m8XLwFdA3+6cFL/E9Y3NNNy8pUi5sw/QgcFj1tFapxtHQyPrY5QshA19NsXy2ThNbxYH/nDo9
	oDwaFg7muQlg7RSpnAaA/aWRgXFCuxHYMwpmJzpVCr6IyZwUKc7vmdMo/+gayQB9RvWJgvL9KHf
	V5pQfrCcAvMrqDfTGJHWMull62WSmsaMFnx7ztuRUadQsAbUpjAm0oSzaA4QGLoO9//vy74Pjf3
	3xjInhFmh33WoRfXYCRNGwd4yRvTA82YASJqstqmdayfY71Ta+WEVhDHm1m2OZnpxiOTfvD4Odu
	zceOq0S+FbNu6AMr3VCuAu2Ftth3K44jw1/5qtioPq
X-Received: by 2002:a17:90b:1e42:b0:3aa:ff61:9504 with SMTP id 98e67ed59e1d1-3ae580a9daemr4820811a91.20.1793294178874;
        Thu, 29 Oct 2026 10:16:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae845878b5sm276953a91.4.2026.10.29.10.16.18
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:16:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae73921fd1so817135a91.1
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793294177; x=1793898977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lE2uSXffLzacbrPa786MlXxJ3B9g3YGKriI1oE9ksSc=;
        b=Xffpx+5Zks4jwrXGeXfC/Wmarq8AB4r49igoB46m4tRwQkbkbWvf2bjursmEHeGMiG
         p2jIdDDtpusB8cPFn+deTPquoY9vkjRSoMGflo/vGsymczYKSzVsV52DG7Xv51dFNVxG
         9SIdOzmrUrrInrIM3cXGtaV1Yf2fychPtODaw=
X-Forwarded-Encrypted: i=1; AKwUvBz53sROJVJnGMT25BXk+45R4ONae9CzgaKkgbezc+Kpcc/JRl/xbSIFZkpaVurjw3s6T8vJ53I1N7M=@vger.kernel.org
X-Received: by 2002:a17:90b:5903:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3ae57e2b52amr4762321a91.6.1793294177302;
        Thu, 29 Oct 2026 10:16:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5903:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3ae57e2b52amr4762297a91.6.1793294176832;
        Thu, 29 Oct 2026 10:16:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm444813a91.14.2026.10.29.10.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:16:16 -0700 (PDT)
Message-ID: <fe8b7acf-b495-4202-a5f1-51950c55c037@broadcom.com>
Date: Thu, 29 Oct 2026 10:16:11 -0700
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] dt-bindings: ata: sata-brcm: Describe the NSP IDM
 registers
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM IPROC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
References: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
 <20261026191618.3178830-3-florian.fainelli@broadcom.com>
 <20261029-versed-automatic-orangutan-43cfde@quoll>
 <e5c4ac0a-f5de-42e7-910a-cf2c9c4cabbc@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <e5c4ac0a-f5de-42e7-910a-cf2c9c4cabbc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/26 01:10, Krzysztof Kozlowski wrote:
> On 29/10/2026 09:09, Krzysztof Kozlowski wrote:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: brcm,bcm-nsp-ahci
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          description: AHCI, top control and optional IDM register regions
>>> +    else:
>>> +      properties:
>>> +        reg:
>>> +          maxItems: 2
>>> +        reg-names:
>>> +          maxItems: 2
>>
>> Please move entire allOf to the bottom, before "unevaluatedProperties"
>> line.
> 
> And you already have an if:then: block, so this should be together.

Will do, thanks!
-- 
Florian

