Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC58C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2722B6104F
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 15:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhISP2f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Sep 2021 11:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230105AbhISP2f (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Sep 2021 11:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632065229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSy0qSazpxmU03SoDhSpde0uFhTOnrJsDqywzUzjo44=;
        b=d/Oz6Ktj70an1Fh/hdY/CXzxFAXpARRab/K4D1QKTbt1e+6xfIau8M7TZMzxquj2C8iw7e
        bjSx9We6toqS8cjJkByOhxENiu1Xel3+WK1qgIC0oEJW/gb4ky+2OX6wV9xv7xVvS0WKOg
        YgKd9pkZr0R9WAVShiAUU3GRwQAwIWU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-QdmXwu1tMmKQLpDxy_zxkA-1; Sun, 19 Sep 2021 11:27:08 -0400
X-MC-Unique: QdmXwu1tMmKQLpDxy_zxkA-1
Received: by mail-ed1-f72.google.com with SMTP id q17-20020a50c351000000b003d81427d25cso7009807edb.15
        for <linux-ide@vger.kernel.org>; Sun, 19 Sep 2021 08:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iSy0qSazpxmU03SoDhSpde0uFhTOnrJsDqywzUzjo44=;
        b=EvGxygJay1IukxpEJ0nIJH+OTIIWnD6O0AHc3P11IJtZynSYt1N07kQpA6R3obQ3rb
         Z6BLmo1GfD/haKOIOdDOvrE6+h5muxkgzsxZtLJKnRbN5JcI0qkeS/Exi4Q7S154uAvd
         sGhtcZgog8JG4tGwadRM8L5eJyA57Zqg9Ki44cG7xd1RiJTMqhPia7FlqIdSi+M/8NXb
         J+/SPq32fyb9H+dXmCSoLBm02fGNjRTIab13jxNZjkF6tiKWeiAFfIRiWT993wD8jImA
         mc9I1prRrdaQdIMtK2ZiABcPStHDyydol94k9Tza3BawBeYK92ujwAbfLVY7YMfZNrfv
         CS/A==
X-Gm-Message-State: AOAM5330/RVWd83sR2F0qE7R8ZmUrOQ2qRf+yGI5S8KrbA9xk/0gXT5V
        e00YbltvSwmeI91BL08jOC+itPhvYKVKB2kNOCscZ03Khvvs4bQZQ/an8bIJS20CME1VNePMb/u
        AcA/HoCNES6ekHym0I+SZ
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr23233443ejb.278.1632065226988;
        Sun, 19 Sep 2021 08:27:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymySWXR5PitvxFBfYirVcRcCRDdr9WoU5KFrhKSouL5UtZ+ltob0hExB0o/D3JAvzxSNkAyQ==
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr23233435ejb.278.1632065226849;
        Sun, 19 Sep 2021 08:27:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p24sm874569edq.27.2021.09.19.08.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 08:27:06 -0700 (PDT)
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     Tor Vic <torvic9@mailbox.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210901151643.13562-1-hpa@redhat.com>
 <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
 <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
 <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
 <cd75fa32-8c4d-664e-5adb-f2f325d3c58e@redhat.com>
 <yq14kb24e97.fsf@ca-mkp.ca.oracle.com>
 <f071dfb3-1aad-003c-00bc-6b7ecf103e91@mailbox.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <967d7639-fc31-a209-8c21-ea8ab3718de6@redhat.com>
Date:   Sun, 19 Sep 2021 17:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f071dfb3-1aad-003c-00bc-6b7ecf103e91@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Tor,

On 9/19/21 4:24 PM, Tor Vic wrote:
> Hi,
> 
> I saw that v2 (?) of this patch has made it into stable, which
> is quite reasonable given the number of bug reports.
> Are there any plans to "enhance" this patch once sufficient data
> on controller support/drive combinations has been collected?

ATM there are no plans to limit these quirks, we have bug
reports of queued trims being an issue over all usual chip-vendors
of sata controllers (including more recent AMD models).

Note that unless you have immediate "discard" enabled as an option
on all layers of your storage stack (dmcrypt, device-mapper/raid,
filesystem) then this change will not impact you at all.

Also note that AFAIK all major distros do not enable immediate
discard, instead relying on fstrim runs from a cronjob, which
again means this change will not impact users of those distros.

So chances are that your workload simply never triggered the issue;
and this is the cause of everything always having worked fine for
you.

Regards,

Hans

