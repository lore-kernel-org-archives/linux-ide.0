Return-Path: <SRS0=h3CG=7R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C959C433DF
	for <linux-ide@archiver.kernel.org>; Thu,  4 Jun 2020 11:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A1C206E6
	for <linux-ide@archiver.kernel.org>; Thu,  4 Jun 2020 11:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNTi5UZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFDLEX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:04:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29805 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726337AbgFDLEX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jun 2020 07:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591268662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mehVpAUvWzUzwnjVWDUxrI2iJus7+/jOjkVrnetPdck=;
        b=VNTi5UZ+tEZxKrfFpxTFMO+GV+kVjL1CvTTw53+Vmt5BO3HGZ4v4PbZWDQEIoXfiXvModh
        JXL4yG9JT1xGhPEjbXfkfl9TZKEufeE4miq6ebVBrJmJoHXNmYqekeS8nKE2Q+x+N9qztb
        7HNq102eiZ/aME2HJT+VNtTPpA93+qM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-V7PdJmJ_O6eBXOteTwTeGw-1; Thu, 04 Jun 2020 07:04:20 -0400
X-MC-Unique: V7PdJmJ_O6eBXOteTwTeGw-1
Received: by mail-wm1-f72.google.com with SMTP id 11so1683871wmj.6
        for <linux-ide@vger.kernel.org>; Thu, 04 Jun 2020 04:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mehVpAUvWzUzwnjVWDUxrI2iJus7+/jOjkVrnetPdck=;
        b=oRPFiAsKjDruOfLzwnfQwqONKIHWKBtj7n95ziPBMtZ/+qwoZFvwQmle1Y1O0yJZtr
         dvR8oD7bKAzmxn0rJRkjdH8GNtQEaxYpsXj3koMtpsWi6ufFY5dy7WPfRPV13nfOJgRl
         2uzPtsvgMVnPuHpUvYBZQoNbzgtUL+d6kcL+ug7qseGYIi5PHV5Rd43/GmHIcJYP067e
         ez1ohYEEdbIegropU7oB4IXtj3feOLC4bEP6epGwOSYi28Cl6CQXotaVqOvNhG87RL9w
         iEQhWTGPdnFDn+7nwYvmagIzg/VIHKxchiAresJMihcb3SL6a+gWhBVU2oBFzhJWmDLl
         3NLA==
X-Gm-Message-State: AOAM533cj9zasfPQMZ6q6aSepkTGcKXHapuhA272THUZFUdxqjzndNCz
        6ZwfvIxLBOB5iOTCEPrRuvPmhG8xUW907+Cjvw48GrlrJCpMHZ7mBxd541pcSZ6z5USZ5dB3myB
        UgdgD9DUu4aBksA4Gi2Ul
X-Received: by 2002:adf:e40c:: with SMTP id g12mr3932943wrm.121.1591268659071;
        Thu, 04 Jun 2020 04:04:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuG6vZWa0s86EVH1946fNN/MGfbc9yDTDtdUI1i1Q4oJAQtphFm6WC5ogZfhtmeG9Vv7yR9w==
X-Received: by 2002:adf:e40c:: with SMTP id g12mr3932925wrm.121.1591268658752;
        Thu, 04 Jun 2020 04:04:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id 5sm10177586wrr.5.2020.06.04.04.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 04:04:18 -0700 (PDT)
Subject: Re: [PATCH v3] ata/libata: Fix usage of page address by page_address
 in ata_scsi_mode_select_xlat function
To:     Ye Bin <yebin10@huawei.com>, axboe@kernel.dk, hch@infradead.org,
        linux-ide@vger.kernel.org
References: <20200604093109.134949-1-yebin10@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <882cdc0e-6468-d171-28aa-bd90969562cf@redhat.com>
Date:   Thu, 4 Jun 2020 13:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604093109.134949-1-yebin10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 04/06/20 11:31, Ye Bin wrote:
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 435781a16875..03dd265c30be 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3684,12 +3684,13 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>  {
>  	struct scsi_cmnd *scmd = qc->scsicmd;
>  	const u8 *cdb = scmd->cmnd;
> -	const u8 *p;
>  	u8 pg, spg;
>  	unsigned six_byte, pg_len, hdr_len, bd_len;
>  	int len;
>  	u16 fp = (u16)-1;
>  	u8 bp = 0xff;
> +	u8 buffer[64];
> +	const u8 *p = buffer;
>  
>  	VPRINTK("ENTER\n");
>  
> @@ -3723,12 +3724,14 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>  	if (!scsi_sg_count(scmd) || scsi_sglist(scmd)->length < len)
>  		goto invalid_param_len;
>  
> -	p = page_address(sg_page(scsi_sglist(scmd)));
> -
>  	/* Move past header and block descriptors.  */
>  	if (len < hdr_len)
>  		goto invalid_param_len;
>  
> +	if (!sg_copy_to_buffer(scsi_sglist(scmd), scsi_sg_count(scmd),
> +			       buffer, 64))

sizeof(buffer) would be better.  But anyway:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Perhaps the maintainer can fix it up on commit.

Paolo

> +		goto invalid_param_len;
> +
>  	if (six_byte)
>  		bd_len = p[3];
>  	else
> 

