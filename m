Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60D43FD1A;
	Thu,  8 Jan 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864579; cv=none; b=hi3D2nhTzA4nx3E6wozijungVQvShSqybuMoeadoTxTGickoCO1xw32+7hFA6CBU430ZBi6Fjm0InPsRnaELhptWqpCHLG1eXAaHbZ2fvzBNxI1/6sEBdLQ00JXSXW39IV6z+XJLrMyUf/CfRMZfO5p+DycbAPzW/TYOtoBjiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864579; c=relaxed/simple;
	bh=W8DJmHThBYvxGSmtz4McDRjOmfRywwR7+XCWBWBL1l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikStancuUhVdU/ZGnBpU2ZV1/zSqQEjwFG8TA+bihrBAMxHkSIqAtUK6YwsNHk8PQ+HUtQyIWfyS3/3+k+WUvbzgDKLEPPqf0qZD+SKiCv1IbPUgTQjWW3KUrB/lqfz0KOV7ncz+bdMhJ2gcp09LcMQ53a1LuwEgvj1o6y49YNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+u5Dmpl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+u5Dmpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5BCC116C6;
	Thu,  8 Jan 2026 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864578;
	bh=W8DJmHThBYvxGSmtz4McDRjOmfRywwR7+XCWBWBL1l4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f+u5DmplBkq203+bl7h8gv/gMn1W3Ksr4DnuBjxBUikh8Isjso1UliWw+z7+Uy3K4
	 pfedbjT0JAncz0yLgOoDmicTWKkQ3UgggOvxVRkGmjpwsy+4bakGPgtLXGZpXxepcz
	 pTtGtO1Md+MBlPv1cLaWXioLGd0FbN5YakLkVqJ/yS2en0MCa7QK44Cw38A/WDHrTj
	 hdoUS0cGjV3cLvne3L3sejbUSY7fwNDS6HU8ZCDJP/Iey7FPNGlWh5Q8OEBrmjlh8o
	 LZaXsaU7bnQZNW7FCuknupcNZmvMNIYAIo5ZP8fhJ0oSFfwvHrDKfWIhdtzoY1L8t/
	 PPpIdqb/JcALw==
Message-ID: <38385033-5bf6-4ee2-b227-f46677136d86@kernel.org>
Date: Thu, 8 Jan 2026 10:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ata: ahci-dwc: Simplify with scoped for each OF
 child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 llvm@lists.linux.dev
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260105142944.372959-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260105142944.372959-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 15:29, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes and switch to
> iterating already over available nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied all 3 patches to for-6.20. Thanks !


-- 
Damien Le Moal
Western Digital Research
