Return-Path: <SRS0=07Tt=DB=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D6C2D0A8
	for <linux-ide@archiver.kernel.org>; Thu, 24 Sep 2020 01:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB2C21D20
	for <linux-ide@archiver.kernel.org>; Thu, 24 Sep 2020 01:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD//kS7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIXBbg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Sep 2020 21:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIXBbf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Sep 2020 21:31:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC82C0613D1;
        Wed, 23 Sep 2020 18:31:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j7so727170plk.11;
        Wed, 23 Sep 2020 18:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cK1MHKRYrqYjskSliGEjt6+mSN57/qpKSAsstsuFM24=;
        b=rD//kS7IeFXd9hF2ed31+EIcIBuTITtO+mRjbhaDBwM4TAXB0MI0PKGGSXDx1NHoJi
         kcOOEkJ60oO7Hzpbqfnj8g1YCXDxXqBevUzyD/RH8Q9CmarGXcgY4Evj9girgOhSr6Ae
         cyj09ChE8znNk4N8Qx3oHOIGLbK9ZQmLFOsQmjmWA8xzAgaHD1EQomrQNEe/LzV8HTLB
         NiuM3k2PY+SbIoR/qPP7UM1YKZE5M5pZOcm5sOSKCmWRq0pEh/k1YXgyDMcEA/oqGI1G
         kdiHDoUHXryUR8fUp0hGA/F6XqxAC7//3HTxc1oN4f80mtMCIj+xlq7h1DHVIKu4g18E
         iEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cK1MHKRYrqYjskSliGEjt6+mSN57/qpKSAsstsuFM24=;
        b=PJc2groKBtUQ1GBTbTYylG5ie3Ayl3TjsFTzo2FQHt1l7dXARd4WEzxMwV56yXMwjW
         o/lQ4Bh1tuTbsIixDeii2Ypke4BZNy7SQ/9kGEaMoBTj9oXuiVvFex2rSYPPGz9HVN8B
         cR8lv+qneTxP7XkSxKMbFSegz2hrzyVJF7xOBBrqxFkJaUXaT2IWB8u3CkRet071KP2/
         gd4ATsnrqIOyiydDhaJzbIXebVCsxAUelsVI1WA/Wuu7mPs22S3nWv1UHfbwIOlFCE/c
         Rd4nHNFxkQFQEGY72SzsWKhfu0oYxGd1FecE4Sb9TfOY7qk5/x07wsBOMlm7Hbyq8qPp
         l7Rg==
X-Gm-Message-State: AOAM531lQ6IdfW7UbK5sdcnL+FLnW0NbjMUCI8foe7iwUei4Fx/of23M
        7/Vd1vIsRYovNLjD4SkEh4kVynA8m0A=
X-Google-Smtp-Source: ABdhPJwj6If3BCt+I9dyAdwdKDTg4PKZseGf/Jfv46eNOjjevmvqspHXfp1j6svWXVOATQCGoBbfrQ==
X-Received: by 2002:a17:902:16b:b029:d2:565e:a70b with SMTP id 98-20020a170902016bb02900d2565ea70bmr2427614plb.42.1600911095117;
        Wed, 23 Sep 2020 18:31:35 -0700 (PDT)
Received: from [130.216.45.21] (nmr1-400i.che.auckland.ac.nz. [130.216.45.21])
        by smtp.gmail.com with ESMTPSA id k4sm849011pfp.189.2020.09.23.18.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 18:31:34 -0700 (PDT)
Subject: Re: [PATCH v2] ide/macide: Convert Mac IDE driver to platform driver
To:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <3cf40b9df80a99a3eee6d3af79437016038f0a44.1600051331.git.fthain@telegraphics.com.au>
 <CAMuHMdUOdOkBE72ouk0W_bXnoSTFqLsLKag+2LSRz+Qox6MoxQ@mail.gmail.com>
 <alpine.LNX.2.23.453.2009150945480.6@nippy.intranet>
 <CAMuHMdX1GXMGg1mviE_msM1vx0ZLEKEPT4AacSBjYDzN6sZVmw@mail.gmail.com>
 <alpine.LNX.2.23.453.2009160758350.6@nippy.intranet>
 <alpine.LNX.2.23.453.2009240929310.7@nippy.intranet>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1ae450be-0c26-f9e3-1544-3b58dbbf7e53@gmail.com>
Date:   Thu, 24 Sep 2020 13:29:21 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2009240929310.7@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On 24/09/20 1:07 PM, Finn Thain wrote:
> Looking further at the drivers using ide_host_register(), I see that
> falconide.c is missing a set_drvdata() call, while tx4939ide.c calls
> set_drvdata() after ide_host_register(). The latter example is not a bug.
>
> The pattern I used, that is, calling set_drvdata() after ide_host_add(),
> is actually more popular among IDE drivers than the pattern you suggested,
> that is, set_drvdata() followed by ide_host_register(). Either way, I
> don't see any bugs besides the one in falconide.c.
>
> Regarding falconide.c, my inclination is to send a fix following the more
> common pattern (among IDE drivers), as below. I guess that may prompt the
> subsystem maintainers to make known their views on the style question.

Please do - that is clearly a bug. I must admit I never tried to boot my 
Falcon off a SCSI partition to test falconide module unload.

Cheers,

     Michael


>
> diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
> index dbeb2605e5f6e..607c44bc50f1b 100644
> --- a/drivers/ide/falconide.c
> +++ b/drivers/ide/falconide.c
> @@ -166,6 +166,7 @@ static int __init falconide_init(struct platform_device *pdev)
>   	if (rc)
>   		goto err_free;
>   
> +	platform_set_drvdata(pdev, host);
>   	return 0;
>   err_free:
>   	ide_host_free(host);
> @@ -176,7 +177,7 @@ static int __init falconide_init(struct platform_device *pdev)
>   
>   static int falconide_remove(struct platform_device *pdev)
>   {
> -	struct ide_host *host = dev_get_drvdata(&pdev->dev);
> +	struct ide_host *host = platform_get_drvdata(pdev);
>   
>   	ide_host_remove(host);
>   
