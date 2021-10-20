Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B972AC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 20 Oct 2021 17:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9577460FF2
	for <linux-ide@archiver.kernel.org>; Wed, 20 Oct 2021 17:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJTRF2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:05:28 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:47036 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTRF1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 20 Oct 2021 13:05:27 -0400
Received: by mail-pg1-f177.google.com with SMTP id m21so23038099pgu.13
        for <linux-ide@vger.kernel.org>; Wed, 20 Oct 2021 10:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tZS5mcQ6tFKkPPW3AB3czU0UgwjSHZ6GFDFkF61p8TI=;
        b=4WqvVXeji/+9eRuzC3tINcmsFNTJpCt38JHP1BNwDl9TShUFhM1FKKeJ4EJ1lcsCFk
         l3VGJAjfC/fZctvqEWFj/KZ1cYNCAoCjPT/hui9mqp588cM8PhxQeyK6GHCNRIsFVXAG
         qXi2mPr0CXT4b95YrbQwN/Bj5YzMDCMB+mSZFSDxLId7meMjOOlNkEL/cqjhWKXcYuEp
         qrwPMw4irty4kRNKVb6gI/uu9q2CiZeOCaCbhIP0osGYceNSjgalEj6YeAl5aSUMIEYV
         EuLQGNSRrguEx5rvoADlR3mUPlLPWz9PW0jweyGzC+6PbQXFQviLbK7F1BrG8Kv+05vq
         ph6Q==
X-Gm-Message-State: AOAM5338bJj4l8csSQRgNeT1AjqaQr9W3VIiz56N8WzZR4tS0+H5C8om
        pGoS+Nig74lWi5K4dnZthpKvEz5nIS4=
X-Google-Smtp-Source: ABdhPJzlRaIAdSMAXajzng1Cp7OU3gsex+zqQWasEt8Oc18pFNdCEBltQ69S6K/xh7ZM/sEpN4T75A==
X-Received: by 2002:a63:258:: with SMTP id 85mr350726pgc.11.1634749392561;
        Wed, 20 Oct 2021 10:03:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:200d:62ea:db33:9047])
        by smtp.gmail.com with ESMTPSA id 66sm2981530pfu.185.2021.10.20.10.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:03:11 -0700 (PDT)
Subject: Re: [PATCH] scsi: ata: make ahci_sdev_attrs static
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org
References: <1634639082-1007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <af043ccc-6287-47d4-d5b5-7bbef4e3380e@opensource.wdc.com>
 <59795405-fe7c-2181-b1a0-6beda1963911@acm.org>
 <f4795aee-c29e-1561-fc05-0cc518ad6cfc@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <54b7f09f-14db-6cf7-c9d2-fd8ae5edb120@acm.org>
Date:   Wed, 20 Oct 2021 10:03:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f4795aee-c29e-1561-fc05-0cc518ad6cfc@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/19/21 10:42 PM, Damien Le Moal wrote:
> On 2021/10/20 12:27, Bart Van Assche wrote:
>> The above patch looks fine to me too.
> 
> Can I add your reviewed-by tag ?

Sure. Feel free to add the following:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
