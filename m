Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79DA15382E;
	Tue,  8 Apr 2025 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744083859; cv=none; b=gbZJqwuwRD31mtG50KXQpX2G5zbSZnDYjJdkHa9sUrLcalzduvaFpSd4eUjwJrJInalX8M+//MQMW9+1f0dDKizOqGnnno5cxyjdf/kboqLgDWYcZb9V8UPzBVXT5QjIofQ95i6VkChtFrhF5GRIXsZ3g3CEiSldoNxuy7yI+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744083859; c=relaxed/simple;
	bh=k9K2LwfOeLKLocOf/FXdrr1aZSMFK1le7bu6M2NrfdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk5q9QiDPPxZs5LUMsZTqmMQAopQqBcbKJfDEcKfKTkwGKGBVJadHeureSmxydzDFfHlGVxfCMCuRIqtAE6vMX1RDYLMhGqiKxvBVv1zT2x0fdMi6rkHx0sz1Z8jSu8VpYjsEZhaGf1zEkjFcjpeBLKpNLKaNsrrsK5VQ0YJg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3BIBZL8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3BIBZL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCF7C4CEE5;
	Tue,  8 Apr 2025 03:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744083859;
	bh=k9K2LwfOeLKLocOf/FXdrr1aZSMFK1le7bu6M2NrfdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a3BIBZL8OqwpfE2jZ8tT/eO3jRx9muCIeJDE3wn6tBBSdsoDtr+BxVGyuIKARj3e5
	 /zEmO4J3foqAW/K2taQd5OaNe66Yks8nwTt+JHE8J31BNdwRHPZIYYt+IaInrxDFgx
	 zCHURY0KURaeztUjfJUVFOSDnjJXgGRpMwVLPt9TEumu/ibRpnnqQw9m/s9nmEDiem
	 4jOsF3M0B6AQ+sBAv8WBGMWVIuaqWywApamsEX07p+ug9JMsrdQgUKXRTxbmYL4oZA
	 xl+64Iz2noYpCJW/nsUV6OJfLf0JJcJL9vbthODU8uAAQhVQlzWWa63QXCwdtc6oXn
	 lTrZ/R1R09MgQ==
Message-ID: <2804da1e-b636-4a08-a42b-1eb77b7556e0@kernel.org>
Date: Tue, 8 Apr 2025 12:43:36 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_pxa: Fix potential NULL pointer dereference
 in pxa_ata_probe()
To: Henry Martin <bsdhenrymartin@gmail.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d16bdd67-5060-4bb1-991b-6c82f3936ace@kernel.org>
 <20250404061438.67557-1-bsdhenrymartin@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250404061438.67557-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 3:14 PM, Henry Martin wrote:
> devm_ioremap() returns NULL on error. Currently, pxa_ata_probe() does
> not check for this case, which can result in a NULL pointer dereference.
> 
> Add NULL check after devm_ioremap() to prevent this issue.
> 
> Fixes: 2dc6c6f15da9 ("[ARM] pata_pxa: DMA-capable PATA driver")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Applied to for-6.15-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
