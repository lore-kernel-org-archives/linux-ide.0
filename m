Return-Path: <SRS0=h3CG=7R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F62C433DF
	for <linux-ide@archiver.kernel.org>; Thu,  4 Jun 2020 18:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7940206C3
	for <linux-ide@archiver.kernel.org>; Thu,  4 Jun 2020 18:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="06i4UKNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgFDSIm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgFDSIm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jun 2020 14:08:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FCAC08C5C0
        for <linux-ide@vger.kernel.org>; Thu,  4 Jun 2020 11:08:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so1548359pjd.1
        for <linux-ide@vger.kernel.org>; Thu, 04 Jun 2020 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Utq11x2uKxbCzxgHksRIVgWDDkHVtuQb7xXSLVuMZwk=;
        b=06i4UKNbG5LM0hOp++7xIfD0DCaXgWQVynTa8qz7V5W0QLI2xmeU7Nehb6bU7r8RL8
         /rAXjIXf9G/dusutcIbwJTzrcNOi395yGXZt8VN4DIUlWC4tyQdS6PLv61zudA7cwdYl
         lQJPRBJ9y4d5NalXZx1pOBDMsUkj+31NAGRrUupRnsrZH2Qtdpepqwk9yqSgCNiChYEt
         20Qk2WK1OGfWt2N+1L8rsa7cDZ9O/QFvwU+N2fBz2FmF4roOQJSJijJ+Ckm+jE4pZXJh
         uDYL0ec8O1FIPu4N6WYIqcJm3jkPE6X5YVTn2b1Qg8G5VmUN/jjUgNpDzRbv5DQpv3tn
         C6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Utq11x2uKxbCzxgHksRIVgWDDkHVtuQb7xXSLVuMZwk=;
        b=bfNAU6YdliqdcE9GaSTxFDE8dMiygncXUGtLBZuJKVdfz0ybsuu0QZqmRQRje2zvCO
         rsfOG/+bJ7DxyllQB4twvQpT+VuAKnsyIVzHvc2JvuexBaQZj4wQBibIxtQbvVICTtWZ
         ZVtEjMWHxUlltGmXUjjTm15lb1p95E7oqEkuepid93GSbeezQiCtvMpjqYJUjDzU/XhI
         Stqqt7C6+2upJp5JBoetnNhczVmBf8zTXjNx0pOiQ2l3i1LJBzYqO0JX8jXLXDfPa4xz
         g15qMOLOFrzp/mcvar5TgdQ85uZpSbz84aysJ1EAC0HDhmGVMVe0Ch30weq9EHJFcNJV
         luTQ==
X-Gm-Message-State: AOAM532vsKC1/LTo6N1d2XRdzptPe1WQLBYj8wcuoqqoiIW7/0tg1yXO
        dMRRLxzYIkahTJGBVGdnTZAUH0yqduNe0g==
X-Google-Smtp-Source: ABdhPJyqIO7alMhU50wnp1Kkh2Z84vuzSql+syYIWoMcBZm1mi9HowY35qwJCE2q6PC873D8sVyMzg==
X-Received: by 2002:a17:902:a711:: with SMTP id w17mr5933181plq.173.1591294120005;
        Thu, 04 Jun 2020 11:08:40 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id mu17sm7334565pjb.53.2020.06.04.11.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 11:08:39 -0700 (PDT)
Subject: Re: [PATCH v3] ata/libata: Fix usage of page address by page_address
 in ata_scsi_mode_select_xlat function
To:     Paolo Bonzini <pbonzini@redhat.com>, Ye Bin <yebin10@huawei.com>,
        hch@infradead.org, linux-ide@vger.kernel.org
References: <20200604093109.134949-1-yebin10@huawei.com>
 <882cdc0e-6468-d171-28aa-bd90969562cf@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce4440a8-4d8b-3f47-7ce3-492289dcbb32@kernel.dk>
Date:   Thu, 4 Jun 2020 12:08:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <882cdc0e-6468-d171-28aa-bd90969562cf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/4/20 5:04 AM, Paolo Bonzini wrote:
> On 04/06/20 11:31, Ye Bin wrote:
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 435781a16875..03dd265c30be 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3684,12 +3684,13 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>>  {
>>  	struct scsi_cmnd *scmd = qc->scsicmd;
>>  	const u8 *cdb = scmd->cmnd;
>> -	const u8 *p;
>>  	u8 pg, spg;
>>  	unsigned six_byte, pg_len, hdr_len, bd_len;
>>  	int len;
>>  	u16 fp = (u16)-1;
>>  	u8 bp = 0xff;
>> +	u8 buffer[64];
>> +	const u8 *p = buffer;
>>  
>>  	VPRINTK("ENTER\n");
>>  
>> @@ -3723,12 +3724,14 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>>  	if (!scsi_sg_count(scmd) || scsi_sglist(scmd)->length < len)
>>  		goto invalid_param_len;
>>  
>> -	p = page_address(sg_page(scsi_sglist(scmd)));
>> -
>>  	/* Move past header and block descriptors.  */
>>  	if (len < hdr_len)
>>  		goto invalid_param_len;
>>  
>> +	if (!sg_copy_to_buffer(scsi_sglist(scmd), scsi_sg_count(scmd),
>> +			       buffer, 64))
> 
> sizeof(buffer) would be better.  But anyway:
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Perhaps the maintainer can fix it up on commit.

Please resend it it, thanks.

-- 
Jens Axboe

