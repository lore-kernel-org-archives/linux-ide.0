Return-Path: <SRS0=gGcN=7M=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF0C433E1
	for <linux-ide@archiver.kernel.org>; Sat, 30 May 2020 05:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7852074B
	for <linux-ide@archiver.kernel.org>; Sat, 30 May 2020 05:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkHyOdUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgE3Fnt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 30 May 2020 01:43:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725814AbgE3Fnt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 30 May 2020 01:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590817427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdyzi865Uo7biLxQTMr7EZJw5dyX9n2ZR6DLXT4z/ME=;
        b=HkHyOdUyl3A3FcY7nekk2YEeqPQDkVbBYnopU1VK3XPqpDtNGDERTwhqcVa3IlVmHW0Rth
        DzbrRUjWfs77l7tCaG0Z4n9YWj7J14ZL05CwKnGD39DgvzOFAQjOSxBtrM9oW0qfS49lqH
        YmtXzCgHSDKWuZJ6Mv6u7doZii27C6I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-bLNyEl-bNIm38Ket4ih9Xg-1; Sat, 30 May 2020 01:43:45 -0400
X-MC-Unique: bLNyEl-bNIm38Ket4ih9Xg-1
Received: by mail-wr1-f69.google.com with SMTP id p10so1826195wrn.19
        for <linux-ide@vger.kernel.org>; Fri, 29 May 2020 22:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kdyzi865Uo7biLxQTMr7EZJw5dyX9n2ZR6DLXT4z/ME=;
        b=TK6lBUW1IMTQOb0AzitYwNuV6VZbbHjW2DiCZsHu7xhfErxiT40ZOE4RcwVR7v3OXk
         EXKoOXCHUUyHHoUWfrf4Y8UKxvQgu35QJKrmtvjnIlbsxOVYQRAT28/Rcng4BN5t/kvK
         4+wA9mmR4gK3u+h0vkS17oGxrz5E7PhJfd7ninvX849IiHxZhLrK2VO2prNoxjRrY7J/
         4S4P5qMWBZPKMFrk8MIzCTYGjd+DBANO97Tr2geYYAy1nFi0KO/SL7ti30N3dZs+Fff6
         pjbfCCWEweaKCuZD5qvHNMNAw7sDPxEmbKhVrSey82witp+WnZw8zTUPU75IDyRZjzVi
         Cvfw==
X-Gm-Message-State: AOAM5304s9FHk9lGnByEX9DMu8hoHFJgphusi7N1Cc528KFDxZ+MskAX
        j8bP3RmvYKxaLKMQaytxXISuaMBVqf8lgDH1Cu8Um8uwJgU6TPiuwYoMM0GNgLGkYL6GV61j1x1
        W4vOn0gNbBmUnRgxrVPZ9
X-Received: by 2002:a5d:60c3:: with SMTP id x3mr11434246wrt.48.1590817424303;
        Fri, 29 May 2020 22:43:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+6i7C+lPv6CutPqtcaBf5XWFj1zn9iCmmIwe7Uzm9L2e1I7OpexajJKZTjgrn1CiLU7IwAg==
X-Received: by 2002:a5d:60c3:: with SMTP id x3mr11434230wrt.48.1590817424115;
        Fri, 29 May 2020 22:43:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id c140sm2157428wmd.18.2020.05.29.22.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 22:43:43 -0700 (PDT)
Subject: Re: [PATCH] scsi/libata: Fix usage of page address by page_address in
 ata_scsi_mode_select_xlat function
To:     Christoph Hellwig <hch@infradead.org>, Ye Bin <yebin10@huawei.com>
Cc:     linux-ide@vger.kernel.org, axboe@kernel.dk
References: <20200529063251.14665-1-yebin10@huawei.com>
 <20200529124807.GA23222@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <360d848f-4b56-3e5d-531f-754f505e1a25@redhat.com>
Date:   Sat, 30 May 2020 07:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200529124807.GA23222@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 29/05/20 14:48, Christoph Hellwig wrote:
> On Fri, May 29, 2020 at 02:32:51PM +0800, Ye Bin wrote:
>> index 435781a16875..d674184ed835 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3723,7 +3723,7 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>>  	if (!scsi_sg_count(scmd) || scsi_sglist(scmd)->length < len)
>>  		goto invalid_param_len;
>>  
>> -	p = page_address(sg_page(scsi_sglist(scmd)));
>> +	p = page_address(sg_page(scsi_sglist(scmd))) + scsi_sglist(scmd)->offset;
>
> This also looks completely buggy on highmem systems and really needs to
> use a kmap_atomic.

Ugh, yes it is (I wrote that code...).  In addition, now that it handles
offset correctly the input might span two pages.

So it's probably simpler to just make a char array of size
CACHE_MPAGE_LEN+8+8+4-2 (or just 64 to make it easy), use
sg_copy_to_buffer to copy from the sglist into the buffer, and work
there.  This will also fix the bug that Ye Bin was trying to address.

Paolo

