Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216633A3814
	for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550408; cv=none; b=Nxa8phJUKkxVd/0QCKh2tXfnrZy8oupX5kyA6jQQbbPy9Oyh8vZUIZaSL5t3lEG1Cs6vUJmxJmF5ziQE1tR741ZXl1GjDK+OEx4nwQ8/vHtFHVtyS48C49DW/sMiWvIvzxRay9+bCJ9rTNtKnyRQomMVmICB0gbeKPE9en8MAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550408; c=relaxed/simple;
	bh=EZZ2E4Hk4P3ioWVMaervDcnw6ADW65oM1zGar71sbpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLnDNi5pI4xjfVc4xxSndNwcRbJWYMQxNWJg0nXI20RMkQ9yzc8QL2hR6GsPqdwZM7S7PLqMIxE/LeeC4TGMfWrg3/GgMQ1NXNRvg0qgoTv+7TKRvWD+EWGdF2WU3NrcwQ6DSqN3prJ5aSEw3H0QJRxftHCK5H/+XpDy8znMnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56f6afbd205so418138e0c.0
        for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2026 05:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550406; x=1778155206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksIL4rip+tLI1Yx6QhQXSN6krUTnsd9SRkVzjQXrZjA=;
        b=q82D2qpAoq10x/Q02xV2lc/RmEV6ZmSMGRuFK9Kg8KCBz21Uj8FBtRI8hBzdlG+JiV
         vIAhobqiReJR2iXqsqzgxmwBBMvH8T2/DhHQWxiY1OJnP4BD7hQz3eDy5/jJx6gQNs3U
         m1vN01RV92mttIwT44OQ6OA0bjhpzkax3HeOS7nzplleqndtFMkhczCh6tvXqnqaep4e
         1U6gCIyc2kGS8Sz9ZbDK8ITyWuAeU2mcHqu0zfrYVl7GAlkHnjrYAAPYwKzTHnilzH62
         4sVbMBwdDOx3bfiCdSVPIWyQcqU+uyf+GPZaSh7xUZkfEWrfBuF/1UkYGb9faJrHo4z+
         ktKw==
X-Forwarded-Encrypted: i=1; AFNElJ/I1z1bOWuIbmgU8H0YCW878DoDOqBP2wHcnu7rODrcsxxnn6E35+QEjoVD1o2h21JVXr1yiI4SyME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBL0QW3yRLoxx8o7ycSvPDXZ/en6xU/JrxcueXBiIU69Q6a2n
	rubM/IWZeLugLazcrUGW1tQpIAfqIjrzvfTEkjIwdgU0gCxXWu2eJTkoQ8yhoHcIbzM=
X-Gm-Gg: AeBDiet4ftuqXAY+rdyCdn/R/OdlHUN8Ru1czz22155Sx5A9IpY/ylj6rQUPLhhRNGp
	I3vQeexINiJxQLN4P+9OrdZRh2Ve5OeTxPuNfiRYtsxiJ5yMQKqQZHETAdQEvWpGt6euuEml6q/
	XtBud5Hqt++rY+rlRtUEJSjpDj3XQVHuHYgYB89wNTkbmsXk2shC1tVzexu6fUxtkx/spnZmGFG
	MeBfRpcHKxkILNV2FSeIb8r1cSpL1/k2fpKucxKL1f8JwTwxCN9LarSAsTrhB38y/mOpm/vVJZw
	/u3NqzfMGyrocf3DH9T3IUa2MQBWXUfNwM7Yj8XO3mIKz1xiW5A2nTMtXsMX0AoJImtC83c05cv
	LKI97I+Fa2IxJ3C2GSjKnOG2hgE2Z7nk8Z7lMD7Ru/CDm8Dp8Sn96s+eQRqH0K7HpENuErkb1Oe
	wBMO1wySgWExPOaH7OiU8eT2CvSZ8cjWQuIh2PcDnSz1Hq4VhsMKX4+fxbhh7SLG2i7v2g/Og=
X-Received: by 2002:a05:6122:179b:b0:56b:8ba0:fd58 with SMTP id 71dfb90a1353d-573c9f043e5mr566086e0c.6.1777550405915;
        Thu, 30 Apr 2026 05:00:05 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6bbace7sm2862504e0c.5.2026.04.30.05.00.05
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 05:00:05 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-610f4cf6ddcso1346576137.1
        for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2026 05:00:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/XfG9/fZkiXRD++hJxHL6WiAW16Yj3cLb18+SC/Jlw6BFawCQ/JbAYvND4vTzmnAqLjkQu84fk0Vo=@vger.kernel.org
X-Received: by 2002:a67:e708:0:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-62afc506100mr613209137.3.1777550404889; Thu, 30 Apr 2026
 05:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430110652.558622-1-vladimir.oltean@nxp.com> <20260430110652.558622-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260430110652.558622-18-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2026 13:59:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
X-Gm-Features: AVHnY4K0yYb6vTu9KdtDciwvAziqboYRX_ITZ386sa6ttixZ1EP_Mzy9gi4Pi0E
Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
Subject: Re: [PATCH v7 phy-next 17/27] phy: introduce phy_get_max_link_rate()
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
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Markus Schneider-Pargmann <msp@baylibre.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Thu, 30 Apr 2026 at 13:07, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> In CAN drivers, the transceiver is acquired through devm_phy_optional_get()
> and NULL is given by the API as a non-error case, so the PHY API should
> also tolerate NULL coming back to it. This means we can further simplify
> the call sites that test for the NULL quality of the transceiver.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Markus Schneider-Pargmann <msp@baylibre.com> # m_can

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 3 +--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # rcar_canfd

> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
>  int phy_notify_state(struct phy *phy, union phy_notify state);
>  int phy_get_bus_width(struct phy *phy);
>  void phy_set_bus_width(struct phy *phy, int bus_width);
> +u32 phy_get_max_link_rate(struct phy *phy);

This (and all the existing getters) should take a "const struct phy *".

>  #else
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
