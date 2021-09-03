Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3AFC433EF
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138CA61059
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 14:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbhICOEY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347765AbhICOEY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2021 10:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630677803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tZE3LmZD6jqJSuh20CcZIArD1TpiWN9qz/c9VBYUjE=;
        b=EO+xthW0qlR/rBUUGhl54UsHIGBixi3g2NETrx3ww8YO3BfmCNULfKZUmIJpsZ8Y2Avu0F
        dVmHxNQ8e48xjzWh+Ngx6+e5nEe9HDbv2RZ35rh7ok32ZcD9mFny0vLTgLvg6x5JZZNVc4
        x5oFuVZYMp7ww4t8Fehc/fd0iUEfKII=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-keFchGEQMtquPoWGm2Ef4A-1; Fri, 03 Sep 2021 10:03:22 -0400
X-MC-Unique: keFchGEQMtquPoWGm2Ef4A-1
Received: by mail-ej1-f69.google.com with SMTP id o14-20020a1709062e8e00b005d37183e041so2737486eji.21
        for <linux-ide@vger.kernel.org>; Fri, 03 Sep 2021 07:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tZE3LmZD6jqJSuh20CcZIArD1TpiWN9qz/c9VBYUjE=;
        b=ipud1Qjj71d8Qto9pfsdST+gmefsFY9TIbL6IdRZI3QtJyKomZ5WKMkDHWFCrG1EhM
         Zc1+xMhVbfmGWMKghhvFgYDQqiLQp5dYJRDZ5TCeZcXdbZBxjrgfHinbOuiYRh/D5QeN
         qAkmk0pr5fLBUB1C3jzSX22W0kBMMIE8BBuBKlY5cVx4/sVC5QOkrxBk+GelTHqRLU5m
         xdOz1PFbURtTvNDJQbfVKPfDE5qzdAD98NnKxEOKeLEkg+hAcA7WVIWnxnSIWnpxWRKg
         Z/vU2C8rwcJNnqcqRxow2VsZ/iTJF3DrAdNAUX6n3McF9JWkaQKOnCtGuBrhJFLsJ4BZ
         yC/g==
X-Gm-Message-State: AOAM531nAtHmTx1/SVgzipZHna0LG4VTBjX9crBtJst52Fj32GAGq3Z4
        MZUYHsGUrf1ryy/CMtgnUp6d4PnZCRRhHLNiBpCN0L2Lurn8HCgR221o+oqKbaUjtSJEqnNAFwc
        O4SzJO5rXlORvf0IIbWtX
X-Received: by 2002:a50:c88d:: with SMTP id d13mr1095274edh.392.1630677801419;
        Fri, 03 Sep 2021 07:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaCT7porsj2UGCGGzKrIMKLimH7h15q/Y8kNosd15RnIz+2gAay6cGCFAoOpdy7q73eWTSDA==
X-Received: by 2002:a50:c88d:: with SMTP id d13mr1095259edh.392.1630677801279;
        Fri, 03 Sep 2021 07:03:21 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id bq4sm2832420ejb.43.2021.09.03.07.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 07:03:20 -0700 (PDT)
Subject: Re: [PATCH v6] libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860
 and 870 SSD.
To:     Jens Axboe <axboe@kernel.dk>, Kate Hsuan <hpa@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210903094411.58749-1-hpa@redhat.com>
 <d3488035-d269-2a63-f958-746f371cf490@kernel.dk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f1f0b799-6676-ae06-6a71-05dfeeab8512@redhat.com>
Date:   Fri, 3 Sep 2021 16:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d3488035-d269-2a63-f958-746f371cf490@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 9/3/21 2:35 PM, Jens Axboe wrote:
> On 9/3/21 3:44 AM, Kate Hsuan wrote:
>> Many users are reporting that the Samsung 860 and 870 SSD are having
>> various issues when combined with AMD/ATI (vendor ID 0x1002)  SATA
>> controllers and only completely disabling NCQ helps to avoid these
>> issues.
>>
>> Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
>> SATA adapter vendor will cause I/O performance degradation with well
>> behaved adapters. To limit the performance impact to ATI adapters,
>> introduce the ATA_HORKAGE_NO_NCQ_ON_ATI flag to force disable NCQ
>> only for these adapters.
>>
>> Also, two libata.force parameters (noncqati and ncqati) are introduced
>> to disable and enable the NCQ for the system which equipped with ATI
>> SATA adapter and Samsung 860 and 870 SSDs. The user can determine NCQ
>> function to be enabled or disabled according to the demand.
>>
>> After verifying the chipset from the user reports, the issue appears
>> on AMD/ATI SB7x0/SB8x0/SB9x0 SATA Controllers and does not appear on
>> recent AMD SATA adapters. The vendor ID of ATI should be 0x1002.
>> Therefore, ATA_HORKAGE_NO_NCQ_ON_AMD was modified to
>> ATA_HORKAGE_NO_NCQ_ON_ATI.
> 
> What's this patch against?

linux-block/for-next + my pre-cursor patch from here:

https://lore.kernel.org/linux-ide/20210823095220.30157-1-hdegoede@redhat.com/T/#u

Regards,

Hans

