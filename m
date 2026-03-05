Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED72EB87E
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699343; cv=none; b=F0l4LMF8ZEoSI10y9c+p0bmvkcdnKPcHHcc8TyyrlJAwltojY95G+hEQGb5JPkHCXtk9XvN0OYfE+xCnuFJNQbEGrU7M9CNZG9+lBlc7PP7CScKzPfV3AZ+rdeFLr+0EHkCY4Pg8yYXAY3D7Us6UOEEINKyUnrhplvC5DImHzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699343; c=relaxed/simple;
	bh=hefLtFvtSppGuVWRD/xSsfWMjnGgnQggEUG9Y7OFLDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8cJmVa9cgaCAfJhwPNaGCaincNK7Y0mrrQPw6Xxwf8PUSmb0NbknaD3N6yyl4fqWkcVC6tsB7FnKoorxLtTSk9W/fR8OQbhiCOqAVn0blt+JrB4I5fLflz65aPVBd1w2ta90j841bqfGJsPBt8g6e7MGTHXYAFPMVixbH5L1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-56af41d1e0bso166441e0c.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 00:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699341; x=1773304141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlLnToI6SbxsSn7ypnmaqq1RX+miw2VMTyDHKi+gwbk=;
        b=ELwEGVl96hyawlik5Edag8GUsEsOFiKrcb0+hRA7RQ1cJmiOz+2RKy6OGRD1HY3yXS
         q6BoO17RpLE4ch8VF0lr/gBjL8TRmyOVD/e7ydVIsExlw8eKwqc6nKx6Zgtog96kc449
         5zpchsEj5r9IZicQiF6NaJyPjXU/AkI/PNFJAMqNjHJ8UnqOmrPSXU+z3yB01CvU+qjl
         vo2vLR430isBMK1XLQu01yKUQVEnIfz/CgTB7kEtUennhFNydKlhKwkOCnB4PHQD4Z6+
         0lRIv44aiCLlVDAVEG5cZkDy9W8W1MqCbswQgKGDz7DB2DZ0w106PmMxznOT8ibASMGC
         nACg==
X-Forwarded-Encrypted: i=1; AJvYcCVSXHHJbPfg+hmrYY9SMV/GiyjuKEZvRs18Ta0pzwiorAaBrBSgodz2fFJqLZ5adgcdeMz1SqWszoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5cUTwu0YFFpTj6CvHnJx5iMlQTBNXy3bpfGGIeUIqxrR/zU4n
	/LDC5NO6+IGre10mE4P3w32KVC6snGzBajrXXnMIdXcU7k2FoC8hS8JtE/kK/Md+Gm4=
X-Gm-Gg: ATEYQzx88b92MK+a3MNvmtMaj6mij3hh6E5Aift05QTNm/U8cJv3xlUe51MTJ7tN0hb
	tDSsJuWJ44BgMm04hff320qaYrDbeiABjdy7YIeU8gOfhr3N9VW+onGdmod7AaP3eG30AtkAOZk
	OofqxuFa1v8L852jc+un3f99cxuomZAI3ZArpfD1nRnD+z+d5NT6DbSBa1D1a4oY0LA9IywT3ce
	PW/3q3VdCstOPd/Rmtls5bCHy/rVfkZo9tjBjgzBCDjn2cDaOM4AszIs4Cod5NOCGfgir3IL16M
	jHzyOzcqegq/oNWGWdTvyQm2mrDqLSRU5BHxN4GWyQWzResUjroonFBNd/b0uHm8uQyAQXAnU+r
	TyALfdN8QCdG9UDezyyCN8p9Cycd7xMhlVJzF7s49zr6rX9ux8UrhCUDX3rW6E0ckgeXzwUUks1
	zYzSFPk33D/zGl5CVth+qKcDjznEOWeLzDhqMERIVc1IiTTar+2i+6jB61rh26
X-Received: by 2002:a05:6122:4893:b0:563:c868:a32d with SMTP id 71dfb90a1353d-56ae74dbbb6mr2358329e0c.2.1772699341236;
        Thu, 05 Mar 2026 00:29:01 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df63d8abbsm20056026241.2.2026.03.05.00.29.01
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:29:01 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94dd687e040so1817720241.3
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 00:29:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvxHC4tOpWoZ5q5TiwACUzJr59jZHlixbLgmWuHeuqqRfFiHrUdhqAUGNX0j2AEIC361Aw0hW4/1w=@vger.kernel.org
X-Received: by 2002:a05:6102:1607:b0:5ff:c64d:228c with SMTP id
 ada2fe7eead31-5ffc64d2600mr724913137.22.1772699340961; Thu, 05 Mar 2026
 00:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-13-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-13-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 09:28:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+7n==crPmitH-JCwtJiH+7LaPKZQYU4ZqX_duo3_7Eg@mail.gmail.com>
X-Gm-Features: AaiRm50Kgxrt1IEt_9GEmeNyCIrylErpUd7qkh7D4FIoK_FYituUB8DTITetq4c
Message-ID: <CAMuHMdV+7n==crPmitH-JCwtJiH+7LaPKZQYU4ZqX_duo3_7Eg@mail.gmail.com>
Subject: Re: [PATCH phy-next 12/22] phy: move provider API out of public <linux/phy/phy.h>
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
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Wed, 4 Mar 2026 at 19:03, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> The major goal is to hide the contents of struct phy from consumer
> drivers.
>
> The idea with "phy-props.h" is that both consumers and providers make
> use of some data types. So both headers include "phy-props.h".
>
> Two slight points of contention.
>
> 1. phy_set_bus_width(): Vinod explains that despite the current caller
>    situation (9 providers, 1 consumer), it is a consumer API function.
>
>    The use case is that the controller (for example UFS) may have
>    limitations and should set the expected lanes to be used and width on
>    those lanes. A number of Generic PHYs can support multiple lanes and
>    multiple width so this is way for controller telling I am using this
>    configuration.
>
> 2. phy-provider.h should go to include/linux/phy/ or to drivers/phy/?
>    We do have 3 PHY providers outside of drivers/phy/:
>
>    drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
>    drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>    drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
>
>    but the practice is not encouraged, and with time, these should be
>    moved to the subsystem. This is not something that I can do now.
>
> For temporary compatibility, keep including the provider header. This
> will be removed when abuses are all gotten rid of.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/phy/phy-provider.h

> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -1,246 +1,38 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
> - * phy.h -- generic phy header file
> + * phy.h -- Generic PHY consumer API
>   *
>   * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
>   *
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>
> -#ifndef __DRIVERS_PHY_H
> -#define __DRIVERS_PHY_H
> +#ifndef __PHY_CONSUMER_H
> +#define __PHY_CONSUMER_H
>
> -#include <linux/err.h>
> -#include <linux/of.h>
> -#include <linux/device.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/regulator/consumer.h>
> +#include <linux/phy/phy-props.h>
>
> -#include <linux/phy/phy-dp.h>
> -#include <linux/phy/phy-hdmi.h>
> -#include <linux/phy/phy-lvds.h>
> -#include <linux/phy/phy-mipi-dphy.h>
> +#include "../../drivers/phy/phy-provider.h"

Shouldn't there be one more "../"?
Interestingly, it compiles with/without.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
