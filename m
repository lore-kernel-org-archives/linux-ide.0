Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3C4C6C;
	Thu, 28 Aug 2025 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756355494; cv=none; b=IkjEDJ1EMwZWrygG2Sj5BCEGVmiaDUBtZwBilmY/p2QNr6QM2h64MVdGjiGPTMDou5LoHuOUDwV/djvn9YOeJEzXtrqujEAuUYj/pLC2zsIbXzlbzSlTTSzRcYCEaxtWPPDD2vtCTLs1Sowsa86+9VnXyPm4Qz41Y1/pu1S+utY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756355494; c=relaxed/simple;
	bh=SBVM7xEfTU5B6hQu/DT+Zt/qKN9nEG0w1/uxuvhRoAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqqLNmuHXGviMAZokPa/TFjEsN92RdjxeFebDqQCo6reZhUn61hUDFLAM7RQMfJwDJQERXaLyIn/Br7cPjFpdb5thWQ0e/8qnnK7TiVoxNKtBIjE1/wUtmtLysRjB8MREalPJtXTPmFfKwLNGRDMcIe9ke1puzdGJZ90Ytb62Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbX47mnK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbX47mnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732FAC4CEEB;
	Thu, 28 Aug 2025 04:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756355493;
	bh=SBVM7xEfTU5B6hQu/DT+Zt/qKN9nEG0w1/uxuvhRoAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WbX47mnKPXD63aDs0+/CSE/yw1VJVPTGdav2eTfel/pf+hu9J8jgL7dhfMf6tE2dh
	 JzU7MQDqyPaWQFvrDJze/IR8YA0EsCWXYcu0ld0PUaZgZjW0dZsBhF8c8C7BW/+XbR
	 SP+GIpgUQjLl6at6PXV2Rqu0EAgyHApH3O0E+Jv6TN4S+RVjO5fXBI4ZXfeE8Oyoct
	 s0i/Gu3pNrx9xMB5JcFbJ1piXd3BybLSchWu/iUvHk2yUnVS8r09eJTR99NA2+ugSH
	 9KERjvrEvc+HSMgeF0HnwkYM6+HqB3B+GdKGNfA23AqVMGHqhOngPnmfC41AZBE7xo
	 0gQvwWBv//EfA==
Message-ID: <36415f84-4441-4457-bccf-d5abd3d69cb3@kernel.org>
Date: Thu, 28 Aug 2025 13:28:40 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: ata: imx: Document 'target-supply'
To: Fabio Estevam <festevam@gmail.com>, cassel@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org
References: <20250823195021.300488-1-festevam@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250823195021.300488-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/25 4:50 AM, Fabio Estevam wrote:
> The 'target-supply' property is used by some i.MX devicetree files.
> 
> Document it to fix the following dt-schema warning:
> 
> 'target-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied to for-6.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
