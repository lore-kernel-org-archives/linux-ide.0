Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261377;
	b=Di3V4HrwzW0OdSk0gATNbrd/gZ0ofKZUHRznbV3ksV2IlIa6U5fYb7xo/6BI+ewYfZB3
	 hAkSbk4XXsHjx6R/vF5AstyeXtYTosHKi8kniHOdhLZM4Ef2ukk6EaD4jcyZ0bjLH7h9w
	 14QkIA9oGem6eMDsViILQsFPX6pfQlXIVfyYZNSh9xVrYMaW6wGaxpmgvTzN8mtekQlwg
	 cyeKwKrqxwBJZMQCy6zJOxvTWmVNUCM3VDwBygy0SLQuX1VMKBbyZbxsrkBsbTz28nDlU
	 RrJGlh3kZjuXzh2rcpr5M9mqKoARlYasa2iPKAXyA17UyvsNQWi0fKLq+LB0Sq1SMOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261377;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XcnOgGjQGzD2jt2+DxGN1X1zcvzYzq6x9cioPsXKF5A=;
	b=KjdCJy7bMWDPjROT/WzXSKPwVamYEDUMcOqunM+2ZKZESBPqZXVexIfRJA1pDBT1ok6+
	 D30fWhe11fge4Pdrp/wV8hvzVLGSeugpaFvN34S7Fc0mI9tPVL14xJjhAm1SUMfSPe8cq
	 YeQCPmJKLr2/Yb6chjJsNO7bVyzDBnYLjzBvBbj3uJarzjipNczIS1JGS+F8NikTLsfYv
	 VNfGYu4cTp1uS/9yjspSUp2i7325gOAAexoRO/2sdicU0nN04HVBh1twML3UB9wY0H7o/
	 t1e5wdzPUUelAJJUkxVEVjnLdOzePHE2HgsVD05bMwkaYHqSIAZVp2SpwnTgzC42UDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQQUUwqu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E048606A31A;
	Thu, 29 Oct 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQQUUwqu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049331F01825;
	Thu, 29 Oct 2026 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793261377;
	bh=XcnOgGjQGzD2jt2+DxGN1X1zcvzYzq6x9cioPsXKF5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cQQUUwquaWBlsXDYoTLxTQ94mlF1ENpJUtdHRep3gjTCqt4CcYJmg0orM8Av1MiJn
	 lijwkBKZ7LYj7PTQlTnAP3Dv0g8kJMnSbSEZVygjKv9nKRvOVDZ/GEjQbuRl+Wyzt1
	 ZRoA+HU+wX9/MRRSER2kjftPWPbhc0iYqKcjG6ycMATi/mrmHId+n3uVqMJU04qMYB
	 Sb1rwbVtZUIn8OWeclPDIQd8Mi9whmlxnmfgYFwp3ic1VJHqb84SW2ip8N0JyV4jnW
	 g1JHXWYGRyDGGJk0i/RzvjG33Yx/2+N1YVFmQmXsQD/ScyocJ0lTlnZzHZ0On9PTmJ
	 vGmNnfGnH8yYQ==
Date: Thu, 29 Oct 2026 09:09:33 +0100
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
Subject: Re: [PATCH v3 2/6] dt-bindings: ata: sata-brcm: Describe the NSP IDM
 registers
Message-ID: <20261029-versed-automatic-orangutan-43cfde@quoll>
References: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
 <20261026191618.3178830-3-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261026191618.3178830-3-florian.fainelli@broadcom.com>

On Mon, Oct 26, 2026 at 12:16:14PM -0700, Florian Fainelli wrote:
> Northstar Plus uses the SATA IDM block to enable the interface clock and
> deassert the core reset before accessing the controller registers.

And which compatible in the binding is "Northstar Plus"? I tried to map
them to arm/bcm/brcm,nsp.yaml but nothing is there, so it looks like you
are making changes without having actual compatible documented. In that
case this is not needed. Make changes WITH documenting new compatible.

> 
> Allow an optional third register region named "idm" for the NSP
> controller. Keep other compatibles limited to their existing two
> register regions and allow older NSP descriptions without the IDM.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  .../bindings/ata/brcm,sata-brcm.yaml          | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> index fe7f091e744f..98529784b1fa 100644
> --- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> +++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> @@ -15,6 +15,21 @@ maintainers:
>  
>  allOf:
>    - $ref: ahci-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm-nsp-ahci
> +    then:
> +      properties:
> +        reg:
> +          description: AHCI, top control and optional IDM register regions
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 2
> +        reg-names:
> +          maxItems: 2

Please move entire allOf to the bottom, before "unevaluatedProperties"
line.

Best regards,
Krzysztof

