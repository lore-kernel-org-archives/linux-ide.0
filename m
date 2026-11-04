Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789245;
	b=YgzOEWqGxhQvV4Y+zpUfPA0AwIhIVhBVfrmdM7EPaBOTZppf2ZpM4Sr8Zoq6OKCfKnZs
	 Zp2BcqdM3PvZdnHtY91BIOcMqgRXum0RwQVwsSzzYyuaA4JEWUdX30LDQT4YUz5ahfSm9
	 ld2gkaLTSJaAZHgcAF2w+eKG60G6RMZSrScEisWIpeVYpbkHcrI4fshXkpt7tKApC7lli
	 SxXtkfycqsQuVRv/yrFMyXAJkwWU867DMDwpX2rgtoGuCac5Knkz155RSZXcmBIpM9cH6
	 GkXkIE5N9GfF+iUUgB8YlGt+WevHtLuOquWOOBikrpEyf6gDCMA0TtkBV8ea5zOk6kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789245;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=izVuTaXv7urzHImsKbDUJPr30hqebXz3eIHBs72kLC0=;
	b=Q1I/BCoLcVYVYPdNzuvmqjGWDZFcZJU5o+caH7QoN0JEWwZVA1MElKTaPaTSxtX7UaQc
	 r9KRlmvLfva/LUZ8X08yxBXWjwMAc5Kopu312z/uT08gumSH8M6FMXX5EKf/YIL6RtKo/
	 2qjAZjg0SQW0XKXTvws+heUZW+w8sZTAfiq0xEAE5+W3n74E7Q+LpzY/lhny4Q/SZNnSN
	 bDIMrmYrDwsbR7dbCoXbjkM0qT+4BiIvDi0uUy0PQf4w1WVTqMMZJxv5D3sugk79+/rGH
	 ovJIBBsAIRU/LCX07hDCP1lzSbl97QyQW9Gpnkg8vxkz6DT8o7mBUog0CwFE/QGZuhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxbRFJIk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70E606A328;
	Wed,  4 Nov 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxbRFJIk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B801F0093A;
	Wed,  4 Nov 2026 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789244;
	bh=izVuTaXv7urzHImsKbDUJPr30hqebXz3eIHBs72kLC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FxbRFJIkDb4ZJYTlZwyIhnq4AVYRI1w8iJ1Lc9TdhDJ5BSYl0iVnRhIO5cKZUdxYD
	 kWN4fMScLm65ugckP6RF/Yl5RZy58FW2wphonclexoMET8n8hQIipwnmruIj7VhyCl
	 lpeXVI0d4FqKrlvJYYri9cTKXT1OYP1qBb+mrdEEYGPrjmROaMUpJp+qWhfq4LsaBy
	 J69V2D0rT0h8j51s1H8vISyzlAim4pjPjwsXqfo7z5BQmovZ1sJIrKrqFMgA5Tsvgu
	 bEr5HpHWQ3fADB/FHyrARkA0zpOfN4mUtmK+lF155k2lTuuA8tdU0CNLUiyjkVq96w
	 PilRtze/xOXeQ==
Date: Wed, 4 Nov 2026 11:47:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, 
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:BROADCOM IPROC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: ata: sata-brcm: Describe the NSP IDM
 registers
Message-ID: <20261104-seahorse-of-magic-destiny-7338e3@quoll>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
 <20261029212513.4126083-3-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261029212513.4126083-3-florian.fainelli@broadcom.com>

On Thu, Oct 29, 2026 at 02:25:09PM -0700, Florian Fainelli wrote:
> Northstar Plus uses the SATA IDM block to enable the interface clock and
> deassert the core reset before accessing the controller registers.
> 
> Allow an optional third register region named "idm" for the NSP
> controller. Keep other compatibles limited to their existing two
> register regions and allow older NSP descriptions without the IDM.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  .../bindings/ata/brcm,sata-brcm.yaml          | 57 ++++++++++++-------
>  1 file changed, 37 insertions(+), 20 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

