Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832101459F6
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804294; cv=none; b=Ll/hDgJqAlIoDjtdCVhSKK0t1GJDGy53T3n59ybCe21h9f8zIbEDDwAOnsiniP8+y0DsrOI3f5CAaTcyYXXQK70Ie0vZiB46LkQdgKwk1QKUiThIeMNkE2fo4Lj3OOCB5QEDUoONSeGNnXdX1H1Bv7nFaS2B7opiHl2SqTKiEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804294; c=relaxed/simple;
	bh=DR2GU7B7vKe1fRGpDrIOHaYbKAB0WyStucsjC/I0pWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnuieORoDwvhLdt/3A/tWxJ4tmOTyz4OiEh9ThMoPpPwZHNXorb013z3ijEFn3lf8OW6M19dFPe3nFIQbwHB1Pr5UjFosIE8f1qUwhxlVhjrlhcjidheupeTIIqJ6cDKM6WLwGueQdwOMLZ6h6OewDrgdedCndH7kWOmlfZQo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8670fd79990so1599569241.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 01:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742804291; x=1743409091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oPYt1XECdKKec9hLvTco+yrpmt9lTzEom5ts3R7JGY=;
        b=e+hVIj6RagSZovWjWFPiqJZRikUQkDjWvbZId1cJq7xQ7Jym2wdjfytRb3UUgkR5fx
         mBLW8qhbeDI0CrtG4MHOW7ItHYhplgc8nTqkx8soT6oueUNtZ5L6sURIO/fbtdfvj5xs
         FxYMb5MNlOGEciIhpCl+XsyrmFIvyqexjc7pQETPZpRgqIRCJfWCBQQ5SxLYsJJUv6ag
         TU04VEEEhV56XrWnyNEbC1YqGvkrru5+CWdw8Bp8R/6sAzFnwZnJ2sV/FulyFVXrG5Gc
         O3hlGTpzB/sAFtb9N8YdA1IHxL8FBKchGNGXbgNPvyrppsDyfO2xysc3WP9jqwKxpXIi
         cU3w==
X-Forwarded-Encrypted: i=1; AJvYcCXEtZ8ASDFxPFvh+SNtANU9PB6yAbjvYwAyPbO1oP1ElzlVeAGZrAg+DZ8SxpMVo4SPPcEgqoucmbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0XdbHKTLvHXniZYTQVcbtTn02oImdYs7ip2D6oyxJSzn3e/K
	cO/WiPck3d36Y8srpyfieaX/aU8iIborcoaLukxIlqW8cl4qnsTLkUVwZafM
X-Gm-Gg: ASbGncuzDwghtqj2RKjfnaIciGs6FLPaq64Wr2KnK5nV4XLvBN1XWbzDymse4ueLGE3
	L4FBjicS/mjLGn39h45HPuMsjiq25XtVU9Tqmorh0mBWO8xMtIn8HCF3aZPmd010h4OeDJfxhOR
	d8b8jZAh4LXX9VXrqAvVBPRbviluW3azyu8OOy3PFDsKCpLJ+lkqBXvmfC2VpU9P3IL7EVC5XYr
	bf6lzJ7qNOxJn4N/U2sSfErTMsWNFmEqnOW/A5m/pLpwvThlWZspB5oJXhdceWm5xbPK38IJMfv
	IH0pmB/jQW0pUyKfel5FFB3S6kkb/yR3qWvMRrzrCmnYPAtsj+IZ7nUpk8FMBdp/mWIIQslaSRl
	HUlHgvUnOiy8=
X-Google-Smtp-Source: AGHT+IE2jvz4axkrpNPkErNNze2ErZ6vPdvx2pPx0Md0MsRcGmAkXKvLGypHDWkrfe9nSFVIT7mfYQ==
X-Received: by 2002:a05:6102:3a12:b0:4c3:49b:8f78 with SMTP id ada2fe7eead31-4c50d65cfe0mr6878559137.25.1742804290438;
        Mon, 24 Mar 2025 01:18:10 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bd75e84sm1470733137.20.2025.03.24.01.18.09
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 01:18:09 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so1942187e0c.2
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 01:18:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMbhBhV3JQ/agVxMDz87mAnCuPe5uYYjjdWSj7CABmXQ9PBiNekrpdBXrV1/Tso6/2al229dgZw9w=@vger.kernel.org
X-Received: by 2002:a05:6102:32c5:b0:4bb:e36f:6a30 with SMTP id
 ada2fe7eead31-4c50d5471femr5760952137.15.1742804289678; Mon, 24 Mar 2025
 01:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321151416.338756-1-p.pisati@gmail.com> <20250321151416.338756-3-p.pisati@gmail.com>
In-Reply-To: <20250321151416.338756-3-p.pisati@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 09:17:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0yDSXoeDoK0yUrJ-cD_4BChEXcvteJW5Ra6afKzciMQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoW7bheJCVVukIRWHNfiQ7Vyomh3BRmOcBVJ1orzSt7F7GUHpg-m56AkvU
Message-ID: <CAMuHMdU0yDSXoeDoK0yUrJ-cD_4BChEXcvteJW5Ra6afKzciMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] amiga: cslab ata support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Fri, 21 Mar 2025 at 16:14, Paolo Pisati <p.pisati@gmail.com> wrote:
> Driver for the on-board IDE interface on CS-Lab Warp Expansion Card
> (NOTE that idemode=native has to be set in Warp Configuration)
>
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/ata/pata_cswarp.c

> +/*
> + * We cannot have a modalias for X-Surf boards, as it competes with the
> + * zorro8390 network driver. As a stopgap measure until we have proper
> + * MFD support for this board, we manually attach to it late after Zorro
> + * has enumerated its boards.

I started working on Zorro MFD a long time ago, but never finished...
https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd

> + */
> +static int __init pata_cswarp_late_init(void)
> +{
> +       struct zorro_dev *z = NULL;
> +
> +       /* Auto-bind to regular boards */
> +       zorro_register_driver(&pata_cswarp_driver);
> +
> +       /* Manually bind to all boards */
> +       while ((z = zorro_find_device(ZORRO_PROD_CSLAB_WARP_CTRL, z))) {
> +               static struct zorro_device_id cswarp_ent = {
> +                       ZORRO_PROD_CSLAB_WARP_CTRL, 0
> +               };
> +
> +               pata_cswarp_probe(z, &cswarp_ent);

This looks very hackish to me...
I guess it blows up when trying to unbind either the zorro8390 or
cswarp driver?

> +       }
> +       return 0;
> +}
> +late_initcall(pata_cswarp_late_init);
> +
> +MODULE_AUTHOR("Andrzej Rogozynski");
> +MODULE_DESCRIPTION("low-level driver for CSWarp PATA");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> diff --git a/drivers/zorro/zorro.ids b/drivers/zorro/zorro.ids
> index 119abea8c6cb..33418af7488a 100644
> --- a/drivers/zorro/zorro.ids
> +++ b/drivers/zorro/zorro.ids
> @@ -400,6 +400,11 @@
>         0100  ISDN Blaster Z2 [ISDN Interface]
>         0200  HyperCom 4 [Multi I/O]
>         0600  HyperCom 4+ [Multi I/O]
> +1400 CSLab
> +       6000  Warp DDR3 Memory
> +       0001  Warp Video Memory
> +       0101  Warp Control Registers
> +       0201  Warp Flash ROM

This change belongs to the previous patch.
Why don't the product IDs match with the definitions below?

>  157c  Information
>         6400  ISDN Engine I [ISDN Interface]
>  2017  Vortex
> diff --git a/include/uapi/linux/zorro_ids.h b/include/uapi/linux/zorro_ids.h
> index 0be1fb0c3915..5736d2bf0295 100644
> --- a/include/uapi/linux/zorro_ids.h
> +++ b/include/uapi/linux/zorro_ids.h
> @@ -455,6 +455,12 @@
>  #define ZORRO_PROD_CSLAB_WARP_CTRL                             ZORRO_ID(CSLAB, 0x65, 0)
>  #define ZORRO_PROD_CSLAB_WARP_XROM                             ZORRO_ID(CSLAB, 0x66, 1)
>
> +#define ZORRO_MANUF_CSLAB                   0x1400
> +#define ZORRO_PROD_CSLAB_WARP_DDR3          ZORRO_ID(CSLAB, 0x3c, 0)
> +#define ZORRO_PROD_CSLAB_WARP_VRAM          ZORRO_ID(CSLAB, 0x64, 0)
> +#define ZORRO_PROD_CSLAB_WARP_CTRL          ZORRO_ID(CSLAB, 0x65, 0)
> +#define ZORRO_PROD_CSLAB_WARP_XROM          ZORRO_ID(CSLAB, 0x66, 1)
> +

This does not belong in this patch, and adds duplicates?

>  #define ZORRO_MANUF_INFORMATION                                        0x157C
>  #define  ZORRO_PROD_INFORMATION_ISDN_ENGINE_I                  ZORRO_ID(INFORMATION, 0x64, 0)



Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
