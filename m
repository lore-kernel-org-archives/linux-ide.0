Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68775C432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 09:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC2760F4B
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 09:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbhIAJjk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242984AbhIAJjj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 05:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630489122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUMgUGMek2BTIcQrz1eRbN4kQSB1Pe9L2E40QgP/xs8=;
        b=hmgiNryN2wGF1SHfNeQLu95qtR0MZymhhsKVKE/utCyT03PldGTFDHOk2an9hs4DwqRwh+
        NNzrj5oATMuoAuM770yGhGK0hwVXT6mUINkeG4UQUGoXlk4RSOKB0xGX8ggsocX2nyEFV9
        ImsyXkozAA9TJq8EQ7VU5P7Kcd6nw0s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-V_el3eHtMQCwjjYcmGc1FA-1; Wed, 01 Sep 2021 05:38:41 -0400
X-MC-Unique: V_el3eHtMQCwjjYcmGc1FA-1
Received: by mail-ed1-f72.google.com with SMTP id v13-20020a056402174d00b003c25d6b2f13so1025294edx.4
        for <linux-ide@vger.kernel.org>; Wed, 01 Sep 2021 02:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUMgUGMek2BTIcQrz1eRbN4kQSB1Pe9L2E40QgP/xs8=;
        b=k8iWHob3Lg+VsyeM8i+qPgCpkXMQixRBZ4vcZdDUudxVT4rvSU8KkZAB330OAJPrOa
         q3FB8d1EwqTT4VlYDyltWRnmaEeEU158SYABH9WMnZ6ueS2snSc4ckO7xHWagGSofzgW
         CWMwYM++gr5tKFzEhwnzZ8YEs+tEI5o06mKoEbSFNoA1V9kIZUDxYl2Wk2LQFuo41114
         ir0BOQ1SOxEFrqJOU3QGgm+ipDu3ZcaQ+ii0u70RF55VTR9C1MAylyfcoTOf05YDAruK
         pM58iLJRBI8+ImHmh9E/USAC6S3hCq73wDscpGncr7BH/LTgEvfmxnWi4rpDt1zpwdRx
         JR0g==
X-Gm-Message-State: AOAM5304/uLWMT7AZwMUTOE/SlV0NARLYC6lvJNQbQWP6Fc/2Bm4JaZP
        ymnL3te3SfbcGYgcYmvJdZmYA1UxZVa/neEI+r8nK1O8Gb4B1Izz8uQoJ8b+O+bbMRVXNua/EO1
        fxnArK4s8kceBmV/2o7u6
X-Received: by 2002:a17:906:8258:: with SMTP id f24mr36087119ejx.375.1630489120717;
        Wed, 01 Sep 2021 02:38:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUk8ZJu+eEk5NcdDPpvkbaWhIRni/SaBDSt2prHH6gMkc6bodJqhTQdUkN7Hsh/4YZm1cH5A==
X-Received: by 2002:a17:906:8258:: with SMTP id f24mr36087099ejx.375.1630489120489;
        Wed, 01 Sep 2021 02:38:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q18sm9654169ejc.84.2021.09.01.02.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:38:40 -0700 (PDT)
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
From:   Hans de Goede <hdegoede@redhat.com>
To:     torvic9@mailbox.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
 <e6f9921d-0fb6-da30-4dc5-53b4cb7b5270@redhat.com>
Message-ID: <2df1c3d5-301d-dc46-7f9f-d28be2933bd3@redhat.com>
Date:   Wed, 1 Sep 2021 11:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e6f9921d-0fb6-da30-4dc5-53b4cb7b5270@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 9/1/21 10:55 AM, Hans de Goede wrote:
> Hi Tor,
> 
> On 9/1/21 9:37 AM, torvic9@mailbox.org wrote:
>> (Sorry for not doing a proper reply)
>>
>> Hello,
>> Noob here.
>> I have a Samsung 860 Pro connected to a AMD X570 chipset mainboard and
>> it just works flawlessly on 5.13 and 5.14.
>> Are you sure that *every* 860/870 is concerned by this problem on
>> *every* AMD controller?
> 
> I am pretty sure that every 860 / 870 EVO is affected,
> I am not sure if the PRO is also affected.

So while reading https://bugzilla.kernel.org/show_bug.cgi?id=201693
again to add a comment asking if anyone was seeing this on a
pro to I found existing comments of both queued-trims being
an issue on the 860 pro, as well as the 860 pro having issues
with some AMD sata controllers.

So it seems safe to say that the 860 pro has the same issues
as the 860 and 870 evo models. Chances are you don't have
discard support enabled causing you to not see the queued-trim
issues (which means you also won't see any difference from
disabling support for queued-trim commands).

So this just leaves your question of:

"concerned by this problem on *every* AMD controller?"

Where "this problem" is needing to completely disable NCQ
and I guess the answer is no, not every AMD controller
is affected. Still the plan is to err on the safe side for now,
allowing overriding this from the kernel cmdline with:

libata.force=ncqamd

I will add a comment to:

https://bugzilla.kernel.org/show_bug.cgi?id=201693

Asking for PCI-ids of the controllers where people are seeing
this and then maybe we can narrow down the "AMD" check in a
future follow up patch.

Regards,

Hans

