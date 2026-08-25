Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54C3FF883
	for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2026 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651737; cv=none; b=d8J4e5rMhYmoyt9OWAPcYdkwjgArDIBn9+U6rODmbHiUrZFI4LfYnZy28uCN/JdxBNNObYVrPWAf432LaktimHsIBkRrd5SHEiu6/n89KlOGTO2H4oGU3a39wG09LZQNXjI0OoOYBl1iID+4dVeDtRSfJ5exi5qB+icfPweYukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651737; c=relaxed/simple;
	bh=VQNIKVSkP/d6q2TEsIXAnz4jzolXjWU53VyPob9y6Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBt0+nqG6gQETbgRzoxWUe5nz4zIKOnlo1Ox4LKqUAricwq0AW1+6BMzDdlZdEEZlY8ugTyOE7IHAQC0TisPNQF+HKf34XQWRUbrL+DJ/Q3Ym9v9XRti6AlmnDQIhp0A5Pge0bgE4WKAqTa37XS+Fu4r5ZEhh+K/i/IOEGawbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-74ad03fa605so2488105137.0
        for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2026 02:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651735; x=1788256535;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1N+u2cW8WqOV5adenun2vzALvmH/BsdjcCtQthcuE8s=;
        b=XATlMGsjnWNOyWu3lyYLPyYHFSH3+ptfFpPuDf0Ora59Z7TtohDcvpBrwPt9O/pfy9
         gpIq2D0aLqcDDj2LojNtvQyTcvDBlz1EXNFuVDce2XSlyznnO/zsZQegTWvaAesBXora
         2TdiQXTD7cEwL99tTZKNMgTUld2LCzFLtzzE80hhbNuvwPJ/6Oj7EQISlSQQMmYpV0QC
         XENFRXObMweCkjoopapza8MZKDzxSxCApe7gq+ZYy3+XbKOFiUJwNMojUbtE5XDYGCVE
         955grbLCOfru1ytBTDZo1YHHAl1Gdw6Q3YIKqCXtYrXtUrCOBuDk49/B85MNP4Sf5ZiS
         wntw==
X-Forwarded-Encrypted: i=1; AHgh+RoPfuIu3a9UVOJYG8wuYubr04Llcns7ofzm13PFuR/ol56s2UOISlS4qiQrPlGrF7GwJhWjdMudaTQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mMK3xlS5MfSKAh/NVOyVW9QxS8XIorX5qmUmxbZq8RKL/0z4pI
	xjaskXQKFyqfD8khdIW725oAqFFHku8RVK3RkKP07MtA99qDm7EbaLApT0n5IuxyVys=
X-Gm-Gg: AR+sD12W928PKkGd9pHwWrhlBjl8qjzgxtLrD6erJajZ/o4HoCj2QZ6LebAit6gfQwT
	/cSZbQuuSiRiImXjdNgnOpA+GFcFNcpeNpKSM6Qv2K0YYmFNf1bkX8e8u6Nwm6lu9jcquVqZ/Dd
	tTgOwA5Lwaabj6Va4Bsoa/4RPgfdBr3svqvcs/vwXmQ5bYG2keOrhMpzsPRRTmxH8sD/s1RIcPc
	1a4U5p2ilc80LQcdlA+l6SvjNTzpAcoUXsXNpAgcLzuvIbbeosgOCpHworcJgrEftQ8o3xCpio4
	FFhxTtUX/k6phdOcM44i1nogQoyspLLXqi3SzTm4sSZJG+XHj0aspAHAdE9YlZmH8SiKk8B7hjS
	teEyhl2R5Yu7HAZzfjiTX2KG1ThxDSViyPTo21Nkk2LM+VX+SZ8Xz5TVBrZi2v0CfVrj/rZZfDW
	CFEboqLrYIVFY0qg+HM8cDJ6hlJTTAxF7wIgFXmZ3pHLCMpoh9C15xvmGD90nVCvYhVsrFtlSCh
	z10vb75dHuo4VwW3UiAgyV7pQ==
X-Received: by 2002:a05:6102:fa4:b0:778:459:f215 with SMTP id ada2fe7eead31-77bd0abe148mr10759262137.3.1787651735034;
        Tue, 25 Aug 2026 02:55:35 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-77d8306598asm4923150137.1.2026.08.25.02.55.34
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 02:55:34 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-977258a75d9so2800035241.3
        for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2026 02:55:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoGiLTJWPHIK8yPsT2ygZgOhS7pAcSHcIgjbltCKI3o8BxLIVmn0c1IqBvRKEcqmYcvO5bM+ixgwzs=@vger.kernel.org
X-Received: by 2002:a05:6102:3310:b0:778:f972:3235 with SMTP id
 ada2fe7eead31-77bd1e9b8f4mr9873841137.6.1787651734018; Tue, 25 Aug 2026
 02:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824153339.512487-1-p.pisati@gmail.com> <20260824153339.512487-2-p.pisati@gmail.com>
 <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com>
In-Reply-To: <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 11:55:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWUbAiboKzk4=tM+zP0Ed2gL8uE4t1Qk+UATAhROo8RdA@mail.gmail.com>
X-Gm-Features: AcwNN1UwazRhwxmRVKo6H3UX9N4eSNyMk1PCYraN0L-8HZf4IVCWDlsXuYI1QEk
Message-ID: <CAMuHMdWUbAiboKzk4=tM+zP0Ed2gL8uE4t1Qk+UATAhROo8RdA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ata: pata_cswarp: Add Amiga cslab ata support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

On Tue, 25 Aug 2026 at 09:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 24 Aug 2026 at 17:33, Paolo Pisati <p.pisati@gmail.com> wrote:
> > Driver for the on-board IDE interface on CS-Lab Warp Expansion Card
> > (NOTE that idemode=native has to be set in Warp Configuration)
> >
> > Assisted-by: Claude_Code:claude-opus-5
> > Signed-off-by: Paolo Pisati <p.pisati@gmail.com>

> > --- /dev/null
> > +++ b/drivers/ata/pata_cswarp.c

> > +static const struct zorro_device_id pata_cswarp_zorro_tbl[] = {
> > +       { ZORRO_PROD_CSLAB_WARP_1260, 0},

FTR, this doesn't build anymore.
You also should include <linux/device-id/zorro.h>.

> > +       { 0 }
>
> Please use named initializers, and drop unneeded zeroes, like Uwe
> just did in all existing Zorro drivers:
>
>     { .id = ZORRO_PROD_CSLAB_WARP_1260 },
>     { }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
