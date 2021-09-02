Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E5C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  2 Sep 2021 20:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9611D60FC0
	for <linux-ide@archiver.kernel.org>; Thu,  2 Sep 2021 20:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbhIBUrb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344875AbhIBUra (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2021 16:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630615591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCglRUEE7rogtAfOGbvk+uUlCVK6Cupx/05Png5N9W0=;
        b=Op2s3QTmox/Zl7ipKqA81BFdOPb2kIPS3xmiLv2hy90ekNjPEh8z9iyA07hdtql9rw2UhR
        vq2HFiuGJBoJgzvCMP1LLOz0oqZBr/9ehHMoZI1xc2dZjDUXjybfmdUF3aQ9u118pKXTuw
        U2qh7W868mmotazGdUGjnsEr35GNmFE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-9uSUYESpOFmZWPT4lG9C-A-1; Thu, 02 Sep 2021 16:46:30 -0400
X-MC-Unique: 9uSUYESpOFmZWPT4lG9C-A-1
Received: by mail-ej1-f72.google.com with SMTP id q15-20020a17090622cf00b005c42d287e6aso1585142eja.18
        for <linux-ide@vger.kernel.org>; Thu, 02 Sep 2021 13:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCglRUEE7rogtAfOGbvk+uUlCVK6Cupx/05Png5N9W0=;
        b=S8lmrnDjYiq7Mwblqo/FZDnNTmRh4tdyjA+Rc46SvcJDGKR0aW5yVt9ynZikICpOvG
         m+dGqVNZp2D1lCV9u2yN3NdTHq7Lvb8ioS/bjuQ2UvDeE1HAbW0fAJm6p5bQLUtRM/32
         FFWPRj2bWLdGYIc9A3Pb0COaNQWzjobjZmK2iHR1QvC6xnERDAimpmouR/0VQOn5UIaL
         pm8rNzqvwZn37MvivP7C7MoJ4BztzhBKw8lG0khLwcRecQbC9ei6icucdzCeefn25ngh
         3tw+N0JqbUSSB5S4Gq08iKczmxorUZ9Tiwb5XTevQmIPNv/MF7k0cIjTTkPGq2Go7m0W
         9+nQ==
X-Gm-Message-State: AOAM531f6RONN7D4pEFPb1DbOPZMhU33MglG3QLX9pDD/1gT7s49nu3a
        uUUIwnU+0aA/d6b1mvuiXl9A9GDWUBx+s2AcuHp31oxORIkdDeNsrIdFej8TeBRXd2QHH50Kv0K
        Sy1rZGh/PM7UPpOi3wzBh
X-Received: by 2002:a05:6402:714:: with SMTP id w20mr270979edx.62.1630615589385;
        Thu, 02 Sep 2021 13:46:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZkrpfUmKqFbYAigKUyboyl/I0MERdGX15LTrs0VwKkrMD1DPYnzz5haBWGo8xBvrcLPNz0w==
X-Received: by 2002:a05:6402:714:: with SMTP id w20mr270966edx.62.1630615589234;
        Thu, 02 Sep 2021 13:46:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id mb14sm1703522ejb.81.2021.09.02.13.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 13:46:28 -0700 (PDT)
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tor Vic <torvic9@mailbox.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210901151643.13562-1-hpa@redhat.com>
 <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
 <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
Date:   Thu, 2 Sep 2021 22:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 9/2/21 9:01 PM, Martin K. Petersen wrote:
> 
> Hans,
> 
>> So it looks like we actually need to disable NCQ for Samsung 860/870
>> devices when the SATA controller has a vendor-id of PCI_VENDOR_ID_ATI
>> rather then AMD.
> 
> That's another great data point!
> 
> I wonder if there actually is a Samsung problem (given that these drives
> work fine on other controllers). Or if it is just the queued trim
> handling that's broken on 1002:4391 controllers from ATI.
> 
> When I originally experimented with queued trim I had systems I could
> not get to work. But queued trim worked fine when the same drives were
> connected to more modern chipsets (note that this was "did not work at
> all" as opposed to "randomly corrupting data").
>
> Do we have any evidence at all of queued trim working with non-Samsung
> drives on these controllers? Not sure how many modern SATA drives
> actually implement this feature. Maybe the reason we see Samsung drives
> in the bug reports is due to a combination of popularity and the fact
> that these drives actually implement queued trim support.

The Samsung 860 / 870 series causing issues when queued trim support
is enabled are quite wide-spread, covering many different controller
models from all well known controller vendors (Intel, Asmedia, Marvell
and AMD). So disabling queued-trim support definitely is the right
thing to do (and we should have done so a long time ago, I am to
blame for this not being done sooner).

As for your theory that it is really a problem with the controller
and not the the SSDs, I honestly do not know, but I doubt it,
there are no such reports with any other vendor's SSD or newer
Samsung models, so this seems unlikely.

Regards,

Hans

