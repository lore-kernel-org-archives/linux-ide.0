Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8064FC433E6
	for <linux-ide@archiver.kernel.org>; Mon,  1 Mar 2021 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3370F64DFB
	for <linux-ide@archiver.kernel.org>; Mon,  1 Mar 2021 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhCANsA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Mar 2021 08:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhCANr7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Mar 2021 08:47:59 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC28AC061756;
        Mon,  1 Mar 2021 05:47:19 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n10so11586424pgl.10;
        Mon, 01 Mar 2021 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AiRtyjlQ9H1d4qqwhlnedJw0eeCaWbUP2szZD4nDgI=;
        b=pu8QHjbaK6DWB8LoTGmA5eDmJON7k4B+9cDg2psmuOAADCSH/p1VO+iKMJT4Cwqmqn
         i+WiuBRAC1dFzzT1kSq7XXb82RrCLSGdwebFZm/J/0WdDpsQErdDSmYklqyVJr+1unC9
         WwCRwBkky8JR4keLgJA1JU+x6w/V77XCbY3h9wpAeiid5qcz5Tn+UH7jpygRlljCqQet
         LTMlCJn0Cbtb+f2K44puRAsSeAHa6Cf3PXwakxJz+zWO45JTCO/Ywms1Fd0B1gswS3kr
         hz2k1CiqaZW641IU7At4A/nEaCfyS/cZF8FKxMMhAsVIKEG4P+cXey5F4DQRWzSCiPZE
         RoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AiRtyjlQ9H1d4qqwhlnedJw0eeCaWbUP2szZD4nDgI=;
        b=RVKb4bP+rWSjRkijUgrEEJBYwN1S/VmRWvpaFonDiFDp3i9GIt7W+54pNZu0aRRkax
         bq18SSUBTtSzA1OA5opLdobFRu4fWPk+fCHWVfRaiMfQsJA3cXliAOGpxcdfUgYGOP0f
         h1EDGU0KGwlXRnLBVuerFskB7UuJw66KmDHJ+ofNMdSgE4kUhEVJktDuy4ujVuyHuHCB
         zftMW+f7sEQFp3n2izmQl7uoluS+o0bdXl2RnOiItVM+W+Vq5e1ow+xQLDE+nw+0CW/h
         yfesVD3rxxi+lMkhCp9ya/QvZTFA+VCEfnykmx5FSVV1F7k2x6vw4+p9PL44hX/exQt8
         8sLg==
X-Gm-Message-State: AOAM530WipjuAGCjhnQbtGODPB1bFdzatFoqQNLaIf70Ccj7trlBthqi
        YltuPIXmt8z87q6DuiUDJOFAtGg86mjkReAgGb8=
X-Google-Smtp-Source: ABdhPJxK+vUSplMDX4f0mQeg2hCMigWmbVMEgASex0bOHAFW9JZLevPge+R1bxMwoFUKsSss3ENFi15a76TMZmhUZ18=
X-Received: by 2002:a62:8811:0:b029:1ee:b016:85a2 with SMTP id
 l17-20020a6288110000b02901eeb01685a2mr3282483pfd.40.1614606439212; Mon, 01
 Mar 2021 05:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20210301072842.7410-1-dinghao.liu@zju.edu.cn> <CAHp75Vf86_Ccs7wqzbpWbLDZSSJLbMwZ1TX3dwru9JvXUTMR_Q@mail.gmail.com>
 <44c09a14.a0cbd.177ed8446ea.Coremail.dinghao.liu@zju.edu.cn>
In-Reply-To: <44c09a14.a0cbd.177ed8446ea.Coremail.dinghao.liu@zju.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Mar 2021 15:47:03 +0200
Message-ID: <CAHp75VdT04AVzW=C=SubHjUE5_MHBeC0ptHTFSLgKzrSP3HmRQ@mail.gmail.com>
Subject: Re: Re: [PATCH] sata_dwc_460ex: Fix missing check in sata_dwc_isr
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Mar 1, 2021 at 1:20 PM <dinghao.liu@zju.edu.cn> wrote:
>
> > On Mon, Mar 1, 2021 at 9:44 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> > >
> > > ata_qc_from_tag() may return a null pointer and further lead to
> > > null-pointer-dereference. Add a return value check to avoid such case.
> >
> > Can you elaborate more on this? Is it a real case?
> > I have a hardware, how can I reproduce this?
> >
>
> In the branch 'if (intpr & SATA_DWC_INTPR_NEWFP)', we call ata_qc_from_tag()
> and access qc->ap->link.active_tag immediately. If ata_qc_from_tag() returns
> a null pointer, accessing qc->ap->link.active_tag may crash the system.

Yes, I can see that. My question is how to get into the case when this
will be true.

> This issue is reported by my static analysis tool, so I don't have the
> vulnerable input currently.

Should we blindly follow everything that some (non-ideal) tool
reports? I don't think so.
For all my experiments with that hardware, I haven't heard about the
issue with NULL pointers. Useless checks make code harder to read and
CPU to waste cycles. It might be maintainers of this driver consider
otherwise, so not my call.

-- 
With Best Regards,
Andy Shevchenko
