Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3E2110;
	Tue, 19 Aug 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613568; cv=none; b=gFC5MSKpjw6TY+KYTIlpQejmFqhchgK7q2eKon758XT7Ah2LXD1HJ6MqVeuf6PMiVYgukNDQnXgSEffha4ynunHj1qaglyJfzo0byuyLchPaobbjCm664ofFROJkJfKMugSQ6UCMQ1UPs5IO25G5+6lCTLObVnqG7R64oNmwYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613568; c=relaxed/simple;
	bh=n/xilA7irRmAj0LB/NL12l12Niea8lTQx06zLoALehk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecojp4Z1cICqgI02LUp1WWN6LSjrSLw+T8STWX8/peq+LJZ33F8saUqW9Vm72xKdwtOxh4xCttKD6Db8ZAo6RXXtB77JQd8+pjritwmxXEYyqhpvMh0SnG35mxim7Vhi29X2jLVAOuQjUJAkvz8KWoiN9m+zskXy2A9PatRrWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBm8ZKNK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBm8ZKNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD9FC116B1;
	Tue, 19 Aug 2025 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613567;
	bh=n/xilA7irRmAj0LB/NL12l12Niea8lTQx06zLoALehk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BBm8ZKNKlDkFdQPkA+WEx73uciE6BHOFFgg8ty2gJXd/3fAnCf3K4t1CIYT4S2OWD
	 jqI2PeEJbujfyWE/QuTtbPluHTiXg1FNa0jUvVmCVfe2BVxD4fSb9grqIQTRYiYchO
	 ab1rVfQkHdIAIk6Gmd9Dw/KlUV/V7+TeJcT9iAPqbP9gZT1ntX4PgPVxGnH9QOhlu2
	 eOaSO4RItkOmP99s7ei9/vy33vYBaWZ/5TQLOUyLud5Pe77aCPfQTtbcKmzEaPN5Iz
	 pPUgL/7yLc20F1n9TQT29eGDhMLXDRsKAbkv4e41nm6rgXWoi3jMuH3zrEb5KFT631
	 Oc1UBE60xeiSQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afca3e71009so938438566b.0;
        Tue, 19 Aug 2025 07:26:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg0L6UxT0PbTOc9NAiNlNlafFM5XFZFtJ9Kl3X4PgDJvGNGi/py9yrM7cS4ZgOV0jUDj0BRhUicYuT@vger.kernel.org, AJvYcCUroA8CsgEMxsTd4+kCC1+zDjUOWWsbn2w1HxetSqvyPrCaJ3ZmBOPF5pkPwzwW0CBXWkXVl6TEz+JX@vger.kernel.org, AJvYcCXBVdRh/aseRk7xEdsP/vRQkJKdT6GV85wyT3iUUONQ7FXfkeBkOQiLvx5Y745bXn8yJptosCzvJUDDFmM/@vger.kernel.org
X-Gm-Message-State: AOJu0YwneXjhyKnlVyP2Gl0wOigjO/LAl0g9t2YViqAQnQIsy4CXyR/K
	nP+COUdi3JCaYDbqi1G8xxOqhzg16q3iHuD3WpQRozDSQLPESMH0xGSUxL3w9B2RMBTG+u7CEIO
	4nwC1eKB2QAr6q+aHwi66+Fvz5w+Zmw==
X-Google-Smtp-Source: AGHT+IFbhb8/3xhszilypE8VV8iG3CCjPu6s9e1Ni+rGTB0XK1fMseFlxRxtSaS/E+ZfV0jZAYRmMAo6DV+EOi1g4Jo=
X-Received: by 2002:a17:906:4794:b0:ad8:91e4:a931 with SMTP id
 a640c23a62f3a-afddf1588aemr240209866b.26.1755613566418; Tue, 19 Aug 2025
 07:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134722.220-1-luyulin@eswincomputing.com> <20250819135413.386-1-luyulin@eswincomputing.com>
In-Reply-To: <20250819135413.386-1-luyulin@eswincomputing.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Aug 2025 09:25:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKFotNLZZXwiy7S6K8qXLdGRAnsa-1zvZRDQBE39Gf5kg@mail.gmail.com>
X-Gm-Features: Ac12FXy4XMOevgyZ0XGLHWuNSqRe6qDPuZvb9j13TrODo_kPF8kWFFTSIKPCPH8
Message-ID: <CAL_JsqKFotNLZZXwiy7S6K8qXLdGRAnsa-1zvZRDQBE39Gf5kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: ata: eswin: Document for EIC7700 SoC ahci
To: Yulin Lu <luyulin@eswincomputing.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	linux-phy@lists.infradead.org, ningyu@eswincomputing.com, 
	zhengyu@eswincomputing.com, linmin@eswincomputing.com, 
	huangyifeng@eswincomputing.com, fenglin@eswincomputing.com, 
	lianghujun@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:54=E2=80=AFAM Yulin Lu <luyulin@eswincomputing.co=
m> wrote:
>
> From: luyulin <luyulin@eswincomputing.com>

Please fix your name.

>
> Add document for the SATA AHCI controller on the EIC7700 SoC platform,
> including descriptions of its hardware configurations.
>
> Signed-off-by: luyulin <luyulin@eswincomputing.com>

And here.

> ---
>  .../bindings/ata/eswin,eic7700-ahci.yaml      | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-a=
hci.yaml
>
> diff --git a/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yam=
l b/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
> new file mode 100644
> index 000000000000..9ef58c9c2f28
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/eswin,eic7700-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 SoC SATA Controller
> +
> +maintainers:
> +  - Yulin Lu <luyulin@eswincomputing.com>
> +  - Huan He <hehuan1@eswincomputing.com>
> +
> +description:
> +  This document defines device tree bindings for the Synopsys DWC
> +  implementation of the AHCI SATA controller found in Eswin's
> +  Eic7700 SoC platform.
> +
> +select:
> +  properties:
> +    compatible:
> +      const: eswin,eic7700-ahci
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: snps,dwc-ahci-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: eswin,eic7700-ahci
> +      - const: snps,dwc-ahci
> +
> +  reg:
> +    maxItems: 1

Drop. snps,dwc-ahci-common.yaml already defines this.

> +
> +  interrupts:
> +    maxItems: 1

Drop. snps,dwc-ahci-common.yaml already defines this.

> +
> +  ports-implemented:
> +    const: 1

Really, your firmware should initialize the DWC specific register that
sets this and is discoverable via a standard AHCI register.

> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: aclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: arst
> +
> +  phys:
> +    maxItems: 1

Drop. ahci-common.yaml already defines this.

> +
> +  phy-names:
> +    const: sata-phy

Drop. ahci-common.yaml already defines this.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +  - ports-implemented
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sata@50420000 {
> +        compatible =3D "eswin,eic7700-ahci", "snps,dwc-ahci";
> +        reg =3D <0x50420000 0x10000>;
> +        interrupt-parent =3D <&plic>;
> +        interrupts =3D <58>;
> +        ports-implemented =3D <0x1>;
> +        clocks =3D <&gate_clk_hsp_cfgclk>, <&gate_clk_hsp_aclk>;
> +        clock-names =3D "pclk", "aclk";
> +        resets =3D <&reset 96>;
> +        reset-names =3D "arst";
> +        phys =3D <&sata_phy>;
> +        phy-names =3D "sata-phy";
> +    };
> --
> 2.25.1
>
>
