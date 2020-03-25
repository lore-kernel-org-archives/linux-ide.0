Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5924C1975A
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08B2076A
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 15:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xTFEUvOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCYPRW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:17:22 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:36936 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYPRW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2020 11:17:22 -0400
Received: by mail-pf1-f177.google.com with SMTP id h72so1186945pfe.4
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2020 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=++0iFUNY9Jnnau0pEJ4qqnLzGiAu+s2s37bTG1dtEgk=;
        b=xTFEUvOun2OiMiKCJNgehzrkNbDS1OpGwWoMTe83qLEaH1Dd2WGogKlVNzSk4KZb2S
         tLo1AMBA6ZJxxg7ALrCLUAYDQyRTXS6Uko7bhOoeCgkgsLvF+0IRmAQKTaukovxNBlG4
         2v7EtCMvvYnpZ3GyVUR4JmmFyErdmHWC3/kkLL3K0rqsrbXJUUhFQS+gmJrxk8TA/YBE
         7WfNVFCHrLSBg8PFVYwMqXrfMI1/TorV0aiTDn+UGu6BPwCdoua8ELgFWtKkfsBznHV8
         3lefOKSuBLmndeYZVr/UQF4ik0nvB2Wbb4nR7/xiVv/o0+AMdaZPt+3Hlekh3FiOMHXe
         Io8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=++0iFUNY9Jnnau0pEJ4qqnLzGiAu+s2s37bTG1dtEgk=;
        b=Qe2OLwuRcw5Oltka+iuwfUBgUvgUNaYUpnJGUFd712MnpfNTUBOou1KnJqNzDIR8sB
         g6IcRYVsZroh1U4DozGWB/SYEd05T9vsI2ou4LKLY1hGAXnQGHxpyr25YmR0Bc6vjzKv
         MLpPRdyQV7XRS1sBTR4BTaAkmEdH4Zwi2rslgHH4lu0cH/eDgerrPDPjj/JG+qi5xZye
         QXpIdUL6OXcXHKANVvsTouBvMsrwMI8R4bWb8SbblD0nq1CmbIXFe1VNvinbZ0GoT9+C
         qU5xCJoJXfP/vXI5l34hZiBam9+ELUPFVBi5982mOo6FPRXuJJzYLvvkHxXsQcGnwxWI
         /n9A==
X-Gm-Message-State: ANhLgQ2swyXGW9HLWjDIaxdnYdJHncA4i3fBZrsCWvA5PKJ6XAbRg0In
        o54ZhIT8mlg9lOqUQOZ9HSO8wwhvOFzQiQ==
X-Google-Smtp-Source: ADFU+vuPQe9RNwTf5aZ1K9CnJhW4cez3XzifN47z7BtwFCrJgDOSVzZr51t3fscCxjPt+tBJIQhhYw==
X-Received: by 2002:a63:c212:: with SMTP id b18mr3460770pgd.92.1585149439094;
        Wed, 25 Mar 2020 08:17:19 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id t63sm775624pgc.85.2020.03.25.08.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:17:18 -0700 (PDT)
Subject: Re: [PATCH] sata_fsl: build fix
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
References: <CGME20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81@eucas1p1.samsung.com>
 <98bf5f87-3601-efd5-57ce-58e6db308e95@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87a9e403-efd2-5464-9e8c-4d966ed1ab39@kernel.dk>
Date:   Wed, 25 Mar 2020 09:17:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <98bf5f87-3601-efd5-57ce-58e6db308e95@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/20 9:15 AM, Bartlomiej Zolnierkiewicz wrote:
> Fix incorrect DPRINTK() conversion in sata_fsl_init_controller()
> (dev_dbg() should be used instead of ata_port_dbg()).

Thanks Bart, another piece of fallout. Applied.

With the recent discussion as well, I wonder if we should just kill
this series entirely.

-- 
Jens Axboe

