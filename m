Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C7CC432BE
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98EF60C40
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 15:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbhH3PGw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237471AbhH3PGw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2021 11:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630335958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/eY6MBBGnoc9ZGH1Ximi++6G4BBsWfaRYMnOxmNy4U=;
        b=N4aQKc5UsokBg1kY5Aoayn8aXTeN9jK6kpABYnFDhXnhV9meoQm3SHXKvZjf+2V2K/WYT+
        VUguY9oH7BNIieY+2j0J7w6GpODqfOQ0eN+xEOgqxGoB51aNhftMfKmgKaQB82EoVEYpyS
        ShZgQb0BJopc4Rs8R8u2xKSzx4BM1Jk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-uJ_JeT8cNEuOUEpNgjkkug-1; Mon, 30 Aug 2021 11:05:56 -0400
X-MC-Unique: uJ_JeT8cNEuOUEpNgjkkug-1
Received: by mail-ed1-f70.google.com with SMTP id d12-20020a50fe8c0000b02903a4b519b413so5541695edt.9
        for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2021 08:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B/eY6MBBGnoc9ZGH1Ximi++6G4BBsWfaRYMnOxmNy4U=;
        b=tOy/vjsVH76AuPKwzpVr04jMFdvwefNDy6xLBEgnxPQaNyY98kkwWEORi/zvZHMMr1
         Cjrg4tS006cih62juOsziLIH9Ym79nTYcS/vCI72ChVzUjx1ueMBeyXPn262pvHgrcZu
         U8MtCNj1M+rv/KiPlNlOr2L2ySq0Oxost78fdv+SVB5IhxdraCqPavN+6mpCgH1y87SK
         sHHUy5zIoOnr8VkqhPZ8vZOHVNyPkYE+3I32c1M5jIiwvAiMAnCOhfna5u1y+ekZPLyH
         em9cIdzVc0byRCw0oqshih7rt8Ij0jT2lgTslF/zxagpVqf5nuOchR4swcgFjZsoCbGe
         d2ig==
X-Gm-Message-State: AOAM533gr43XNbJnyajKQSv+IhQuLbVCdrmGnUQkAR8WC4uePqUdSzAw
        TgwcMwQYicmjtmNAdyz24Oq8eiiv8xN8fsIbRmDY/Pd+id+SrrOZzWI8Ya4NXTqbULbEHTO6WHi
        hE0MuUDKLlBlNjRU3xS+3
X-Received: by 2002:a17:906:1ec9:: with SMTP id m9mr26346163ejj.115.1630335955533;
        Mon, 30 Aug 2021 08:05:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsw0gUJqPRcAYUZDNvgJ7oZRWoF/ixLkYQw02ic/Xu0lKjevOM15d0b01zVw0oIKHNX3VFeQ==
X-Received: by 2002:a17:906:1ec9:: with SMTP id m9mr26346147ejj.115.1630335955369;
        Mon, 30 Aug 2021 08:05:55 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id i13sm7787381edc.48.2021.08.30.08.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:05:55 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung
 860 and 870 SSD.
To:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210830144253.289542-1-hpa@redhat.com>
 <20210830144253.289542-2-hpa@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <54f63e11-e421-0fa6-80e1-297287dc0974@redhat.com>
Date:   Mon, 30 Aug 2021 17:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830144253.289542-2-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 8/30/21 4:42 PM, Kate Hsuan wrote:
> Many users are reporting that the Samsung 860 and 870 SSD are having
> various issues when combined with AMD SATA controllers and only
> completely disabling NCQ helps to avoid these issues.
> 
> Entire disabling NCQ for Samsugn 860/870 SSD will cause I/O performance
> drop. In this case, a flag ATA_HORKAGE_NONCQ_ON_AMD is introduced to
> used to perform an additional check for these SSDs. If it finds it's
> parent ATA controller is AMD, the NCQ will be disabled. Otherwise, the
> NCQ is kept to enable.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201693
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/ata/libata-core.c | 24 ++++++++++++++++++++++--
>  include/linux/libata.h    |  1 +
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c861c93d1e84..36c62f758b73 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2190,6 +2190,8 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>  			       char *desc, size_t desc_sz)
>  {
>  	struct ata_port *ap = dev->link->ap;
> +	struct pci_dev *pcidev = NULL;
> +	struct device *parent_dev = NULL;
>  	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
>  	unsigned int err_mask;
>  	char *aa_desc = "";
> @@ -2204,6 +2206,22 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>  		snprintf(desc, desc_sz, "NCQ (not used)");
>  		return 0;
>  	}
> +
> +	if (dev->horkage & ATA_HORKAGE_NONCQ_ON_AMD) {
> +		for (parent_dev = dev->tdev.parent; parent_dev != NULL;
> +		    parent_dev = parent_dev->parent) {
> +			if (dev_is_pci(parent_dev)) {
> +				pcidev = to_pci_dev(parent_dev);
> +				if (pcidev->vendor == PCI_VENDOR_ID_AMD) {
> +					snprintf(desc, desc_sz,
> +						 "NCQ (not used)");
> +					return 0;
> +				}
> +			break;
> +			}
> +		}
> +	}
> +
>  	if (ap->flags & ATA_FLAG_NCQ) {
>  		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
>  		dev->flags |= ATA_DFLAG_NCQ;
> @@ -3971,9 +3989,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "Samsung SSD 860*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> +						ATA_HORKAGE_NONCQ_ON_AMD, },
>  	{ "Samsung SSD 870*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
> -						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> +						ATA_HORKAGE_NONCQ_ON_AMD, },
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 860e63f5667b..42e16114e91f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -426,6 +426,7 @@ enum {
>  	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
>  	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
>  	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
> +	ATA_HORKAGE_NONCQ_ON_AMD = (1 << 27),	/* Disable NCQ on AMD chipset */
>  
>  	 /* DMA mask for user DMA control: User visible values; DO NOT
>  	    renumber */
> 

