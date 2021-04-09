Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2958EC433B4
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9674610CA
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 16:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDIQt1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIQt1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2021 12:49:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA2C061760;
        Fri,  9 Apr 2021 09:49:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o16so7235335ljp.3;
        Fri, 09 Apr 2021 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xAsumXJcN6syFj5poypQyxoqwQFWcqyC5WGT/xKy8v4=;
        b=dJ80Iu1K+1KISllpH7SXcFnmNUi4Olh2nwoYJdg+3Jmqrxw+kNW7BYEx3Yt4UjHujl
         vEW30Cv1uER0WCu6vvbZTbTLbqTwTGeBEwlovEkjPTIXAi90fYc6tH80NifAlGy7xpPg
         6DcAG/8ZIUbeo57xrpdOnveCgsMJSUiq1JGNWDWZVg2yn08NXLe/EPQWAKO+waeJKggR
         VvC36R7Zp5+IP46nJFbBsJHw9h52cUu3JzvD1ANAJF+lzaIgSQnfNmX1BZBc53swj2qY
         k6/SmcLCa18maufnLAblP2GidMZ96961HniFyoxGgDtKHi9rMiXt5kA/j2ukyTCFtdAq
         YJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xAsumXJcN6syFj5poypQyxoqwQFWcqyC5WGT/xKy8v4=;
        b=GDUncW1RK4eZIooUkzn8vZXlZlOK73HiGPqYJ0aj82P97jspf8KqMRVyPhL0dhAHao
         9sxdqU49W7/D7COpRIZbGEk30soMmL0L2XPQlMIKKAaZcrUCqLEevjkvdLSSyboVl6jG
         Zzo95nB8ZZp9DeVOlSfk0lAnm1kgr9QaTGnxJ0cbunAkQqKe4GeJ9/jXLfN6Np8bFNFB
         UV34PhXSpsZdZAAL+ZPrcXzGn4GUdLxbGVVnBsiyrcOCX2MuouaPXgXCmdAqOHjJXBFc
         fntmKKQWG7Mx7D6WSuPFJxIgEEac5D8O0KEieSQQSBLI69V1rEl3FJKziuCAMAg3+cuN
         Pj7A==
X-Gm-Message-State: AOAM533udxrS0pMYMOan7mJFAya5ZBeOHd1VISeD8dyuEhMwfWM1O7DM
        s6ZTpnqXk/8aYbArmqnyZSpxOCbjmR8=
X-Google-Smtp-Source: ABdhPJy0XbOvDQs4D3oQlaBO/S+FVPUXNXvi9pu/oPNkB3OLJspOwEWOQqiQYV64XLjxVMWXcTiVag==
X-Received: by 2002:a2e:8e75:: with SMTP id t21mr10030228ljk.216.1617986950569;
        Fri, 09 Apr 2021 09:49:10 -0700 (PDT)
Received: from [192.168.1.102] ([178.176.73.141])
        by smtp.gmail.com with ESMTPSA id m3sm334127lfo.190.2021.04.09.09.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 09:49:10 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH] pata_ipx4xx_cf: Fix unsigned comparison with less than
 zero
To:     angkery <angkery@163.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
References: <20210409135426.1773-1-angkery@163.com>
Message-ID: <e74ec570-96b6-23ce-edd5-b5a38628963a@gmail.com>
Date:   Fri, 9 Apr 2021 19:49:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210409135426.1773-1-angkery@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/9/21 4:54 PM, angkery wrote:

> From: Junlin Yang <yangjunlin@yulong.com>
> 
> The return from the call to platform_get_irq() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'irq', so making 'irq' an int, and change the position to
> keep the code format.
> 
> ./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
> WARNING: Unsigned expression compared with zero: irq > 0

   I'd understand < 0... but > 0? What tool warned about this issue?

> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> ---
>  drivers/ata/pata_ixp4xx_cf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
> index abc0e87..43215a4 100644
> --- a/drivers/ata/pata_ixp4xx_cf.c
> +++ b/drivers/ata/pata_ixp4xx_cf.c
> @@ -135,12 +135,12 @@ static void ixp4xx_setup_port(struct ata_port *ap,
>  
>  static int ixp4xx_pata_probe(struct platform_device *pdev)
>  {
> -	unsigned int irq;

   Oops, not sure how I missed that. :-/
   Thanks for fixing my overlook. :-)

[...]

MBR, Sergei
