Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305A27E048;
	Mon, 22 Sep 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532620; cv=none; b=qPP/VDsPFcAK0XHtjm2WOYJy2RA815b4+ecGZvdPFpFCKqt0wLsuP6lwUjjxNuU9q6PzeHxZrXfC5oQT2Q+2RNoEcdUfmosfh5r/WF7besSJeK1LbOq7ssTopumeLKttDVlwUO8dbAHHub0r7Br4HupbQVZCcT+69X/U+oexdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532620; c=relaxed/simple;
	bh=ndoKjbXd99W0Q01g1a5m27fkrZj/8VRmY8Cj68kDylM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwfpgSxB7W2youj4knXoziq+GrdeBOmEKZA5ABkyZVUU341WZLDc1pnPrzOEdVGyN6yNMkNlz4pdPqzSpHOJAN2AFT9kfOmNRnYg7vO9LKIUsaAneo8RZfnFLBAa29ZE7pLgfOr4MO/HLh84QkMdof5Bw6KaH4PNQ0HM8G6fGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2hhDm23; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2hhDm23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6D2C4CEF0;
	Mon, 22 Sep 2025 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758532619;
	bh=ndoKjbXd99W0Q01g1a5m27fkrZj/8VRmY8Cj68kDylM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N2hhDm23neKJghj6Hh1G7FHoqN3aYYT5lvp6w6etfpj0ANC/077FPGj4AYj6msawL
	 4L1usIw8BqBw6TWReYxYC2uL6Z7INHCgj8g1gO2m5OyiWvnojL5CgjpyrSPRBlQdog
	 SaBjaB4Ds5jdgZnuTaS0j0uDXUtOtH1dZc97AuQcCOQ/r2aJuqOskQOV2euZA9bo0f
	 civrwJG0o0Nm0ESsSIeoKUNkdcHyCw54CrUAhtavmO21ECM9L2QjGIzedGIrNb1bo5
	 1OLgv0OH1E4JiEDZf43x/lGLnHhQKmAMc++Vl1BAu64z6Mnhy4VNx7hMgnfkMOoBI7
	 W6VVc7Sm0jYQQ==
Message-ID: <7a15302f-6528-427a-85e5-e4fef985f185@kernel.org>
Date: Mon, 22 Sep 2025 18:16:52 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: apm,xgene-ahci: Add apm,xgene-ahci-v2
 support
To: "Rob Herring (Arm)" <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250919223532.2401223-1-robh@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250919223532.2401223-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 07:35, Rob Herring (Arm) wrote:
> The "apm,xgene-ahci-v2" compatible has been in use for a long time, but
> was undocumented. It doesn't require clocks or phys.
> 
> Remove the "apm,xgene-ahci-pcie" compatible which isn't used anywhere
> while we're here.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied to for-6.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
