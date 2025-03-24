Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AAA18DB34
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803453; cv=none; b=mXv0h5sbGxwMQKNbdB2iEt4hzlAxzI5VMHsg5A4JpRtZ9LnGyjtyUpf/tq4T5i6UyQ5LmY6hBw2gFWUTdDjSGBN4mEWWFcw8j+488FsESgamLO+eypFrihU7ZLqwqtt/tddm/tSY5JifO3IZb4ZEa3GLJo+kUxCfjMHu0m5GsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803453; c=relaxed/simple;
	bh=waIDTzfJeGprf0IJDgI4ophvCidcyEBtX1rhBS0R948=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma3QH216lXT7Q71Ld8bxvCPS7Zy0wib+Qsp6UhiAetneEgoV1v6TDT0NBt6OWbrxhzXlzZhlhnqBJn99admvdkhP4SjYr16DzIW21dC24oskfRuOE3CoCUc3jyCxcMJgUgYO/XqdLugMl/FBJu3P/1B8ic6f6kLuUS3Uwmibha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so4174625241.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 01:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742803450; x=1743408250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LW8fSp8pDr8IytbOKxU9Ce5slmJtka15/u9Kms9+eGM=;
        b=YR4W4I6lmDEUTBZO4GwO9PQAWk1vBGpXTP+x4uLOGSEu+GXMjWDraUj5ASQZ2cZejF
         4/cUiLTiibkbJ42mAP8KD7PGjqRvcuWWsYzRI/4ryB0cYIQmvQTDFjGgHFOYkUUL1u41
         6zW823seKTfjgEhWkWwem9f8UO4BmOrd2KdKyS1cjoDg6g8+Gd8AWnJt7lAnFvWjBfTU
         iZ6Iot4DCqkxoxdmw9zw5/LM+xyWEISVeMQvniroQ+gEzAI0ZRe9AyHNHJ5BjAeOYe3J
         kX6LtkAQIOhGC6bpe0bP4+eSTZuNjD+hbJ6fxSBIdJtVJIBEBu6ejBBzpZBoavxdp43N
         M3GA==
X-Forwarded-Encrypted: i=1; AJvYcCXHtJi9bcMzTqoDA0DTplHX8ga83HDeGPcZO+HkltJSsCAI4BHUL+Gp2H/PXWibfx6wjbjUWq0GEHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCYCOprkgezoC7ntONbgTF6f2tMkutvA0j7JtXVH50qc3GNvh
	ZY6OdDfEw4EY/HVkfvHcackwBS2IsesgY9WhYbFyvOB550pDGSRhuJMrTywK
X-Gm-Gg: ASbGncvEplWobkH5jvKm1548sldWAIq4N7k+x7JgZyI822OA3U5VmISRt/VA9GwUWd6
	3yJJlp+ESh2HkeS0kwonYccyLhxFGuyankPaDHdnxK5L6BEBbxlZIj7+9QSzXnlRrsoY3AsMWiB
	YKGLhRgkn2gWu/s0mpg/0Rx4HblHVGF+z5LNPRxyC4vlwSN1Amd8KfTwAU/7I7YcG8/9TlzeI1p
	F5SsDcpvhSQRuj+C8dSOT11boxGV93zj7JlpyDl2xzMxmyzlbOqKhMCzYezy+CppcfX+4XPC73z
	IKkyT/DxPp+WvVz9OzIplZu2pFyMYDXOqrCmvNzhDTMcTYAwK7Xto/C3dnvcLUrXUfqZDkdIqIv
	4npsi9x6FvCxOO/+KRg==
X-Google-Smtp-Source: AGHT+IF/Q1dyDdNy5IQ55TtA6Ra7WjA3NPjuMxO/F5hz8JKK+U8CFdGoPwK4DQn6xdBmpli1x2qdIw==
X-Received: by 2002:a05:6102:390e:b0:4bb:cf34:3757 with SMTP id ada2fe7eead31-4c50d5e2787mr8013440137.17.1742803450019;
        Mon, 24 Mar 2025 01:04:10 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f455488sm1492274241.23.2025.03.24.01.04.09
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 01:04:09 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86929964ed3so3887295241.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 01:04:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXovKilOOCcZlccf0pobG5gOL0hKW+n5oRKpUBVnG+0QtXbub7T0gYElEKe7x5i24/YhTy9RcL6m+Y=@vger.kernel.org
X-Received: by 2002:a05:6102:3f0d:b0:4c3:6979:2ef with SMTP id
 ada2fe7eead31-4c50d620e46mr5828890137.21.1742803449228; Mon, 24 Mar 2025
 01:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321151416.338756-1-p.pisati@gmail.com> <20250321151416.338756-2-p.pisati@gmail.com>
In-Reply-To: <20250321151416.338756-2-p.pisati@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 09:03:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWzNdJesbKeWBrJ88rHBWP36k23EQo80TjYbe4V6vprhQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqPior9Jo9Nzr-fOs-iHqTJa_bcQoKsPvZY5OyLpkGT1K3mjUiFtrnvQgA
Message-ID: <CAMuHMdWzNdJesbKeWBrJ88rHBWP36k23EQo80TjYbe4V6vprhQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] include/uapi/linux/zorro_ids.h: add more cslab warp id
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Fri, 21 Mar 2025 at 16:14, Paolo Pisati <p.pisati@gmail.com> wrote:
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>

Thanks for your patch!

> --- a/include/uapi/linux/zorro_ids.h
> +++ b/include/uapi/linux/zorro_ids.h
> @@ -450,7 +450,10 @@
>  #define  ZORRO_PROD_VMC_HYPERCOM_4                             ZORRO_ID(VMC, 0x02, 0)
>
>  #define ZORRO_MANUF_CSLAB                                      0x1400
> -#define  ZORRO_PROD_CSLAB_WARP_1260                            ZORRO_ID(CSLAB, 0x65, 0)

This removes a definition; was it incorrect? Please explain in the
patch description, especially as this is a uapi header file.

> +#define ZORRO_PROD_CSLAB_WARP_DDR3                             ZORRO_ID(CSLAB, 0x3c, 0)
> +#define ZORRO_PROD_CSLAB_WARP_VRAM                             ZORRO_ID(CSLAB, 0x64, 0)
> +#define ZORRO_PROD_CSLAB_WARP_CTRL                             ZORRO_ID(CSLAB, 0x65, 0)
> +#define ZORRO_PROD_CSLAB_WARP_XROM                             ZORRO_ID(CSLAB, 0x66, 1)

What do these represent? Please explain in the patch description.

>
>  #define ZORRO_MANUF_INFORMATION                                        0x157C
>  #define  ZORRO_PROD_INFORMATION_ISDN_ENGINE_I                  ZORRO_ID(INFORMATION, 0x64, 0)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
