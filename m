Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C99EC433F5
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 16:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1AF60FE6
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 16:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhISQwt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Sep 2021 12:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231594AbhISQws (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Sep 2021 12:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632070283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9A/ZW/hYr0iV04kgVzIKko+q+g2fbtqUk/FZXyEAQM=;
        b=XWvxdZaFpCqZKkjyW46OxF+Dlnxihg7K0L+KNvGfBXash84NcDJSLmM4bVXTsOZtk+QqGN
        doV0NpO1xQDkE1nvNZ4yU+iipKH6+pvElc5hVPkc7CwsJrt8X25EOP5nh0cT4SbsrNW6Pr
        8tj0rMMaNGCcBecX7WaXMdxXjqOIH3Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-mW1JoZlYNq-hp_czfGxaqw-1; Sun, 19 Sep 2021 12:51:21 -0400
X-MC-Unique: mW1JoZlYNq-hp_czfGxaqw-1
Received: by mail-ed1-f71.google.com with SMTP id x14-20020a50ba8e000000b003d5a565de3aso12648001ede.18
        for <linux-ide@vger.kernel.org>; Sun, 19 Sep 2021 09:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9A/ZW/hYr0iV04kgVzIKko+q+g2fbtqUk/FZXyEAQM=;
        b=3FTQ4s63INOZ2W/RqMnfY+zZjqD8omP+7T5nd+KvRgAcdBjmJ+NT6NQQgPIim9ImbH
         7X2EeiJn7r6OwgPW3wtZ7W7F9DgXkFW1stgsVnDll2BxUYpFzb6vVng74wfW4/0qOQBS
         O3pzbzppGScZ/1OF714lLFXwXEVn8NiXRcMOHMzKE2JvrtyRl4j5ED/8MzccvWztgu4T
         zLvg7LM+/R8443yu2bdWUgG10YkSuF187lySkleu7HTyu8Rbfi+QczqUUUb5QFtAMeEj
         TghhzwOoX+JEN8RDaHXkim8jKYbSBcUARZhL1LKF2Qen0CVQTmkGnfmtwPiVVSc9jl7l
         ef+A==
X-Gm-Message-State: AOAM533kf8FKeU6pjUbNdoCPyuKhNBXjpuvZxgxaKCyacJ6+Cs3oRZQx
        kV7vOEKgBi1+d6hwfyqrMf14D+fU3lU3YK3iNwUvWZOf7RF1LTiTSw+WhYJcpeWIUT/L4W0QS1C
        0ct+69RAUhfUdo079h5c3
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr24857553ejp.520.1632070280164;
        Sun, 19 Sep 2021 09:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu9tmc5IiASoxzvTqmp01CKGM4gJcPBoC8MmukNHpp+eGCuR+z/e3wHMSPI4q1UQCKZCuUKA==
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr24857543ejp.520.1632070280004;
        Sun, 19 Sep 2021 09:51:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h8sm5277277ejj.22.2021.09.19.09.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 09:51:19 -0700 (PDT)
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
 <967d7639-fc31-a209-8c21-ea8ab3718de6@redhat.com>
 <66b4c377-1b17-1972-847e-207620cc9364@mailbox.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <361d702e-44c4-625f-5b6b-121a4dc07105@redhat.com>
Date:   Sun, 19 Sep 2021 18:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <66b4c377-1b17-1972-847e-207620cc9364@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 9/19/21 6:27 PM, Tor Vic wrote:
> 
> 
> On 19.09.21 15:27, Hans de Goede wrote:
>> Hi Tor,
>>
>> On 9/19/21 4:24 PM, Tor Vic wrote:
>>> Hi,
>>>
>>> I saw that v2 (?) of this patch has made it into stable, which
>>> is quite reasonable given the number of bug reports.
>>> Are there any plans to "enhance" this patch once sufficient data
>>> on controller support/drive combinations has been collected?
>>
>> ATM there are no plans to limit these quirks, we have bug
>> reports of queued trims being an issue over all usual chip-vendors
>> of sata controllers (including more recent AMD models).
>>
>> Note that unless you have immediate "discard" enabled as an option
>> on all layers of your storage stack (dmcrypt, device-mapper/raid,
>> filesystem) then this change will not impact you at all.
> 
> Is that the "discard" mount option?
> I added this to one of the partitions residing on my 860 Evo,
> reverted the patch, and it still seems to work just fine.
> 
>   $ mount | grep sdb
> 
> 
>   /dev/sdb1 on /mnt/vbox type ext4 (rw,nosuid,nodev,noatime,discard)
> 
> Is there another place where discard has to be enabled?

No since you do not seem to be using dmcrypt/raid/lvm that should
do the trick.

Except that it sounds like this is a partition carrying vm
images. Those never delete storage, they only grow, to
effectively trim you need to either punch holes in files,
or remove files. Discard only comes in to play when used
diskspace becomes unused.

To test preferably remove several large files at once while
also generating a whole bunch of other diskio (e.g.
compile the kernel while also deleting several large files
from the same disk, with discard enable).

But even if that works for you, that is 1 report that this
works in some cases, vs many that it does not work; and also
note that you had to manually enable this, it was not
enabled before. So this really is going to impact the
performance of very few users, while looking at the amount
of bugreports about hangs / disk-corruption the problem
of having queued-trim support enabled is much much bigger,
so I see very little reason to re-enable this even if it
happens to work in your case.

> Or is there a way to check that discard is effectively enabled?

There probably is, but I don't know where / how to check this.

Regards,

Hans



