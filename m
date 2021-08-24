Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B99C4320A
	for <linux-ide@archiver.kernel.org>; Tue, 24 Aug 2021 16:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E7561212
	for <linux-ide@archiver.kernel.org>; Tue, 24 Aug 2021 16:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhHXQMd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhHXQM1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Aug 2021 12:12:27 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369BCC0617AE
        for <linux-ide@vger.kernel.org>; Tue, 24 Aug 2021 09:11:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a15so27030192iot.2
        for <linux-ide@vger.kernel.org>; Tue, 24 Aug 2021 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JAsKRN3bly1YA9bPZ1MQXzadV3alLJQ6BFvBOznMdfc=;
        b=x3t6Igle4xKMrUrFP1IGFtgXi7yZDPeXMHU921icvD2kUSHfH5Jl24+zfhqRqO3o9+
         ianmQOi2yUAqYoK5Kko4euXqWgeVm72XpNCa9W3yC+eMiKZlFV1zmDEH42C6d1OiKEH9
         xNj0pJZKY/7n1mqxIi7fRWl8Apv4imnWEnoDgjvKWg3VI/EU0Go1mEPNryiuvl/UI9N8
         RQkj/ULEz6ayHGZXW4qIfMC761BSC3cm5rr3+Kma+/KA5pgrv59/KaZeO+DkZpOifwOV
         H01dakL9VQp+jwhHN+Qi5z0RLVL1WvYLsax0t1PLE7QlAPobcmSO+8aiqEiGc1Zo6pao
         syOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JAsKRN3bly1YA9bPZ1MQXzadV3alLJQ6BFvBOznMdfc=;
        b=guLFQHXgwgt55f580SzUwqKLKPCPoJou6tDodiqEUacUHQbho7PHlCwoF3zl/4NqpW
         1BXzHDAN3PrVqBkJ/oRIah8HZx9fAeladn1H6tTIcu5xQPpMbDqLor+uEi4KVY9vdW1/
         Fz5TeiidtqvrbK1mkFPwNsTfe8nC3b0lZElAjnSoU67d26QJPYKHN+RkvdPyC5J35hH8
         kgxE/mMslItBiPF1B1/k3WHS2zNz5nxv0zpN6dYWJu81P+VA+r7FlMpgZOKqXNAPPL9h
         5XWa2A551KUc+V+u6/SblqGm7L9A7kONbuy42/Al6A1txjO9YlwPLkscGC9yBgm9h37k
         XEIw==
X-Gm-Message-State: AOAM533kYk344Jc/Ws3gHXP+DIrrnRko7cSk24aRO5AUMuEHDcMHbKiV
        QRtw1so5klcfYs0zV2gecRSmqA==
X-Google-Smtp-Source: ABdhPJxQezq6YEXGwvgGJIGh/xG32FXNToJF3KRwkIcbaEuNSf5vCd8mqCG2RRAUXTX6XqrUVvhpPw==
X-Received: by 2002:a5d:9592:: with SMTP id a18mr30914809ioo.168.1629821501641;
        Tue, 24 Aug 2021 09:11:41 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v5sm10014577iln.42.2021.08.24.09.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:11:41 -0700 (PDT)
Subject: Re: [PATCH linux-next] include:libata: fix boolreturn.cocci warnings
To:     CGEL <cgel.zte@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210824060702.59006-1-deng.changcheng@zte.com.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fe2fc07-bd1c-32bd-138d-a04cf4c5e489@kernel.dk>
Date:   Tue, 24 Aug 2021 10:11:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210824060702.59006-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/24/21 12:07 AM, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> ./include/linux/libata.h:1462:8-9:WARNING: return of 0/1 in function
> 'ata_is_host_link' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.

Applied, thanks.

-- 
Jens Axboe

