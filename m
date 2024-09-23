Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F0944E;
	Mon, 23 Sep 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090174; cv=none; b=fhLorzeZaJlVqYSGFwZgDThc3VUrQclKSm7sb51+pi5DyD8WkTKffLCVDzHnZSazE3B/xENmcdOzgGuxgszWnnUSlmtsWdcSNP3dL2ovXpBSKk/9S7QWjj3Q0LLNnGcGL/keHtqyRfoyDXiKMLF7GRuTudMIUie0tceWfB9TbUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090174; c=relaxed/simple;
	bh=tIHO8DH5NyuiT++VB0fJEsbCMEqGEMc8XYaT7bZ5vuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSwvZC9TnmOfrYgvEaPIKSWdL9nBQGzHO1dV2kgBRQ7hRiUVoLDlK5bJUxRutyVEOxs4X+xnMk2Er5UqwtMnxcjPF3qDpVftDnurdpX5hs/zH6mxpgm6mNh6eieUJTBBybRz2fVzlLMbxP3VV/rfHicv8YLLApoQ2kQlQ956TKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ninrRGzI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ninrRGzI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20536dcc6e9so26504905ad.2;
        Mon, 23 Sep 2024 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727090172; x=1727694972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R3zN6rjgmDwiqM1tyWgAnuP+HwbctY1gr24v68LNtPU=;
        b=ninrRGzIfygo84pIhGuOPB1IcagzMSisDxSlb9pm9fJYRyPrW0WZgvE9E/V6UpK7A/
         GjaTqBj8nxR0PCWvVxtM/FnxCakg9x4cMbxbXjTx3duk67S98xkFVCEZ830tu9vxX7sg
         IZ/LXDUfVs2fmlpsEVB2rK0XTvMNSh1uPIdBf7mCEt9PaK7nv/9Hyz5tSShrlcC9tSFg
         d/ZuXCETWXgQywCv+YcwMyVhu5KAZXpIpc70gigXv1sPn41UW4grj/jKRPfYEVbtcNbv
         oSkvzhGCDdRNmLRg8BYCL5wllZgJnIEvTeu3BXCPJasqTK7XF/WkGD6VCz9iNcYvMq2z
         4Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727090172; x=1727694972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3zN6rjgmDwiqM1tyWgAnuP+HwbctY1gr24v68LNtPU=;
        b=lyzFROUrb1WcOegGHLNhH9u5ZJ27xZy1I2We8nFNBrpf4yFKlNb0EUQyVyYeYDzQeo
         jdWGR6NoJKwVeFs0795cAx5QHWXg26augk3CcvvIxp2QeJPcyDYZKC9QZoAOGc8ZnGbj
         CuX+O6y4YZoUFu7qs7qsZYBVMJhNZHkrk9wMRHWw/+VtqcZbsUoV4NXKug9GKvjmVat5
         rUgTJQL03mmPhhvXfBdW1fWnSGI546bd9ur62sjHWBomL+2lGT9dOHAHiafdQh35kmsD
         xHRs3WosGtn1Xsx8Qqz0B7hvVE45It31E4bPhMb39kpFBQWo/G3RjW6hzvQusEhorIgv
         7ETA==
X-Forwarded-Encrypted: i=1; AJvYcCWi+wbHNQaQMaGpesQVFcVU0sYYJVOg+8niDzSS5MwyCZ2R+4FdCWmu2ubiyI7efqvccvZxtMKpmc/s2tq0@vger.kernel.org, AJvYcCX6ia1oPkJyqWpcYgRDxVoaSE7cogRv/OMXgPg+9YlNQ2L7vk1RPlrjaHxShe9rMLK6HVv3HsnI9iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpILNeGatHcuzLW95Ul3ct/4VYzZDR9pzG30GJbRnJZnp8EWPU
	StgqfzMDFUyvPf02nI9U0nFszryZXC1SsIMVSBg+Ukgt/5ZKMHHQz+Nyw290AI6IgUBFvi9Z8lv
	aqUMMnNfyKHF0a8Eer1qx2cdD1exc2S5+
X-Google-Smtp-Source: AGHT+IFxaJ7zZqhfiM8JBHTh6a0N4meJp8WaZT7uvhQ7yC5nkL5yya6ws/X3WlcNC0WR5YNa2oC7fT9fG9zzSXSLhmg=
X-Received: by 2002:a17:902:e5d1:b0:206:d6ac:8552 with SMTP id
 d9443c01a7336-208d84143edmr177444945ad.52.1727090172100; Mon, 23 Sep 2024
 04:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921124117.82156-1-aha310510@gmail.com> <f70ee386-d8eb-4d28-99fd-9d40e5d93ca8@kernel.org>
In-Reply-To: <f70ee386-d8eb-4d28-99fd-9d40e5d93ca8@kernel.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 23 Sep 2024 20:15:59 +0900
Message-ID: <CAO9qdTGAgBux-M3GxZdBbBpsUm0V_E8fyWSjZuA7jA8bH-Qf4g@mail.gmail.com>
Subject: Re: [PATCH] ata: libata: fix ALL_SUB_MPAGES not to be performed when
 CDL is not supported
To: Damien Le Moal <dlemoal@kernel.org>
Cc: cassel@kernel.org, syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 2024/09/21 14:41, Jeongjun Park wrote:
> > In the previous commit 602bcf212637 ("ata: libata: Improve CDL resource
> > management"), the ata_cdl structure was added and the ata_cdl structure
> > memory was allocated with kzalloc(). Because of this, if CDL is not
> > supported, dev->cdl is a NULL pointer, so additional work should never
> > be done.
> >
> > However, even if CDL is not supported now, if spg is ALL_SUB_MPAGES,
> > dereferencing dev->cdl will result in a NULL pointer dereference.
> >
> > Therefore, I think it is appropriate to check dev->flags in
> > ata_scsiop_mode_sense() if spg is ALL_SUB_MPAGES to see if CDL is supported.
> >
> > Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> > Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> > Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  drivers/ata/libata-scsi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 3328a6febc13..6f5527f12b0e 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -2442,7 +2442,9 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
> >       if (spg) {
> >               switch (spg) {
> >               case ALL_SUB_MPAGES:
> > -                     break;
> > +                     if (dev->flags & ATA_DFLAG_CDL)
> > +                             break;
> > +                     fallthrough;
>
> I do not think this is correct at all. If the user request all sub mpages, we
> need to give that list regardless of CDL support. What needs to be fixed is that
> if CDL is NOT supported, we should not try to add the information for the T2A
> and T2B sub pages. So the fix should be this:

Okay. But after looking into it further, I think it would be more appropriate to
also check the ATA_DFLAG_CDL_ENABLED flag when checking if CDL is
not supported. So it seems like it would be better to modify the condition as
below.

What do you think?

if (!(dev->flags & ATA_DFLAG_CDL
      dev->flags & ATA_DFLAG_CDL_ENABLED) || !dev->cdl)
        return 0;

Regards,
Jeongjun Park

>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3328a6febc13..6ffa975746a6 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2256,10 +2256,15 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
>  static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
>                                              u8 spg)
>  {
> -       u8 *b, *cdl = dev->cdl->desc_log_buf, *desc;
> +       u8 *b, *cdl, *desc;
>         u32 policy;
>         int i;
>
> +       if (!(dev->flags & ATA_DFLAG_CDL) || !dev->cdl)
> +               return 0;
> +
> +       cdl = dev->cdl->desc_log_buf;
> +
>         /*
>          * Fill the subpage. The first four bytes of the T2A/T2B mode pages
>          * are a header. The PAGE LENGTH field is the size of the page
>
>
> >               case CDL_T2A_SUB_MPAGE:
> >               case CDL_T2B_SUB_MPAGE:
> >               case ATA_FEATURE_SUB_MPAGE:
> > --
>
> --
> Damien Le Moal
> Western Digital Research
>
