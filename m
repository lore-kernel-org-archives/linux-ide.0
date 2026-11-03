Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741676;
	b=zMNdXJxtCRb2xZCHm50csTmJF/y7bcCpi9PEsqhciA1+LRbTYhC6GlwTwcfoNycpHCHu
	 yyDxVI0+hYNWBIghqkvprGH2ECVn5CqLIr/p9kLezHXxIFlLIdLkdiniVLCi0PIX7cohO
	 HB2+q/qtsAvV6TR1NUIWkrTrusCLj/PvKdzzGEKNJtrSOK38sCLUwpUMLpdFZfNffyWuT
	 FkihpyNId23YwPuNVMgwxIx60yPZ1xvmhodq7hGQw+nQkhR3FiR0FKz70U86A3h3qftQG
	 dw3dgnaDownI93I+RfypBDolJSawSPW9Yliv8M/3T0e6Qtgioie3oB75d7nFOjmJUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741676;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Cw4Vh3u5pUTre46ZqR0etgfWHSA5CGZ8SmRQa95BXA4=;
	b=VpTXELjLcggW4bCutut7w91mrnueDzrwpesQYhZR8RZJ6s07m8KDZc3O+KJKc8hvrB2Q
	 x0iZ0lbC3c+ScBVVSbEThOe4BKUOxCOrXAB3eqY4pIwImNhgUbwO7eyqel+7Jwc8DLzL3
	 xZlLHZunZXGzx8Wxf159Q+uvC907YUjg3lJ+TMeuPSrzBpoW1nPshyT3+9fiAXvSGxiL+
	 49ddIOANpqaFNPOK0lSr6m4o0BefY+fLnytxin2VGBfkuwYHO/cdq6AOdHgBWUUwAndDd
	 3zc1zyIoJqk165v7xsqtg1NeS10jnDaViUSNBOX548wZR0NLVtowySsjNxnOCyrXFBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTlqK8x7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359D606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTlqK8x7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042041F00919;
	Tue,  3 Nov 2026 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741675;
	bh=Cw4Vh3u5pUTre46ZqR0etgfWHSA5CGZ8SmRQa95BXA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MTlqK8x7Sc/UFmXQjPFemn1LTgfV4ZmnecyweCcJGL2b0wPNgUPldOEDD25KwyRvx
	 QbMp4BDoToPZg+vN6hGkP2ov7yQLgnKNG/M72+4RgXceEMr0cv2XL9URVfkzrpjGw9
	 0/aH7FOLcHeRIM0QOJxk3cw14uUaSk08yOwabUSx2KoGI/VsBF9F7AdqOodAw8f2GF
	 Fvp+ZDBvlMMuzDhb7yavPXi4HA3CYXTPWp31sjYxtGYEeiTzyrGdzBaH1GGhVeRTH0
	 6dJAuNqcZGkvE01FJYFoWGpbd28kJPS0WfHHKRFAkcmYR0tkPoQQDc0Tw2WvqDjAUy
	 JXMwqHVEmVS0A==
Message-ID: <58a8321a-3434-461c-8749-497290e691e8@kernel.org>
Date: Wed, 4 Nov 2026 06:34:33 +0900
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
Subject: Re: [PATCH 7/8] ata: libata-scsi: set the field pointer when
 rejecting CDL
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Shao Mingyin <shao.mingyin@zte.com.cn>, Hannes Reinecke <hare@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
 <20261103205448.931471-17-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261103205448.931471-17-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 05:54, Niklas Cassel wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ata_mselect_control_ata_feature() rejects enabling CDL while NCQ
> priority is enabled, but unlike its other error branches it returns
> without setting *fp.
> 
> ata_scsi_mode_select_xlat() initializes fp to 0xffff and, when the
> handler fails, adds the offset of the mode page in the parameter list
> to it, i.e. the length of the mode parameter header and of the block
> descriptors. As fp is a u16, this wraps around, so the resulting sense
> data reports the byte before the mode page, i.e. the last byte of the
> mode parameter header or of the block descriptors, as the FIELD
> POINTER, instead of the byte containing the CDL_CTRL field that
> requests enabling CDL.
> 
> Set *fp to 4, i.e. to the byte containing the CDL_CTRL field, like the
> branch rejecting an invalid CDL_CTRL value does.
> 
> Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> [cassel: set *fp to 4, the offset of CDL_CTRL in the mode page]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
