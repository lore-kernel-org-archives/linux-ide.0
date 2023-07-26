Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25816C0015E
	for <linux-ide@archiver.kernel.org>; Wed, 26 Jul 2023 08:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjGZIss (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjGZIsT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jul 2023 04:48:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037DD44B8
        for <linux-ide@vger.kernel.org>; Wed, 26 Jul 2023 01:41:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so20836141fa.2
        for <linux-ide@vger.kernel.org>; Wed, 26 Jul 2023 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690360883; x=1690965683;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjbnNFixw3CqUy+1p99LdaySKRJAH3wBo6V+ARVn8OQ=;
        b=Spk55jjD7C3BXGVRqo8tDI2MATd4Zt3P2nNUwDC+bUuNBLWHKq7Mq2LTnE+IfoUQ0b
         xMPThTgvW28cRbbXVeyinwgw1dngHYzzfLbxT5fxtN6Ty6ViJutRp/igJmKanvRoZ40F
         cwLL9aQQRXRuUCYUPhTJ1sRw2i+oz0JJO2ae9lOa2f86X/BJHlR6ZovXQxOoY8cXIKdY
         1AfX1mwi2hsCTshShI57kId/dWcT1OLyGG+mVWxYcpMDgTowS+EKjO/ja1dH73v2DMNs
         qYuJgUpzdK7tvudpxn5behb4JsAOBpsWMx7JVKdn4Qxn1OauAgxlf1u4Gl1OS649+4kB
         ibbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360883; x=1690965683;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjbnNFixw3CqUy+1p99LdaySKRJAH3wBo6V+ARVn8OQ=;
        b=gvNE/VzjTyibdfN+UVJyVnGBkMNXdacf6ES9uzPXzoyINCbD8uCZIEvkDN/SnImJWJ
         5HoIgR+So3S2Jb+QiDssemjF5eKielFf+lrtLmjxe4k+spOCSFu1yQrFwdDOfutDybz5
         Xu/wqaZ1A/d+NIIZcKedvOeSp2W0BKmrkzK0DPApXt4amD4cb45XTiXWQ85H8gPFI/it
         5I1sIifwgmO1hqJ0+oteYPPDLaNI5DIXZtNa3mGfUNM0qqxGKH84yfDe3tXqODNHlm+D
         1gVpUsV7JMgq1mtytaYh5sNpMLMTbSIATWaE9ut9IocM7/9qPyfn/hmuSjRC7kqz2tiG
         sTMA==
X-Gm-Message-State: ABy/qLYGamWawI4/KZnKSo8gSp4ZRM4Kfgd5B3I0qHPVgDfp4k1ewJl6
        +hAX6d6B34gJ/JP7Y+bb7eBUjA6KwOE=
X-Google-Smtp-Source: APBJJlEOK7GFdYOi/tFQgqJmY+KTeH5QHRqTOc+Iwp01uo4cUNft1JUpWju4csRbBYoewhLUoChKyQ==
X-Received: by 2002:a2e:8455:0:b0:2b9:3883:a765 with SMTP id u21-20020a2e8455000000b002b93883a765mr970817ljh.31.1690360882592;
        Wed, 26 Jul 2023 01:41:22 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.84.156])
        by smtp.gmail.com with ESMTPSA id s20-20020a2e9c14000000b002b94aed74d5sm3975379lji.72.2023.07.26.01.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:41:22 -0700 (PDT)
Subject: Re: [PATCH 0/8] Fix the remaining sloppy timeout typing in libata
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20230616194607.7351-1-s.shtylyov@omp.ru>
 <190e84cb-8e14-8488-f0a8-f809f8640984@kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <3d3fc1d5-029a-e240-eb3f-5aba1614ff39@gmail.com>
Date:   Wed, 26 Jul 2023 11:41:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <190e84cb-8e14-8488-f0a8-f809f8640984@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/26/23 2:36 AM, Damien Le Moal wrote:
[...]
>> Here are 8 patches against the 'for-next' branch of Damien's 'libata.git' repo.
>>
>> The libata code still often uses the 'unsigned long' type for the millisecond
>> timeouts, while the kernel functions like msecs_to_jiffies() or msleep() only
>> take 'unsigned int' parameters for those. I've started fixing the timeout types
>> from ata_exec_internal[_sg]() that tripped the Svace static analyzer and posted
>> couple patches, promising to post a large continuation series somewhat later...
>> in my worst nightmare I couldn't imagine that this would take a whole year! :-(
> 
> Sergey,
> 
> Ping ? Are you resending this ?
> Need a rebase as this does not apply cleanly.

   I need to find the time for doing this...

>>
>> Sergey Shtylyov (8):
>>   ata: libata: fix parameter type of ata_deadline()
>>   ata: libata-core: fix parameter types of ata_wait_register()
>>   ata: libata-eh: fix reset timeout type
>>   ata: fix debounce timings type
>>   ata: libata-scsi: fix timeout type in ata_scsi_park_store()
>>   ata: libahci: fix parameter type of ahci_exec_polled_cmd()
>>   ata: ahci_xgene: fix parameter types of xgene_ahci_poll_reg_val()
>>   ata: sata_sil24: fix parameter type of sil24_exec_polled_cmd()
>>
>>  drivers/ata/ahci.c          |  2 +-
>>  drivers/ata/ahci_qoriq.c    |  2 +-
>>  drivers/ata/ahci_xgene.c    |  7 +++----
>>  drivers/ata/libahci.c       |  7 ++++---
>>  drivers/ata/libata-core.c   |  6 +++---
>>  drivers/ata/libata-eh.c     |  6 +++---
>>  drivers/ata/libata-sata.c   | 16 ++++++++--------
>>  drivers/ata/libata-scsi.c   |  4 ++--
>>  drivers/ata/libata-sff.c    |  2 +-
>>  drivers/ata/sata_highbank.c |  2 +-
>>  drivers/ata/sata_inic162x.c |  2 +-
>>  drivers/ata/sata_mv.c       |  2 +-
>>  drivers/ata/sata_nv.c       |  2 +-
>>  drivers/ata/sata_sil24.c    |  4 ++--
>>  include/linux/libata.h      | 24 ++++++++++++------------
>>  15 files changed, 44 insertions(+), 44 deletions(-)

MBR, Sergey
