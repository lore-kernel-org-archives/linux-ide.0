Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13E357CF1;
	Thu, 23 Jul 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792327; cv=none; b=KjhlQoPtXHdnLFh3eI9QuUekOaKsIHuM4xmoBC/9tqnasXcQaCQvXyrUjL2EwA+lXv1eG2XbQCK5pdTqgzyxTGhi7tiXoY+T6hIj6WpMQe5RepabbpHH8N9mpJubMiBus4qIC7r4Zwl8AKXFvESeEi3SNNDQcHKmrFbmPYjI96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792327; c=relaxed/simple;
	bh=CO1f4aosNSLye7zU/DQeod99ElhBKyCkI6zhwnrM9tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNEi8PX0kPp18r6MGSZwGxEEjskU/ei3YB42zAGxrwBeM6N5TQRDAtLX8+WcJ0A1oMLWxzmIZ3HxojOR2XNn2xT+SAp8Y4chsRsu9MOk9CGOlxiBdgVyGIKBYBO880LMJFnkIaQMyHxtFhxy4u+26BEb29uB/VpgwhdBKE7uby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1g/+QQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1g/+QQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05DA1F000E9;
	Thu, 23 Jul 2026 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784792322;
	bh=iuiDmSH0SRYIWcVGps58GDwNZklOhP1xqWJA5fYrB8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c1g/+QQgVYGExMYF+sAfaKFEJDNM0V2PzOSTpJXsR7ep7aliOs/sxkhK/5rFBAl7w
	 ojkd979O0pWu77CMJYKmbg8wb8K8fdOplNzV0BwngJE70M/GNyR00RwOCltVADYnpy
	 3TawtmiNM+1ZyBrPvTQ9eAaBNLS4RxuFctWF1638aayOPlbct5E8ytaY9dYacAYbl2
	 NlsAMK/kD8UTsKY83b+6JTBOWnDxoUcQoxrAViG9HCwxPyHSdfN0L9VE1a/+3RjFm7
	 kIvt/9zJz7FeSjtYyrpMYsunh0+MoeUNQnbyyLmm4vvrJ2JCne3zYNeDiLS9snUwBg
	 w0c470QboQFKw==
Message-ID: <26f01958-7476-4e72-adb5-0ee0028c5347@kernel.org>
Date: Thu, 23 Jul 2026 16:38:39 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] ata: pata_pxa: use devres for DMA channel management
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260721015856.17503-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260721015856.17503-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 10:58, Rosen Penev wrote:
> Convert the DMA channel request to devm_dma_request_chan() so the
> channel is released automatically on device teardown. This removes
> the explicit dma_release_channel() calls in the probe error paths
> and in pxa_ata_remove(), simplifying the driver.
> 
> Use ata_platform_remove_one() which is now equivalent to what remains of
> the remove function after dma_release_channel() removal.
> 
> Built as a module for arm/pxa_defconfig (CONFIG_PATA_PXA=m) with
> LLVM=1 W=1; no new warnings.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.3. Thanks!


-- 
Damien Le Moal
Western Digital Research
