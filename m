Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422484;
	b=jxZN0MGoNhQmFZFquDLYMkPaXInAfsZsU2lBKJx97ODD1k6dL0F4I2A1rEYxoALf04MT
	 8/ibmqfaecouKY5Zi7ouR0OCN0uvMGpOSsNicrJaxlCc3zkNmic2wqPi0y5Lq3xj1MW7G
	 xxeU8JGF5/7Z/TYQJ1Vbdtefm88MBA4T6oGy7Ate6LnRPLzGDybjXZkW0JsVlwOTXBpp0
	 fHMLLQghyOgj5tYOxG/jzWEI9PPPDITLMkpTN8eAfNxnNo3jJ8LKI/yZTVMiJlb3jeG7k
	 Hd4Z/IzDrIFJaZ67bFrKJNPty/Dk00rdSm1D01dO9zTKn66VQIgZkXC7Bdgy6NzeGjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422484;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ijyetjFveDyx8d2oHXD3zLUbbfnSn8RYdMkJF4ohCQ0=;
	b=piOxAreywEL2ux0Hyn8t4ECDbRvI2FFvxJrtL8UxPtc6FC+/EO3PI8IZo3Maz7a774Qg
	 Lkm0vKdUBTk1DStqM5yOSXiT66MIid2U+Vbpv4zAisc7tDiMGucx5KOOY5CYCK7iKDv2i
	 VTuTQlpfWMK+tdjIt30VJOWUmCCG4pgkVc1Dtl4EqNe1E3yPAITc/hEL23KOBrOdMUV05
	 fJvwDuj5aGJeeWBNgRpMzbXwL15NYBMT92VPUVau8nWN4y5gGNJFWfmda2RrIMBk8Ylmd
	 mFqFLLZN+6PN2uSQEcF0jCFSL+rCdtv56aH4gAsIkOx/GdmPUE3ZFWNgvddZopzNqXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRgNkBuA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BBC606A332;
	Mon, 23 Nov 2026 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRgNkBuA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EB41F000CF;
	Mon, 23 Nov 2026 08:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422484;
	bh=ijyetjFveDyx8d2oHXD3zLUbbfnSn8RYdMkJF4ohCQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRgNkBuATBZUt2Ophjkqvi6ZrUouc+KYnC048Q5TibJouB+gHeINVZ/p7qu1XI6a9
	 2txgSp+ZKHXQfE0vmhNscwVpGA140KfyagginBxbivt4s6C/pAOeFMbXwaXqZZ7QSP
	 OWMzC9jLT0fI4Py0ILZryqSbTU8GIktJTETeKRTVaVPo8jzsG/yXvEpLVdFbFKFT+z
	 SJD3Ybhf1izLyCZY03EYBDRFg6pZbaLMj+Sruz/uY8xzOOvoiu8/fyuw6qveKVPixg
	 hOvj69mcV+vW3jfmhBXn294OvOb8ZBkxX1dSmOOO6MXbqISEgZ6tEnxjCSFR/YvKVy
	 AO2wss5/0hnrg==
Date: Mon, 23 Nov 2026 09:28:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wu <david.wu@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, Shawn Lin <shawn.lin@rock-chips.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/9] dt-bindings: net: rockchip-dwmac: Allow iommus
Message-ID: <20261123-quirky-scallop-of-beauty-c662b7@quoll>
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
 <20261113-mmu600-php-v1-1-231196049a3b@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113-mmu600-php-v1-1-231196049a3b@gmail.com>

On Fri, Nov 13, 2026 at 04:38:47PM +0000, Arun Iyengar wrote:
> The RK3588 GMACs are behind the PHP SMMU. Allow iommus.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>

No response to the report, so dropping from DT patchwork.

Best regards,
Krzysztof

