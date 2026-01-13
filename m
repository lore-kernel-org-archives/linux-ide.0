Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412D30F94C
	for <linux-ide@vger.kernel.org>; Tue, 13 Jan 2026 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289705; cv=none; b=Xryga4qvoNi4cus0H4+A0ra14mYYeIl5Sd73meYsWz32J31FOqKensDgt0CHESDqJJNwzlhye3mylmwBABiT6PQDGwUz0mXOG0mK/hrotOcWSGnaxGcOkxVBnACyp55VesF2tTVEeHv6eDLCNfuCC7XruKxGuDELZZF0dnOWpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289705; c=relaxed/simple;
	bh=2pDdu+GRV7yO+ITGfCqB2mu2KW5dJ+c37XO75FPCvMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KINEtoBlGYdU0fYJ22dyTOczF2Fju5Zi+OImIFwdOz8B8paY4LKqPAa486llns712Gvj67qvpPimN5c9i4AcFewj5F5Oiut5fRGgQVjUu7pL/YYA6k/6SNzjTTU020XP1B3epRXnOsrb9fP5Prnmek5pfP76vWXBy1V2Za5DvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.26.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dr1H62qFDz8v0H;
	Tue, 13 Jan 2026 18:34:58 +1100 (AEDT)
Message-ID: <cdaafb76-cb5a-47fa-8e66-b22148b1564c@eyal.emu.id.au>
Date: Tue, 13 Jan 2026 18:34:57 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: Why do Pending sectors disappear without writing to them?
To: Damien Le Moal <dlemoal@kernel.org>,
 list linux-ide <linux-ide@vger.kernel.org>
References: <a41dafec-2ab8-4e6f-83f6-628104ee9b7b@eyal.emu.id.au>
 <211e1d4e-7ecd-4f83-b437-a4a09ebcf035@kernel.org>
 <fbd27438-3f2d-4777-8e7d-f9df2bc83b80@eyal.emu.id.au>
 <37c3a9de-768f-4ef5-88d0-6b6ae5c49524@kernel.org>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <37c3a9de-768f-4ef5-88d0-6b6ae5c49524@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/1/26 18:02, Damien Le Moal wrote:

> You could try rewriting these bad sectors (copy them over themselves) to see if
> this pattern goes away.

Damien,

Unfortunately only a very small number is ever reported (maybe 40) out of 656 counted in
Reallocated_Sector_Ct. The same sector was never reported twice.

I will let the disk limp with palliative care until the suffering is unbearable.

Thanks four your advice.

Eyal

-- 
Eyal at Home (eyal@eyal.emu.id.au)
