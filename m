Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678124;
	b=r8SzkpKDrpC8U6qbAhnSZDrxpDhmL2/rPgPS9XhfrMCNu1Zg0KRiumGIoXFWVpU0xMut
	 seAtV89nyvnl9EOtngM2g/l3g6N1128a+qFl73WHiS098UZUsSBnH7l04cBxygzIrLtad
	 1KtJQJkhNmQEpYd/5K1Z0tKczz3lLDiDv6D76koEjw/MC6yOlDD5uOd5icOJn62ie8pUg
	 XrOVC7fIrjyGEkcokkImu8PIyQLHBvru/kZSCoG0pGCr1FF2SdmQDDOAiIf9OaOrEtmQ9
	 BvStWd76+IxK7FSIBvUrCJI5bQmXkfAAJBqty1I2iY+APRGV08OX9qFK2rfMvYDS8mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678124;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=//Re+V7EZVfWXwg/O4zdzNqJu5htYVv59XsGVxPQq/k=;
	b=eKqmJf9JODQHEjBX20m2X+MzPeRgr75C8UO/pnc5acAau+N6Jr3uN8p+xstvskjApxwh
	 w6iWRjexfsrkDvy/Oqg6feJfJ5yw/hHZ1emmKkJXOae3DWNH1cBLe5cWFJnwn0ks6YPX/
	 nRyhDlUenSQOBVF06ISi5bglDwCm1eksIpBAZhY1ld1IUr44PTlVOfofytPiH1perLT//
	 luGmPK9qz2o3W9W1aWdfU0lWiJ9py3n1rWZw5kPf9hjz3qcnHMdNTsn4ld53FUulMZTR+
	 5wfIv/eryPpPezvqB6Q3H8K5a/xGvL6ertdDRVT8H/vUmz2XUrcaTJ4ZuaJsMva4Wpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPn7loh0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAB606A684;
	Thu, 26 Nov 2026 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPn7loh0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FC81F000C4;
	Thu, 26 Nov 2026 07:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795678124;
	bh=//Re+V7EZVfWXwg/O4zdzNqJu5htYVv59XsGVxPQq/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XPn7loh0dhgKLiE5vQ3qsU91eAiqTW3S/TrdP932wI8o5Lm2TSzuPj9yQ7Y/HxAqe
	 Xdqmf//U331vtmnWUEJDXvbuRm3SU7ip6+2vcdgrHa2/ilvM6hGukKa/yieMrOUt6t
	 hmRsRXRr/Q7bOd4ezeEkMTTBXgUjZiOM3n+FLSCTX1nCh908prfuKcUvY3CQjvJM4i
	 7/iYCpxmZ2yq95PCtAX7vkudu98udsN0UU0I0gtNZH6zPYjMOURCgHo2EacCMeIbcI
	 as8kc6fTgV4GBzTGp8e+V6g5HP4wHEylLtq8L3WWnDKVx2vMjf9benzLi/Yc+lemAE
	 +BajNl1vnfnPQ==
Message-ID: <5c9b117b-6bc7-4246-aa1b-228e4e4a43cb@kernel.org>
Date: Thu, 26 Nov 2026 16:28:42 +0900
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ata: sata_dwc_460ex: add missing newlines to error
 messages
To: Artem Novak <artem122novak@gmail.com>, vireshk@kernel.org,
 cassel@kernel.org, linusw@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126051523.14431-1-artem122novak@gmail.com>
 <20261126051523.14431-4-artem122novak@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261126051523.14431-4-artem122novak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 14:15, Artem Novak wrote:
> Terminate the error messages with newlines so that subsequent
> kernel log messages are properly separated.
> 
> Signed-off-by: Artem Novak <artem122novak@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
