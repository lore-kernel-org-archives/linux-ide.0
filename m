Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCC2BD1B
	for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268235; cv=none; b=r4Rp6irCRZ2+GVAaLRtMk52j7mZDsknPcrSajaFBB8xH2+GaeojQsKDxc46U+fS+XXuAXlS/AoTUInKdQvf1kjwosifF0eKdFE5Mkbx8TQPjQ0tf/ilJaj6rkdvgZGtLMkfmzU372GT7UeajZeV1ee8/2toLB6Pzd2C1TZr1PDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268235; c=relaxed/simple;
	bh=M56FL+UpkK56wuTbs3FGjSdEUPCOwsr0dxOYvxuBUrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPiYmc9JCkQ+f8nzOxlft8Rk1RSZNme6qq7cq8VEAHU80Y4aovzIxBhOdJKRlEH1A3ZWlmiB80nwnXivdMefPS3A6rtd7DlettmX3MV1W71PJ58/EVAqXoKcLSTU+whc7Yq2UE6oxHxf868eIYW4kvhMbRiTNDyoWFruf0aX2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2d522f699bcso855585fac.2
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 07:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748268232; x=1748873032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Yw5iSzYbzriDp17/brRyJ5/xBiVxOZLd/jW4wl5BxA=;
        b=VkaYagylmfFSYFvJnXuCESYjRsCUZtPEJa5JoKoIOrdHN11kGReFxFs32T4KMm2KGI
         ug9M9Krh7hBnoxxH1uIKCDjfuoKBA4HwtVW3dvjEcIkbEEe7mMWMVuTvGyYQUIKge3fL
         wqRxvO+wLyhKoneM8jqJXONTkpW2TBcsMFjKfpEwGYFeLhcPXohv7WUaUtoN8Um7nn8h
         26RCy85GFEY3pjMD+cwS6aY9ShRK7jg0+PJwuwtwKFG+ScojvFqH0TOhHhN0nohJsjVd
         q8J3006EptGdrMZkouh5C0Tl40+hNWaVYCQfswkbJs50Xn+EJA/yodB58OcnuKU2QE8c
         /ywg==
X-Forwarded-Encrypted: i=1; AJvYcCVIUz5ktnNE1ATg3XWsIvrrIvLMSe86Hx1HOrVQ2INb1n41eyhhESajsTYMsleCJrrfO8Fo3GynCAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAozEW/EoIGZgAME2DO8Gz/IhIZQugriQQQxD/JYW+qM8TmH5
	Zd8+rrMvsNoWH9xNFsW/HuT1+cYiXX4IjWKFcY6yZKUzs1JNTEA7XaLbBS8cllY8
X-Gm-Gg: ASbGncsmDInxzJIVflawgA1BX2NIA1wLPn9QDhUyV7T33c+mDwEpyeMP/AfrBi+JJZU
	tZRmGrQjJoo2M56HB5pgrQdSdJIF7hHYr9c9LLkNeooZ64OdKAjVggEJWi7/pkJ6N63GS1Qi7/i
	Ir54+IWBGKW7A09ch31m142Is2e8h5619xf4/kW+7GlY7qEkZFF+LTIpwyj29GVwGLvoF1vk4zv
	Jhl+QK50Co5sj8IkdaRsQD6sDdrbrzGRZy/ZKH9peb66rlgo3IGuSXFW5QAKkRVZSEJQGnV2aKf
	BLRRHFimdL56e9ppy6KyVVXoErHgJIyxWSkEMvFPS+tXTiNXxbMZVe1RK4tzKPgBPqpUPs0hTQG
	oKsTb5g54rI/8zE6a4Q==
X-Google-Smtp-Source: AGHT+IGHbJrY4pScrp/4fgyjoOW599sUr/odUY2VWB0l4IyD9gxeJP+bdHD30ExVAanYZw0JFot8Gg==
X-Received: by 2002:a05:6870:1796:b0:2d5:4f4:e24d with SMTP id 586e51a60fabf-2e861d6321dmr4538893fac.6.1748268232263;
        Mon, 26 May 2025 07:03:52 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c06a93d5sm4891214fac.12.2025.05.26.07.03.51
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 07:03:51 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fefbbc7dd4so1362889b6e.2
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 07:03:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjWu7vl2tcuJ8sVQuXuC43Vdie0Uj3dEnp/FN+PhV/JwqLG9cY4Omv07PYu4nFhmM3r8ncoG2xi+I=@vger.kernel.org
X-Received: by 2002:a05:620a:3190:b0:7c5:4eee:5409 with SMTP id
 af79cd13be357-7ceecc3c64amr1605591185a.48.1748268219856; Mon, 26 May 2025
 07:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325155613.352680-1-p.pisati@gmail.com> <20250325155613.352680-3-p.pisati@gmail.com>
In-Reply-To: <20250325155613.352680-3-p.pisati@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 May 2025 16:03:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdViC5UYcdca5yHzTYhkNF60sNJOd3y=JMNRn5zfApSEOg@mail.gmail.com>
X-Gm-Features: AX0GCFuoxcpObwYMdx2bQg0VrY-3KmF7-dZUL-LWHGwcdoJt6f4gDNi9UsoTaqs
Message-ID: <CAMuHMdViC5UYcdca5yHzTYhkNF60sNJOd3y=JMNRn5zfApSEOg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] m68k: defconfig: enable PATA_CSWARP
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 16:56, Paolo Pisati <p.pisati@gmail.com> wrote:
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
