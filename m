Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728833;
	b=K8wEh/QY0hdx/Uk0ifq2oOvYOLDOFDRr1gPf0HvKh9wl69mUn3JzpLObkjLr1PVosash
	 WvrIjQSrbwXLV6/txGBoYWWRIq8U96XpiFUAQ71y/Il7TuvneXNGJ2o2WxZjRasnHFqP0
	 HJBJkzTLanK4yaG1FYQ3e35mbBfgQHVASkJMkw03fuk6/bdF/UWiyAobaawniqOMUewMT
	 Mi8TR2gq9wQ259X06xhzF1ALyCjmUgGtdU/jexM6Adm+uINOFU659dP8qREZ78VEmuhYK
	 tkm1K0chrZEH3mCcTa/GI0tD5n3FoaMBmzbhCvq6sLXacEuROGY3eOlKJsRsdCLfuMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728833;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DyV933UJ9sPFmflhXi7BLGrxtwRfqVr56IsJCpEwtRQ=;
	b=Da1AgQLU+dPUp6HZV9AQ5akuBTqD220LLQepSrWVO+hCWQ3weO8f+l40Vder9y6eWGbR
	 B5zjlnxz7sl7gy/LQgvLyHCF0I3+ogQTQyK5J3KmT2+hZjpOeBXYDNqczZ1Ur5UtNAxB/
	 m92pKCOpYB09g7OB+fDodiRIn8U6LUHLYLdbo5fK6t0EbC8HOGMCrz1zHHmC75AMp+7g9
	 hfRdh9JFzcs1RGxLAAgaymiqDmYSWP6BE6Mwl8IFKLI/R6LpKKKvaeBI5R0gjbWqzhS5P
	 6QjnNBDsUIlaRwUHxqyMgiTc6MwHi+8Z9PiBPRjLURM9hzb6i5d736pfHPYPwUlG1hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6yX092K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BD7606A329;
	Thu, 26 Nov 2026 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6yX092K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13EB1F00896;
	Thu, 26 Nov 2026 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795728832;
	bh=DyV933UJ9sPFmflhXi7BLGrxtwRfqVr56IsJCpEwtRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L6yX092K9x7C24PP94Q5LQa1roXFSIHKUxvvEjb5knjymHOcDrTjDs+FhPR80JHNQ
	 +itVRD3SSbj4pQAh32F29gfyoYpY/A1CAyv2HqHyX1ZRbbLYFb12meQV9GiXx2h6n0
	 PXcqvIqvzfNRib23n98BehMYa3zM2jSSq6KhpJ/vlet62fee65OldJIpSn+7TX+922
	 yJtxTkqDSJMPiCefYy15gGJv4JqRbsOTBSx9YkiLezBAl7d0fqZl6EWhXQfOyWdCr8
	 drhgY9f4TN7tOtc8k7sagPxUFUqdl4nwYnZx8HVJphBEt/RudWDkXSQOZtBJMTdjON
	 bmqekRiQOOrjw==
Message-ID: <7c32080f-9afe-41c8-99d7-8af438e79b49@kernel.org>
Date: Fri, 27 Nov 2026 06:33:49 +0900
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
Subject: Re: [PATCH v2] ata: sata_dwc_460ex: add missing newlines to error
 messages
To: Artem Novak <artem122novak@gmail.com>
Cc: cassel@kernel.org, linusw@kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, vireshk@kernel.org
References: <20261126051523.14431-4-artem122novak@gmail.com>
 <20261126212531.28154-1-artem122novak@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261126212531.28154-1-artem122novak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/26 06:25, Artem Novak wrote:
> Terminate the error messages with newlines so that subsequent
> kernel log messages are properly separated.
> 
> Signed-off-by: Artem Novak <artem122novak@gmail.com>

The normal practice is to resend the entire patch series again with the reviewed
tags picked up and a change log in the cover letter. That makes things easier
for the maintainer as they otherwise have to sort through different versions of
patches all over the place and selectively pick them instead of applying an
entire series.

So please resend the full patch series with the review tags I already sent.

And feel free to add to this patch:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
