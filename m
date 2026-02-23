Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C98757EA;
	Mon, 23 Feb 2026 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873075; cv=none; b=Lrmedgya6AQS3YA76I0U6HBrvwf+XpTWG0JTdUmzswCG8dKTMBzAI7rBw1hFgWZ3G4LWk6WM6FrceaWL/I837Xlnri3lFkNxEQV1l0k0PsRWGh5cErSpD5k7RSMLKxWj9+TssQksNsj5F0mqNVgZbYMIX/wUVS5A2eQBEw3fdRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873075; c=relaxed/simple;
	bh=g0Q5/vi/n3KDDToxDqxi4w/+3/UlTQzYM7y6tF/hpy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYTtlD5e1FipST+bcDE/MF738bDrmhQ9i6i9F66B/aKJSqjZIbNRcq5luxJ7969bqZe4CtAy7Rn5PMWMF4HVxwfNXyQBe4/LO7RPl5ZMolsj+uCAaSbojssbYEkSxs42iLuWra3GwZsKootQkeRn859Kk8l/gBLXr7+i33nJFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVPmBsTJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVPmBsTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03235C116C6;
	Mon, 23 Feb 2026 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771873075;
	bh=g0Q5/vi/n3KDDToxDqxi4w/+3/UlTQzYM7y6tF/hpy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVPmBsTJ8uwxz7KHVVW21ID6c6VB1woZbQgsHrNqXqPVhMDLYhSgzYEYSEpnK3Q5z
	 9vphCNwdgOfshR8NmWIA7qYzZw5jaUYtGBXullGweI/FD2/KfdnazzFZErckVSaJv3
	 AVni2W7kU7g+ZoKs7xhKTPE0PFOMQKeKwL2Wb6tT6ccJbnVEgJ30DqWejEMqGN8Xk3
	 n4FJzHJ6UFFkMjNm/HaPkWn74YqmxKjnsRQrZK5yNYsRYxTyrJElW7QNJuTWRvptlL
	 eBG42dZ5fswoR9XeK+QHIZa1DAcf1eiz9yAiqbHh9ZLkQ1nO/m5wyc3l8zOcdGyK36
	 I0GFDXDRpEajg==
Date: Mon, 23 Feb 2026 12:57:54 -0600
From: Rob Herring <robh@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/1] ata: ahci-dwc: Remove not-going-to-be-supported
 code for Baikal SoC
Message-ID: <20260223185754.GA151596-robh@kernel.org>
References: <20260220133613.2392906-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220133613.2392906-1-andriy.shevchenko@linux.intel.com>

On Fri, Feb 20, 2026 at 02:35:46PM +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: dropped YAML and regmap.h (Niklas)
> 
>  .../bindings/ata/baikal,bt1-ahci.yaml         | 115 ------------------

Bindings are separate patches though anything only deleting lines is 
automatic ack. ;)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

Looks like you missed a few more cases:

Documentation/devicetree/bindings/bus/baikal,bt1-apb.yaml
Documentation/devicetree/bindings/bus/baikal,bt1-axi.yaml
Documentation/devicetree/bindings/cache/baikal,bt1-l2-ctl.yaml
Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

Rob

