Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3B1F94D
	for <linux-ide@vger.kernel.org>; Thu, 17 Oct 2024 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125289; cv=none; b=e2Zpo26DV3RhFLxvttPDU0eAQ3VzXyoMMKRqF92zSiGcllQ9rSSso9w/epQ1zlwolPBedd1cV7C1Enj0t0z3usxdqYGqCOtLm67jjGslQciDPt50P+Fvy2R7/SvNfa98/ZuOuJdMgzHck9gSNhFYK4fWvEe9hxtybGvZDvA17BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125289; c=relaxed/simple;
	bh=atI4S3MFwSNfunvV8a9tb4aDrNp2cyinECWBkcRcfDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjvPtRSpGyxYYmQCOk3DAmBoRzXmq3BmcT22mv4zO+XDvp+DGhxPUBOFdJLRwyKzagZUeAlUE3uHagJx0rm+uCqPC+DC1IijF12KXShKAFCaWUnWIMzqq1ufBLhIAogX1II8jE35QLgN/TWlovItxvw23axmpEYi4rmcEBfsyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPdFtflL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPdFtflL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B969C4CEC5;
	Thu, 17 Oct 2024 00:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729125288;
	bh=atI4S3MFwSNfunvV8a9tb4aDrNp2cyinECWBkcRcfDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nPdFtflLWCN3X0rurOjX2BFvLpJwr+LVvuwtuSJYNwJFXH/Lx7/wMbZtL9DnUQl3o
	 5iqBraHehzJS2A4V4cVen+vSPoPgXiZanyh4cmMGwMa9ZBlzEdB8vR+japakD/i3c6
	 JZBqhNUknoexo7vKVGKlRIGJQF4ifyvEYED6Z2cZ085SXIfUZyBhG36K/RqiSO3l16
	 IXOivi/+lrcgVel56GPlF3y5uEIFmtWcPwmy0/zipw1Bx+QUrpVFtjrIglFltxHpmS
	 lKFywcPXTQhrT3/eTvr1RHKMbJvKzbcpYp2EQDtP7QVYOrBRA8OUQLOIbjXj4T2efM
	 6vJqTwJMmPaug==
Message-ID: <8854fd2e-c8d5-4308-893a-0cf14da03ffe@kernel.org>
Date: Thu, 17 Oct 2024 09:34:47 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20241016141609.27329-2-u.kleine-koenig@baylibre.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241016141609.27329-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/24 23:16, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/ata/ to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> While touching these files, make indention of the struct initializer
> consistent in several files.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
