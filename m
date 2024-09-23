Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE7197A87;
	Mon, 23 Sep 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090702; cv=none; b=qmAfjDaMe64CqbV9h3aAgLuzbelnyD8ccspqFgmrGZqX7V/65SnspexjIKc9L7jGLqLskNw1Bsx3DFHJk1SDpAkOywHldOJ9BXNpmM4Skx3N1Buu2sLY1vDCyz/EGbcV3WHGRotmXq/8mg/UenywuEeyQwCbZHOEXbVomCuWdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090702; c=relaxed/simple;
	bh=qQiTKXuo0kHzJt4uiWRrF0gmBXqNwXV3dFzct12/lgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G30mQygrhIUkopBddJKSZbDkjrwYcyyThdDhb/ld7/8OrOfTjS+shfnUNkmM8YcVJScRaJ0AeZbRVKY9UgfxNRE82ZTnmNlqFUhssODX1isP6+6Z8RlKQmlf1jG37jgPIuDmo282WcG8JLpxDCxS4FpawygoZmItgbpZp4rNBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCGuEWA/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCGuEWA/"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso3420731a91.0;
        Mon, 23 Sep 2024 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727090700; x=1727695500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VRwFjm7CQd3Vf7oTyyEsm7717+Av8FqIgULwHZDZliI=;
        b=CCGuEWA/5Oa8MqLCZ/YuxrNANaEiiRhYiur5D3fvDwqdwr+KP7QiOs5RXyzG+7MYJ9
         Tp42aPmdYwLeQpD1uWfQjYeDy1D+nEdVC+1dfQPRxq3CzYxL/w9l0176VB+5FHYoNdtg
         y7SsQpsnLZIeMQ8/un0QRfwsjGI/TSdB1I1T2neOLSzryv51tuufkA6t04WDVaWscsgu
         hrhJ7BDbIhfoYqhAPlwFJmDfp93BymFI9dN/G4Dh0lj8ZmM/bgmsRq9rmoSW7lHY7O4a
         GqXWHE6oPpyQ2BtqqaEBVlX2niqsEmXJAspmx9M+k7PcHreaRri+qIzB0YIbIIno0UQr
         YYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727090700; x=1727695500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRwFjm7CQd3Vf7oTyyEsm7717+Av8FqIgULwHZDZliI=;
        b=Wi+wPzlPTbzCkSDFYiGyXvPDs2ITTJGiF0zX63B5c1f556XUlqpgnjhtUs7dYy3jbG
         k+vmNSzxdLzFsiSRxRyqnMBbYMpPeqvp1PEF/Xq0iVQmF2vwcxDomd9g8wt6hVfEIfNN
         ZVv8BsQnerFDycEJKNKnCBqqolJvkzjcdib9jTbgN82Bn7hhBEMwDGODtNTVOyoTD5H2
         duKSLON/qlnUGYUEAtovaekr5d0JZWI7oo5HVNx9M/ElMyoT0oxXI6ch4ax8xdBCKHda
         7JbEf5M43Ken3COHUSs9bzFSyGZGgtX5biSYbsINLCxryKG8xxEJOxmP0ynFDkd3YtkW
         dceQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXSQT81g/wt5LDPCLlQSxHBCrPN6X+5a40M3u2+seh8sSyBRSNFkjUnMmtCCd4b7UxLHCukAuwKoMefdKs@vger.kernel.org, AJvYcCX1SyEyw5QK9jJxPBxobnUYtOnC0eaWylTC50CxFgiJDDOX22z9MQVHnIXtMOG78VUw1dXY2mLSXJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPR4Zh9JwXflFFr9bci+6wZH5KoEDjeFY6qJn4Xs6NuxYjlYQ2
	evxZTKTOYVxkx3XrHDIGMvlX7BMS/QKYsLuugba6ZYlMUTpt0/lp+a1Z51EAb9GCGoL0CihqcNJ
	cZGu4JO/OSxeZ//aJLeUZ0uHsnVk=
X-Google-Smtp-Source: AGHT+IHWAhxgsNA0+BMNiFP14NiLvyOlck0PQLPBT4UGGZacZuY7sMwjZ8zEsgyrcvTZ69NG+hTBPfhPpFMxORQ/dro=
X-Received: by 2002:a17:90b:3511:b0:2c9:9f50:3f9d with SMTP id
 98e67ed59e1d1-2dd7f37f2c7mr15838289a91.5.1727090699817; Mon, 23 Sep 2024
 04:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921124117.82156-1-aha310510@gmail.com> <f70ee386-d8eb-4d28-99fd-9d40e5d93ca8@kernel.org>
 <CAO9qdTGAgBux-M3GxZdBbBpsUm0V_E8fyWSjZuA7jA8bH-Qf4g@mail.gmail.com>
In-Reply-To: <CAO9qdTGAgBux-M3GxZdBbBpsUm0V_E8fyWSjZuA7jA8bH-Qf4g@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 23 Sep 2024 20:24:48 +0900
Message-ID: <CAO9qdTFgU1TrfGTgOf=+TgwyNpk-dof2sCHr9+Ut7O+MMHaf5w@mail.gmail.com>
Subject: Re: [PATCH] ata: libata: fix ALL_SUB_MPAGES not to be performed when
 CDL is not supported
To: Damien Le Moal <dlemoal@kernel.org>
Cc: cassel@kernel.org, syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jeongjun Park <aha310510@gmail.com> wrote:
>
> Damien Le Moal <dlemoal@kernel.org> wrote:
> >
> > On 2024/09/21 14:41, Jeongjun Park wrote:
> > > In the previous commit 602bcf212637 ("ata: libata: Improve CDL resource
> > > management"), the ata_cdl structure was added and the ata_cdl structure
> > > memory was allocated with kzalloc(). Because of this, if CDL is not
> > > supported, dev->cdl is a NULL pointer, so additional work should never
> > > be done.
> > >
> > > However, even if CDL is not supported now, if spg is ALL_SUB_MPAGES,
> > > dereferencing dev->cdl will result in a NULL pointer dereference.
> > >
> > > Therefore, I think it is appropriate to check dev->flags in
> > > ata_scsiop_mode_sense() if spg is ALL_SUB_MPAGES to see if CDL is supported.
> > >
> > > Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> > > Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> > > Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > >  drivers/ata/libata-scsi.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > > index 3328a6febc13..6f5527f12b0e 100644
> > > --- a/drivers/ata/libata-scsi.c
> > > +++ b/drivers/ata/libata-scsi.c
> > > @@ -2442,7 +2442,9 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
> > >       if (spg) {
> > >               switch (spg) {
> > >               case ALL_SUB_MPAGES:
> > > -                     break;
> > > +                     if (dev->flags & ATA_DFLAG_CDL)
> > > +                             break;
> > > +                     fallthrough;
> >
> > I do not think this is correct at all. If the user request all sub mpages, we
> > need to give that list regardless of CDL support. What needs to be fixed is that
> > if CDL is NOT supported, we should not try to add the information for the T2A
> > and T2B sub pages. So the fix should be this:
>
> Okay. But after looking into it further, I think it would be more appropriate to
> also check the ATA_DFLAG_CDL_ENABLED flag when checking if CDL is
> not supported. So it seems like it would be better to modify the condition as
> below.
>
> What do you think?
>
> if (!(dev->flags & ATA_DFLAG_CDL
>       dev->flags & ATA_DFLAG_CDL_ENABLED) || !dev->cdl)
>         return 0;

if (!(dev->flags & ATA_DFLAG_CDL &&
      dev->flags & ATA_DFLAG_CDL_ENABLED) || !dev->cdl)
        return 0;

>
> Regards,
> Jeongjun Park
>
> >
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 3328a6febc13..6ffa975746a6 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -2256,10 +2256,15 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
> >  static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
> >                                              u8 spg)
> >  {
> > -       u8 *b, *cdl = dev->cdl->desc_log_buf, *desc;
> > +       u8 *b, *cdl, *desc;
> >         u32 policy;
> >         int i;
> >
> > +       if (!(dev->flags & ATA_DFLAG_CDL) || !dev->cdl)
> > +               return 0;
> > +
> > +       cdl = dev->cdl->desc_log_buf;
> > +
> >         /*
> >          * Fill the subpage. The first four bytes of the T2A/T2B mode pages
> >          * are a header. The PAGE LENGTH field is the size of the page
> >
> >
> > >               case CDL_T2A_SUB_MPAGE:
> > >               case CDL_T2B_SUB_MPAGE:
> > >               case ATA_FEATURE_SUB_MPAGE:
> > > --
> >
> > --
> > Damien Le Moal
> > Western Digital Research
> >
