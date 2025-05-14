Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371621B909;
	Wed, 14 May 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747207447; cv=none; b=oEJy8jGWsLpuL//3ZatRgclV1UzogMw24GPOdDGAItEx9axKQ3xGKRZVLRsYkBqxHKu2Yo4nL6Wa/197TpujXf4WkxWacVI4zGg3yNgFiPyYCwpgaxHAKmKhbU13WxAUwPZmnAP8kzsEnZWm8BRIok7OrPsZpXdG5sUbRvw+MsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747207447; c=relaxed/simple;
	bh=bTwlpTbHT/sN8S0yFQYo0xHw/kFSMi6RQvsEE+8Hejo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rokqfhZG8YOpdWPqphHM3PN07bRwdrnJHa+zybRbkVCLYjIbeyVGLsN0hMFOb5IUhn0dFPZJ9EX2IiQmp4CpA7aofiRsA/cz6iLJNOgqxhNuafmuVwMtXAXD2H63x9MZVBIdl6yg3cXQBdilvi83RJ4Gq4v++c32JyyaqJ5mX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US6T6L92; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US6T6L92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6B4C4CEE9;
	Wed, 14 May 2025 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747207446;
	bh=bTwlpTbHT/sN8S0yFQYo0xHw/kFSMi6RQvsEE+8Hejo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=US6T6L92e+PgVxfTFiZtsowzHdUgdbTzQFYJD4DBA/ne8nwmF46VT5lhGE+qGMM05
	 TFWSn0y8R7G/SKy8l2UjJZpxPFGAc00fFfYas/GkzEiIT7FDYIhej962RZ+/95lMez
	 zzcR4A/LHeO25jnMuRj4UXASmX+wlpvJ9j1CKH12GZMg4z8js/Kgpv/2OdI9JwoC7B
	 oFe1QCVnO4LzzNIwIB2cnYTlfgTEj0hMwIZK3NtR2+63jngcd2ZoTDhG+c9WBGqiBX
	 KAWmfQEPHgm+2K7891ilrWNq2BthoAF6YTE0EXIGIG0QWVyFU+HVtccIsamjTRSmRq
	 ttiUBj5qORZSg==
Message-ID: <aca3dabe-d050-49c3-88c9-6e76ca63e0ec@kernel.org>
Date: Wed, 14 May 2025 16:24:00 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: Convert ti,dm816-ahci to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250512215706.4177925-1-robh@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250512215706.4177925-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 06:57, Rob Herring (Arm) wrote:
> Convert the TI DM816 AHCI SATA Controller to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied to for-6.16. Thanks !

Note: I will wait a little more for the other patches to see if reviews come in.

-- 
Damien Le Moal
Western Digital Research
