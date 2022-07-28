Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D244C19F2B
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jul 2022 15:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiG1Pqz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jul 2022 11:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1Pqy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jul 2022 11:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BD72683EE
        for <linux-ide@vger.kernel.org>; Thu, 28 Jul 2022 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659023212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EmS7Ccs5/MDTrXLJrSc+o7OHAAYam56AxbLa9GLn+ZU=;
        b=gDrTGCTNDfztSF9bqCmRWA2CEHOTrGvmqNNDOhnY+UxXvSVqUzR22hmLPE0puJBlwMfXXl
        3hgHSZb8JEdalDqEu/ccjtKg1zr5+NkWDYATDXWtKTVF3AqcFZBzWYvcPjOFldzn8z2jAh
        R4sUznVYIlqo+gKfNeyc1gc71Fc7NoI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-Oo54ZcYaPJeOMkNRlFCTdg-1; Thu, 28 Jul 2022 11:46:51 -0400
X-MC-Unique: Oo54ZcYaPJeOMkNRlFCTdg-1
Received: by mail-wr1-f69.google.com with SMTP id n7-20020adf8b07000000b0021e577a8784so518612wra.5
        for <linux-ide@vger.kernel.org>; Thu, 28 Jul 2022 08:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EmS7Ccs5/MDTrXLJrSc+o7OHAAYam56AxbLa9GLn+ZU=;
        b=qVwYvoNEp3jv06kj7gRcQFo2SK5ilHnoNFFWyioNmEsunvwjtl7xjsWLlIK5xMXm/X
         XH/rNp1IBvdRVCAr8WIHKaJBC6HZKVhXS8oO/J3B5L6so7rs3bbUmZdkEtaNGDM16yg2
         5tzu/TlPKlc1XHs+9NV9GHLGMmp+aHzTkYZspYR3kSJ6RJKfwuWT6cPu9nAeqoKRJtqJ
         JlJPXiAE7Pv5Z66fSpBp/+XzLlOZWca8m00SUQZ1g6pDrCCa7i/zSfiKDzKW9d1WT4ac
         jvhWSMHh3idI2SRa+9MNlvtezmfPJDw5/+RUeCTlY4gU1t/7qqizS98SN4VQ+bk2D9ht
         Dq0Q==
X-Gm-Message-State: AJIora9dtt8JltwICfF8eZ/qwSYhjJVWNQzrL/Kbp/rKZPHBaidVOj66
        78GmsVVIh+MBi1woY+1D/fm4QZYiDmWo1FGXqB6ZrmG/Dh5V27iLYJHQX8//G21OUbNTCUQkbUT
        u3f7HA12Lh9QAbhIbHiFo
X-Received: by 2002:a5d:5983:0:b0:21d:a811:3b41 with SMTP id n3-20020a5d5983000000b0021da8113b41mr17047044wri.441.1659023209771;
        Thu, 28 Jul 2022 08:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s0VS35lI0ph/EK1AnHvKNx/cZr0wi1NnS29HmTqj6VWbEHpfbhWdhOTtsyf9vaM8c5Sag/Ug==
X-Received: by 2002:a5d:5983:0:b0:21d:a811:3b41 with SMTP id n3-20020a5d5983000000b0021da8113b41mr17047032wri.441.1659023209518;
        Thu, 28 Jul 2022 08:46:49 -0700 (PDT)
Received: from [192.168.0.104] (ip4-83-240-118-160.cust.nbox.cz. [83.240.118.160])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b0021e5cc26dd0sm1331983wrr.62.2022.07.28.08.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 08:46:49 -0700 (PDT)
Message-ID: <73c1263d-0aad-de5a-ea70-4f86c4257238@redhat.com>
Date:   Thu, 28 Jul 2022 17:46:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] libata: specify timeout value when internal command times
 out.
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-ide@vger.kernel.org
References: <20220726170108.25087-1-thenzl@redhat.com>
 <7d985315-bedb-78e6-a6cc-c18e31ab3c5d@gmail.com>
From:   Tomas Henzl <thenzl@redhat.com>
In-Reply-To: <7d985315-bedb-78e6-a6cc-c18e31ab3c5d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/26/22 19:36, Sergei Shtylyov wrote:
> Hello!
>
> On 7/26/22 8:01 PM, Tomas Henzl wrote:
>
>> Specifying timeout value may help in troubleshooting failures.
>>
>> Signed-off-by: David Milburn <dmilburn@redhat.com>
>> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
>> ---
>>  drivers/ata/libata-core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 40e816419f48..e1f8a01a3b92 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -1578,8 +1578,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>>  			else
>>  				ata_qc_complete(qc);
>>  
>> -			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
>> -				     command);
>> +			ata_dev_warn(dev, "qc timeout after %lu msecs (cmd 0x%x)\n",
>> +				timeout, command);
>    The 'timeout' parameter is now *unsigned int*, please generate the patches
> against the libata repo's for-next branch.

ok, thanks, will do

>
> [...]
>
> MBR, Sergey
>

