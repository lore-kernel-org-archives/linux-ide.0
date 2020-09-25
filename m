Return-Path: <SRS0=DroY=DC=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5981C4363D
	for <linux-ide@archiver.kernel.org>; Fri, 25 Sep 2020 06:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2E821D91
	for <linux-ide@archiver.kernel.org>; Fri, 25 Sep 2020 06:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgIYG6Y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:58:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39560 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIYG6Y (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Sep 2020 02:58:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id c13so1764284oiy.6;
        Thu, 24 Sep 2020 23:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3Yw2JSMJ9YMUyhRxop52ZEmWXLCPwoLTZXpveNO0fc=;
        b=sc3TkeLxeggvtNO0qqkweFijwZoLNjv+I5jImnZGtIoocxyZBmG4vId/kvLtGyQ4qI
         ZGxWaLZnfI+S1dZ+IfSIJgzlNzPChTNMhlYFM0bXttlGJwYygr0R/d+pbxsfcdjEMyFx
         5BO4JYjLXiXFZ9UqOZJ42lHJujo2WNEcNqVXTnMJh4n06m1YodkLeNKbp3BkqTwkoLLi
         kwSBoUedGPrYaQmlmbzyAIvh/1Cm/UWApaOZrIHuhQc3MhpYAUloxiuHIoLGzVKudBe0
         YuqBptgnY0d5z6jzCOWCaZ0SyV37SI8mzh8f8Izc8r9a43RehdCYw/fLsJGpQ0z3/4sq
         GUMA==
X-Gm-Message-State: AOAM531ipp3GgoFvoEMLbjL6mB9rz7IKtOtWiR4rOS3P+RJGq1cY2uBP
        rguLW0vGh9PqofmR5jDL65OZSO5prRd7PIXRwDA=
X-Google-Smtp-Source: ABdhPJynGEHE8plxVOMnpuSBb4WXibznM+UxbseQlsRuDndVsl7ZgC5jIQw82XrLHwGZ5WEpAklYa2BtWuVRJiqilss=
X-Received: by 2002:aca:3bc3:: with SMTP id i186mr703603oia.148.1601017103075;
 Thu, 24 Sep 2020 23:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <df121aff561c73f3ff7d83f906942ed0d954d737.1600997998.git.fthain@telegraphics.com.au>
In-Reply-To: <df121aff561c73f3ff7d83f906942ed0d954d737.1600997998.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Sep 2020 08:58:11 +0200
Message-ID: <CAMuHMdWuVLy1PHryOOMkvDQ=MHJV=gs2JS1AUU-KWE53zOAfoQ@mail.gmail.com>
Subject: Re: [PATCH] ide/falconide: Fix module unload
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Sep 25, 2020 at 3:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Unloading the falconide module results in a crash:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Oops: 00000000
> Modules linked in: falconide(-)
> PC: [<002930b2>] ide_host_remove+0x2e/0x1d2
> SR: 2000  SP: 00b49e28  a2: 009b0f90
> d0: 00000000    d1: 009b0f90    d2: 00000000    d3: 00b48000
> d4: 003cef32    d5: 00299188    a0: 0086d000    a1: 0086d000
> Process rmmod (pid: 322, task=009b0f90)
> Frame format=7 eff addr=00000000 ssw=0505 faddr=00000000
> wb 1 stat/addr/data: 0000 00000000 00000000
> wb 2 stat/addr/data: 0000 00000000 00000000
> wb 3 stat/addr/data: 0000 00000000 00018da9
> push data: 00000000 00000000 00000000 00000000
> Stack from 00b49e90:
>         004c456a 0027f176 0027cb0a 0027cb9e 00000000 0086d00a 2187d3f0 0027f0e0
>         00b49ebc 2187d1f6 00000000 00b49ec8 002811e8 0086d000 00b49ef0 0028024c
>         0086d00a 002800d6 00279a1a 00000001 00000001 0086d00a 2187d3f0 00279a58
>         00b49f1c 002802e0 0086d00a 2187d3f0 004c456a 0086d00a ef96af74 00000000
>         2187d3f0 002805d2 800de064 00b49f44 0027f088 2187d3f0 00ac1cf4 2187d3f0
>         004c43be 2187d3f0 00000000 2187d3f0 800b66a8 00b49f5c 00280776 2187d3f0
> Call Trace: [<0027f176>] __device_driver_unlock+0x0/0x48
>  [<0027cb0a>] device_links_busy+0x0/0x94
>  [<0027cb9e>] device_links_unbind_consumers+0x0/0x130
>  [<0027f0e0>] __device_driver_lock+0x0/0x5a
>  [<2187d1f6>] falconide_remove+0x12/0x18 [falconide]
>  [<002811e8>] platform_drv_remove+0x1c/0x28
>  [<0028024c>] device_release_driver_internal+0x176/0x17c
>  [<002800d6>] device_release_driver_internal+0x0/0x17c
>  [<00279a1a>] get_device+0x0/0x22
>  [<00279a58>] put_device+0x0/0x18
>  [<002802e0>] driver_detach+0x56/0x82
>  [<002805d2>] driver_remove_file+0x0/0x24
>  [<0027f088>] bus_remove_driver+0x4c/0xa4
>  [<00280776>] driver_unregister+0x28/0x5a
>  [<00281a00>] platform_driver_unregister+0x12/0x18
>  [<2187d2a0>] ide_falcon_driver_exit+0x10/0x16 [falconide]
>  [<000764f0>] sys_delete_module+0x110/0x1f2
>  [<000e83ea>] sys_rename+0x1a/0x1e
>  [<00002e0c>] syscall+0x8/0xc
>  [<00188004>] ext4_multi_mount_protect+0x35a/0x3ce
> Code: 0029 9188 4bf9 0027 aa1c 283c 003c ef32 <265c> 4a8b 6700 00b8 2043 2028 000c 0280 00ff ff00 6600 0176 40c0 7202 b2b9 004c
> Disabling lock debugging due to kernel taint
>
> This happens because the driver_data pointer is uninitialized.
> Add the missing platform_set_drvdata() call. For clarity, use the
> matching platform_get_drvdata() as well.
>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-m68k@lists.linux-m68k.org
> Fixes: 5ed0794cde593 ("m68k/atari: Convert Falcon IDE drivers to platform drivers")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
