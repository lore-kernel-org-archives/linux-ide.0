Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F486C4320A
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8935F61057
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 08:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbhIAI4l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243208AbhIAI4k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 04:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630486543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xT6YX/8MTeduh5vXDIw9ZgKlPqVeou/Tf3S3Uzgm3TM=;
        b=Z6wViVhIQj9pZx9Cbw9cvWecdXC0DC+FE1usdiUMIitHCEPjUIOqrpb0NUzORQfA6SP3zg
        s6i4oa3iXjYi8QLrLCeynIsKTs/SI0MWRrGhtudM3Ldk14TksTQvONUl42jbcOHp1k5rQH
        +KBdcVIAJml8bsyJ+6XZ/QlrEQ6FR1E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-15BS-RnlMMW0NVzcXM9VxA-1; Wed, 01 Sep 2021 04:55:40 -0400
X-MC-Unique: 15BS-RnlMMW0NVzcXM9VxA-1
Received: by mail-ej1-f71.google.com with SMTP id jw25-20020a17090776b900b005ca775a2a00so1105817ejc.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Sep 2021 01:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xT6YX/8MTeduh5vXDIw9ZgKlPqVeou/Tf3S3Uzgm3TM=;
        b=k1cvpJAnBH6zss3/Nz8d/iWB1fNbSbNIY22ht/Rm1fFth0HbSCmrlAZR7AnGToS1Q8
         3GQr/qxR9nXBg+ND1iE7tUafCoHHfKnfzpuulJz6SgOSmC3Ty6XmeTVZnpJw772WDHux
         oz1Yjxqfn00K4xNWnUqRMsPeWhzGKy1xHbIIT7YPuafgY4ePAwM8gtF8QDuAphJkHFrC
         dD1A3UICIzPGn4nSxVFPHb/f2AalJ9eGIgbUFTndvGnryRP42OBHAyY645mwJRNn19uP
         kBs1i2oZoh6SBjT3iUFKRBvuksa+Aivi79AlxxU8aoU5/xulJKm+chrg3diS2kn+hKia
         T7FA==
X-Gm-Message-State: AOAM532IpURAppa3QxrvvRsNBS4vNyI0qnRKQWUSigLldOjn3NNCTrGI
        eZp4cgFadmzAENs/1Z3O0WDOSNDkrc9anVI+E0LrCzxMWGAELm/akVnpi3STZL6zsm7Sic7OjJs
        sBgp5xXsXmwm4RrKj7srS
X-Received: by 2002:a17:906:9742:: with SMTP id o2mr36279526ejy.532.1630486539217;
        Wed, 01 Sep 2021 01:55:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFIoEaIgWKck82cXtSM07ZddrJn3BIknjQk8s4oo2zco1Yv8nJyyD9+kS8jjRjyPmIccm80A==
X-Received: by 2002:a17:906:9742:: with SMTP id o2mr36279509ejy.532.1630486539013;
        Wed, 01 Sep 2021 01:55:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v24sm10611583edq.79.2021.09.01.01.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 01:55:38 -0700 (PDT)
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     torvic9@mailbox.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e6f9921d-0fb6-da30-4dc5-53b4cb7b5270@redhat.com>
Date:   Wed, 1 Sep 2021 10:55:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1876334901.51676.1630481868266@office.mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Tor,

On 9/1/21 9:37 AM, torvic9@mailbox.org wrote:
> (Sorry for not doing a proper reply)
> 
> Hello,
> Noob here.
> I have a Samsung 860 Pro connected to a AMD X570 chipset mainboard and
> it just works flawlessly on 5.13 and 5.14.
> Are you sure that *every* 860/870 is concerned by this problem on
> *every* AMD controller?

I am pretty sure that every 860 / 870 EVO is affected,
I am not sure if the PRO is also affected.

As for *every* AMD controller, chances are that more recent
AMD controllers are fine.

We have been trying to resolve various issues with this combo
for a long time now, see:

https://bugzilla.kernel.org/show_bug.cgi?id=201693
https://bugzilla.kernel.org/show_bug.cgi?id=203475

> Isn't this too restrictive?
> Or am I simply missing something?

The problem is that when users are hit by this they end up with
a non functional system and even fs / data  corruption. Where
as OTOH disabling NCQ leads to a (significant) performance
degradation but affected systems will still work fine.

So I believe that it is best to err on the safe side here
and accept the performance degradation as a trade-of for
fixing the fs / data corruption.

With that said, I do believe that we should allow re-enabling
ncq on this combo through libata.force on the kernel cmdline
by adding this extra bit to the patch:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6136,6 +6136,8 @@ static int __init ata_parse_force_one(char **cur,
 		{ "ncq",	.horkage_off	= ATA_HORKAGE_NONCQ },
 		{ "noncqtrim",	.horkage_on	= ATA_HORKAGE_NO_NCQ_TRIM },
 		{ "ncqtrim",	.horkage_off	= ATA_HORKAGE_NO_NCQ_TRIM },
+		{ "noncqamd",	.horkage_on	= ATA_HORKAGE_NO_NCQ_ON_AMD },
+		{ "ncqamd",	.horkage_off	= ATA_HORKAGE_NO_NCQ_ON_AMD },
 		{ "dump_id",	.horkage_on	= ATA_HORKAGE_DUMP_ID },
 		{ "pio0",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 0) },
 		{ "pio1",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 1) },

And I will also add a comment to both linked bugs to see if we can maybe
exclude the pro models from this quirk and if we can maybe narrow it down
to a subset of the AMD SATA controllers.

But that narrowing down is probably best done as a follow up fix, while just
going with this "err on the safe side" approach for now.

Regards,

Hans

