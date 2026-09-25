Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85F38DC57
	for <linux-ide@vger.kernel.org>; Fri, 25 Sep 2026 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365236; cv=none; b=qOsJ8pNRlLF1fNU8pvXAuqXeiwpjlJQgw1XB66BW3FufPdtkjCcO/39gHZBU174m0qyoVDYIOP12kEatmSRcBHWnHWlm4NPWmA2sED6yDtyNYqLQrwjqiFCW4PDy1eU1xDMGnI7nHU9+lTmTJGUzAtE79cUKnlfBgGO6hILdu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365236; c=relaxed/simple;
	bh=512p4i89hfbNNLzUkKTVeWeHuY1+SF96J80awVgU234=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xzpaj2UAvJWvk9QyRcRUPnN3kSKAT7LM3IyjO7zWCcZbarOMFM8imgYyr7i7PAqvual7l0Caa89CBSVWjEZXOJiZWITmOFJN87qjcMaQSYEB3CNpkkNsM2A9zryy1TAEFZ+tGkxbrZQp2wJMdiwwmAlYZLSrcV6Wfc3eX0O74hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msvg0SPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msvg0SPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05C31F000FF;
	Fri, 25 Sep 2026 19:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790365234;
	bh=GTqFYDgqVYoKIQ8wnkRp4psOA5362lbnrB+zkkTxLzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=msvg0SPGUHzG0lRP5nq+8u+9RSuXCUycAaJNbCpX/znXNAnxJGsvY43aKO2ODrbo6
	 pKIYEwUMPs/s0CNUFHoiKZCm51aBOcgeiB7B1LEIsnB+u2z2hdypKOeD/yWd5PC/Oo
	 mwI/dSQvA6nXUISRjw6wDavvyIW2S51xJ2pcXLl+cRvMPmvZnfXhnbbsWllGBOem5S
	 wcar3nHALjd0tSGTzuLDSLJeFgd65aNAXghV66C9Njw1QLK/Dno875h/icFGEyDupN
	 spORGLPP4jIHyuTpFPc0ZJO+A7ymRdmhf9YdbCwWdd7N/a3lHapZjS1IphyNW8zjCt
	 jDlKSG08OYznQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_mv: enable SoC SATA LED presence indication
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carlos Junior" <cjuniorfox@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260925193134.114566-1-cjuniorfox@gmail.com>
References: <20260925193134.114566-1-cjuniorfox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:40:34 +0000
Message-Id: <20260925194034.A05C31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ata: sata_mv: LED blink mode state desynchronization and register =
clobbering
- [Medium] ata: sata_mv: hardcoded LED multiplexing risks board-specific pi=
n conflicts
--

commit 30e313ac1545b898b81aab6027f1bf3c7b86b831
Author: Carlos Junior <cjuniorfox@gmail.com>

ata: sata_mv: enable SoC SATA LED presence indication

This commit enables the SoC SATA LED controller in mv_soc_enable_leds().
It sets the enable, device presence multiplexing, and activity blink bits
in the host-controller register.

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 365454390d7e0..90a4ca5b5c407 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
[ ... ]
> @@ -3382,12 +3383,21 @@ static void mv6_phy_errata(struct mv_host_priv *h=
priv, void __iomem *mmio,
>  	writel(m2, port_mmio + PHY_MODE2);
>  }
> =20
> -/* TODO: use the generic LED interface to configure the SATA Presence */
> -/* & Acitivy LEDs on the board */
> +/*
> + * Enable the SoC SATA LED controller and device presence
> + * indication on the board's SATA LEDs.
> + */
>  static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
>  				      void __iomem *mmio)
>  {
> -	return;
> +	void __iomem *hc_mmio;
> +
> +	hc_mmio =3D mv_hc_base(mmio, 0);
> +
> +	writel(SOC_LED_CTRL_ENABLE |
> +		SOC_LED_CTRL_ACT_PRESENCE |
> +		SOC_LED_CTRL_BLINK,
> +		hc_mmio + SOC_LED_CTRL);

[Severity: High]
Does this blind writel clobber existing register configurations? Without a
read-modify-write pattern, any settings previously configured by the
bootloader will be overwritten.

Additionally, this enables blink mode in hardware without updating the
software state tracker. When mv_edma_cfg() later attempts to disable
blinking for non-NCQ devices, it relies on mv_soc_led_blink_disable():

    if (!(hpriv->hp_flags & MV_HP_QUIRK_LED_BLINK_EN))
        return;

Because hpriv->hp_flags was never updated to include
MV_HP_QUIRK_LED_BLINK_EN during initialization, this check will falsely
indicate that blinking is already disabled and return early. Will this
leave non-NCQ devices permanently stuck in blink mode?

[Severity: Medium]
Does forcing SOC_LED_CTRL_ACT_PRESENCE globally for all SoC devices risk
board-specific pin conflicts?

Unconditionally enabling LED multiplexing here overrides platform-specific
pinmux routing. On boards where these physical pins are utilized for other
GPIO functions like UART or I2C, forcing the controller to drive them
could result in hardware conflicts or erratic behavior. The previous
comment indicated this should be handled through the generic LED interface
to respect dynamic Device Tree routing.

>  }
> =20
>  static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925193134.1145=
66-1-cjuniorfox@gmail.com?part=3D1
