Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35625DD04
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821103; cv=none; b=UbK5qyy+nBh4mEsix12XyleG+wuWrBbjTJMli5kuBHMVl8b+EA+S4JWTlLbRACrgO9W9lGDXSkwSskjAJVAADK72I7FMv69jnEYJ3pmv3blgF4Dl3zLtlFi+GUHKIQnzNRBLIZPFIvuqmNn9D/vBGwNXPeg/d2qDcp9KVzlWACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821103; c=relaxed/simple;
	bh=TNp1OPkGqBU1QA4npSv/D4DILYmbk00gq8bA84JoTuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWLZrAbBLie6nS17QlTBuo/mbsfkVbDwFEcAApSp4YBWhoeAE0LKrIL4soXxUSqtBTmPai+R2U8D3yIKLBbZTKOh61HkgzqPgBrzBt49otbdxndWr5z3eFT0CL0vXqIO8cMOasC6KgzayVHXWyT2wCYO0aCopxGlv4Qjp/+TW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so4405983241.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 05:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821100; x=1743425900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hMaW+j0ix8yucAj8zHWEI7223vtN8mVOwYO+GlnwwM=;
        b=TVWKJiGWiUz8pwn5FK9CmqRXHKZ/+xMH307SCkXpFH300uCEQa8AbxVjVZzJ36mqz4
         pu9VK9nzoLJpU991dJhectSgjOAp+jdh5GEQ8TPxzrQW1H4Fdp7xZ9dVEOQlJVtgeAQd
         WZz3TWvznVxy/LhvVLMJ8Wt/o43SABSRy91zm7pGU7cu8iSGFr80NnFlBajstjGsS8UW
         16of4+8ravruRKfiYNwf9SmTI4/+2sVmjjOJv6MUi111THjSxAspgcl3ooRkhHPmDGxp
         /Lwlj4eYh8OkvaciXwrmyp0rNeqTqs9b56k6/Iu68MzogxjQQPIKkQsuEfpB5/Gx9Xsr
         mc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwWHfTwJ4rFRkf1d+qBcddFc1rvEZgEPMrra3E2u3yXxHBBRr7NCzYR5sKJWe59XGdjfWHXrjPrDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUfqrpXCzbvW3ZJaVJAS+x3zeKPWQmD6zbtTet/r6Fll1O9gr
	wu8HrippQZJaQbSp/C0x2T7wnZoy4yMwRt7ZsWbzsU6sNFV6NUtSSmAPL+3w
X-Gm-Gg: ASbGncuYtXSMri8PXzM/7pWSkg2G8G9bn/HZf5nqk9t0pCMX0yZD7KmwDDdX5chMLt2
	2CSI5US0WZ7kQmpbeM/qn46c72oqe0OFfDLoE+tkU9Wl4UGx8zIvOz575ItyFlqHgrPgx92d0PE
	EEXA+r1tJ1WLKeGO2nFR5gxp8k3icNZqZ8Mtp0hN8TZ7sVUIj1g/n/JWNkhvuvoeUQs9u1iC/US
	gQaqZFr+105v7u7NmkzytidOCnfk4xSTMONIUU9jNLiE4EuZDcwssg2UcoTFV3j5H36BVSlqKne
	XhvLxK3pmQI26UOvGvJCivWrhPqRSjVzJ9zBNFvf/iNMD4S4SnXhaKuxQWEQ6x55ReINAqQdFGf
	uxx2gdV0=
X-Google-Smtp-Source: AGHT+IEHKxKEICJd2RkRWnWLh1qnPlPOgbqAAIJeu3eFu8IvwJ8lhuNaTBNhi3jPMGQ7Ngd3h6vP9g==
X-Received: by 2002:a05:6102:1629:b0:4c1:90ee:f8c1 with SMTP id ada2fe7eead31-4c50d47a65bmr7867150137.5.1742821099594;
        Mon, 24 Mar 2025 05:58:19 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc4caeesm1542720137.15.2025.03.24.05.58.18
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 05:58:18 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so4405955241.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 05:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJ+6Q9/ZlhUXZ9VtQ0Y/QG45JWPZiBFfHFcDHGoibJmiDazFvIi88F+N3tmj6zJxGQd6noYbo0XzA=@vger.kernel.org
X-Received: by 2002:a05:6102:f11:b0:4bb:c24b:b61a with SMTP id
 ada2fe7eead31-4c50d5e0ff4mr8374313137.19.1742821098713; Mon, 24 Mar 2025
 05:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324092409.99430-1-p.pisati@gmail.com> <20250324092409.99430-2-p.pisati@gmail.com>
 <c874f648-8583-4c6c-9ce5-5ba369ccc731@kernel.org>
In-Reply-To: <c874f648-8583-4c6c-9ce5-5ba369ccc731@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 13:58:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4iLKT2edVs-LpyXULe_ENktiM_C=ypgM=_WPrLLA8bg@mail.gmail.com>
X-Gm-Features: AQ5f1JreT1hxEEiWCWU_4i_Py2L_6BPEWUHCH-0XYi7YhGWmcI9OlIw2TX7_VgM
Message-ID: <CAMuHMdU4iLKT2edVs-LpyXULe_ENktiM_C=ypgM=_WPrLLA8bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] m68k: amiga_defconfig: enable PATA_CSWARP
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Damien,

On Mon, 24 Mar 2025 at 11:53, Damien Le Moal <dlemoal@kernel.org> wrote:
> On 2025/03/24 5:24, Paolo Pisati wrote:
> > Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> > ---
> >  arch/m68k/configs/amiga_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> > index c705247e7b5b..feed92c95394 100644
> > --- a/arch/m68k/configs/amiga_defconfig
> > +++ b/arch/m68k/configs/amiga_defconfig
> > @@ -334,6 +334,7 @@ CONFIG_ATA=y
> >  # CONFIG_ATA_VERBOSE_ERROR is not set
> >  # CONFIG_ATA_BMDMA is not set
> >  CONFIG_PATA_GAYLE=y
> > +CONFIG_PATA_CSWARP=y
>
> This needs to be patch 2, otherwise there will be some bisectability issues.
> Unless Geert wants to take this patch and we queue patch 1 (the driver) through
> libata tree.
>
> Geert,
>
> How do yu want to proceed ? We can take everything through libata, or you can
> take both patches through your tree. I do not have a strong preference either way.

Me neither. We don't get to see new hardware support a lot ;-)

Paolo:
Please enable the driver in arch/m68k/configs/multi_defconfig, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
