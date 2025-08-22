Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173687E792;
	Fri, 22 Aug 2025 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755829376; cv=none; b=DoVA3x/ma/WVW6lK9sch9/IonfUfyjPCb1qT/YXnA9IP2m+zBy2xTGjp9CDg8S7tR9VUh9IlaOvqgJJrv2SqhMd+nHXoOISCJzoXDlRKiCP3mUBZt7fsBzkPU5Z+DcLTjO4dUf88ZuHLUkXBoYwGyERjfokUAQoAj7iyfQADJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755829376; c=relaxed/simple;
	bh=dCeXCJ9QMydRcyvtjsu6J1NnGqJvl57XZBijx7wKzI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rQ1BLNW4llMxeQQFYVnl616eYu1eO0bRVXpWA4F2MlP9PxrCE0ErxzcQ+KnJCCG4E87VjpNjY4J5jyT4i+9V4hfB7F3OynvDOmmE/SZhNWI3XQ/wxnbEdgyxb9p5S+qbCEc5vN1QsRsdldq8UtB3PGKiTXtpXozrXB4tnVCT4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBqMPCZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBqMPCZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED2CC4CEEB;
	Fri, 22 Aug 2025 02:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755829375;
	bh=dCeXCJ9QMydRcyvtjsu6J1NnGqJvl57XZBijx7wKzI0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nBqMPCZuX89gNQRDTavj9oOeDiZv4u/rP5QuYqbN2l4uQb4b2Wq/11Y+mwT1ZRAwm
	 Nq4zGLPeLNymaxsn3atQY0UFsVpWbEj16nQvVBK7zvU7wFqk0F7vuMBwWqpbqvltWa
	 QPRkQiGEwupHDfwp4eLP6SLYkYFhscdR8Jczb+xw7rYHTQ4KoZqxQwMkbQnXz9lf6m
	 jdlry1tHUlINiMb/ZLfenZxIo5hza7vWdJB7thHv0B9QUH3MX/f3JdOvoPJjWAsgOT
	 0Klw5ImepkpvgtTTpvFeHbkLSBSYD5Wn0yeeMxi5imlf7E9nHTkVyDgmM2c4H8Sdbc
	 OqawIRkqTVsqg==
Message-ID: <00e905ad-7242-4446-b019-a61b67ab4264@kernel.org>
Date: Fri, 22 Aug 2025 11:22:52 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: highbank: Minor whitespace cleanup in
 example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250821083239.46726-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250821083239.46726-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 17:32, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to for-6.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
