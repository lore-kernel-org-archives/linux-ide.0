Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9A25A338
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642616; cv=none; b=fBXdR7mnrR+qpP2b/IMhBFDDVOm3Y5OLaSU6Iorcm2DP7Tby9FN/JzKwAfY941t1Yprep8aiI5KOvQ6NYNX1CHcdrTexda82WLGkOyLjM71k+2T2xAvhfcsqPrxLRFGxQL9DP4o/wT9ovrDeH6GbkrtqRlzeO03EiNXh9tolWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642616; c=relaxed/simple;
	bh=PalukWnpoxHajsaQiTso2FQxEkmAIXFFjUmfggZZanE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkEAUhKTEzD6RYx1InsKdH0ngamfqRX9EDEpJkL9RrWyICTOYBjxIZ/C7ihkQzSWFEtepCzVM/4oKiJkLGB8EALyf1A9eG8cBafh+Na+LB8t55yKBYgejc6yoCQ4u2KEkGaCnD0UsmUYaT3p1NeuPileZUpOSCm7ZFm6aNL5ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVpbK7jm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVpbK7jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D32EC4CEF1;
	Tue,  2 Dec 2025 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764642615;
	bh=PalukWnpoxHajsaQiTso2FQxEkmAIXFFjUmfggZZanE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GVpbK7jmTqs3EYwpj/Uzaf/LRF5EwJzx/DOdkfAU7rhCZgu2i7zKDIGDjCIBxmvtz
	 AmiNzllEwspkTHj1kQhrU0fBNYRuF4Tq681h6yDLLFpZ527lphkyPn5Ad79yEsUmKr
	 dagA5R4mmtRiu8itEszzaE4sLeQtN1bgG/l0FBt2Tm17Oqhih/WCwK9FsSHG7/YfkZ
	 gKMk71U+bpBLP7JAScFfX6GPu7DkLx1Ko5DreRP34krbdojoxYAzIVIAlESxekS4+9
	 CpulL0cWW/44h64mWAvdKeW4mV2WMUgKCIUr9Y49NW7v/HxPFfrrb2xD9qDz0bBO3N
	 Nh/yKffQ97brw==
Message-ID: <4f22f4aa-677c-4ed0-9958-beb5e3e705ca@kernel.org>
Date: Tue, 2 Dec 2025 11:30:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] ata: libata: Change libata.force to use the
 generic ATA_QUIRK_MAX_SEC quirk
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251201123501.246282-10-cassel@kernel.org>
 <20251201123501.246282-15-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251201123501.246282-15-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 21:35, Niklas Cassel wrote:
> Modify the existing libata.force parameters "max_sec_128" and
> "max_sec_1024" to use the generic ATA_QUIRK_MAX_SEC quirk rather than
> individual quirks.
> 
> This also allows us to remove the individual quirks ATA_QUIRK_MAX_SEC_128
> and ATA_QUIRK_MAX_SEC_1024.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
