Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2D4C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 26 Nov 2021 19:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhKZTs6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 26 Nov 2021 14:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbhKZTq5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 26 Nov 2021 14:46:57 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE2C061574;
        Fri, 26 Nov 2021 11:27:33 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y26so26473475lfa.11;
        Fri, 26 Nov 2021 11:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O1kK9AYBtc9AD0KhODE7NvT+qyLPdaRS8n6Xu3GYNXw=;
        b=N1PRWlXx8pANbj2NPlTiFayoeMPh+egborEJg1CHEWS4T9yk/adQRe6+QCzUZQ6MmN
         WvtMl2kAOP7xFb8hFb9LJ5UegafHCsOwlMoTuvyy7pm6LUorAW9q87DHBc6eUlHgGgxf
         3Dqa7Pcv1e4TpqvAR4zeCIR4nCNalsOwQh3wt5Gw49/fBmE3kcxsSE5PEgFXE8zqJdBn
         RNXcG631LSVnNsHbmkJxT8d0B29g0ScP020YoYZikbVOTOtuo7oWpzxQ+7MrqjySUz/m
         E3OLLuJNBcA0ZTWzczJ0bjsJgngSsUXNp5IF8KtZuqGSZLnoWSCZ+VXocUNDrS/somke
         QlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1kK9AYBtc9AD0KhODE7NvT+qyLPdaRS8n6Xu3GYNXw=;
        b=pOrCMh/YePxT3dy95KxJfoRGNIQn2lD1WRBZ6dEQ5sLNgKakHTXZe2gvlDKIFwxfh8
         Y0FvxIvE5z1yvlGdWaIrTIut0WYy43uv29pw/ApvaOmWUNL14ZWcvg+bJjjyvSGf1XoC
         3ifXn+CndiQ6IGdnu6SapGBgNrqaZF+ygTmkhllBeBEkLlnzHdTBfeZB6txdYJ+Z+tU5
         degwkIruIS0+MyXDOFjDMeBH1KDOjmv/MwUvs8MITkqwxuYOosUuxyU5Ja1Zz3dDJtTJ
         OvboAUC/kuqwRCc5y5fGEKPvfhNhf1axPnnUy+whDqGlgesYPQfntBrfm4sqZ5XDuWmJ
         IPiw==
X-Gm-Message-State: AOAM533fn3O7DwRGV/cqy6N95ZTEoNNzCO3zaX3JO5guaGDsxdbRQtR2
        EbN6zNcvR01OqASsWPRb7F20638x6jQ=
X-Google-Smtp-Source: ABdhPJwsAOi539yLJqNfE5zyJYLxjjvJ1laZK+5s4ZfumYwXzUr5B/hLGXjZ6PwZEC6MzWPg7sf1cA==
X-Received: by 2002:a19:4f02:: with SMTP id d2mr32018081lfb.547.1637954852084;
        Fri, 26 Nov 2021 11:27:32 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.184])
        by smtp.gmail.com with ESMTPSA id a30sm565161ljd.134.2021.11.26.11.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 11:27:31 -0800 (PST)
Subject: Re: [PATCH -next V5 0/2] fix two bugs when trying rmmod sata_fsl
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Baokun Li <libaokun1@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com
References: <20211126020307.2168767-1-libaokun1@huawei.com>
 <4469be5f-01a9-5d10-9dc3-b703f36a1ea4@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <52d961ae-e4e0-00fb-0753-518125edc560@gmail.com>
Date:   Fri, 26 Nov 2021 22:27:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4469be5f-01a9-5d10-9dc3-b703f36a1ea4@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 11/26/21 4:56 AM, Damien Le Moal wrote:

>> V1->V2:
>> 	Fixed the check on the return value of platform_get_irq().
>> 	And propagate errors up to sata_fsl_probe()'s callers.
>> V2->V3:
>> 	Add fixed and CC stable and modified the patch description.
>> V3->V4:
>> 	Use a single structure.
>> V4->V5:
>> 	Delete duplicate dev_err() message.
>>
>> Baokun Li (2):
>>   sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
>>   sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
>>
>>  drivers/ata/sata_fsl.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
> 
> The series looks good to me now.
> 
> Sergei ? Are you OK with it ?

   Yeah, I'll just give the patches by Reviewed-by's.

MBR, Sergei
