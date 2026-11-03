Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741970;
	b=fdIF3oj+J+XBwXkF+Sy0xwKVZIppVbTjCMohofLFnELLhPDDCFJ8jO6rp2jTvWE1TzZU
	 u5xU8CIOse3ta4GR7M+YtR3tjiM69eYi0RdBcWB3AbFVtaZj0I0iYn7XtIxyXK67+JHkH
	 W0A+9cAzGGJ2aEsdWOM66Ft76dwYKTAZ/+oYomR4VSAa/EC6uO3GJxCjkzynQ3XIiXq23
	 HtGZN1pxrycJwR+c00OC48gpi/OwD3V4vkkjt8nUAiH13tLvRqGDDvIq5V1hUDsGq1Te/
	 hH1ut8cwzP2SLtP+THYpStoBWGFCXxHM39tuAOEFzlKDHUI4pL6fQsie4h9DvkLHE+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741970;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wKpZs5RzrMNeVmhNeOjdgF9Vze96viW5ervd9xgeUVk=;
	b=JJBUdvfK2cun5VvZ7fbZvzjiGWkBwPUe3B3RJSnNdEX+kcialovlxtFkcc4Kewbv301e
	 EPWj04GzRH4A8fjgT/c0g/PuXNCctiOddFffaC4VCeVqQKBg3dDdu992l9o6PV5NLKBjT
	 iHqt8oHYR6Uh6TUwuWEIs481Eh0FbaAwBAVRF+sORcsE6+f/8Ckq6tASl+diwCp0lNr8E
	 Q/T4lS7zyr8sgW8HSWYn9U/oZB7HzkWhlL8qvKkTbmO5K8lCmqRTNpXsE1NDgJGjjp8b2
	 BJc8zQKPGVt6DOlKrasVvrFCHDmqvc4w8ItA+vMlPUxJJV8dN/47RxN9gJOJhpuyukg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9K4D53u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1988606A31B;
	Tue,  3 Nov 2026 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9K4D53u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C291F000C1;
	Tue,  3 Nov 2026 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741970;
	bh=wKpZs5RzrMNeVmhNeOjdgF9Vze96viW5ervd9xgeUVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M9K4D53uEsZ5Ll1NJ3ntc0pNLmmPyRDWljChg0378psGWVO31qMfeHO1+NqcZwgRP
	 r0E3qqAZWOoQ4cGhV56zS7OBmRVgWzC3Q31wYx9CE+nhxQcRc+ZinTZ0Cp2P8givmN
	 EdqCX9awOgtRB3LTGBDnrZ/DBzp3hYL2eazlX364bXmws/tjHl39gNiPy5S4uU+DoO
	 p+wANBazpemRwFaPro+nr8ReSZbmd8XkzRQhvUuXh8FLsZO3t1QqJIRZPbZWOWcyC7
	 K2k9TdSILnuK38RhvqYhBt2OjExde2K+8CmWEsUC9tRRaFIeQJx46TO8gydcjkLdzn
	 586dequwb2UUQ==
Message-ID: <2acc3ea7-bc36-4940-87f0-90c02bd33e51@kernel.org>
Date: Wed, 4 Nov 2026 06:39:28 +0900
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
Subject: Re: [PATCH 1/1] ata: replace chan->device->dev with
 dmaengine_get_provider_device()
To: Frank.Li@oss.nxp.com, Niklas Cassel <cassel@kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
References: <20261103212427.1769922-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261103212427.1769922-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 06:24, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change intended. Prepare make to struct dma_device private
> to the DMA engine.
> 
> Assisted-by: LLM

Please drop this.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>

The commit title should be:

ata: sata_dwc_460ex: use dmaengine_get_provider_device() in sata_dwc_dma_filter()

With that fixed, looks OK to me, so feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
