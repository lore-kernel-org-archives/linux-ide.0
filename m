Return-Path: <SRS0=DroY=DC=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC956C4346E
	for <linux-ide@archiver.kernel.org>; Fri, 25 Sep 2020 02:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A214C20809
	for <linux-ide@archiver.kernel.org>; Fri, 25 Sep 2020 02:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLQ5VcYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgIYCl5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Sep 2020 22:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgIYCl5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Sep 2020 22:41:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A77C0613CE;
        Thu, 24 Sep 2020 19:41:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1029424pjb.2;
        Thu, 24 Sep 2020 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+Fa7TES0qQFtjKKrUbNH2/3ScLEheNlCL4wh5wzrHuc=;
        b=uLQ5VcYXupu3R+G/FLJVShMIvw1ceL91yXmzP0Hlu3QGXZ6BOvgDYuip46weZHlUMq
         f+lzVsRX53OHQm79GlTMUfAGhKktu/ll8CEOEbdtqurFg6Sjh0k6WZ/PB5fOXa+8inFT
         s1plxAoUDGoU7Gqu7deTrVLjDredYeVmbri5LfGUv4ZsFckWPvAqdVcq7RJ46Fr13VDI
         9LZ5yR7i+8z42diWCidmJUPyIY7f3tsmtweNdsQXq7LwpA4VxNzJAm22e2XpSeAFI+4M
         noTbvtIy/xDxzz9659wiPSpZsujzn2KhagPee1GJOxikJpDZ5o4kB5XQS6ys2mJWg2a8
         ujJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+Fa7TES0qQFtjKKrUbNH2/3ScLEheNlCL4wh5wzrHuc=;
        b=sE5bT7TuI2q83O/1sDli+eVtSPMI4fCE6GS+JseJpmBIBT8FSAVT7jClx3P0FIYwUq
         5GjQC1xVMOewLPSWM84YaCAKc6I9yW7TXtlMhhc/6qg9HGzJQK+BR9Gk+/eyDTsnRpu6
         81hHYuP6o2Hwn/weF4QR66HnXutoehRzgZ36TixzAk21gMwO18PNTjrvcJEI4cpXlYV/
         jv904IiGPBz+HVDTz1712CLnWtX3p2uiHrSp/IfQDedBuiLebn2Ss3HGjvl0xvW6kpP9
         /C7/8bsnEX8fMSqFEyaGrAV/zaXvD/M6coGmlWFPLRBYs9vkObBYAK5h9PXNWdWYM96v
         EhJw==
X-Gm-Message-State: AOAM5335ngX8lmK6Igez0S0Zs+njStJwvEE/X6gViJyQS9bIaAQzrh6Q
        CoK1MfKdlVdCRuV6C6Mu6RradSmav7A=
X-Google-Smtp-Source: ABdhPJxHaTAcEBxSN7FOFIsLiLjvo6azoNjLoHVZvQ5NfH+juIHmLLGioUyQ8Hsyb/ZadHJ9Teoj5A==
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr638796pjr.82.1601001716334;
        Thu, 24 Sep 2020 19:41:56 -0700 (PDT)
Received: from [192.168.1.101] (122-58-178-137-adsl.sparkbb.co.nz. [122.58.178.137])
        by smtp.gmail.com with ESMTPSA id gg13sm510875pjb.3.2020.09.24.19.41.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 19:41:55 -0700 (PDT)
Subject: Re: [PATCH] ide/falconide: Fix module unload
To:     Finn Thain <fthain@telegraphics.com.au>
References: <df121aff561c73f3ff7d83f906942ed0d954d737.1600997998.git.fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-m68k@lists.linux-m68k.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <9a263780-e123-77ba-32cd-3b667195a463@gmail.com>
Date:   Fri, 25 Sep 2020 14:41:41 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <df121aff561c73f3ff7d83f906942ed0d954d737.1600997998.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

thanks for catching this!

Reviewed-By: Michael Schmitz <schmitzmic@gmail.com>

Am 25.09.2020 um 13:39 schrieb Finn Thain:
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
> ---
> This patch was tested using Aranym.
> ---
>  drivers/ide/falconide.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
> index dbeb2605e5f6e..607c44bc50f1b 100644
> --- a/drivers/ide/falconide.c
> +++ b/drivers/ide/falconide.c
> @@ -166,6 +166,7 @@ static int __init falconide_init(struct platform_device *pdev)
>  	if (rc)
>  		goto err_free;
>
> +	platform_set_drvdata(pdev, host);
>  	return 0;
>  err_free:
>  	ide_host_free(host);
> @@ -176,7 +177,7 @@ static int __init falconide_init(struct platform_device *pdev)
>
>  static int falconide_remove(struct platform_device *pdev)
>  {
> -	struct ide_host *host = dev_get_drvdata(&pdev->dev);
> +	struct ide_host *host = platform_get_drvdata(pdev);
>
>  	ide_host_remove(host);
>
>
