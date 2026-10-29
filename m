Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291741;
	b=2SOibzuAyiES1bDKcEOl+R//FSFsxFyog1QUxWvqayS4Ce1Ypr+9Occ0eTCNdbg6ulEA
	 AZBafQ8tYV8G7idI33167Za99pDOVLs0swsehRbLEiR1WCrCY/ZtZu8WPq7auBnTt467A
	 UUh0RhvrPFtb1AWSlPU3mdriqahSjEpUU0vMyOc60ZtEUNB9okiPXq/q0RJCeq0ru+eZA
	 wUtqLzw75Di/vor0R45r2wvdQdJxv2vIrL+Q62IzOqQT+0BZz7k6O/qccGM9BqD3I3LEa
	 DoxuRgIc98/0nNO5JVvx8hRJg+mVvQ1ZhfNLNUdYj3pfqCnz53/4EEXVkO17RLUYjXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291741;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=GjQwvDz4mWIuZZ+lNXDjzqnPWz3b8NLeIsPBGcLEPHs=;
	b=OmuTCFV/p9DyuaG8/HSlEtHAfWsd8kfx+5J0IHDf+urkoqaBNcypw1WFUuReXlOzHmo6
	 DPnXDdyekTo74TBioTjudpkJijKrcAk5ElJxeIH8rLyuKQhPk3O6Yz7whp+DQXPvJ67Y7
	 orPAo7hDwowQ5Mq8/LiZ7SRoa805cymKFazLFfbdkzMn/geNRgdRihaUpRKiZ5CRl/V5w
	 n0eyh2y1M/n3nvYJNEvhDO/QUQwOvxcOxdnN2pN1eXgDiE7J1lPXwTbkebttAnx+TYIFk
	 M4sfzq0OagNte0XT6XLxxLSR4hGxmlseSd1Hxdroz39YNZScCuM2b9S7qwyCvrn0pfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EqWHs3Ul;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37688606A31D
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 16:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37688606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EqWHs3Ul
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so1157985a91.3
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 09:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291740; x=1793896540;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GjQwvDz4mWIuZZ+lNXDjzqnPWz3b8NLeIsPBGcLEPHs=;
        b=hmiwhJwy9IH6OG0k1CRKYpfYFq8WsepBv2uNmloh1KfBtjml6sNiYvIHNtWphnQ4X0
         FYByw3UJHw5I9Y4F24kYX15Mmq13/Xx0AMkkugDHxAtF6S1ntu1tBHfj8au368resDR0
         66ji1qehDJeQctlaZ2XAk1ZJzv4UJ6DLTUSfe6+fIHPG8j13+mMq2L2U9arODbIlD9/Q
         00L09CXwYqT8gpi8QOkP7JuBbEZm98CkIGlprybCeEmU+4FWNm+ey2gUQHq0SA2f9tUv
         mNZmma7Po52Sn6Ek4KsFd5H7kNTp8AkuEOfBeb2IQI7VcNgVJ+4YTV/cY+WwjQyaBba1
         GzUw==
X-Forwarded-Encrypted: i=1; AKwUvByd6J/2DfdPTtnrE6tBjarJWV1X+ts7cK5rs+Bcsq1aRKU9ETt1YQueK2cP0z8Z6Qk41M5TrbodF6k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcJ8H0ywWcN4Thj4i+oS944p20/DBM4kgR1QCw1Up+wo5K1Izy
	hoafBPrkmXIc9EA+1kXM+/YKps62U0LYGu/8mDM+1T8cq59YFQ9IY9fnGhIvgREelpAx3XQPLVP
	ouqo/Gxp5Bgu9QP4C70U95FwEz+WBMlSgHtqvGJZcZueu4TulqS64N/vBt9xKTt5rIJePGeDCIq
	0tQNIB6V+x+IRLPmWnB3sXUDqH/k0qdX9J/mgYQyqEjpuGMn1Ok3CV7Y9tiQ8MtIPAwFiOyI9C6
	p8R3U5HWoZhdig9ob72Dz0=
X-Gm-Gg: AYBFou0UxCrcKys127MapDKpPJnDJzkL7CJqQIhD7aNxIh8C70X8A98r8B6Sip+t9DO
	uz0cXrDRha5lY89lh71kbSa6u5R2uwbLehqvuviBIeTZW/zfLReVpetT0WYyf8Rd5hbBbrJLrzU
	h6INFFSSfG9vfCSDWw5N3Rdzc9WXR7IYkP92ZTb35tgwAcoEXRS/qz3MZHgQz2RMJlxgwKLQXGB
	rVxEqbWabcufcr9B4xaZ6/NWo0PLGdsJ5S17Qg4RoEe7migo3NFDPWlFgz6K9OCdSurCjCMsfRp
	7r7HjIbwj8IwHndv/MjgNmVJCtTt8vCpGKmrq7+LxPlXBklwDEvaXCTY6Lo1+zvRgvB4o5Tpp+U
	shSIGY3WxknJ8bI2lyFBn/9adYKpSLghSYxFzee5rdjLdfeAh+pM1OdlbXuNQVDFpaHaYP3IK5T
	yRyiCFWRkcPY0Nq0nTXyzaMMRBnIEPagjNrOdO9bEw
X-Received: by 2002:a17:90b:a09:b0:3ad:a270:a623 with SMTP id 98e67ed59e1d1-3ae57e35220mr3386015a91.4.1793291740552;
        Thu, 29 Oct 2026 09:35:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae844502dcsm215898a91.1.2026.10.29.09.35.40
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:35:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5376f1853bfso47709841cf.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793291739; x=1793896539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjQwvDz4mWIuZZ+lNXDjzqnPWz3b8NLeIsPBGcLEPHs=;
        b=EqWHs3Ul2xbpUC22cUpMT4gGXmtVcon4vWvkcTu2UUSr5w3AAzNumUeSuBdhNZQfOw
         +OEJAfUNBbGNPTphyv/wOKyCddh5hxp1fEz+/URCAxYMYbkl9RBWcD9X8CDw1+boquXU
         GMFmxDC66++3Xj1vt8s/NePmn8IsBiEIumOBk=
X-Forwarded-Encrypted: i=1; AKwUvBwMTMp9DPlSg7vHNwLPbuvogWzVvNgXeyykugQZVMsih7R9mi0fIs2FReXyIBRtC53UeoBo+gvTkk0=@vger.kernel.org
X-Received: by 2002:ac8:59cb:0:b0:535:fc2d:b7c2 with SMTP id d75a77b69052e-53fcb7f9340mr101251801cf.33.1793291739286;
        Thu, 29 Oct 2026 09:35:39 -0700 (PDT)
X-Received: by 2002:ac8:59cb:0:b0:535:fc2d:b7c2 with SMTP id d75a77b69052e-53fcb7f9340mr101251311cf.33.1793291738724;
        Thu, 29 Oct 2026 09:35:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca31b46f3sm272576d6.45.2026.10.29.09.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:35:38 -0700 (PDT)
Message-ID: <cb6c4485-90c4-4ea2-8df8-4e1ccf47dbb1@broadcom.com>
Date: Thu, 29 Oct 2026 09:35:32 -0700
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
To: Krzysztof Kozlowski <krzk@kernel.org>
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
In-Reply-To: <20261029-versed-automatic-orangutan-43cfde@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/26 01:09, Krzysztof Kozlowski wrote:
> On Mon, Oct 26, 2026 at 12:16:14PM -0700, Florian Fainelli wrote:
>> Northstar Plus uses the SATA IDM block to enable the interface clock and
>> deassert the core reset before accessing the controller registers.
> 
> And which compatible in the binding is "Northstar Plus"? I tried to map
> them to arm/bcm/brcm,nsp.yaml but nothing is there, so it looks like you
> are making changes without having actual compatible documented. In that
> case this is not needed. Make changes WITH documenting new compatible.

There is an existing compatible defined: brcm,bcm-nsp-ahci. NSP = North 
Star Plus.
-- 
Florian
