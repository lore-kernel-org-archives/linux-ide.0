Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC39C433FE
	for <linux-ide@archiver.kernel.org>; Sat, 22 Oct 2022 13:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJVNuf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 22 Oct 2022 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJVNu1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 22 Oct 2022 09:50:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35961B8C07
        for <linux-ide@vger.kernel.org>; Sat, 22 Oct 2022 06:50:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBC8521B61;
        Sat, 22 Oct 2022 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666446618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYX2rCCdL4K9pBaT1A4aBXT/8LYcc4CxUosb5Twlmz4=;
        b=lrwMsoP7yGknO+NuLLywtze1UY3vC4kdeFoS2rfZDKRNWzn3yoIUI9Zb+NTm0ExDSqMrrT
        uYIe2462k4iGkOqEFnZJ4DUKVJXSzmZibJIyv3NRDqBI86vCVbsV+iaZMr6v/CkKQEJaTX
        tQs9L99JE/t7ozG0bUfc0OS6AUluI5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666446618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYX2rCCdL4K9pBaT1A4aBXT/8LYcc4CxUosb5Twlmz4=;
        b=EWJd6eZZ5y6Qsd/P6ES5jUPUwIoNnk+Kwq9oDL7We7rKsHfjapAX5gWS/eyjD9tcsfQV/s
        gi5cRAUquQ35vrCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD2D013494;
        Sat, 22 Oct 2022 13:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1BMTLBr1U2MVagAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 22 Oct 2022 13:50:18 +0000
Message-ID: <5b8ae976-413a-98bb-1912-2fe953eaa918@suse.de>
Date:   Sat, 22 Oct 2022 15:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] Improve libata support for FUA
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <165565d4-f391-b13c-b450-26f115bb4cf9@maciej.szmigiero.name>
 <d0315388-460b-37c9-298e-97f86b7965b7@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <d0315388-460b-37c9-298e-97f86b7965b7@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/22/22 00:45, Damien Le Moal wrote:
> On 10/22/22 06:02, Maciej S. Szmigiero wrote:
>> On 21.10.2022 07:38, Damien Le Moal wrote:
>>> These patches cleanup and improve libata support for the FUA device
>>> feature. Patch 3 enables FUA support by default for any drive that
>>> reports supporting the feature.
>>>
>>> Damien Le Moal (2):
>>>     ata: libata: cleanup fua handling
>>>     ata: libata: Enable fua support by default
>>>
>>> Maciej S. Szmigiero (1):
>>>     ata: libata: allow toggling fua parameter at runtime
>>>
>>
>> Thanks Damien for the series!
>>
>> I've looked at the code changes and have basically two points:
>> 1) There seems to be no way to revalidate the FUA setting for an existing
>> disk, since it is now only taken into account in ata_dev_config_fua().
>>
>> As far as I can see, this function is only called on probe paths
>> (and during exception handling), so if the "libata.fua" parameter is
>> toggled the new setting would only affect newly (re-)attached disks.
> 
> Yes. Indeed. Forcing an ATA revalidation needs some more trickery as the
> regular sd_revalidate() does not lead to ata_dev_configure() being called
> again.
> 
But shouldn't we rather fix that?
After Johns series of pre-allocating the SCSI devices we should be able 
to call ata_dev_configure() from sd_revalidate() ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

