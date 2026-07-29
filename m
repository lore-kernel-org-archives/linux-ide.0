Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798930FF36
	for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2026 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289704; cv=none; b=Dsp/LBIOEhsJLk1O0GdZCrd5oWISIaOExB+OrLDosUSd4sTJdjfXRNBHAR6fSMb30UKWvEfw7sqnW3EbYlFX/I4NBwX7lFSowUzrS59lvYuhGGLapTRCvlVu41hbJEd3nZSfmbYfh37pEIVxRQ9t3BKjeVXgfXMqCYFbONU8V0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289704; c=relaxed/simple;
	bh=wbgENOSlC5wcZtXa1MGckeGvW71XMlMDY8NImcmLYgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMEEGHsDQboG5gscrHSu8mew9ZPmC3Hd1VlmU5t+ABdxpj7DdNsQEntOEj8LE5ElJogpneCK4xM7B3Ai+PzUvrnuFpX+D0DzJBZm1uovvVdViH7TmfwX4eMXqoRQgiJWc9xAtWS6qUUq5pmMfDDwF4l79gQw3qJmnUU8xACcdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+Np/6fj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+Np/6fj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386671F000E9;
	Wed, 29 Jul 2026 01:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785289703;
	bh=+15JtqQbdp6LC8yFEqyR4+iBMJx+5QW6LHUctspr/Vk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a+Np/6fjI5iAtXYihBlonCR9pcjizWerwloSZRUEPaTXcr0oQkC+j1imzk3ng8b85
	 X9/RNDMUKqcH6c/n/0gjzz3PAAX5wk5WLSbAGjfwqmJ8cJ8Y4Wx+n3QhjyUk0G3RVp
	 yCjVCbVR4aIJSLjMazV8gsL2/DkuDDcqv/GYTNsuDuaMe5iNtpiH1zP4D8AnDANJpp
	 1542xfm1y2ZrE4G/KQ+rieQumdgxTc8YZtZgINEhn7/n6M/DMEGjby2LRDJrFoEst3
	 DMIgVfomBwaukCH6YggOkmyujYOXKWG4YZUjE18fcVUEqTQ6eQJRubl2zjNxqPZaWJ
	 8vZU3sQhPyR8Q==
Message-ID: <76a3e91d-ae58-440d-aec6-d9c402858013@kernel.org>
Date: Wed, 29 Jul 2026 10:48:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ata: disable LPM on some WDC drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Ronald Garcia Vazquez <ronaldgarciavazquez@gmail.com>,
 linux-ide@vger.kernel.org
References: <20260728111310.722450-4-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260728111310.722450-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 20:13, Niklas Cassel wrote:
> Hello there,
> 
> This disables LPM on some WDC drives, which, according to user reports,
> have issues with LPM.
> 
> Kind regards,
> Niklas
> 
> 
> Niklas Cassel (2):
>   ata: libata-core: Disable LPM on some WD drives
>   ata: libata-core: Disable LPM on WD Green 2.5 480GB

Applied to for-7.2-fixes. Thanks!


-- 
Damien Le Moal
Western Digital Research
