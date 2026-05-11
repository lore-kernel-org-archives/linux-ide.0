Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB643DA5D;
	Mon, 11 May 2026 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536286; cv=none; b=hKzoFmL58DFpWd7yyzq/JjBMJ7aAWxb8Xo5XjA2zdJ6iYV51LvVeLUjBfth55HY9CYGD8LGf+AnVVGqsOtAg7PMkf+SBLSnVRxGia/n4qw2+L/psIv3cVVc7ahh5G5Nab9MdX3S09mUHLE1N0XXNwgf8AMuyHw0SQdxq7lXn8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536286; c=relaxed/simple;
	bh=t1YT0uyEykVcqGB8FKzSa0d5dxdceljyfzVDLAJ3bec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkTtGVm6H1TV25r8jZw0FyjmdNvhYzewtsYkdh9xWcHY99QNThpjDZsYgnHn8XRM9hnHzMgqgS7+zV9Xf8GQwKbGePhF5cQ7cVYGTC2eULfSInDrFKtBGy4i3hdHs6tlfF4cwlW/7omfIW8B6gy4A3Pk6eALm0bxJ0JfxBEz3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx/gRhSc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx/gRhSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AF7C2BCB0;
	Mon, 11 May 2026 21:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778536285;
	bh=t1YT0uyEykVcqGB8FKzSa0d5dxdceljyfzVDLAJ3bec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fx/gRhScwM2/AQPuxTqlBo8uzXEDcx1qaZD0L0UGaG0w2Sfz/tLT55p7HpxJ7YmId
	 yWYsprI+nyIiU5blqPH7zEe/xjAh09HPqXEiqt6E6pnfcVT+dBPOpsCM2kNvVm4Kbo
	 giMYPG1B7X6KM5dw8dRAnBMyMQxBQcuwhKs9UBNC09aP+TtBag42NS512en5YDwDqw
	 bvBeV+IkjxRKycmKSYbExGwsvHS0TmSP1QQTq9NO95SUX+c4O3NrztxTp1ZUJAjgIa
	 0m5Xmv4lHBZRQuk/bQRdlY+FHviAWDh/jbdcKuoefDtnwM2+G//nnj+fISf+KYDwwa
	 Unb9HXohikDpQ==
Message-ID: <abd12c4d-2337-47af-b016-fdde06615061@kernel.org>
Date: Tue, 12 May 2026 06:51:23 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_arasan_cf: simplify ioremap
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260510194607.9567-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260510194607.9567-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/26 04:46, Rosen Penev wrote:
> Use devm_platform_get_and_ioremap_resource() to combine
> platform_get_resource, request_mem_region, and ioremap.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
