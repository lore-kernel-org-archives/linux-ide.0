Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917120;
	b=XALs7Z3GfeMpSxm78AYifg1dHxhasyKTWbmePyzNPDsdxMGOqgcQviD6s5So9G//Wety
	 tVlKmk2dbGzf84vZwPZ1K/7IxwxZ0i3i+Rj17NPgQKCDkTOPipwn3Qa54ItS+2zu/mj3p
	 nXbpb8Cii9HdW5z2XjQ98JMzvq+ZYgcmbkSwscR61WhCsNZmekE+KHRCgwCLRi8QLD8fD
	 fDORbPGXh/j6aWf/KFTZ8OdIinK9PRuuacd1QAFknDxpdBnMH6e3AI9hv8TDDmVzatRP3
	 g8smy2D4i9XbbnpIB1RtuwPnUfxEeml2E3iFyhSt1pn1kJIF35OAQkTfIa+tkkZbroQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917120;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8s6a0MI7QPoKHwH1MbGEvMc5FXbEXeSN+WYeMG6Dhbc=;
	b=Zl7AfmC/bGdQoA8Kb/DacDsTGhfp1qCFnHLOnzFbFL+dac/eNfAyxpbD/Nzf0w0VXndM
	 gxsGk62E5lNgxYVbflhCqqOoLRXSs5gAZNQ91OvtKa1AzoKxVj78OmIBVV70tW4SBBL6x
	 8kVyZ70H1UXtXTFCZ1YxYwj5cNxa150jBCkh7nunCGQEijmMfMtQCto0C2iRALooBtOOY
	 wXR70pUfyRBqFrRWOnMX6PN+Zfd+5Nl7xQ/hBgLfWW54bjGuGEJrLdF+jYUdmbx2AFiiE
	 pJ6T0dAnSAEf8G5ZuL2o6lz0/bVLBu9OTf7MSMp6H4gi+NtZXa9htqnYdxTuk8nJ6gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2TxyB2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BF606A31C;
	Tue, 17 Nov 2026 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2TxyB2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02B51F000C5;
	Tue, 17 Nov 2026 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794917119;
	bh=8s6a0MI7QPoKHwH1MbGEvMc5FXbEXeSN+WYeMG6Dhbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K2TxyB2imiIlT06s1lWMEKtSOysimmlF2tcen+oVKWilX9uFekLT8/Dob0WOUmWq5
	 VuFWnEsyYiCQCzuuyf5kSy+5MtUTS3RngMAkkfi0BPt63hPi1PRLm77GtvQBzw9+8o
	 58Deq9wogUbYnBUxBmM6StKLt/zWVYw90GHyOJ/ZPfTPv/8F7Axnm2vm1QriYQS9CP
	 EZaCSLWZaY3EIKTIf7mLPuhXvWQ+ofcbpOy1FM0LrO4FWc8sD4IoIpB+KeMn9wGbnD
	 jTcMVYpLc2AzA8+/5wNNQvoCoNc/bXMSeBy4zK7CxSDG606GVejj8wQ0mpd/uHbljk
	 aijYTYKr9+5pg==
Message-ID: <46a76a46-ff13-4298-b87d-22091fc8158f@kernel.org>
Date: Tue, 17 Nov 2026 04:05:17 -0800
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
Subject: Re: [PATCH] ata: sata_dwc_460ex: Fix DMA channel leak in
 sata_dwc_port_start()
To: Haoxiang Li <haoxiang_li2024@163.com>, cassel@kernel.org, mans@mansr.com,
 tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261117094903.1282096-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261117094903.1282096-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 01:49, Haoxiang Li wrote:
> If phy_power_on() fails in sata_dwc_port_start(), the error path
> frees hsdevp without releasing the DMA channel acquired earlier.
> Add a cleanup label to release the DMA channel before freeing
> hsdevp on this failure path.
> 
> Fixes: 0f48debdb906 ("ata: sata_dwc_460ex: add phy support")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
