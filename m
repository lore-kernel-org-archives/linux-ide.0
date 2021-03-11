Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89CAC433DB
	for <linux-ide@archiver.kernel.org>; Thu, 11 Mar 2021 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE0164FA6
	for <linux-ide@archiver.kernel.org>; Thu, 11 Mar 2021 15:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhCKPMd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCKPML (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2021 10:12:11 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F05BC061574
        for <linux-ide@vger.kernel.org>; Thu, 11 Mar 2021 07:12:11 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u20so22237322iot.9
        for <linux-ide@vger.kernel.org>; Thu, 11 Mar 2021 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8uzWR98tr30jTjAvujuKHcBKWh4iZ4wgejl+7WugCPs=;
        b=Fcy+PPYqjKJEoxOQ2vElnvB1kN93O7t/tAbO2fozxIuJSzwELE6AeFpO8Fqz2FQE7s
         m4FICO3nlvO00TFPAkSntfmWcCl0QIGQ4gTWf7aOcF1fliF86HnKTAoF8YMVYGkTzpeM
         gi8WZ6pOBLsF5MYtqBJDo/zx/GLLTQz9cUn/dMDEHgnBsOI0O2gp7Ivvh0/svwbLCPGv
         0VVBMwCegLfiFBAjGOMuE2r99gwnqqa8KuvxJcPS0c9+3xoFQY6vyHsiKqIwfV/F34n7
         0/ZYJQfT/af/RTrovanNMwfVJBDYSA0uXkwIMtrX3ehf/LKEnOcj7sm/MNnqAIpRZFZI
         jtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8uzWR98tr30jTjAvujuKHcBKWh4iZ4wgejl+7WugCPs=;
        b=W6HmpRTPkaBWuhMONq0KxDyiIeCFEHjURLpj2xNrz4wga+CA0QuQ2n5mv+W6ZVM6vv
         UaN3TUxkq6+/T9dD57RXIEgig/x5BIErdVJJBt+2h1C5ByOYNlstlTjcOgT70xX80B/+
         sshRJq8S/M0QHHyr2Yf0Wku6f/OqvTrex4/N7IlCvebd+wLh3/D6so+ZRydxWlK46UzV
         ULx5wX9oZOszMlYlSITur+RDWJ+mpxrVwFBljNv92iYfxyjtygMI2c26uhz+7T8WwvKa
         B3ISYZk22R8QQQVj3iHcPRw7o9T0n3MPJXetYwWXcBXIyPtG2G2NOOOwfPuddjj1NDQ6
         lcsw==
X-Gm-Message-State: AOAM531qAKP4Vf/ZoQjKMrcRIRA6n+Ev4VsuvaAz7VbR5AxYS+X62QIK
        3smGV57TxOn298zpJVA7CRJX6TP/wCpkRg==
X-Google-Smtp-Source: ABdhPJz1TleSAlCcpEHwXGi4dk1lb/CpLc/h59zEp0RM2ifcqF9OCZ03Hcn2cdJEzumDie7ZXCG3zw==
X-Received: by 2002:a02:cb48:: with SMTP id k8mr4118806jap.52.1615475531036;
        Thu, 11 Mar 2021 07:12:11 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m15sm1369443ilh.6.2021.03.11.07.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 07:12:10 -0800 (PST)
Subject: Re: [PATCH] ide: fix warning comparing pointer to 0
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        davem@davemloft.net
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1615456086-127803-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <034a3feb-27b3-a349-6dcf-75cb36a34e23@kernel.dk>
Date:   Thu, 11 Mar 2021 08:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1615456086-127803-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/11/21 2:48 AM, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/ide/pmac.c:1680:38-39: WARNING comparing pointer to 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/ide/pmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index ea0b064..d5171e0 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -1677,7 +1677,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
>  	/* We won't need pci_dev if we switch to generic consistent
>  	 * DMA routines ...
>  	 */
> -	if (dev == NULL || pmif->dma_regs == 0)
> +	if (!dev || pmif->dma_regs)
>  		return -ENODEV;

This looks utterly broken - the warning is most definitely about
dma_regs, not dev, and you swapped the condition (failing on dma_regs
being set, not NULL).

I'd just leave this one alone, drivers/ide/ should be going away soon.

-- 
Jens Axboe

