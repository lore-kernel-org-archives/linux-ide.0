Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD37C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 18 Nov 2021 23:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856D61A89
	for <linux-ide@archiver.kernel.org>; Thu, 18 Nov 2021 23:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhKRXnB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKRXnB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Nov 2021 18:43:01 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C9C061574
        for <linux-ide@vger.kernel.org>; Thu, 18 Nov 2021 15:40:00 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q12so6907388pgh.5
        for <linux-ide@vger.kernel.org>; Thu, 18 Nov 2021 15:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oXVLgn7Fm48aBJFzNVOVlXR9OEHonO1R9lF3Un+NrdE=;
        b=adean6vy4yeH/XRaSWPDn2eF5HEXAskqbiJ4tLKSBOb1kEyQu9T00sNYEWyuZYH2gk
         BuF3Urre/F4ibEf37iZjBvW4IZEl0BMap4ubCE63aePPvfePIQAiI+s9xh6cRSH/QQrU
         BDvNCfnznWgz+Gl09t2mFIMIKWsWkcTIDmIKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oXVLgn7Fm48aBJFzNVOVlXR9OEHonO1R9lF3Un+NrdE=;
        b=4QibHdHnBk1fW+Vqp4uVhfsyz2EpRvXuxXqdXREdvVpKg/Az21rOdFX9WAUJZu3Ffn
         FhHOpQHcUZgybjXhbKDtLVUyCyraqcfV4dtGtG9MNe1HkqcYAlkHgkBw5B/sp0E5rZvW
         jsZDvmyNl458FefpNXOlBH+HB81ETy6rM3BJiHXaHwuOeKNJCArLJ7ZB2xJedb3KEVUO
         nz6kjK83Vq7rCsnM+oyMxSasSqCUx+JOey6qI6bzQdx8pg8OL2VK285Ufu3k5fQqSAdN
         Xa2a8xrNbXiPyrBVR9Yi5TXqmEkKVlFlF9J8LX71bFx7KX6Howoi+MUDhfne9fZezzg7
         H/JA==
X-Gm-Message-State: AOAM533z8FMovt/3hA0KsKOKjBRO6JENrv1FCIixkDEYOx+5BzobALVD
        wIorm3L9TGh5d8wOq4CFTxBX9rc5c3PQGg==
X-Google-Smtp-Source: ABdhPJzhq8/zLZS54halfY22K3R0DFf+8t9M9mL7GrX7pO1LuSwDghC9VZ8n/iGRKAxpPjjpRv4NSg==
X-Received: by 2002:a63:e216:: with SMTP id q22mr14105524pgh.3.1637278800301;
        Thu, 18 Nov 2021 15:40:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm680152pff.211.2021.11.18.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:40:00 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:39:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sata_fsl: Use struct_group() for memcpy() region
Message-ID: <202111181533.2D90E391@keescook>
References: <20211118183807.1283332-1-keescook@chromium.org>
 <0dd24142-a5e6-b146-9315-d2680ef4ed35@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd24142-a5e6-b146-9315-d2680ef4ed35@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Nov 19, 2021 at 08:17:14AM +0900, Damien Le Moal wrote:
> On 2021/11/19 3:38, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> > 
> > Use struct_group() in struct command_desc around members acmd and fill,
> > so they can be referenced together. This will allow memset(), memcpy(),
> > and sizeof() to more easily reason about sizes, improve readability,
> > and avoid future warnings about writing beyond the end of acmd:
> > 
> > In function 'fortify_memset_chk',
> >     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> > ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
> >   199 |    __write_overflow_field();
> >       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> This lacks some context with regard to FORTIFY_SOURCE and struct_group(). Is
> that already in 5.16 ? It sounds like it is not. Do you want a ack ? Or do you
> want me to queue this up for 5.17 ?

Ah yes, some details are here in the earlier "big" series cover letter
here:
https://lore.kernel.org/linux-hardening/20210818060533.3569517-1-keescook@chromium.org/

One of the requests from earlier review was to split it up for separate
trees for the maintainers that wanted to take stuff via their trees
directly.

The new helpers are landed as of v5.16-rc1, so it can go either way, but
given that the merge window is closed, I would expect this to be for
v5.17.

I am happy to to carry it in my fortify topic branch that I'm expecting
to send for 5.17, but totally up to you. Some folks like to take these
changes via their trees, others would rather not be bothered with it. :)

Thanks!

-Kees

> 
> Cheers.
> 
> > ---
> >  drivers/ata/sata_fsl.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> > index e5838b23c9e0..fec3c9032606 100644
> > --- a/drivers/ata/sata_fsl.c
> > +++ b/drivers/ata/sata_fsl.c
> > @@ -246,8 +246,10 @@ enum {
> >  struct command_desc {
> >  	u8 cfis[8 * 4];
> >  	u8 sfis[8 * 4];
> > -	u8 acmd[4 * 4];
> > -	u8 fill[4 * 4];
> > +	struct_group(cdb,
> > +		u8 acmd[4 * 4];
> > +		u8 fill[4 * 4];
> > +	);
> >  	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
> >  	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
> >  };
> > @@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
> >  	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
> >  	if (ata_is_atapi(qc->tf.protocol)) {
> >  		desc_info |= ATAPI_CMD;
> > -		memset((void *)&cd->acmd, 0, 32);
> > -		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
> > +		memset(&cd->cdb, 0, sizeof(cd->cdb));
> > +		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
> >  	}
> >  
> >  	if (qc->flags & ATA_QCFLAG_DMAMAP)
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

-- 
Kees Cook
