Return-Path: <SRS0=RB9J=7Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A8C433DF
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 13:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52581206C3
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 13:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEyD17Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFCNEo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:04:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgFCNEn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2020 09:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591189481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJrHpg1OL1BtBmaAtK36M9SjSe87ZwCInDPm/vcZ+kI=;
        b=dEyD17VzISIYSoC7w+FCHGwsgynPIVGBOySF77KPZCG+47LCxqW4u2OLJQpJdwdZj5y9wf
        nAHR1o6HHWLibhB8T8xFl4Fb1YbIMP1FdKI/Kdg4QcwESKCZE6wBryf26BORt/VEoT2dok
        WLrNm4+93GMOIgwhnxq6BiitHlH57gM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-5mY55_Q5P9GIxetJ_H41_w-1; Wed, 03 Jun 2020 09:04:40 -0400
X-MC-Unique: 5mY55_Q5P9GIxetJ_H41_w-1
Received: by mail-wm1-f69.google.com with SMTP id l26so852493wmh.3
        for <linux-ide@vger.kernel.org>; Wed, 03 Jun 2020 06:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJrHpg1OL1BtBmaAtK36M9SjSe87ZwCInDPm/vcZ+kI=;
        b=THUYPG7LDPdB0Tvg8V6yehDZJWtoWTcEX3d0c/8RDRaMZLziSin2bNOFosnRFhw0/2
         bshBYsFtsSXFugxhpVRV9Rve9wtO5x1wPsuTKgD89dyrKU2C1MqPk0+qErzk5ZKeOJCm
         uAUye8u4iNU3ftXIRQi/aUupgD1Lrk+pbG6Hp0ofFs3/mkCBoOe/usE4f+J8zea8/PUw
         J8LIiSYMHVy8HBwjCgQHrwP0TXt3PX9BEE6GpuLT5JTwn61Gnz2OhWXuc7Qkfg1QNhZm
         XHbvDVsJAhYDWWAjYMrWcBVuiJyy++rog3sbaJhiFqIy9Twjs2TJZ67k23zWAKkbYo+3
         0xCA==
X-Gm-Message-State: AOAM533zPysskcWkbUqqCcPS9HoKWX8QdZ3HcA3PcyEDSSaX541kc1VY
        lBKunIwMA9rWyjvcGFap4UmXY9rDsU9c+7FZwrpUpMCMpNiXdHsFG9SmScG3rWDhRJuE1fvYxcj
        jXYztOaFUt4JRyXuEYaiz
X-Received: by 2002:adf:f707:: with SMTP id r7mr33172843wrp.390.1591189478985;
        Wed, 03 Jun 2020 06:04:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH4y0ksSVVWNPHpgQOrvjfwbzl9/zKgKN7/IJjGgt7M/4YHudyopsIn+DESEGYBqp7gX0lCA==
X-Received: by 2002:adf:f707:: with SMTP id r7mr33172827wrp.390.1591189478711;
        Wed, 03 Jun 2020 06:04:38 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.243.176])
        by smtp.gmail.com with ESMTPSA id d17sm3794702wrg.75.2020.06.03.06.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 06:04:38 -0700 (PDT)
Subject: Re: [PATCH v2] ata/libata: Fix usage of page address by page_address
 in ata_scsi_mode_select_xlat function
To:     Ye Bin <yebin10@huawei.com>, axboe@kernel.dk,
        linux-ide@vger.kernel.org, hch@infradead.org
References: <20200603123924.135160-1-yebin10@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18288afe-efea-a670-c9da-3827f4f2ec0c@redhat.com>
Date:   Wed, 3 Jun 2020 15:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200603123924.135160-1-yebin10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 03/06/20 14:39, Ye Bin wrote:
>  	if (!scsi_sg_count(scmd) || scsi_sglist(scmd)->length < len)
>  		goto invalid_param_len;
>  
> -	p = page_address(sg_page(scsi_sglist(scmd)));
> -
>  	/* Move past header and block descriptors.  */
>  	if (len < hdr_len)
>  		goto invalid_param_len;
>  
> +	if (sg_copy_to_buffer(scsi_sglist(scmd), scsi_sg_count(scmd),
> +			      buffer, 64) != 64)
> +		goto invalid_param_len;
> +
>  	if (six_byte)
>  		bd_len = p[3];
>  	else

You should not check that the number of copied bytes is 64; it will be
less than that in most cases (because CACHE_MPAGE_LEN+8+8+4-2 is less
than 64).

How did you test this patch?

Thanks,

Paolo

