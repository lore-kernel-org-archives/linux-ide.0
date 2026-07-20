Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADF449B31;
	Mon, 20 Jul 2026 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591909; cv=none; b=LztgJhYJKTIN6d3KmW+Coc2bLIJ03UM0RPfi13x9vU8IfBYAX7Buqr9UUwLYFgtE14HAcRLbS4rAYqD4p5fM3JmfVaMHN9VfLCL5co0pfonKrdU9/Rr9tXcPnmhf3IW5a+8Mex+Yid5QOnmnSp0ao54CvYSurUfiWt0vb0WyrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591909; c=relaxed/simple;
	bh=BhnvLPfjBhqReUr6mTe58IXcF0OiouKlt8Pj9p7uvCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/JbMofQIwtyZGkNQ3q2AWRtmnsjS1kzw4vb7j4kUtgIfoRDehmUoPMgg7ps0qftYf+FNlNdI9rXCNb9WE2RSN05XHzmOd5/chnxhK9DVc7wQQJzTC4XHQruaHX+7YfIplknsei7dN6p+OcdCab8cRUBOHYpBqL4H7kcwdHz9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNrdT6/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNrdT6/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE881F000E9;
	Mon, 20 Jul 2026 23:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591908;
	bh=/P0skrbYyqE0q1+DCGGww4fGsVLyiqIXtfRaxXt0qKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oNrdT6/gG+0+jYatFkxcD4vhfHNLmZJg2RUf6GWE1RGE/WG5dyPkM3E2F9zDGDPF6
	 /7ZwOY1/JM2ZkA0qxQATdFKLRdWKf7KwMEWglI41y0CEyqbAc96mvfGZljgRWIrea2
	 4TyJtej/d1FU2+OTkKBJuCaxYKJgs081q2g7M7P4bYrLspkBVUaTPbZwwEzIEI0XTu
	 4KvuH+cpVNPi7O2baomLLcqXZnkmUmXObilEfJ0lgcMs9T6Scf9eZPlx62SwT3fG6x
	 GLyLrW+uR9ZsXNMYkDK3JVMNhAArHT9e4nskJItd5xQheXYZSgML4TFkaPAerilBKQ
	 ncpS8XBUnxkqQ==
Message-ID: <7b68dcb2-9b52-42cc-9524-debcb01185d0@kernel.org>
Date: Tue, 21 Jul 2026 08:58:25 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_pxa: use devres for DMA channel management
To: sashiko-reviews@lists.linux.dev, Rosen Penev <rosenp@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260720015014.1912040-1-rosenp@gmail.com>
 <20260720020148.7A2DA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260720020148.7A2DA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/26 11:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit message falsely claims that `ata_host_activate()` registers a managed host detach and that the patch preserves the previous teardown ordering.
> --
> 
> --- Patch [1]: [PATCH] ata: pata_pxa: use devres for DMA channel management ---
> commit d581effc5d41a82779ae2b411de235a8efbfb017
> Author: Rosen Penev <rosenp@gmail.com>
> 
> ata: pata_pxa: use devres for DMA channel management
> 
> Convert the DMA channel request to devm_dma_request_chan() so the
> channel is released automatically on device teardown. This removes
> the explicit dma_release_channel() calls in the probe error paths
> and in pxa_ata_remove().
> 
>> Devres releases in LIFO order, so the managed host detach registered
>> by ata_host_activate() runs before the DMA channel is released, which
>> preserves the previous teardown ordering.
> 
> [Severity: Medium]
> Is this description accurate regarding the managed host detach and teardown
> ordering?

Rosen,

Can you resend with a fixed up commit message?
Thanks.

-- 
Damien Le Moal
Western Digital Research
