Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75651328B7B
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696882; cv=none; b=qCwiHdgMt9f39b6h48o6eykPK4H4xceORo1CX2hN1YJJHdxKI2fa6VEktrcHv/lP5dylaNKxg0Gv7yMyDfUN9nLMy7k6HQreeJXq5L9JMCh3saqOuQENAqNU8O7tTgVjy5j92vNYxIGNVlGmlr0vEXuVRpbG+q3DOqgJ69/5y3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696882; c=relaxed/simple;
	bh=urVD1xPdaF3hV5GqXqVqTidMinFWi7P2lc2J0G3o7gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKOqp+lltY1vGsrUexwOfcaOhZpZ7wXeD/gvtSdJTFD+Gg3u47wUjdY/edc5ae50BOaD7Y9lRJ9BuqChuMQYWRaAPN1nxZ7fIIBCwQEInP4ejosgl6/VJ8III7mB0gGOf67wDl+2cuD+fRtiCWNhNDswHt2yusY+TkYi85qmels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ff18242343so2069571137.2
        for <linux-ide@vger.kernel.org>; Wed, 04 Mar 2026 23:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696880; x=1773301680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xyHjzGnphi32H4Bte19x6wQV76UaiJqzbc3zMkJKs8=;
        b=KAlWa0rqMTLZjMuJIJ9cFFNlt30P/gfjmV2FHn4aUekpfTw1tJhfShyWf+Q71e1IFX
         Iwgg5D0812FgmSwukKRQvmV5yR9wPRCCrFN5iPn1FBS84n5gw9VKOEReKJVkcSDvlSD0
         1y0zxKtfZWEkripGNjnm+W7detoKqxHZzzbLLS3v66RbNgf8rl71/1RWgbNTY79vInb2
         FmaYZEGs0SQUB1A3LhIQdq1118xppIsuOyTmIvJxsoUP7RKSLBwPkNVoYJYHWWeAaaY8
         +cYZCHpOKnQTweCHkqR7vQTbsIpV8HC8/M8ZJGFCYn35M0aG5NfdEwqljGuGl+wrvrW8
         tU/w==
X-Forwarded-Encrypted: i=1; AJvYcCVSGKXEKxknFdsF41YItx6nmhhVQc6cIqjgcLastbLXcwzwIlWSkxhEK1Vfq/Nr/rb8wMepDFmww0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwET/039OcK5mBpwwgnDbHqSNjv+4TN7Hg6VPG2Ltho7z557KoG
	noB7iAmJjTcxXzxSC3e9Rt1wLmbSQKz05Pby4Y1ZYRjFYzrPCv08P7vQs9NmM+D3
X-Gm-Gg: ATEYQzyKHEj3bPxqsMK1lmkzorNFOS68qxJLjgKh3NfgKCNiQsHOtout8fveqFZROR/
	qp2FvFc2/pdoiQUiHkWoBkJcWUwrRy6V+w/EzB9csq9krWtPPBtdKWGz4WshMi0MFGxTfFriYYd
	58vyWOLZp5rw1xiJ/SaE4UZBwUr2zYmyOqDexkrbqA9sKtKkqswyDEEm0JJ7wvuDuXsLoCc/Q/u
	CwjZ2LbpDDq5PTgPDcBfNf0uoFbVloC/1M7yCnUVxRyF1+0R6hRl+3ffph0wNUCnnTpQx+ixbhU
	Ek+W9AhTyVhm6ffMh1/Fmw4IpyvFoFqJ8Sipw9r5Qwbb92+b+yZD/TnpLX4+yHtgWFCwqzo5Obg
	nmVv1KkArTpTqqRKrJ7qBwsnzbOtHS+0RHgZEaKrQ6KgmlLb9oCbX6pJb7e9ElcvmuQvSCkLAkf
	8m9SprClsCQJbRjTVSXBorJF4hJnKCkhn9z7PmzkRO87q0Ylqq/ANX8K03ASp6
X-Received: by 2002:a05:6102:dc8:b0:5ff:8b8:9f89 with SMTP id ada2fe7eead31-5ffaaf66716mr2083555137.35.1772696880357;
        Wed, 04 Mar 2026 23:48:00 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65a2a0esm19626931241.12.2026.03.04.23.47.58
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:47:58 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ff18242343so2069558137.2
        for <linux-ide@vger.kernel.org>; Wed, 04 Mar 2026 23:47:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5S+jrKR1hBL0T2plDqESUWrPdXQkGeN3y1AeISJe6MSlghTksT7TzpBec87y4v41WU4acKn716xs=@vger.kernel.org
X-Received: by 2002:a05:6102:32c1:b0:5ff:a16b:93f9 with SMTP id
 ada2fe7eead31-5ffaae2d5b0mr1883200137.21.1772696877960; Wed, 04 Mar 2026
 23:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-14-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-14-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 08:47:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNtqsui3ek1RYCTyiuDLRajpSBMnrdzED6wu6i7-QcuA@mail.gmail.com>
X-Gm-Features: AaiRm514iMGAdfTBAVsgfVfK-GGHy9jHY4ezK-Lp3w09-JWpnENLQ0I4lkIFgvE
Message-ID: <CAMuHMdUNtqsui3ek1RYCTyiuDLRajpSBMnrdzED6wu6i7-QcuA@mail.gmail.com>
Subject: Re: [PATCH phy-next 13/22] phy: introduce phy_get_max_link_rate()
 helper for consumers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 2 +-

For the Renesas part:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -640,6 +640,12 @@ void phy_set_bus_width(struct phy *phy, int bus_width)
>  }
>  EXPORT_SYMBOL_GPL(phy_set_bus_width);
>
> +u32 phy_get_max_link_rate(struct phy *phy)
> +{
> +       return phy->attrs.max_link_rate;
> +}
> +EXPORT_SYMBOL_GPL(phy_get_max_link_rate);

Any specific reason you are not making this a simple static inline
function, like phy_get_bus_width()?

> +
>  /**
>   * _of_phy_get() - lookup and obtain a reference to a phy by phandle
>   * @np: device_node for which to get the phy

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
