Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D534418F6;
	Thu,  8 Jan 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864535; cv=none; b=le+i4mGK2JSXuhvCyH/km4gC/q/RxNmQDjsUCl2CK1Pj5Rv2dGYm08fxKDdiV2eRHI5j2eWLR9gOxdXVU9IBa46AVpOJw/nevgHhpL1SnRrP9DBUKTQxcNcz6ECk73qldAW1dP4JNQt35NPYEWQZ/+CQgOh7l6PInF/k8cdcfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864535; c=relaxed/simple;
	bh=+tjyFd0fHw6LzOXUd4ZwW/MPfhrm/H6pAzD5LF2K2vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPXwGnvt5kN7N06OLEtwIO23D9efEfq0PBT71+uZp2C0WETAJ+S8H33Hs5ibfUApWdrd9gvlaGXoZtZ0A+SMfkXp4LIyebDSTwPMHeHXxQY1S2X3p0CgKCH4pytLJ2TIF9BVINu7DA4iGZyzMWBXzgZxzggl4ZnmMiW1AZ5oqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awTOKt+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awTOKt+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8B6C116C6;
	Thu,  8 Jan 2026 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864533;
	bh=+tjyFd0fHw6LzOXUd4ZwW/MPfhrm/H6pAzD5LF2K2vI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=awTOKt+lmnJpjDDNby9RkdBSwUKfmQhzH8iNRy+O3PHCk2GdDZlkTtdxOpK61T9v7
	 sn34EHzx4obAvdDu3RI0Qasj8cpsxaQmN+tqXjMFpbkaKQol+s8anbhwILubdPcrgA
	 3e9cWQCkZQlKDY5bJS+8VhinWD3ZuUv8IjkEgpS9v6ZQP2/WjrmLy+ndCmREPLgH5D
	 w3gPRXtMWFtS3aC0I5HFW5XmoaewMze17M6ynOhg3Fx9PAfa735sbjwaAalyjr+5aq
	 XTCltdBgXFUm2d6WNROdT93GBeJxgB0G6QaJM0k0cz/pIxYY11GWXNhduY0UAvtT+X
	 ZmCCtpoJ5NQDQ==
Message-ID: <883ef963-4974-4e7d-a0d9-876be3d1b4bb@kernel.org>
Date: Thu, 8 Jan 2026 10:28:49 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: ahci-platform: Drop unnecessary select
 schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260105212917.3454753-1-robh@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260105212917.3454753-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 22:29, Rob Herring (Arm) wrote:
> The "select" schema is not necessary. It looks like it is there to prevent
> matching on "generic-ahci" compatible, but that's not necessary because
> this is the only place "generic-ahci" compatible is present.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Pushed to for-6.20. Thanks !


-- 
Damien Le Moal
Western Digital Research
