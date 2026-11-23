Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450081;
	b=Uy3ZTOEY2FoKA43AHA4mDLtKgIK0nWqPYc6Oz80O/lA69O0slHAwYL2VojIgtl2SuqNm
	 obS4lOvjknIFXHuq2QVEBywqKJ9zYkrMPLgMwdhX0mJNkkV/MGwdfzcPHkPa7X/a/FkfU
	 ns0Uf/g6dWFISnB/SWwv2Rv3M6HbyK1j2qTqLv09569SCzzm2Yzl8rF30tl8B29Z0vMDx
	 kabIKxG+1vw6AHaBsu7yk3VhTg/HQXjnbOcUndpzSXROdxXlMFn9mW0+Eo16ivTwfLSbO
	 TWTY8w9SBJiHYHfx/d4Qlil4iwNEgRJL0csJsyiPfjTJhUlh0ru7UTr0sH6eXM4yJ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450081;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=uGwu5CmCdNBM7nYfVxbLkG8Sm/FCcmMZiBEkkapxiDQ=;
	b=SAX1jkFsdVlsIu2On254uMsmToRAJoOwVjUOPPJCgC3zgtQcTsCgxeTXwsGu8/WgEpXU
	 Bq/oCusJf8pTqBt/NMb44AcYUgvnih+CulynAcWhlQtM1W8zIw0CJIFIhyJ5Fto3yzJaJ
	 YMQqItqsgbsTiNZbcH6OC8rgl3alzJBOtkZA8vkNCPazdrpArI2qu7dH9S0Om6oDdnjbO
	 cfzEYHi6+FtTGAqTTkRaxgAczAllAbbgjDKyr6iLfzT8B/G5c8c2kaTbU8AHLvltxPIqk
	 Rw658PB3scY0zt/Avan2bNA7JpoLOBInlepuqI1+T0m9k77OvfTsHsde88XCmv5i3/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=AGiitD22;
	arc=none smtp.remote-ip=74.125.82.225
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053E606A31A
	for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2026 16:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4053E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=AGiitD22
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-38699cf08dfso3376875eec.1
        for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2026 08:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450080; x=1796054880;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uGwu5CmCdNBM7nYfVxbLkG8Sm/FCcmMZiBEkkapxiDQ=;
        b=J5gPwYqjWPVGcUmUAnYYIYfP1UZYu+g8pquTL+B/07jU6oILdt+9GHas7nyDD244Po
         ksGuDmM74sU5ac+bjqRe4TAoz8StxxgohFQUrPbeW5Ugd57ws7A8alcIGf584K50xo11
         3YcnVnJAr2tN9oWW+T8txp5FcQWLRxqLRk+kouN/TZ0fAiD8ySwHWWBfIk93qqd46IYV
         oeVpYkE9v9wR5ANP9V80Y3w8/6Tj/iKtno8Tn7HgTwjdwDC/OXmgyGqBInpE/pJP1CIW
         HRKj+7zq/hJMf5ZZUHfQ/LbFocr2cPTaxhDzU6U1GROVYZjp69l5zFGizZ9z2Itoyyki
         rBfw==
X-Forwarded-Encrypted: i=1; AL+hErE3Xnx/uijytmX576aIR/iJS9h/cUGKIe8alN9uVcwErQ5XInMvdVYiIKHIXpnja1+Kmtc6o4TAZWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3a+wTBCXZve1aSud+Ylb7whb+g8hUXafkjsPWDasS/edNP4r6
	TAeDj408cMHmmO8GvHrtjDIi7I9YpReregJKpQJ8lbLHRyDy4Aezpthz0Mzm6MOb6AV3+oIfgwz
	RwNjgYiApV2QkkxstR0pgs82RjqeqWGHNxcsIs8FHcpm7mmZrjWnVbN5DzhFnwdIz+u6syYaYpG
	t7GJrdFeVh+9/lyTD+MYiDIiivthwl0pQ8jPiPSD4tBZ2VKMqM+D/x/OBia0pcDEpfNtoIvlc9+
	0OdfPoKy+4+ehLBI2zJ
X-Gm-Gg: AZFdTZd0H09/QDAcwEgQj3vF/2wxgL2t53hmVYCHz/0o2QtRnwYSiEt9TSap5u7F5Sj
	P1EwLoCJqZ580N4FQN6DESVZz2bXmQ3rfkOn9ayRm8FYw41jrxaV3cRg017Vbv+437lFAdRRr5Q
	VSS7cTlGkKvTxoZFI2yf+lzrgmEI5tD0NjbI0zQ+vCngWS1oM5pMuTVztd+90tTV5VxKIYbLS2J
	At/Lbrrr4b0e5OdKbjxsqAfByGOr7txaPp4cgGKr7rMu57/BIWRrEMnLt2G2M19thawsgP5O7WK
	J4NQwtFqBVIt1JLBbHgaGwpT2Mbt+/m+KLe8l9IiAUdrivoqml1rWZPbu7M39SbzAgq/toocHN+
	9oNtNfBq5nMlV8invDLYYQbdwH/s746gI0eJIqfjc7Jr8r7/NZkNxl3d1oAjnDx0lk8m/EV2IZC
	xQZfRGip9Of3n3ln+vNmmP9ANGju0/IaaqdkoglCVy3iY=
X-Received: by 2002:a05:693c:41cf:10b0:386:ac97:f656 with SMTP id 5a478bee46e88-386ac97f9ffmr4296717eec.19.1795450080103;
        Mon, 23 Nov 2026 08:08:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-385672cea3fsm1416262eec.14.2026.11.23.08.07.59
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2026 08:08:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386a65fca25so2049560eec.0
        for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2026 08:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795450078; x=1796054878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uGwu5CmCdNBM7nYfVxbLkG8Sm/FCcmMZiBEkkapxiDQ=;
        b=AGiitD22/FtMb0TzJkIP3n50RVc6+zoO1A0diNhOd/PV65ZGxiVOjjnt0jGQV8PofH
         gxHXDPJpoL8VDpRkLf72jx+vyBf0ZpmWQ1f8Rou6xW5pIwlAcQ8v9XZ+ffxkB8K9iMTk
         9+ZKioCtG1AiKBMhhl0lP1KkHmaIJ9p0DVdvo=
X-Forwarded-Encrypted: i=1; AL+hErFXceV7iSbWjGMsENTWVdDV+ZKpHkGraCS79aYcEjXSg8bZal+R5/GkY+7qyuO08Z2P1mJtkpdDDD0=@vger.kernel.org
X-Received: by 2002:a05:7300:7c08:b0:384:3123:a0cb with SMTP id 5a478bee46e88-3856ff5b880mr19381594eec.27.1795450078297;
        Mon, 23 Nov 2026 08:07:58 -0800 (PST)
X-Received: by 2002:a05:7300:7c08:b0:384:3123:a0cb with SMTP id 5a478bee46e88-3856ff5b880mr19381556eec.27.1795450077586;
        Mon, 23 Nov 2026 08:07:57 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm38560278eec.12.2026.11.23.08.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 08:07:56 -0800 (PST)
Message-ID: <c5e542c2-4d34-4ee2-8bd8-e3b5b5296f7e@broadcom.com>
Date: Mon, 23 Nov 2026 08:07:56 -0800
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
Subject: Re: (subset) [PATCH v4 0/6] Fix SATA support for NSP SoCs
To: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
 <179544998187.275844.18441245364658646762.b4-ty@kernel.org>
Content-Language: en-US
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
In-Reply-To: <179544998187.275844.18441245364658646762.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/23/2026 8:06 AM, Vinod Koul wrote:
> 
> On Thu, 29 Oct 2026 14:25:07 -0700, Florian Fainelli wrote:
>> This patch series fixes SATA on the Northstar Plus (BCM58xxx/8831x)
>> which was broken due to a number of things:
>>
>> - the SATA PHY assumed separate PCB windows when a shared one is used
>>    for this generation of SoCs
>> - the clock/reset (IDM) was not being configured by the driver which
>>    meant that depending upon what the boot loader did, or did not, we
>>    could have had the AHCI controller still in reset by then
>> - on some reference boards, the AHCI controller is not DMA coherent,
>>    assuming so leads to all sorts of timeouts, data corruption, etc.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/6] phy: broadcom: brcm-sata: Keep NSP ports in the shared PCB window
>        commit: 2a27baf6e203af422db2d84f9f382153612679a9

Thank you, I took patches 4-6 through the Broadcom ARM SoC tree.
-- 
Florian

