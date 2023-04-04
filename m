Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A8DC761A6
	for <linux-ide@archiver.kernel.org>; Tue,  4 Apr 2023 20:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjDDUAH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDDUAG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2023 16:00:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F81BCE
        for <linux-ide@vger.kernel.org>; Tue,  4 Apr 2023 13:00:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 185so9213933pgc.10
        for <linux-ide@vger.kernel.org>; Tue, 04 Apr 2023 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680638405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DYV4PPxMzDepSOWEesiMdaYY+snXj4HjdIADIpWwmm0=;
        b=W33ExpVwZ8GdoAxj5xnh9cMHG9WCfz68fArGpIbwJJ1CqwHf1hO/8PNFCKlpxO/84G
         DTp3JubtCfJ6x5/O0VvN1ubmtMNENiLpKxhaAQ38wRUjyi2DiGn7d/a+LYzDHn7TiIHM
         U8G4jbAPdoE5/ebmw6irlB5ijcMM5VVOWfzwg6c+5VR8uw3fBPl7scA7pDak6hbUrexn
         fwBvUDE2Rgs7lP7NS5EYZKeKEwIX9iWTPxRk4aTpjQ7q19GZKkq8ykRSwz47jpGqIhIK
         1fqwxQT4fMqNClkC4mhG+g+4UVLW4GAt5isDS4QuyyufjrXTIE5rc+8r0nJBceGfd/5e
         SDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYV4PPxMzDepSOWEesiMdaYY+snXj4HjdIADIpWwmm0=;
        b=R6m0NgEJiQxfU1+1/ztNgAuOSxDevGdvpL/bzClx8C+zCRfhd3w0UFONqhbKR6AzM1
         OEHKXowIeWK5KRWbG18AQlotVgjc+3+oP0C25HBxWBBkKqtkqQ1/u4TodZ6XLzlzXjJ+
         +QmVzt77YyZqbtbkxInFAiTHmDvaNcABMbU5NOmjN4hMqXxzjzs1wksRvA9deYoK0anh
         RJva75kUj6uiz10tcVBDxMYf/BQSxEsZYW6cgqqGM/oaGKS5r505KaWIbL5LjyNfUnIo
         g67hO5ydRYyKdgDd453WzkOV2IMzevnxuy24ahbvgcYsX/8QH67BIc1z6aK2GhigkBII
         YBCg==
X-Gm-Message-State: AAQBX9eaVAoKkDAM7XJepHbPqR7Skz+JvO81VMUzd13onoHg/kL1UxMB
        LEVb+x2f7qaaUkivx/1Aiw+kDVICTq2soL7zj9iQVtpOSBs=
X-Google-Smtp-Source: AKy350bIS1+086YMKZ9wH40yEaFQS2Kd+slOjt/9hYZaE8hjITrj+MZ2UwksOZjZlvFBU1ES0c1KqVyuuTGPleCQkKw=
X-Received: by 2002:a05:6a00:1256:b0:62b:113b:72d7 with SMTP id
 u22-20020a056a00125600b0062b113b72d7mr1975533pfi.3.1680638404979; Tue, 04 Apr
 2023 13:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADUzMVb+JbwxiKxrxjAep8Gbom_ynM7Os67_gTEHC-dJFAVL0g@mail.gmail.com>
 <5c99651c-01d8-e396-f817-802ad6f1017e@opensource.wdc.com>
In-Reply-To: <5c99651c-01d8-e396-f817-802ad6f1017e@opensource.wdc.com>
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Tue, 4 Apr 2023 22:59:53 +0300
Message-ID: <CADUzMVYknyN5P4QrzKfb7bP2yVLCgJpvDu+XVZLbemyFLRCUmQ@mail.gmail.com>
Subject: Re: The SATA_ini162x.
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Damien,

Sorry for the late reply, I have been busy porting an ancient android
kernel to GCC 10 and have consumed lots of time on that.

Most drives support HPA but it was not enabled on my device. Kernel
could boot without HPA but I would not recommend it. I have seen x86
firmware using it to backup its image in HPA area so we could get into
big trouble.

I am sure that this is not an HDD issue but can verify that HPA is
workable on another host. Will test an AMD one and test a boot with
the proposed argument. I planned to test it with an LBA28 disk but
haven't done so as I need a spare one. Will definitelly do it during
the weekend.

Thank you!

On Thu, 23 Feb 2023 at 01:43, Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2/23/23 06:28, Ioannis Barkas wrote:
> > Hello Magnus,
> >
> > I will give you more details about it since I reported the issue with
> > this controller many years ago.
> >
> > Yes you can activate the driver but you will need to enable this
> > driver and build your own kernel. That is needed since the driver is
> > disabled by default. There is at least one underlying issue that has
> > got unnoticed and has not been solved yet thus the driver is
> > considered experimental. My PCI card has an eSATA connector routed to
> > port 0 and a SATA connector routed to port 1. Back then, I had tested
> > the SATA port and believed that the driver could only handle port 0.
> >
> > Damien if you are willing to investigate this and help me fix it, I am
> > at your disposal. I still have the card with this controller, the
> > datasheet of the IC manufacturer, an AMD based PC with a PCI slot and
> > lots of disks for testing. What is more, I had done some tests back in
> > December and the issue remains. Here is what 6.1 prints:
> > [    1.947670] sata_inic162x 0000:05:06.0: version 0.4
> > [    1.947716] sata_inic162x 0000:05:06.0: inic162x support is broken
> > with common data corruption issues and will be disabled by default,
> > contact linux-ide@vger.kernel.org if in production use
> >
> > Here is the problem:
> > [    3.285163] ata8.00: native sectors (1) is smaller than sectors (976773168)
>
> Are you using drives with HPA ? (host protected area, see:
> https://en.wikipedia.org/wiki/Host_protected_area).
>
> That normally is drive dependent, not adapter dependent. And with TCG now, HPA
> is not really a thing anymore and not used on any recent drive (that I know of
> at least).
>
> Could you try with recent drives (HDDs or SSDs) that do not have HPA ? And maybe
> also try to see if the libata argument "ata_ignore_hpa=1" helps.
>
> You could also try adding a horkage for that HPA drive (see
> ATA_HORKAGE_BROKEN_HPA examples in libata-core.c, ata_device_blacklist array).
> Note to self: there is unfortunately no libata.force= argument for hpa. Will
> need to add that.
>
> >
> > I tested the eSATA port and it behaves exactly the same as the SATA
> > port. I have also performed some modifications but those were in the
> > wrong direction as I completely broke the driver thus it could not
> > detect attached devices. That brought a libata bug to the surface and
> > I need to send a patch about it. Back to sata_inic, I have not figured
> > out how it works with both channels.
> >
> > Hope to get better Magnus really soon!
> >
> > Best regards.
>
> --
> Damien Le Moal
> Western Digital Research
>
