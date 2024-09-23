Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937453373;
	Mon, 23 Sep 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097749; cv=none; b=rICg2663QLp/JKMcayvlmEz6paOS9LbVA1Byyi7NKVRX4lc4NMjw3zWW0ObKzeezJdwBzBm5SZ5+6xXK56LczUDcbGTW+Tig0+JUqrs/EqvvCmnFySnqDu1zPukKlkRmotEy2T0n5BNHxMZOHW/bwAOnj19jx5RZEifCe05jkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097749; c=relaxed/simple;
	bh=7EQVX28zCQTDrrsEz2EhonF6BdJDs+VD1jDwfKJSCOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnDnxqpWZ++Lf+nYP/Rw6tQbLZ3y8wbFHVORMrP5racTxA30+ZyAbu2BrIFvdJenUINhsFVBewQ/Ta4TRkq5Qi9qAWCcHpSsz4Rp5S/IusDX/sXzSD9/SMaJcXrcUiJMVq3ij47cY78VO81i5KKTtd6TpeFND7utZCTYaqPWWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfsvE3Sa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfsvE3Sa"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2053f6b8201so37774015ad.2;
        Mon, 23 Sep 2024 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727097746; x=1727702546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hBd1g72Uob6vOJpeOaN9C3igYtaCF5l4UFF29KEQwXU=;
        b=RfsvE3SaDlep70NIHSj7pAga+rlMmvErKVT13Ch7PeFC1ZiKn1kkclk+YHrnJge/p6
         rkAMO4sQO3ARaC5NC5LZd6qqDSbiLfADP4V28TBFB/zydp51PsRnwrXyZgjF8m5iSv7k
         tJ/UGtrIDWv7S33PTA/C9ewuqRelZpCruECmzI3QEPb2L4sgEGecb1jvoPMj04iyyX0e
         Vr6c1QMa4of/gUdqnWYV9KtdJ7thhxq/NEvsqQW3liewRia8VaTq9QgrDFSpL7OncmRc
         QLLUPExWppSVY3s2mE6KfClmuJXnh3Hm6evluTcjERKttf7afVAWawbtO3fp5VFl6HuA
         y5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727097746; x=1727702546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBd1g72Uob6vOJpeOaN9C3igYtaCF5l4UFF29KEQwXU=;
        b=rBeuYdNnYFBM7JT5vj8g0E5CxOKx8GqbNjGZRv8mh7u7fjtDH+vH6WwZnr0Aab5PL4
         wbu+PinnGOVEkhBwhqTW9+NVGrBeVAe1z6K5i9D8k2kvAv9fN1vD3a+TWe58Uhz8Byzx
         KyxAyuXrrN3pDgL+Bvy/2huAuOa0fvaOcxtu39IlbZS70UBewM5EBeuvQDQk1F1gh2HM
         CC/oa8bzQKxdwCysv7tl/qw0LFrnbcBI2DL9+1Jn7MhnuwK0f7/nlQpREaOAVqi21oMc
         La9SVy7Sq0f1saDNHIpRVXEMZC8qyL8rYD60oOF27XrPetBqL1QcwKwEW52oZ2kUMSqJ
         jibA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3KSyYUdng+R5CqKEsHMjeQvNGFlMJFrbrHPKGwS6I0Hh/FLlMbu8G9nRQASG0TWdPM0wWBaIDEw=@vger.kernel.org, AJvYcCVXXCjW1xPpnpUXLjMZBqz/HpxUhSxdMf40Ct1NEBik9j6N785ommgc1SMx7K4OFgQlfSKX0SnZZllFbG59@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8q2GsdyHrUj1W6WpwL5weKamuTR9fLxcKIceqWLQL9+tPxz/N
	c7cICUwBz3EuiB83WdrlMW2fQ49+vTu4/7DPrOraOzySgx1Nh1FFEkvjRt0qt+VYB5G8as6wb1B
	TUAD32cCQWXhSrMLS4MfK4YPmNoZJzbad
X-Google-Smtp-Source: AGHT+IHy1uOmtcC+d93HbkvU196wpifbbOifSE2Uw77s+n7fDblbLYTnucHQlsHKm0Q0LR6Ds+uHd9jT1lfatt1qPfQ=
X-Received: by 2002:a17:902:c412:b0:1fd:9e6e:7c1f with SMTP id
 d9443c01a7336-208d986dd97mr173305215ad.56.1727097746041; Mon, 23 Sep 2024
 06:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921124117.82156-1-aha310510@gmail.com> <f70ee386-d8eb-4d28-99fd-9d40e5d93ca8@kernel.org>
 <CAO9qdTGAgBux-M3GxZdBbBpsUm0V_E8fyWSjZuA7jA8bH-Qf4g@mail.gmail.com> <7f297a66-6c82-498e-81da-85bbb74c8a8f@kernel.org>
In-Reply-To: <7f297a66-6c82-498e-81da-85bbb74c8a8f@kernel.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 23 Sep 2024 22:22:13 +0900
Message-ID: <CAO9qdTE+vdFPsCLfaxMK1N8t=9+zSF88LQr-C5L=K9rZRoQjSQ@mail.gmail.com>
Subject: Re: [PATCH] ata: libata: fix ALL_SUB_MPAGES not to be performed when
 CDL is not supported
To: Damien Le Moal <dlemoal@kernel.org>
Cc: cassel@kernel.org, syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 2024/09/23 13:15, Jeongjun Park wrote:
> > Damien Le Moal <dlemoal@kernel.org> wrote:
> >>
> >> On 2024/09/21 14:41, Jeongjun Park wrote:
> >>> In the previous commit 602bcf212637 ("ata: libata: Improve CDL resource
> >>> management"), the ata_cdl structure was added and the ata_cdl structure
> >>> memory was allocated with kzalloc(). Because of this, if CDL is not
> >>> supported, dev->cdl is a NULL pointer, so additional work should never
> >>> be done.
> >>>
> >>> However, even if CDL is not supported now, if spg is ALL_SUB_MPAGES,
> >>> dereferencing dev->cdl will result in a NULL pointer dereference.
> >>>
> >>> Therefore, I think it is appropriate to check dev->flags in
> >>> ata_scsiop_mode_sense() if spg is ALL_SUB_MPAGES to see if CDL is supported.
> >>>
> >>> Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> >>> Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> >>> Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")
> >>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >>> ---
> >>>  drivers/ata/libata-scsi.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> >>> index 3328a6febc13..6f5527f12b0e 100644
> >>> --- a/drivers/ata/libata-scsi.c
> >>> +++ b/drivers/ata/libata-scsi.c
> >>> @@ -2442,7 +2442,9 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
> >>>       if (spg) {
> >>>               switch (spg) {
> >>>               case ALL_SUB_MPAGES:
> >>> -                     break;
> >>> +                     if (dev->flags & ATA_DFLAG_CDL)
> >>> +                             break;
> >>> +                     fallthrough;
> >>
> >> I do not think this is correct at all. If the user request all sub mpages, we
> >> need to give that list regardless of CDL support. What needs to be fixed is that
> >> if CDL is NOT supported, we should not try to add the information for the T2A
> >> and T2B sub pages. So the fix should be this:
> >
> > Okay. But after looking into it further, I think it would be more appropriate to
> > also check the ATA_DFLAG_CDL_ENABLED flag when checking if CDL is
> > not supported. So it seems like it would be better to modify the condition as
> > below.
> >
> > What do you think?
> >
> > if (!(dev->flags & ATA_DFLAG_CDL
> >       dev->flags & ATA_DFLAG_CDL_ENABLED) || !dev->cdl)
> >         return 0;
>
> No, that would be wrong. The mode sense is to report if CDL is *supported*, not
> if it is enabled or not. So we always must report the T2A and T2B pages for SATA
> drives that support CDL, even if the CDL feature is disabled.
>
> The flag ATA_DFLAG_CDL_ENABLED is not checked in ata_scsiop_mode_sense() for
> this reason. Adding that check in ata_msense_control_spgt2() would be wrong.
>

Thanks for your reply! I will write a v2 patch to meet the
requirements you provided
and send it to you.

Regards,
Jeongjun Park

>
> --
> Damien Le Moal
> Western Digital Research
