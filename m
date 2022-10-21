Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DEFC433FE
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 08:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiJUIpy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 04:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiJUIpq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 04:45:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4EBF70BA
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 01:45:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78B72229EE;
        Fri, 21 Oct 2022 08:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666341934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pxXVAMsinL5EgzM9sy4k/L8M5DOOVAXV3476CTP/w3Y=;
        b=h5c8RLjlgG+BAs00FY8WE8KLgbb1CKZl8xI9M1ogbpML7kJDACp2SUkOSF7u4uNQFKgBC8
        Zy/Ct3Fw9mZywgEXNJot2JcLHRgot1gyp7DLb/BVK/c7P9DEItkP7frJL5yvnBFr9nNrWw
        gbdcUBeJ9vbmlImG3KRPGheo2xjYffI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666341934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pxXVAMsinL5EgzM9sy4k/L8M5DOOVAXV3476CTP/w3Y=;
        b=4/1a4gKGVTYC1t3hbvELyC1GI0WNTh0hRY/qiq8JcGLql6ZLiH9xy7uooOZZr7mDS1Ct++
        4vXhUZIOmanmTHBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BCF01331A;
        Fri, 21 Oct 2022 08:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wv32GS5cUmOfXwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Oct 2022 08:45:34 +0000
Message-ID: <ac069cbd-1a90-4d60-3eef-d1d58def73b0@suse.de>
Date:   Fri, 21 Oct 2022 10:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/3] ata: libata: allow toggling fua parameter at runtime
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <20221021053809.237651-3-damien.lemoal@opensource.wdc.com>
 <c1fc6322-d6d4-4579-1281-130e0546883b@suse.de>
 <1ccb3faa-a727-6b4b-cabc-320c7a21ca09@opensource.wdc.com>
 <3a08e4a4-417f-8dbb-42d1-f81c94cf26dc@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <3a08e4a4-417f-8dbb-42d1-f81c94cf26dc@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/21/22 10:00, Damien Le Moal wrote:
> On 10/21/22 15:50, Damien Le Moal wrote:
>> On 10/21/22 15:21, Hannes Reinecke wrote:
>>> On 10/21/22 07:38, Damien Le Moal wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Currently, the libata.fua parameter isn't runtime-writable, so a
>>>> system restart is required in order to toggle it.
>>>> This unnecessarily complicates testing how drives behave with FUA on and
>>>> off.
>>>>
>>>> Let's make this parameter R/W instead, like many others in the kernel.
>>>>
>>>> Example usage:
>>>> Disable the parameter:
>>>> echo 0 >/sys/module/libata/parameters/fua
>>>>
>>>> Revalidate disk cache settings:
>>>> F=/sys/class/scsi_disk/0\:0\:0\:0/cache_type; echo `cat $F` >$F
>>>>
>>>> [Damien]
>>>> Enabling fua support by setting libata.fua to 1 will have no effect if
>>>> the libata module is loaded with libata.force=[ID]nofua, which disables
>>>> fua support for the ata device(s) identified with ID or all ata devices
>>>> if no ID is specified.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>> ---
>>>>    drivers/ata/libata-core.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>> index 6008f7ed1c42..1bb9616b10d9 100644
>>>> --- a/drivers/ata/libata-core.c
>>>> +++ b/drivers/ata/libata-core.c
>>>> @@ -128,7 +128,7 @@ module_param(atapi_passthru16, int, 0444);
>>>>    MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>>>>    
>>>>    int libata_fua = 0;
>>>> -module_param_named(fua, libata_fua, int, 0444);
>>>> +module_param_named(fua, libata_fua, int, 0644);
>>>>    MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
>>>>    
>>>>    static int ata_ignore_hpa;
>>> Hmm. I guess you'll need to revalidate the drive when changing that; but
>>> this can be done in a later patch.
>>
>> Well, this is not sysfs, we cannot do this automatically easily...
>> And thinking about it now that you mention it, going from fua=1 to fua=0
>> can actually cause problems. The reverse not, since scsi side would still
>> see fua=0 until revalidation.
>>
>> So... Unless we find a way to link the param write to reavlidation, we
>> should actually not allow this.
>> Maciej ? Thoughts ?
> 
> I looked at this a little more. We could define the operations (struct
> kernel_param_ops) manually together with the fua parameter declaration,
> but that would be really ugly...
> 
> Given that we are switching to fua=1 by default, do you still need a
> dynamic argument ? I am now thinking that this patch should be dropped.
> 
I'd kill it, and let users it handle via blacklist flags only.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

