Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DCCC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 18 Jan 2022 07:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiARHHs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Jan 2022 02:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiARHHs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2022 02:07:48 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563EDC061574
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2022 23:07:48 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id w7so19197851ioj.5
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2022 23:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1s5pnjbmxYZUEohEh/zC0IorcVg8N+Tw/q324bI7NA=;
        b=jsj/vaLsnctP16xh1ffgs+pwK2DtbRYL8gImS9SYSG6o3xYUGZPwlja8T6oY2TEuZT
         gRnD7GfTdlwfrlmAwJ+tef0H2hKBFqSluTI89YtoIWVUJZ8VDDgHWcprJXaOnyDvy2dO
         ZmMaGfOcCbrYqGSUTBUTCD45iM7CMwtIkIgeSucUjHpT9hbP84oN7oKcXPfrwz0NjCc9
         JV5B0ey8ToBakiOOJrASTZ5QeZii9xc05GfWgCCTUl5iM/OXvlJ0LARF30IXS4dY9V4H
         tZtxeF5N+Rebro4liPKY7hGaYIHmVf+qpI4pkgeqmwJiwxF9OWb6oaWm4UNVn5iQAlHU
         Om5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1s5pnjbmxYZUEohEh/zC0IorcVg8N+Tw/q324bI7NA=;
        b=z3pSEqzk3KBYGBJDcTJS0hDWLXos0i7AJAih3Nz009sHYoCp/esOCU/jO5pI61/iZl
         ACmNzTFlceSxSuVbrd9puJdEx4DtmGYgksRV5Hoq5EEWdWYG+Rv9TKWcSaYV4vGlJ2Qi
         QAc58VAb9iBUhBC56H1cbfPKUoDlI3cSXHiRQS9Aq9jhqfDUfV4UUuqggFSpx3NsRRJ5
         Q86LVFE1/jQgVnvvjJb8dA1Y3z9Y8mtAch4PnQsWeQYbhk1DqdcSagaaHfLmG5iGoAP2
         jiaQzRTc1bFLjEyefMqJ1M1K1j5BIMo6X8o24h1eCRzO94HElV5ML1GW4d+FaMZ8BGLu
         nzSw==
X-Gm-Message-State: AOAM533D9zynY94Ox6egdHRw97l7MxEHopj/X51Jm7ScdiujDFeqTJjx
        zfQZOJtgQ0VLwossXUwSFe3NUs900J5KxO8krhOspQMyi1E=
X-Google-Smtp-Source: ABdhPJzSWUaHFhhUrXfseCLzD85618J5zu8CmjWgLJArkEl7tB+hsWSUhMZwFaSDEmt/+TFfJO9c0zsAqXHxNaIgHaI=
X-Received: by 2002:a5d:9155:: with SMTP id y21mr11655093ioq.112.1642489667753;
 Mon, 17 Jan 2022 23:07:47 -0800 (PST)
MIME-Version: 1.0
References: <CAFrqyV5qv3K4m5m__VGfs5O_ocx0LDa=Dyiqc=rtGj9OwqsO3g@mail.gmail.com>
 <017131e8-50c5-567e-6b17-b82dc65ae3d6@opensource.wdc.com>
In-Reply-To: <017131e8-50c5-567e-6b17-b82dc65ae3d6@opensource.wdc.com>
From:   Sven Hugi <hugi.sven@gmail.com>
Date:   Tue, 18 Jan 2022 08:07:36 +0100
Message-ID: <CAFrqyV5JziaQJk5ZLdjXvmP47qD=qHRtsQesHMozg=jwpumueg@mail.gmail.com>
Subject: Re: Samsung t5 / t7 problem with ncq trim
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Ok, thx

I will ask the scsi guys, if they can help.

I just now see that I am writing about the t7 and t5, when it is the
t5 and t3...
My fault... xD

Am Di., 18. Jan. 2022 um 01:05 Uhr schrieb Damien Le Moal
<damien.lemoal@opensource.wdc.com>:
>
> On 1/18/22 05:02, Sven Hugi wrote:
> > Hello
> >
> > I hope, that this is the correct mailinglist... if not, pls let me know...
> >
> > So, there is a problem with the samsung t5 and t7, those ssd's are
> > just samsung 850 with an usb-c adapter.
>
> Then the SSDs are likely seen as scsi devices rather than ATA ones,
> through USB mass storage/UAS (USB attached SCSI). So the problem may
> come from the USB-C adapter in the device, which would explain why the
> changes you show below are ineffective.
>
> See the output of:
>
> scripts/get_maintainer.pl  drivers/usb/storage/uas.c
>
> to see who to contact about that problem.
>
> > They should get added to the ata_device_blacklist in libata-core.c
> > Those 4 lines should work in theory, but i was unable to test it,
> > would be nice, if someone how knows what he is doing could do this.
> >
> > { "Samsung Portable SSD T5",    NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
> >                                         ATA_HORKAGE_ZERO_AFTER_TRIM, },
> > { "Samsung Portable SSD T3",    NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
> >                                         ATA_HORKAGE_ZERO_AFTER_TRIM, },
> >
> > Sorry for my poor english
> >
> > I hope this helps somehow fix the problem.
> >
> > Best regards
> >
>
>
> --
> Damien Le Moal
> Western Digital Research



-- 
Sven Hugi

github.com/ExtraTNT
