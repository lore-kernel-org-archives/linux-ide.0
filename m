Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBF3CF1F8;
	Mon, 29 Jun 2026 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782777534; cv=none; b=MS5NDNGKdeUp4FALTKiKzCqU8wDyxCCE0cDp2ELSHEsYswclw3CBVvlLRZt70so5JK/G1Vl1CqJydF1On9HXijUo+mYVik4yfqaRqLRhg5270vJLuBI9rVDnOgv5gjpUPJ5fSFXeFHj9KmBZsr1T0WP7P7xQ12NM2brI4vZ80yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782777534; c=relaxed/simple;
	bh=01R/kG8vka3vrzGwFfZlj89sNlu/q3OJgojxDchX5k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axID5pM3VXcklJyaiyT6GLf6c20IajH3OAhM07cbIo6TMVVA6okGWS5Uan/3Uwtm3lbkLP2S2IXkYkAegAWmsxUR9ML9nY2H1r6IUnF/cb7eZqsj2Q1z4lm0p2mgDoS2XERVCumYLo2wDXtnuAX3LhFmDXYAjzIcfZ7zFVN8Qsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7kMStVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7kMStVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A81A1F000E9;
	Mon, 29 Jun 2026 23:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782777533;
	bh=6eSr2bBj0LCI9mMHxBTEcX4uyn5dU6apCX0xLyi7wJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h7kMStVoMZ7Ev5qSG81yf+FqZe3lLMDRmglazvVv8sjSM6nhzVFadncKbEQ1VjR8S
	 4dk3K2FRx5rIfkzm61d+nJ9cVNgP+SmflBgNJiJeeYhrz8fdZc8XQd7wIXgSlE8JoP
	 InDv2iUaIoyFOKrxHQcHWP/Xchr/JyF0+dr/8Ug3YQTO//0BAButi1x2Xx7Cn2BXot
	 hwUJO6lvxWuQeRkmz1PcvIQZEZGYY7a8/+6UMdWboz98eu7sDoLdfV3CFFfAcyOWM0
	 kT3T9eWGHEXkZZRtLDV6g33rujLc97EOKgAhvtytIiqd+fcLuiIISTTBVUPN5FFl/h
	 ACJ79U3XdXRCg==
Message-ID: <3eaf5e30-4a29-4868-82b9-b33e35b69baf@kernel.org>
Date: Tue, 30 Jun 2026 08:58:50 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260628230310.1214770-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260628230310.1214770-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 08:03, Rosen Penev wrote:
> Replace irq_of_parse_and_map() with platform_get_irq() in both
> sata_dwc_dma_init_old() and sata_dwc_probe(). This is the preferred
> way to obtain IRQs for platform devices and provides better error
> reporting.  Remove the now-unnecessary #include <linux/of_irq.h>.
> 
> irq_of_parse_and_map() requires irq_dispose_mapping(), which is missing.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.2-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
