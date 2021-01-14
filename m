Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF1DC433E0
	for <linux-ide@archiver.kernel.org>; Thu, 14 Jan 2021 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70BD23A52
	for <linux-ide@archiver.kernel.org>; Thu, 14 Jan 2021 14:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhANOyl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Jan 2021 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhANOyl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2021 09:54:41 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ED3C061574;
        Thu, 14 Jan 2021 06:54:00 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id o10so8357172lfl.13;
        Thu, 14 Jan 2021 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H43AsPC1Ol3zcrpDjCexwQNmz+Osl0+OhlXoSr96dXA=;
        b=ryn9lPb9TmLcWhM8xLI6KEhUnVTuyMNs1BPg+7zNtMckZh3te89f7IIxpRDAtkARSi
         vtmBTryduHnZyG8gxO00pwyKUMLQGNbdDv8cN2dpm1nqGWSXmZPsUKpibpF/5gXFaZCQ
         8LDk7bGkdBbNWNM5WkK8ZKTsBgFDtsNgzq2NtPWbx4bqosdBxM9KxZ4O7L4PewFKzKVz
         GV2kpmQiI8dJWtwJJ1qQp/rTVvGWGKnzNVz+WAroQCvWR9VJLcEC9uisTD4nRYSMx2PZ
         atbHuoHBVqN4vNF+VQzHc7Qqn/EZHu/qBGCzayKLvsc4FT5rQtjZZP6nlmFyIQu46fsq
         Xyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H43AsPC1Ol3zcrpDjCexwQNmz+Osl0+OhlXoSr96dXA=;
        b=DJA9oXUZbA9d1rg5o8L/Ozjkv3/7B2nRqrZuSX4bBAE60ZRVQeAyead+DHC7x5rhHZ
         cdtwznQB2rrPy3fhQ+LQ07vIAqfVWOj2otzDWdjawM8uzL5SGs+AsQvup/7HmxNHKbtS
         bQkf0WuOHFzw9p0m5kVLMMwwQ/RmBQ5JAnqsT1LVXENRNQhBvZAdiftcUXWR611Sv4uY
         ollk5o2lmesYJbrOfcGFbI24PgkcWgJpb3i/IGkVsJU5LRUUYkUpmIzAcefnZ57A36+M
         Ggkd1I5eLErw6riVQIwHSSEqt1o7BaWAKUDnMK3MtomsFBugsqvsomYQYCUYMb8T5B2A
         WTQw==
X-Gm-Message-State: AOAM5339S2fHIWNNbCHOEGudJBcTF/rPDdKMhPUWqcLlnRMO47iPrb6i
        1vVXHBm+ow8sOE8VLIu7nfrYuggz5BUfU9AYYbFKPvsGNQQ=
X-Google-Smtp-Source: ABdhPJyJTBDUpTXVX/OpGZmgZzRX+iCpQZAOGyNR00VXpqIZmMuCulUlQV4/lclmUTTaf2Id4xYhcULwVj54ElE/xPc=
X-Received: by 2002:ac2:4146:: with SMTP id c6mr3740962lfi.477.1610636037447;
 Thu, 14 Jan 2021 06:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20210112023619.5713-1-dong.menglong@zte.com.cn>
 <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com> <CADxym3bzFPeCXzkO1iFy+Sx7GhwRGo=VkOUzrDE4KMCjMx0v-w@mail.gmail.com>
 <2b6dcfbf-d534-4a2a-53e0-c942a9120a0f@gmail.com>
In-Reply-To: <2b6dcfbf-d534-4a2a-53e0-c942a9120a0f@gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 14 Jan 2021 22:53:46 +0800
Message-ID: <CADxym3Z088OCMpFvUMG8Ggx3yQXVL0N9=yJ4+CUgxgnTwkEysw@mail.gmail.com>
Subject: Re: [PATCH] ata: remove redundant error print in rb532_pata_driver_probe
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <dong.menglong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Jan 14, 2021 at 4:30 PM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
[...]
> >
> > What does this 'MBR' mean? I am a novice~~~
>
>     Generally speaking, Master Boot Record. But I also use it to send you My
> Best Regards. :-)

Haha~,

> > So, is it better to replace 'platform_get_irq' with
> > 'platform_get_irq_optional' here?
>
>     No. You should stop overriding the result to -ENOENT and pass the result
> up the call chain instead. In order to do it, you should only check for (irq < 0).

Well, I didn't even notice this. It does seem to be another problem...

---
 Best Regards
 Menglong Dong
