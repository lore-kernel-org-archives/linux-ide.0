Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B13264D5
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696738; cv=none; b=UUD/Vo9QbV4B5h+8xaIFWFrlEgUt7kwETp13KJfizM+Kv7IWnvJY2/qiCqwXmY9TlRcXllbB7th1NQZr1Gui3Fe23N8qlfFY48hXYDLdqkdkTg67e19YGif0DjM0w3de54OHNInpaprtN6dGhRbv3Pl8C6GGoaoy6t8vwdEB42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696738; c=relaxed/simple;
	bh=1VrdyW7eBzn3eIzcJ/qwIsXSzypVzRQDxfUgekinKYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OX94XmptZoSnuM1oDnLJNQAFLiwUu4vgCO7tX+8P4sSSa/etfxj3pV4IG+1ZzvKkuOyYu1Kd9R1c3qNAQhE9V4F1t1gA7FWyy+R2gof3Oz503j6AiWc9e2QxGc9Eo+e/YUyCH7OfFPGoOrVAIn1hNbTy3gwiX+GHsO8ygzw/TJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94ace5d0e39so2287344241.2
        for <linux-ide@vger.kernel.org>; Wed, 04 Mar 2026 23:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696737; x=1773301537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLWXJFRzKXYfvRWexgs1gCb/dTgnevi1M5AetCjur0g=;
        b=TFb+g7QsWWRHLkdT0Rw5rtls+pJBA85brKr9K0P4+mEu7Dua/85W4y+MvSUNsgn6HW
         i7IL1Q1BckBPoQupO7ji/0QMhyhjN4skTURPnhowGEqiSNmtQnm8y3Ppr9RnwljXWbXF
         aRHeWYBWQoG4SKUQaZ7M/t+Jt2USE0dY8GO740sA8C71qToFLg7af/QaG1E6PNyuuVnx
         ASg/2eqYBR9pVzNVlL7Kikme593kIYCsr/+we8/yrAaZCcnHGHMRkCpz7h+0bqu5VnZd
         vhPNCS41gavUzUDi4JQlmdbd+VeRrn/GVbzo1WQREhm/NI7+lnmiKnMO6Ni6JdPUDmT7
         JdRw==
X-Forwarded-Encrypted: i=1; AJvYcCVievuxON4AmO9Q9PREXPwrCy5zJ1XXajzTn4s27MPRCgurFoCeuFH//uT5NbxuMD2np0FNFHilnH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhR3vUf/dq3Z1EjRTi7o2hLJ7hvHBqOtSzZsxd/d973ctgE7N
	Tg4/FRFt8mduaj7oJAgz9XOr+RixkuZS4WEFU1h102Ny7bL75liZ41eRybk30dT4
X-Gm-Gg: ATEYQzyc+FlNUlCVEmQOFGGoOuZYBMXiH/Xj/4gR10r3jOrmy1oPcqYSI0NUnqRevPA
	5V5ox+T9c2wyy9BbcWlFU4ELh0RHnLmi4L42IeraUDTGJBKO3sbvt8FfpawXo1f9VKDo65YqlCr
	FU+eMgfi0FU6YmDKwZYbIwNoNrYJW7VVjNlKjQuGP14HeqNayG2F8lx/4HQpD9Rtr8/x7W/+8va
	JHfAnMas6+9F+km51k1NnOI6Hyo3xjcyTuLdgT6wF+0tRYwrQKn2pl9APvaM9lMUTCp1Vfbapl9
	JA+SltwhPvVXw/uCtEVTcWf+2b1SGHRffT/Rnmq04OSgEHs/PCvqpNmE1d06uVvvY0w74QJSOUx
	BMVgFoPOrCTUC4MvXsfWqLcWZpSJ19T0F+IBaz4Cngu1SVdGGTwE114v95feCkKDIOkhVrhQKTS
	Bq8Pi22TOmNVc7sQF7LeNgJXu08REaXWsgzQWQ+zfrnY+XfndDpp5xrzlx1hlb
X-Received: by 2002:a05:6102:3ec4:b0:5f5:4d9b:bd67 with SMTP id ada2fe7eead31-5ffaaaaeb14mr1801038137.6.1772696736673;
        Wed, 04 Mar 2026 23:45:36 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e31bb722esm11158673241.11.2026.03.04.23.45.34
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:45:35 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94dda16ff9fso2323254241.1
        for <linux-ide@vger.kernel.org>; Wed, 04 Mar 2026 23:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqg0IMCTrhct9UDLp0F9jm09BhZuITdf8BztKq8M+KWyG51+HbTS8TyMB+FiUH84925yI6OAOMlXo=@vger.kernel.org
X-Received: by 2002:a05:6102:441c:b0:5f9:3a22:85a2 with SMTP id
 ada2fe7eead31-5ffaac72675mr2059267137.12.1772696734612; Wed, 04 Mar 2026
 23:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-6-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-6-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 08:45:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXA67BO8Umz8-4jRg1SLvtZUSEzK0p7WxSvomnBk+WiyA@mail.gmail.com>
X-Gm-Features: AaiRm52ziEM93YxO07h7pOV0rTYZnULijxTOwLRm9EW_k_lOxLulmwK4PITV2jw
Message-ID: <CAMuHMdXA67BO8Umz8-4jRg1SLvtZUSEzK0p7WxSvomnBk+WiyA@mail.gmail.com>
Subject: Re: [PATCH phy-next 05/22] phy: add <linux/pm_runtime.h> where missing
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
	UNGLinuxDriver@microchip.com, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
> phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
> call runtime PM operations without including the proper header.
>
> This was provided by <linux/phy/phy.h> but no function exported by this
> header directly needs it. So we need to drop it from there, and fix up
> drivers that used to depend on that.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
>  drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +

For the Renesas parts:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
