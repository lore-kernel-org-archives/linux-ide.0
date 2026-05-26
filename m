Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F0403156
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808131; cv=none; b=ZGPthq3WUiJ6i829aPQcWo+WNBQ602/4jUA+aiDBA1ndNcrH//1YzMXSAPEfqa8MdviLvTCavGtijOcXIAdfT/g+HRsMUfpY6s+i38i0jaAaQFk+wpbkoZ9Frm4fBMJKhhrOeBRQnb5xeUxFJUDFlNTDX4bxgexXvhmdTZ1jR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808131; c=relaxed/simple;
	bh=yb+0omux6d1zyLgvLzeZABk2GNuWtKQ1yrpCoQCsmR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr1LvWNfYIZjeT/KrAshPyGi75z+6vvYXCUeMTg41s+YF8cB1VQibyJTyZMwPCYKShTtzLJql0BajWNCaFBxOFGjm16Nu4/OKnN1AhcmgBW6RdD6Pcd3adpPnQSUGsqH8P6cR+fHnESW/Ngia7M1rHWLCO4jr0rW/AERVLRSPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-687d82dd690so4866980a12.2
        for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 08:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808128; x=1780412928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLTPgXz6PTE+WNmbiors/d1TQS2Sqmrm+U6hNBea8hs=;
        b=MkZaxIeULCysmB7i8uhI/jyIDMQUJyxtJcSyyh0T5kxl/9T3fTNd97HmtFbOaTvuyO
         vxhzYDu4MVPsmKqWX7PLjoI/WNKPD/CIf2YnHd0bwab22N2dmnDR5RFlBPieC5ykiHsy
         BPkmB+3V/ftgCayN8ygm2cZssHxHxH1Q++kic/Fi9CRdTr0v7ZuEEk2cZ4jPV7332IA0
         yaU8afhjbyuqTZmIntHUb11yVSAuRn7BsMfg61OMZjwdUeZe6kau2nltCq07vNLDG3GO
         gOssRD7zSV95atgoxvAuFivYOFpd0r6asyg1ZJTKlnVAAeJ5lub6l5AzHdSeLfVu6gzl
         JxNw==
X-Forwarded-Encrypted: i=1; AFNElJ9A3iPUKYPzlqShS7EqIDjNeI+X+WKRwf6BPt1rzxPsTkeeiM+04xqCRLrqt8SgzqvLsspA51/KJgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3Mn81IC07ycBGvxey91FQfRGNw4SJymichE3MtvklMgdqZnx
	609U4SptyOER2jJnc2S80N9tNXpfdrnrwSgicyrwFSf+XxkmDfq1ZEbbknXNxV9iSvw=
X-Gm-Gg: Acq92OGI64gwi6sbS6ZjMjITBw928nI3OA70hLf6blWBoOZIrGsyq6nWl3Fv8t3Ek4C
	Z81ASlVcGAX+AKB1Y3DPn5ui8GfvraKJCeWo/4SsrLpPOCCf4QwHAt4CgRWggqGYVqnLn2h1rUh
	Pa5u/JqMfGZhyMyQ4wKGKDwkMj+2KJcPUKhABj9bsNgnnxqV6DoM2qVXGQZkpCTykEIb5xl8sPW
	403CgA0xbCMBLcaRWsr1WVu4qLg7IUKAJOSSAa6tMlyVZUbMQ+WchkPLJl14oS+aSS8MFWFpHUN
	A4vuGLueHehr6VMfeZDCqmfixleJMiFwGYdX7vYnTX96zO85g2s6aWnpl9Z58TLFOjr7mLvmfc2
	8KZ6aWjhrXfIuiOLQKN5h+FJYTxY+c4H+T9vgfwsTrZCGW1p6db1NK72R/a8mGXIGN6jCfSMTep
	cdObMciYBLxj6+RbjvAC+51kOzN4aqUjJQasrEiTxO66c3nYkyVPT9uqp0BYSnXqgSBA67ADY=
X-Received: by 2002:a05:6402:360a:b0:674:40c3:f047 with SMTP id 4fb4d7f45d1cf-6889ca4520cmr9413016a12.12.1779808128341;
        Tue, 26 May 2026 08:08:48 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1eb98sm5157209a12.16.2026.05.26.08.08.48
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 08:08:48 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso6711465a12.1
        for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 08:08:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+qs+jT0e5mbyhCpDUyfmzuaxedNvZDrf1LM19K6LiaNBe19e3BlBJhmKiLz9dVNIgOoYiGqLWP9ZA=@vger.kernel.org
X-Received: by 2002:a05:6402:360a:b0:674:40c3:f047 with SMTP id
 4fb4d7f45d1cf-6889ca4520cmr9385916a12.12.1779807721391; Tue, 26 May 2026
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2026 17:01:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
X-Gm-Features: AVHnY4KG1TJnpMipnk7rqdd9LGhhF-uK_MvXjYFynbh1jLKZ-eyBikYr9yO02y4
Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in zorro_device_id::driver_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, 26 May 2026 at 16:17, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> this series is about improving the handling of pointers in struct
> zorro_device_id's driver_data.
>
> While it's ok on all current Linux platforms to store a pointer in an
> unsigned long variable, it involves casting that loses type information.
> This can be nicely seen in patch #7 where after profiting from patch #6
> the compiler notices a missing const.
>
> Preparing for that change, all zorro_device_ids are converted to use
> named initializers, which is also a nice cleanup that could stand for
> itself, as it improves readability for humans. (That is necessary
> because an anonymous union can be initialized by name, but not using a
> list initializer.)
>
> My motivation for this series is the CHERI hardware extension. With that
> pointers are bigger than longs and thus you cannot store pointers in
> zorro_device_id::driver_data. So this series is also about getting
> support for CHERI into the mainline, but I hope the clean up effects
> mentioned above are justification enough to accept this series.

Thanks for your series!

> The dependencies in this series are as follows:
>
>  - Patch #5 depends on #1, #2

s/5/6/?

>  - Patches #7 and #8 depend on patch #6.
>
> So if the ata maintainers agreed to merge their patch #1 via scsi, and
> Geert agrees to patch #5 and that it's also merged via scsi, patches #1,

s/5/6/?

> #2, #6 and #7 can go in without further coordination.
>
> Patches #3, #4 and #5 are only about using the same initialization style
> for all zorro_device_id and can go in without coordination.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (8):
>   ata: pata_budda: Use named initializer for zorro_device_id
>   scsi: Use named initializer for zorro_device_id
>   net: Use named initializer for zorro_device_id arrays
>   i2c: icy: Use named initializer for zorro_device_id arrays
>   video: fm2fb: Use named initializer for zorro_device_id array
>   zorro: Simplify storing pointers in device id struct
>   scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
>   video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
