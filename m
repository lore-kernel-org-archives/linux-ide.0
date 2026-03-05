Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C6366572
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699773; cv=none; b=lQnz/nAAlE6QlmD7TNFztWrMWOn7x3CTyA+NMdrssC2f78hRK+M594QAMjqY/IrpHQQFFX3Qt8FzC1Bz3ECiTrP1aEAWywEizY/n4TreRMxYPaVRmPZHzlAEPo8IxPX8qFibiZKI2/8MUwivykroHQPoMsZKkwXC9j2xNJBL5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699773; c=relaxed/simple;
	bh=CSh/OPgCewZMrxAGotXGAjNREHTmD2ri4RotS2E+6yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBgBocgckQVrBGsTqeDWbDpp+Ac4D5Ke4g0gcfvzqnwzQATT5gP0UUdvCaI62t19QJ5abnufcR37iULobshGJeV/k4DANJzVxf/Q37STemn6dnlItHAdsXHMJvigF8dDGQnBOF1+IpkP5X0lYQ2q8+GVC65zQvepwCriPQwVDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d55b97f358so6130386a34.3
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 00:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699771; x=1773304571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ymdw+XC/6Jy9fN+NX35+E/o8bLZmtxZBZ4e3pQeTxE=;
        b=v9SZCckzC7CDaGITDa6X4O6/Z96U+SMdjdNiTKkq2PLZ4/KIzgHqG9J5i3E/BTE4Jm
         zkuMItNPfctdSZRgS2OONUcz+Vwi8qrpm+uwxRjdKwF+I0nIe+jFtQDeogFBMhgxRIU4
         xTtJjbFqlkGe95nnW+8bR+N4NZ88rTMLWZ+NQAFKVGvG857Lf/Yw2rwisBr2TSw8sPAw
         Nr9YRh0ur8yeuaQXEkfExEpnIDGZvOZTBicz0Se13FXwPeOPJBU+6NKx7lUB23Fxgceh
         Tx49hjTQindI3sXFECr9zD7auf8yzlugdr8fhhfkHtwDCcznBImDQmju1wFVuI1Twysn
         pKPA==
X-Forwarded-Encrypted: i=1; AJvYcCXRNn7orlFCWjEp/XTnpYfX3YHUlCD3q2otTfvztZhH2Cs7o42NV72FQSdv+I/Trop7MMwSjNeZZyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETzYtLNRJyNX/fQHC4siWPWwcur1jJ4SEto7Ee1zTUNrW3gSz
	2ed+5CrreWYPeTBioj2fNRkF6NTyIzOE5+LeAMyNb8InJltLIM7+F6OCm7DNR4Hv
X-Gm-Gg: ATEYQzwRZDCwrB4Lylwjnfr4zGeQC54gZSlJdCDpqd7egNsUaMv4NfvmjrPpI9lK+hw
	gZ11B6j+GIEQ6S66kiuvH2651bfNM3/S5ma8e7DFGnGEbQuW2JP2sJDiOB/IXvuagU06kq5OSOV
	sSiX77IR3uFCMjAy7DdIkUQGen07u93VFGb5P2eK6wCmP4N81z1q1cLsP12l54Ptp33gkQmMkFk
	XZihd6fm2tP/HpEQdhcGE1lNXcjx80NJfRveuc+NkdFE13ofoPahJfLLc6FDwYjqZle4ubnv5S7
	Mj0aMlqG5j/1uy/b6KlyUQtGuxu7rj7OtStXAaWiNDL5TwvqB4A9fWPS751Xh2lJG/FHyC08Hg1
	Jkyo2K280izqR7VmfXQt2dwdKzeCHrQ9cnyuGb9VHQBJJ2gxIifomKEQK6rsgdJfT6O16OY5iHs
	QFPocRCMdMc3dIZNto02qnRp+qXUjQd8GCWUIRO4dpIg6VEZwpOT5w1drOwTwh
X-Received: by 2002:a05:6830:3110:b0:7d1:93e7:cd6f with SMTP id 46e09a7af769-7d6d12569c1mr3692258a34.13.1772699771094;
        Thu, 05 Mar 2026 00:36:11 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586474d4csm19428166a34.9.2026.03.05.00.36.10
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:36:10 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d513bc15c7so9413654a34.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 00:36:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEUE2hbaVa8IvM6gq7NZV0+VhbCBkNDU/mh+B/qZE9XzmkfWA+7m2JPnUE8lnhB0JUzpuWduHlHss=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac9:b0:5f7:24dc:3ac3 with SMTP id
 ada2fe7eead31-5ffaaa86250mr1899404137.7.1772699399463; Thu, 05 Mar 2026
 00:29:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-18-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 09:29:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXUBhpnFEnnTfyPdECWqNmKLweupX=FY2SedYA3bapG2g@mail.gmail.com>
X-Gm-Features: AaiRm53mHozL13yvxji6rv0MKzaGvWxuhr7SWHD2SjBJ0VWNhqppZZeXezGpDhg
Message-ID: <CAMuHMdXUBhpnFEnnTfyPdECWqNmKLweupX=FY2SedYA3bapG2g@mail.gmail.com>
Subject: Re: [PATCH phy-next 17/22] net: renesas: rswitch: include PHY
 provider header
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
	UNGLinuxDriver@microchip.com, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Michael Dege <michael.dege@renesas.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> As a PHY consumer driver, the Renesas rswitch dereferences internal
> fields of struct phy, something which shouldn't be done, as that is
> going to be made an opaque pointer.
>
> It is quite clearly visible that the driver is tightly coupled with the
> drivers/phy/renesas/r8a779f0-ether-serdes.c, which puts heavy pressure
> on the Generic PHY subsystem.
>
> This was discussed before here:
> https://lore.kernel.org/linux-phy/20260211194541.cdmibrpfn6ej6e74@skbuf/
>
> but to summarize, it is generally expected that when a Generic PHY
> function is called, it takes effect immediately. When this doesn't
> happen, the PHY provider driver must change its implementation rather
> than the consumer be made to work around it. PHY providers which rely on
> a hardcoded call sequence in the consumer are just lazy and wrong.
>
> The most obvious example is commit 5cb630925b49 ("net: renesas: rswitch:
> Add phy_power_{on,off}() calling"). Problem description:
> - Ethernet PHYs may change phydev->interface. When this happens, the
>   SerDes must learn of the new phydev->interface using phy_set_mode_ext().
> - drivers/phy/renesas/r8a779f0-ether-serdes.c implements phy_set_mode_ext(),
>   but this only caches the mode and submode into channel->phy_interface
>   and applies this to hardware during phy_power_on().
>
> The commit author decided to work around this at the consumer site, by
> power cycling the PHY for the configuration to take effect.
>
> This had a worse implication from an API perspective in subsequent
> commit 053f13f67be6 ("rswitch: Fix imbalance phy_power_off() calling").
> It was observed that phy_power_on() and phy_power_off() calls need to be
> balanced, and so, the consumer decided to start looking at the struct
> phy :: power_count (the technical reason why I'm making this change).
>
> This is also wrong from an API perspective because
> - a consumer should only care about its own vote on the PHY power state.
>   If this is a multi-port submode like QSGMII, a single phy_power_off()
>   call will not actually turn the PHY off (nor should it).
> - the power_count is written under the &phy->mutex, but read unlocked
>   here.
>
> The rswitch and r8a779f0-ether-serdes drivers both need to be completely
> rethought in terms of Generic PHY API call sequence. There is no quick
> fix to apply. Just include the PHY provider API along with the consumer
> one, to keep working as before when struct phy will be made an opaque
> pointer to normal PHY consumers. But this is a bad offender (and it's
> not even a provider) so add a FIXME.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
