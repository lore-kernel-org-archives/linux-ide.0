Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED622D3A9E;
	Thu, 21 Aug 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768168; cv=none; b=I/hLmM4AGylIvrYweabby7NLD7LZWuN6ewP/Qa8rNPnJZ/W7MX29kKhgWQ4pUNYOMMkxMe6o/OY9atGtmjniSOZsa7SCSxLjV/1K3IvDzWaK8BXeTCDZQdJREs5yS3/hLk4j2GMU73BE6Vpjg6mVg72eMd7bglPfnqMVoyPixpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768168; c=relaxed/simple;
	bh=pNjuviuiA7HK8pyx2K/S+jSNV8oUtA4ctJGXF7XGnwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeEZOPFYC/oYYGfhy2+qfcnI7Vp9AkmdCkMBGQOXmE9p2aTCxBmFW/UsY+f3ro1exCcl5RxtSvcm9KpfkI05ZZC3woVHpa01ggQZo5TmXmhO6nD9Ybxla2rl5JDDa4ISNhNtuyDS48ws4+TTaJK9HUOa95KnTlWAOfSpw7j4kIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 051901515;
	Thu, 21 Aug 2025 02:22:37 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4EFC3F58B;
	Thu, 21 Aug 2025 02:22:43 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:22:40 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: highbank: Minor whitespace cleanup in
 example
Message-ID: <20250821102240.02a5721c@donnerap.manchester.arm.com>
In-Reply-To: <20250821083239.46726-2-krzysztof.kozlowski@linaro.org>
References: <20250821083239.46726-2-krzysztof.kozlowski@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 10:32:40 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The DTS code coding style expects exactly one space around '='
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  Documentation/devicetree/bindings/ata/sata_highbank.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.yaml b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
> index f23f26a8f21c..48bdca0f5577 100644
> --- a/Documentation/devicetree/bindings/ata/sata_highbank.yaml
> +++ b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
> @@ -85,7 +85,7 @@ examples:
>          dma-coherent;
>          calxeda,port-phys = <&combophy5 0>, <&combophy0 0>, <&combophy0 1>,
>                               <&combophy0 2>, <&combophy0 3>;
> -        calxeda,sgpio-gpio =<&gpioh 5 1>, <&gpioh 6 1>, <&gpioh 7 1>;
> +        calxeda,sgpio-gpio = <&gpioh 5 1>, <&gpioh 6 1>, <&gpioh 7 1>;
>          calxeda,led-order = <4 0 1 2 3>;
>          calxeda,tx-atten = <0xff 22 0xff 0xff 23>;
>          calxeda,pre-clocks = <10>;

