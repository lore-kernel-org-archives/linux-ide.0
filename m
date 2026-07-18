Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FB1FC8;
	Sat, 18 Jul 2026 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343671; cv=none; b=mlP9D6zhZeI+/q5bcM7Aht0z2fNAPF+OT6GNBZl/lPK6YV9Ntgf8GBKXFcPIwsIpzYqkNi6EENv+cHpIy/XopyPcUm0RVmxraNB9p8zW8uU7e7TOw4Yr+0E0WrJAduNA2k//r4XPlseFjlFO+B0NwPJDjbIfFDHVBFeh+5k+fLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343671; c=relaxed/simple;
	bh=v2HcVKSDo5eZ4Vwq9HD98k9/jS1jHVSKis0vOQul73c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EesMaT+b1YXfSWs41IUS0ADTe9y5l9qnURNahLHDFKbseW94kdmf4eNUy+deJkyHkgnYtPjiclfRJT/UhPwg5oi+uj6vZeplJQQOGCKt3MV6duDXvdIMA2DMrklM9raJn4Zz0YnyHpUWfyzOjHJvMjEfexvpiPjSmlQH35rff04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnD5QuSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnD5QuSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4153A1F000E9;
	Sat, 18 Jul 2026 03:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784343669;
	bh=1Xqer7/ciN48RSZM2/9b9HqXKufbmc/Jg8u/6fktzfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TnD5QuSsHhwPFS/kyeKViCktjdPVsBXEApHOVQHKn5qRCaQIAu1KUuMcdcsrXqF5C
	 BORmDe9Mxh4ehNMqQazmsAtBsV9yKMM7kWW3hiNrinCIwv1ZVBsE6R6oz/i/Mv5Z1l
	 oFeEVLXiR584Nmv7JdjZMsSE/ELeZrK78QIwch5Wd5hy0Wr4mgHzHl6EYfFzpLYmcX
	 EiFNWAAz8lWM+Au/Zm/+g5cAhpgbNCoy0eb06TScFde5UZDDh2BdkQwS0/OQHs+kY2
	 moDYd/wgfKCw5pY+w0seiIusPy42oYJmK2T38USAzjv5iN2VtvMQ+lAhoC6sHvHqr2
	 E1FGPlcaXdaGQ==
Message-ID: <c8f10c69-2579-416d-b302-49052447bf33@kernel.org>
Date: Sat, 18 Jul 2026 12:01:07 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] ata: sata_mv: Use platform_get_irq() to get interrupt
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260712222003.1008136-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260712222003.1008136-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 07:20, Rosen Penev wrote:
> Extract platform_get_irq() out of the conditional block to run it
> unconditionally, replacing the direct use of irq_of_parse_and_map()
> for DT-based systems. This simplifies the probe logic and avoids the
> need for irq_dispose_mapping.
> 
> Remove dead branch for platform_get_irq(). It intercepts 0 and returns
> -EINVAL, which goes to the first one.
> 
> Assisted-by: Antigravity:Gemini-3.5-Flash
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.3. Thanks!


-- 
Damien Le Moal
Western Digital Research
