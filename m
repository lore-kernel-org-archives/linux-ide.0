Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF3C432BE
	for <linux-ide@archiver.kernel.org>; Tue, 31 Aug 2021 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BBA60240
	for <linux-ide@archiver.kernel.org>; Tue, 31 Aug 2021 07:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhHaHjF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239463AbhHaHjF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2021 03:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630395490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mQhLKnJ2xoUp4bk3hcpO+tGdeMZNuwhxgy5Bf2xxIw=;
        b=Bo8b/7Yhf/Cl6XtPuTwZfMRTb+nYpCdFWAOEFQKWfH6uW78Y9twdTuJQnoxmzTYunjLy4g
        gcCMWC/n/CMpdto0TQvQRp/zSy+5qtSLiLzueXF44UNEWRXFz5HTJD/HW8AjjemXkW9PKe
        /E4Rjf3Y46Xbg7QK76hM4qtWyKtbb+w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-dSNTHMoqOqei_SLWDNsjSg-1; Tue, 31 Aug 2021 03:38:07 -0400
X-MC-Unique: dSNTHMoqOqei_SLWDNsjSg-1
Received: by mail-ej1-f70.google.com with SMTP id bi9-20020a170906a24900b005c74b30ff24so6689383ejb.5
        for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2021 00:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5mQhLKnJ2xoUp4bk3hcpO+tGdeMZNuwhxgy5Bf2xxIw=;
        b=K9ksUUHcu8oKfymPiU1xYn285mwvkaXfILivyfh9ccXFXBqz3wHpKXHYPowPCSL6Az
         k98Bfq6ZNr7x0ao47SlVpMzw5fSCMjlsNfqbgLvEmv0OTz7uei2XA/cK6266uOR+HX6H
         1TB+q/BFGFQnxM9uqdAe3DILiPQoyU9sIJ4Ou2nKjVZypVscuUr7Zmk5aWdQAJ4MW9N3
         iWxNqNTZxy22dtFZFklmaKGS0vAV8GYaoCF7TdIdp+RQyRzyxxYFO0mT0LIvQFJOVWTf
         QqPrAKpP5Y0OMRuf4nUbbAOUIAuWpbt80r4O7+HgQycGqp64Km/F8nYZ7E26o9l9Ywnc
         DaDw==
X-Gm-Message-State: AOAM533YzKnCM5tFr4rPICE2egVQNxONiJhiam6dR2ynwhe2EYVQJyu6
        ivwVVb31ePma1iayiO2LOp7g4SiK5PHZIdpJYkWWsb7DJjnYpJr6LyurUI0Rep3TV9/cnPT7bvx
        onS9UEGXkz9MDQ15l8JPm
X-Received: by 2002:a17:906:7716:: with SMTP id q22mr30015661ejm.457.1630395485895;
        Tue, 31 Aug 2021 00:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLUWFAXTEKfEy/di0/LWfct67mDIywsCfy24A1pBzQGFAYAhL7mGPAFEZNKhwTmY5sUCRFsw==
X-Received: by 2002:a17:906:7716:: with SMTP id q22mr30015653ejm.457.1630395485727;
        Tue, 31 Aug 2021 00:38:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f30sm7609956ejl.78.2021.08.31.00.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 00:38:05 -0700 (PDT)
Subject: Re: [PATCH v3 0/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung
 860 and 870 SSD.
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210830144253.289542-1-hpa@redhat.com>
 <DM6PR04MB708147357F91D5AEB6128A2AE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a76b2acd-edfa-55b2-907c-f1faa8ce4914@redhat.com>
Date:   Tue, 31 Aug 2021 09:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB708147357F91D5AEB6128A2AE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 8/30/21 11:45 PM, Damien Le Moal wrote:
> On 2021/08/30 23:43, Kate Hsuan wrote:
>> Many users reported the issue when running the system with Samsung 860,
>> 870 SSD, and AMD chipset. Therefore, completely disabling the NCQ can
>> avoid this issue.
>>
>> Entire disabling NCQ for Samsung 860/870 SSD will cause I/O performance
>> drop. In this case, a flag ATA_HORKAGE_NONCQ_ON_AMD is introduced to
>> used to perform an additional check for these SSDs. If it finds its parent
>> ATA controller is AMD, the NCQ will be disabled. Otherwise, the NCQ is kept
>> to enable.
> 
> For a single patch, generally, a cover letter is not needed. Especially so in
> this case since your cover letter message is the same as the patch commit message.
> 
>>
>> Changes since v3
>> * Modified the flag from ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL to
>>   ATA_HORKAGE_NONCQ_ON_AMD.
>> * Modified and fixed the code to completely disable NCQ on AMD controller.
> 
> Technically, this is a v2 right ? Also, by "completely", did you mean "always" ?
> (see patch comments).

Right, as mentioned in my reply to the v1 which was accidentally labelled v2
I suggested to just make this v3 to avoid confusion, otherwise we would have
2 v2-s.

Regards,

Hans

