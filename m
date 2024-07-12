Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4417837A;
	Fri, 12 Jul 2024 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804583; cv=none; b=SoShUMmBeykCUfeD1B5RIYKgUCJrx4bTJgf5itQ6RTFsw6OvxjgOIX26ge3xJCjr9OY2Z9OwtMYg63YXoJ/o1D/tzrOjGozD/heW1AyK/jz2r90gKeBy1C6EIrFBooosmytiOKWHb8UVKxaFT1xAgoZaYUfXMlnPxo9NHek6oV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804583; c=relaxed/simple;
	bh=e1JohCgdoWt7bnHXXWLqvSqn02YJNNfdCgktKON80Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j558H/iwDp3cO4ayQd+9YckiVm+XXuFloFY9iAFcNWblPfEWTo4w+RFwIh5GLMVMMGIOPImf5jBXEfm2yQ4kp4IBPqhmSkEdhDwq9ZGOt7X/81fNutVPvvlJdkVHzTLG6TV+Sjiw9BlZrx5MznY027Y8TynH8J12dw+gO9GBMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anUjeaHL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anUjeaHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBE3C4AF0B;
	Fri, 12 Jul 2024 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720804583;
	bh=e1JohCgdoWt7bnHXXWLqvSqn02YJNNfdCgktKON80Cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=anUjeaHLiIcjuCEA0RK2iJiUDekCJP4B4VejwyOZfckJlGhZspeNdscGmEST3JLUl
	 a4KgwKNuhOO52nfu2GO0zvyBxS7fhnBzBAiReEvAIx2G4GJoRsvzreOEwze2U+TKUU
	 Glux4mFEPiuaoPf3tAu1uMmreLKoImunThB+Y1ARlXK8k6QG91HM9plPY9TGY/wep2
	 2Ku8s9aROpbWdp07FNyzWcubtY/V/Uqphe5rtr6lcQQIIibZVsdRBdBbo5qzBv/qFj
	 0uGcuMzXpAGu8GlnT6jTxNK4Rqt5NBoedQAA0gL+fm9k3KX8oUm+ZxUvSGbjOoKWXF
	 Y1MmPbrV4L7Cw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea79e689eso3134719e87.1;
        Fri, 12 Jul 2024 10:16:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7c8LPLhTfhpIC+sLoOJqeL5FCeCZZzYTIyLnc+nCI1wabox14v0cLeG7vUe7DZdYV7AZSfGubGm3sVKKm/k+sxkeK0CFXyfe7sWA0sU6Ei+kbnJaLilEBI9R1AoDrQxVuX3xNnMkUWzp+ZD/vZX1SWlJEhxfU/OeDfITnOZHypUw7bQ==
X-Gm-Message-State: AOJu0YwWCpdgYMC43UpPXiD7ya8fciFZKKQshRFOmgQV2xSoyXTKd5ax
	Qd0EpKB/veKDkurqBY8fSEsW4yRvcCE8FX52R9SRY8EXMr9+2CPODkqzan/qRM5KWSuK0x5Y6xv
	/itfbsZCs9ofu3azK+I8mwSZaxg==
X-Google-Smtp-Source: AGHT+IFhplp4Uk4SiEUD3xdCB/kGSfWY0kalgJIt/Cc/nX5GEuFiYpWEY6VoVzM0DFoEJrAzMmv/wrJPUj3kEJNLMo4=
X-Received: by 2002:a05:6512:3091:b0:52c:e119:7f1 with SMTP id
 2adb3069b0e04-52eb99d2776mr10435520e87.51.1720804581626; Fri, 12 Jul 2024
 10:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712142922.3292722-1-Frank.Li@nxp.com>
In-Reply-To: <20240712142922.3292722-1-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 12 Jul 2024 11:16:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+6h5ozT==E5qkZS-uoqwYMwEE+ybHrDNzUP3emHnPuyQ@mail.gmail.com>
Message-ID: <CAL_Jsq+6h5ozT==E5qkZS-uoqwYMwEE+ybHrDNzUP3emHnPuyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
To: Frank Li <Frank.Li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 8:29=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add missing documented compatible strings 'fsl,ls1046a-ahci' and
> 'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
> 'fsl,ls1043a-ahci'.
>
> Fix below CHECK_DTB warnings
> arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: /soc/sata@3200000: fa=
iled to match any schema with compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a=
-ahci']
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - rework commit message to show fix CHECK_DTB warning.
> ---
>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Docume=
ntation/devicetree/bindings/ata/fsl,ahci.yaml
> index 162b3bb5427ed..a244bc603549d 100644
> --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> @@ -11,13 +11,18 @@ maintainers:
>
>  properties:
>    compatible:
> -    enum:
> -      - fsl,ls1021a-ahci
> -      - fsl,ls1043a-ahci
> -      - fsl,ls1028a-ahci
> -      - fsl,ls1088a-ahci
> -      - fsl,ls2080a-ahci
> -      - fsl,lx2160a-ahci
> +    oneOf:
> +      - items:
> +          - const: fsl,ls1012a-ahci
> +          - const: fsl,ls1043a-ahci
> +      - enum:
> +          - fsl,ls1021a-ahci
> +          - fsl,ls1043a-ahci
> +          - fsl,ls1046a-ahci
> +          - fsl,ls1028a-ahci

Fix the alpha-numeric order while you're changing it.

> +          - fsl,ls1088a-ahci
> +          - fsl,ls2080a-ahci
> +          - fsl,lx2160a-ahci

Reviewed-by: Rob Herring <robh@kernel.org>
