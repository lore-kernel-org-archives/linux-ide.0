Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D60C2B9F4
	for <linux-ide@archiver.kernel.org>; Thu, 17 Jun 2021 10:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423ED61001
	for <linux-ide@archiver.kernel.org>; Thu, 17 Jun 2021 10:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFQKdk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231521AbhFQKdj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jun 2021 06:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623925890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVlthFQmQaQdgcXen+woq/2l+gZZsPSJuLyGQkrVMiQ=;
        b=XNw0rsKYArnkoPpBxzNEJLxdXEtIvJaj9seMbgiK8U8Jh3/2hSx0UFIapfLNyxcs6alzjK
        fYFEwY9a+kvYqMZnrac5DIy+ov4vqyx4Qz1CLiuUuzR3YJo52ygeQzZySqcdIECYM84OIg
        uVVmX0usEmyrFsG6uibVws0x1+pHJQM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-qPegDR13N-ClYDxYU74aLQ-1; Thu, 17 Jun 2021 06:31:28 -0400
X-MC-Unique: qPegDR13N-ClYDxYU74aLQ-1
Received: by mail-ed1-f70.google.com with SMTP id ch5-20020a0564021bc5b029039389929f28so1230459edb.16
        for <linux-ide@vger.kernel.org>; Thu, 17 Jun 2021 03:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YVlthFQmQaQdgcXen+woq/2l+gZZsPSJuLyGQkrVMiQ=;
        b=oInLGUOaY+ZbFn/GS4/cFkp7Dg+0R9OsWNdQQ9TGGSDSdKV6ix6YVIyHlxI/jFyr4Y
         EsGU8+SYcJp9Kph5fbQq72IDGb0FA7ZBCAQia+c84GCMrwq3vUUsSkNLW5suX+vqZnqp
         DXqqV72dO6SLPz7RQMnoB3Qt32Ho+JWJpHaWlo92212FuYmRK/vfzbbQiHnDO6GzCyDB
         IRWgV2s7G/26j0YgQBgIwy/tDFEjo8V+fb7/9fo7NeRHmt9wJmW5n5wQcjUcDQoJo/oW
         RlPUzYW+/9Nsxamb4OSO1qmGEimoLVbcXUlFChXKdzmz14380zozxbAF3ZYm1OJ8yiIm
         SbEQ==
X-Gm-Message-State: AOAM531YKsfdmsz20+7kTdsbLyed7Mrsn8RjHZ9Y600/4Z3dDLFMCk+j
        n4osC0U6unUcaV8caJZbSgEdW66D1zjBrcQo+aPxclwpKcEZ2OrJ5eeAqirNDvfsW5LVwtq0nv1
        q1ZP7GjJckaL0VMJ0kAx6
X-Received: by 2002:a17:906:430f:: with SMTP id j15mr4383520ejm.445.1623925887705;
        Thu, 17 Jun 2021 03:31:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1Vp+Q0gq+s4vwko4uNngYufTdyboN4gUP+I2uS7LzKUPO2Ll+jzfw1xQQatxLI3bc8tNmsw==
X-Received: by 2002:a17:906:430f:: with SMTP id j15mr4383511ejm.445.1623925887582;
        Thu, 17 Jun 2021 03:31:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t17sm4169504edv.75.2021.06.17.03.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 03:31:27 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add support for Dell S140 and later controllers
To:     Charles Rose <charles.rose@dell.com>, linux-ide@vger.kernel.org,
        axboe@kernel.dk
Cc:     Mika Westerberg <mika.westerberg@intel.com>
References: <20210615190801.1744466-1-charles.rose@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e7067ad7-07ad-e747-ed18-8587c6b6a2c2@redhat.com>
Date:   Thu, 17 Jun 2021 12:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210615190801.1744466-1-charles.rose@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 6/15/21 9:08 PM, Charles Rose wrote:
> This patch enables support for Dell S140 and later controllers
> that use Intel's PCHs configured as PCI_CLASS_STORAGE_RAID.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@intel.com>
> Signed-off-by: Charles Rose <charles.rose@dell.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/ata/ahci.c      | 4 ++++
>  include/linux/pci_ids.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 33192a8f687d..186cbf90c8ea 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -446,6 +446,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
>  
> +	/* Dell S140/S150 */
> +	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_SUBVENDOR_ID_DELL, PCI_ANY_ID,
> +	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
> +
>  	/* VIA */
>  	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
>  	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4c3fa5293d76..803ec446a729 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -631,6 +631,8 @@
>  #define PCI_DEVICE_ID_DELL_RAC4		0x0012
>  #define PCI_DEVICE_ID_DELL_PERC5	0x0015
>  
> +#define PCI_SUBVENDOR_ID_DELL		0x1028
> +
>  #define PCI_VENDOR_ID_MATROX		0x102B
>  #define PCI_DEVICE_ID_MATROX_MGA_2	0x0518
>  #define PCI_DEVICE_ID_MATROX_MIL	0x0519
> 

