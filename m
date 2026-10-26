Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042235;
	b=1ayhWxBKl01zeOXolyimaJ9uyrPiBgU3y3g/l8Gp/bRNbPQidRA+0z/ndWUuSJgd1zX0
	 blxNYlA1u2Og3RFIf20IaPVr/hAQxpkkksapqSLqKeMPdG5dMQuHDKaqgvbVlLt6bRMt2
	 3c7SUrq/4ybrz8GX6CjbryTG6M4bVmhbdMpyI3vlEoBzEOuGyJUPcZ0c3F5uCjiqMdhGG
	 F8+aXY7iaULQayG2PUXczsCK5g4rT4eseINp40P2GuNiOL4mbh4syXmEzBDb04qoutUH2
	 eCDq4YJWJiLGLFkGdpeK+LUwvWZ6VU99Dt52hfSOoOsIx0CZ+JaIFOHWdKi2lp2zMOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042235;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=BdfLZ3+TQnhk/1R/dKHjB/gyQ9lcXQ2fJWw3eaIlqVQ=;
	b=Y1BAoBQj1RNl4r384KY0jU/GDJOQl9CTdKjmxLbXSd4an5D/6VdQuXlhNb0zkKyBN0CO
	 Ab1nyBkt9vm/EGk98Rh8h7xjban+q+1G7XJTWVeZVsHHwj2Uw5uJ+fCnZvOT5DH3hxQoX
	 Y6EX8LnA+qAWflApV6Nj9W3eEhEKo0SSbW/w1ONVRg8AKvqcPSkz/53E+JYF50aN0MObh
	 mxlOzln8RHlRaqJANy2h2dYPSWvSNWuBsu0vn6BocGhag+yMw5PZsQKA6Ccyzdspyowzt
	 B1cERG7EQwjzwjut/17cwCSyS9DfunTTD76E3GVSZGhOVZjQE8hfCEjrtLdmedjmI4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JYlooF6f;
	arc=none smtp.remote-ip=209.85.222.227
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4473606A332
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4473606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JYlooF6f
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93cc1ab5f6cso362806085a.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042234; x=1793647034;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BdfLZ3+TQnhk/1R/dKHjB/gyQ9lcXQ2fJWw3eaIlqVQ=;
        b=rzMGDBe9oOk6ZVZ6wM2V+N8RxgKdhmWpMIjfPdtQoqA/tZtW+glzg7MMK5zi6MI5wF
         CxWHF4JVAIPkdOCXU6/7Sv0s1OL/omPkXsI17L4EcTz1/gC+vjGwtgFbk/ru0L05nE1N
         PT+9PTz5+iYWEK4yVetss5cdN4GtDjMbe5T8LIhedPJp0aMf9YoHsJreP8zZRv7MhIJb
         br8xvL/aGfyhxx0Xc0wrtslq4eIXDhdzOKWczHXiDuXjEmR+7p5ZL0pf29SreO0NPHx1
         R+dy4LiDoqH0WOrUZb9s3q7rIkm5djPCkwLsBlVUDb+kvQJAeg+8m4EgrtQktpk1JETc
         yltA==
X-Forwarded-Encrypted: i=1; AKwUvBxuJcIjPxwtBneGh22BMQXwaQIiyAsCOwiybyXXYFUhLY1MPO7Vs8QNYiZKdtqDBFToGW5CRGS8e9U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSxbrI40NXo+QYmotHnHeASQAJv5RGz5vu/TmAFSGEu8Np9r6g
	uwpqJeRmbc6oKDiXgFUb79caFBxNYkkwVojBuT4qx5g0UrRHBSm6lEtjYadX6PXR/7rJh0Omix6
	mfBQBHv5A/HJYXdBH9oWGQbvtC2RCHVkYG417QrIMGtV8G5QaWBwudfSNpKv+h8vVcPykfUsxVl
	fqTRsEQic9SVlDCseMo2usVVW58h68plXsWE6y7G2aWUcQML2Rh9UfXYm3vuQTXEU+MdYEwKQIh
	kqDOyD51H0hqfE5PKt2dC0=
X-Gm-Gg: AYBFou3TQuaehnOL8POn+qYd/H9kuuO4ZAdPWJmvrEzZh9OI+mtzcHTvaGjKYnQK0/W
	fTWfD2/LA0JZQZ5hKtXTo3IjTwd98YL7Xg1hosWZHTfPA2VEHZKG/KrzR1ZEcojh9NaeufVLzQw
	9KRwhI9mlIoG1AOMMHbEo3zEn3rBSCxHR86eB1iDvEjpCyT0zQV5F3sYRnG7XqBM/eFQe2Zk8Ru
	AzWzy7XYNbsZsIkeFDP6ae7Q74ns9cLlJPXW4AP+d0bY6p6Pc8Zf2726AP+MgSINnpXqVcY+XA3
	vW98Z+dWFlA4ZMRKW5tzZBW8fnmqcYlrvdpGdG5JxyFzPApBwGFdrV/E8sTcKy6AXcys6zJGzCv
	ADUlkVx97DT+a99ZfYQup6AQVAmFfHOU2ePK7es5GQUBv0n0afUdOningnqTWfA9jSg5npXNi6l
	wXpEJksVOWUAcjuLdyj/TpJasyZLgFHsuFOPqs8U3a
X-Received: by 2002:a05:620a:318e:b0:93f:2ab9:7294 with SMTP id af79cd13be357-940ef8bee86mr1298708185a.29.1793042233609;
        Mon, 26 Oct 2026 12:17:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f06613cesm117341485a.6.2026.10.26.12.17.13
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:17:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91785bd637bso83228296d6.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793042233; x=1793647033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdfLZ3+TQnhk/1R/dKHjB/gyQ9lcXQ2fJWw3eaIlqVQ=;
        b=JYlooF6fUCxKIr+zDxP133KEWGIffRYSFU0z/Rq6wGo0/uSh5WPdl4OSt/ex+9Lcj3
         RG6v6Td5SbUG6Zfppih8yKtZv15CKXTSgtK+CKKOKLuEQiiZyBlSGYUwUvHoBLL560Bt
         duDg7b55ic2+KHj6DJPR/TPzIkhxIvbYmr9+k=
X-Forwarded-Encrypted: i=1; AKwUvBzKnNt6lHFuQ0RYE5l4m2bu4h9PRis+qzrJJwo0lFSJklLPnhmw8+cWq1MwDFwi+So8B3IFNqEydbU=@vger.kernel.org
X-Received: by 2002:a05:6214:2602:b0:91b:83b7:b9c3 with SMTP id 6a1803df08f44-91c48cefde5mr132806866d6.5.1793042232935;
        Mon, 26 Oct 2026 12:17:12 -0700 (PDT)
X-Received: by 2002:a05:6214:2602:b0:91b:83b7:b9c3 with SMTP id 6a1803df08f44-91c48cefde5mr132806056d6.5.1793042232303;
        Mon, 26 Oct 2026 12:17:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47ce49d9sm80619336d6.45.2026.10.26.12.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:17:11 -0700 (PDT)
Message-ID: <6cf34238-ed4e-477c-938f-f5d6910fda1d@broadcom.com>
Date: Mon, 26 Oct 2026 12:17:08 -0700
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
Subject: Re: [PATCH v2 3/6] ata: ahci_brcm: Initialize the NSP interface clock
 and reset
To: linux-kernel@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
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
References: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
 <20261026182856.3168686-4-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261026182856.3168686-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 11:28, Florian Fainelli wrote:
> The NSP probe path assumes firmware has enabled the SATA IDM interface
> clock and released the core reset. The downstream iProc config_AHCI()
> sequence explicitly performs both operations before accessing AHCI.
> Without that setup, a cold boot can access an inactive controller.
> 
> Map the optional NSP IDM register region and enable the interface clock
> before releasing reset, retaining the downstream settling intervals.
> Perform the sequence at probe and resume before reconfiguring SATA.
> 
> Keep the resource optional so older device trees continue to rely on
> firmware initialization.
> 
> Fixes: 3ee2e6dcaa35 ("ata: ahci_brcm: Add support for Broadcom NSP SoC")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Apologies, this is the same as v1, I will resubmit in a short while.
-- 
Florian
