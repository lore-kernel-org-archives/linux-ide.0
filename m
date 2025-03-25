Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59F2528E1
	for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918221; cv=none; b=KtmkU5VnxFrKxTuOAY5OCflso9cAa7q4gOi3nCFbkBf51rngxgnT8tcula3lNlA1keMG4R1oix/NN2zHGFu9cF090Xp4+9lTL4RuLVZE+l9IVY1wQKDsPjONjBqnw8MaVNiDbcDwOEiAYSlbTgogm+uoiDgo+sBZIJi4BTWjJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918221; c=relaxed/simple;
	bh=GRDJUa8t2QDqMQ0paHAqwICzDEwF3cTqXjXFQYSXEdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/GK7xUOSPiBwtm7+gozVZsMbTVNoTOZKOC0h3G6T5rmHtyUN7MJgpLkP06Ou/Jo94SVn9JnvbRYnYt9bEt7J9Q/wAuJc+JnmW3CKpXPgYA0x909gX0QisCJJQvwEEjF4NAu6q89UkD3DUagKjIle5O0s7uekhbcvlXDWECHTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-524168b16d3so5503855e0c.0
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 08:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918218; x=1743523018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPWfxryaZtpRz3wfY9xf6zngWom/Hy2f4zbc4qhu/nM=;
        b=jHmHGSxAiTrUNaOuIYEig1/o9pY4HBfRMx2/v1bZRTEabDqsizeEgObTvmf3hHY4pl
         5VlCrhy20WD74iLy55yY8hSFIm7FAt7aZvrzWs2WJuzOJOpqdg0jy8hVyiH7tqOuWdJa
         TkfADxz6vo6IseQSOjpq2sw7Ye/6d1OosxHyWoXO7h+okGpj4XFBbKBsc/+9lshEkSrc
         eIS0wgwsoTLU8Uix9FRVWr9Rli0F1l27VZYPxRh6alWh1WYcWfmQ95c+jbG1hqS2OKy+
         FggkOX1rXzaHp1fXkKhBh2g9FI1+hPRhMizNk832vhoE1ZHa6Ylzx5GGxaa9I3qprqoD
         s30Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+i+odN7NVCMsUBKZ4RAcLGeZHLf3ghQNjm/uXvm77UlYEWD5eIBtCFVk6q/9peMAnAjXRf7+uOcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFd6nffXkVXUTlHFIClh/2zf6QxIwJZUmTMfjkcftAiG9Mepo
	MkeT+Jl2YTS9BQip+N6t6938hSJSVlvTW63HnfwrawGFkyz9T+hJjS1Qx6d/XLg=
X-Gm-Gg: ASbGnctpZnvoH6et7B/UNzmK5sRPMRh1q5g5iVYNlc1reFT20PEwgR+FdrxZGur8HWD
	TvIFIy999weqAfgoz5CIxL0zUD56NUKqk7tEicDFQCDagexItjMC1+LZLmV89WtWuLmIBcaXrP2
	jnO3WxNKwjvmlwsnXC3rRQZdLOFlKBtmnK6a4UUljEcrtvzaU6h3dEeWe6rolCGrQns9M64RUax
	FUPM7VDNH5JR1NLMGjKYCNO1EcJu6dyI93YVK6PdpP53V8LKRYoWNUrMAG+IRBNbvXMrHYnohhO
	ZZAQvQhN2BwnZWHHcrjVo0YYZTDDKKHNDm2Jge15IaF1J/dCyvSgiFZqeKz7/9qE+ZqHEOGWI+1
	PS0EBLP4=
X-Google-Smtp-Source: AGHT+IEGNh3RPCzLxuD+x33R7+D+/0ZGxHZx+1yVZKx2426ei1fN30cyrlgNH+CDCerIBuXjvD0yBQ==
X-Received: by 2002:a05:6122:1b8a:b0:520:60c2:3f3 with SMTP id 71dfb90a1353d-525a834eb88mr13265732e0c.4.1742918217963;
        Tue, 25 Mar 2025 08:56:57 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a7645dc5sm1837521e0c.31.2025.03.25.08.56.56
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:56:57 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86929964ed3so5229665241.0
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 08:56:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZRgqy4mNa21dNE+tLNC3kiXl5wBkwt/LRtkgcTSbDyJ0V4rHf3OFEuwqGj3yghHEsAIyVy+8aqCw=@vger.kernel.org
X-Received: by 2002:a05:6102:194c:b0:4c3:6544:c250 with SMTP id
 ada2fe7eead31-4c50d623ce1mr10483365137.23.1742918216398; Tue, 25 Mar 2025
 08:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324121645.208368-1-p.pisati@gmail.com> <20250324121645.208368-2-p.pisati@gmail.com>
 <CAMuHMdW8WUyUsjG4FaT4nP82pZYVFsUpYNOg2vsPPOthf-O49A@mail.gmail.com> <Z+LR9Glz5iV4Sjll@amaterasu.local>
In-Reply-To: <Z+LR9Glz5iV4Sjll@amaterasu.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Mar 2025 16:56:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-yibj3=EJa0xryau7OXiWzF8kvEdw0TAK-=iBHEOJvA@mail.gmail.com>
X-Gm-Features: AQ5f1Jq4qskIIKPZ_ZM7MltaifMkXQb2h_uSNjDf0fgoy4qyTsLWnavh58QU6X4
Message-ID: <CAMuHMdX-yibj3=EJa0xryau7OXiWzF8kvEdw0TAK-=iBHEOJvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ata: pata_cswarp: Add Amiga cslab ata support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Tue, 25 Mar 2025 at 16:55, Paolo Pisati <p.pisati@gmail.com> wrote:
> On Mon, Mar 24, 2025 at 02:21:57PM +0100, Geert Uytterhoeven wrote:
> > > +
> > > +       ata_port_desc(ap, "  cmd 0x%lx ctl 0x%lx", (unsigned long)base,
> > > +                     (unsigned long)ap->ioaddr.ctl_addr);
> >
> > These two printed addresses are virtual addresses.
> > However, due to the use of a cast instead of ioremap(), they are identical.

... identical to the physical addresses.

> > Still, I think it is better to print board + WARP_OFFSET_ATA and
> > board + WARP_OFFSET_ATA + 0x1000 | (6UL << 2) instead.
>
> Honestly i don't follow you here, but i'll ioremap() and send a v4.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
