Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422503;
	b=hHq6iWIlz3+HtFgGlkviCXh+KqycEkNPSv2j6ivPyTBgTtkIE+kgughcUoPxcsqJuazL
	 A7MsjuQyBwy1h6dwkS8JmO65cBQJ0434S/sjPb7bwkj9fpy+b4+xu04jneH2mFyI9Jx4G
	 Olt6z1VW3ouXc5uOuGOp74ROIRrSaR0dKFPRap2l9stY/xpbXxEltaWlWRybJqxWTqw/H
	 Fz+IdYnvh7iGA5QLjHYKke4aYlSGKbb2Zsk7QMperQyc+La/uLQAx4wJDTe1rOCXGO0mZ
	 Ev0xO1slySzbo+kUftFV8DJ/QxNXihhRc8zVeRsZmHoR3Qe9XrNvelzmaOY0X63mDPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422503;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b0SFDURPDtHYhsTYGEf5G56Lkm17f5tRBqoimhyc//E=;
	b=u3QorE2/AdN+OLaRJkPhMfZiNXLq4DNtjBv1ojvD4JDnylrG5Uxknd6LD4gITWUA5+h3
	 Pk2RqDqJAgsCsaFUbKEP5naZU2OOWjwlsHOxvcPXxSrMsaWPAAstqx0xR6ot5MAxJEDft
	 NBTCoQ9yLgjPDI1ARMe9OZ3UMyhyqjs4dR75teVBtz5JoC60jbMPa0EMK39+na1FqaRDU
	 4vAT5+G+LdfifwRaUfT4ef19p+tvzOJBX9rUFZUjd+bcO3WXgsdi8ZoS+A5wzeZ4wlX/s
	 R/klvZHj9DP8UJu3Jwz63vc8adq+WSecQxUMKfWXMiw+v8R3L2v3+EWIbFNQ1nzTr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7M+DngD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2952606A31A;
	Mon, 23 Nov 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7M+DngD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50D21F000C4;
	Mon, 23 Nov 2026 08:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422503;
	bh=b0SFDURPDtHYhsTYGEf5G56Lkm17f5tRBqoimhyc//E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i7M+DngD1SDR874UCBpw2SklVQofyZcfxMeTHvjGIKZa+v+g+DxJyHumXMA1YEUKH
	 Kg4aSv1qTf1LMH7sul6cKuzOmamn8Lq2Ke8Ay3HHNLePNP1G4+kRR4O5F5XrqOya5F
	 pw9qL+95yGDFAIFBJdDeFnYDD5C0qIxCNiEDIGrw1QFJmqdeVX9DwhHHxRBHy+zVfd
	 /Jo9oR9rFS2karUpqaX4Tfo5GhSowux+fD98NCfnZHO3CDgvpyUSb0lV33zGrVuvu8
	 jLZxcIGCaJQHKkyVIBsU4FLOVOtxerC2MF454BPc0eIU4yaS6WZIIrKGYsKYKczbHf
	 4FjEffIC2WAQA==
Date: Mon, 23 Nov 2026 09:28:20 +0100
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
Subject: Re: [PATCH 2/9] dt-bindings: ata: rockchip,dwc-ahci: Allow iommus
Message-ID: <20261123-first-dark-griffin-a7d2a1@quoll>
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
 <20261113-mmu600-php-v1-2-231196049a3b@gmail.com>
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
In-Reply-To: <20261113-mmu600-php-v1-2-231196049a3b@gmail.com>

On Fri, Nov 13, 2026 at 04:38:48PM +0000, Arun Iyengar wrote:
> The RK3588 SATA controllers are behind the PHP SMMU. Allow iommus, as
> snps,dwc-ahci does.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>

Same here

Best regards,
Krzysztof

