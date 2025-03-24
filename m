Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8D18FC80
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809112; cv=none; b=DRTKr8Y1HFrECH50neqPyl90d7aK77xJWxbJR3rKmItLz1D4N122Z0eC+1yUbnguOnT4dizrgkMC4JxbHTtDax2fCIFlpS427zqbRM6z6kLzCURLOfZaw/BtmNhiJ0E8J5G6yfN0Ab5QBufcf90IFK4OgC/m7kK5Fi7Z4ABHyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809112; c=relaxed/simple;
	bh=GZfYjgArTwLHiXMxmTbvbBnzIUjnBDmSxDdBhz1O0LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeVHmjKuSa0e6lM9lJ5yHdyLNM/maHGKMkDXBf+i8fJdNrT1FO5zq1Uq0PvFhv2426uF5Yhp6ZRkUT91hi9mjPFeEMu2Z0fnsfsKsTTEtecpsHJdD2HTr9yHLPdlzkzYhqcoBu+w1mRZ4YFKMPWrmITU2L/BGUQw4NaGVf/jGEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-523f721bc63so5007754e0c.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 02:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742809108; x=1743413908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0RslLkejdkJKrapLaXeQbXyfA2C7em+zDrHpM/wF4k=;
        b=fSxfvIvpudXz9bdquOzcS1dgx1M1hlF+mn52vBdKU4XSbw+CqPkBBnNqRvdb+/2Rrb
         rnxbD4ek2d1ieyRjo9fBEz/1qox/VqA+wTxFlfIL2CZplBsemzburCDFyn18eNHy3Avs
         8ztbOC0fmWmIKkAjhe/PYTvP//SyN1ZOSiyujHC3LvljVn8J5lfwn8dzAfqgAY9xoLWf
         qgaUIYAozdlKiBja1EGu+ryAW9LFzbYQCKr2yfQNlo5QgEmWjlmMTebjfbp0/GabwdRg
         zOIoeETE7G6xVyeL6lodbWiZcYc3qLM/kgESFxUaR8guqo8P7v96FocaBt/3IdeITA0b
         7SjA==
X-Forwarded-Encrypted: i=1; AJvYcCX78PmBEMHG9eh3IRM/sjnZkqkKXVpkMeTlp6M1hWSNO4eWRF69whwLkWv26O5vht4pvtSFyeI7ZGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5qYU7CEBqRiWuJKtEbfNy7SoEwRuKoBV5EOzAcbzotXsCP8L9
	gzTSA89IHZw4zIVVLuVh0y8lv9S8YWgs1XxSa7a5ZzfNxayqNlZEbYgE3XKk
X-Gm-Gg: ASbGnctHpoz7USOpqCyVASJYLRhfO/8/J2y3dkiBMgb6xqyZiBMZCiOdbDmWv6nIWgp
	Sf9qWxOwjCvuybm0J/JQGI2sj+G0/vDNB4fb9A1gLX1s3GzlL/tU9SYrQtxjmMJhmdXQqmGb5Ox
	fWixxy42kp1HUPMCGgMKn3l2tRXNMhUuBnAeRxEdkQ2KEfdXPJXCKBWznywItpat6qsel9kPG+0
	oGTJVl5zGPuEn+i7psGXvDoemLlie2NQcvbLGgddJUdpkulWFXUJE0Irh9uSXIFSPVHhnSLj2OO
	tuVx5bkgEJJzx0cYzYJOgPAno7GYAK3bRrDM4aLQFrzmIIWnjIVgj7F1+0FFQfZ0pyUFO8VlUrp
	ps2QYfE4YCGo=
X-Google-Smtp-Source: AGHT+IEh3RqxFJ1B6AEiCyrEv+WxGJBccI94BeK20MRaTK/0TQh4lmvU+G3ITcRyDog97xnSBnLHeA==
X-Received: by 2002:ac5:cb51:0:b0:523:eb47:2884 with SMTP id 71dfb90a1353d-52595e81095mr9406116e0c.6.1742809108413;
        Mon, 24 Mar 2025 02:38:28 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a73edcf3sm1328071e0c.28.2025.03.24.02.38.27
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 02:38:28 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-524038ba657so4149090e0c.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 02:38:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhIyYBeiqS9yHFfh8zk/KmAez0RoyZa4HkdH2RSjhfHYuFKq9PQyUR2HT+AjguefiokT3vzBNyatU=@vger.kernel.org
X-Received: by 2002:a05:6122:231c:b0:523:dbd5:4e7f with SMTP id
 71dfb90a1353d-52595e58d98mr8791082e0c.3.1742809107784; Mon, 24 Mar 2025
 02:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321151416.338756-1-p.pisati@gmail.com> <20250321151416.338756-3-p.pisati@gmail.com>
 <CAMuHMdU0yDSXoeDoK0yUrJ-cD_4BChEXcvteJW5Ra6afKzciMQ@mail.gmail.com> <Z+EhmiMWIMGqlXXP@amaterasu.local>
In-Reply-To: <Z+EhmiMWIMGqlXXP@amaterasu.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 10:38:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXCxah0V7p1oHjOXvFK6jPCYitThZw=+s7Rx9BpVgoyMw@mail.gmail.com>
X-Gm-Features: AQ5f1JpcG8V9ZaJ37A7knShxmtSUzoxxncWIhSlLSRQu-qn_T9qr6gkWZrl4hEY
Message-ID: <CAMuHMdXCxah0V7p1oHjOXvFK6jPCYitThZw=+s7Rx9BpVgoyMw@mail.gmail.com>
Subject: Re: [PATCH 2/3] amiga: cslab ata support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Mon, 24 Mar 2025 at 10:10, Paolo Pisati <p.pisati@gmail.com> wrote:
> On Mon, Mar 24, 2025 at 09:17:57AM +0100, Geert Uytterhoeven wrote:
> > I started working on Zorro MFD a long time ago, but never finished...
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd
>
> Uhm, that could be useful for this multi-device board, thanks!

As I still keep up-to-date patches in my current tree, I have rebased
the zorro-mfd branch.

> > > +       /* Manually bind to all boards */
> > > +       while ((z = zorro_find_device(ZORRO_PROD_CSLAB_WARP_CTRL, z))) {
> > > +               static struct zorro_device_id cswarp_ent = {
> > > +                       ZORRO_PROD_CSLAB_WARP_CTRL, 0
> > > +               };
> > > +
> > > +               pata_cswarp_probe(z, &cswarp_ent);
> >
> > This looks very hackish to me...
> > I guess it blows up when trying to unbind either the zorro8390 or
> > cswarp driver?
>
> Yes, this was clearly wrong.

Oh, this was copied from drivers/ata/pata_buddha.c, which does the
same thing.  How could I have missed that? Ah, Summer holidays...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
