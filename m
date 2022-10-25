Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CB8C04A95
	for <linux-ide@archiver.kernel.org>; Tue, 25 Oct 2022 07:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJYHFJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Oct 2022 03:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJYHFI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2022 03:05:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2A5DF51
        for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2022 00:05:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 67AAC1FD98;
        Tue, 25 Oct 2022 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666681503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tB1x77XaOnDHk+1BiWn+SMZi/0qW6+bLSp5ay0125tw=;
        b=uuvavSfScbfrUDobb0Ib0ieteABJ1T2mQbC4ZCNA6Ahs5CyjwMQJAUJavk3qeNaoZ7fU9c
        2RYW6NeW0sUPThNaeHvH15NcGwCiHBLuKfnxS9+wzHJzpK76vJ54SkEouVpkDJD82u/g4u
        Ts6RqcdhdrAcbkk247CMMK6dwtUv9gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666681503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tB1x77XaOnDHk+1BiWn+SMZi/0qW6+bLSp5ay0125tw=;
        b=NZpLyVp6SCZnTEV2V7j5a6kViyrG52jeaDttKMo4E57XtLFy3+6u9SWPSyMgj9LA0wBFy8
        ZW86IleMXWAbv5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BEBC134CA;
        Tue, 25 Oct 2022 07:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ibTPEZ+KV2PhcgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 25 Oct 2022 07:05:03 +0000
Message-ID: <709fb497-df73-0ee7-06db-1fb4c2e50cf6@suse.de>
Date:   Tue, 25 Oct 2022 09:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
 <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
 <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/25/22 01:26, Damien Le Moal wrote:
> On 10/25/22 07:09, Damien Le Moal wrote:
>> On 10/25/22 03:48, Maciej S. Szmigiero wrote:
>>> On 24.10.2022 09:26, Damien Le Moal wrote:
>>>> These patches cleanup and improve libata support for the FUA device
>>>> feature. Patch 3 enables FUA support by default for any drive that
>>>> reports supporting the feature.
>>>>
>>>> Changes from v1:
>>>>    - Removed Maciej's patch 2. Instead, blacklist drives which are known
>>>>      to have a buggy FUA support.
>>>>
>>>> Damien Le Moal (3):
>>>>     ata: libata: cleanup fua handling
>>>>     ata: libata: blacklist FUA support for known buggy drives
>>>>     ata: libata: Enable fua support by default
>>>>
>>>
>>> Thanks for the updated series.
>>>
>>> In general (besides the small commit message thing that Sergey had
>>> already mentioned) it looks good to me, so:
>>> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>
>> Thanks. I need to do some more testing using some very old drives I found.
>> So far, no issues: detection works, some drives have FUA, other not. For
>> the ones that have FUA, I am running fstests (ext4 and xfs) to check for
>> weird behavior with REQ_FUA writes. Once I complete all tests I will queue
>> this.
> 
> Actually, I need to take this back. Checking again the code, I found an
> issue with this entire FUA support: for a drive that does not support NCQ,
> or one that has NCQ but has its queue depth set to one, then for a REQ_FUA
> write request, ATA_CMD_WRITE_MULTI_FUA_EXT or ATA_CMD_WRITE_FUA_EXT will
> be used. All good, BUT ! sd.c may also send read requests with the FUA bit
> set if the read request has REQ_FUA set. For read commands, the regular,
> non FUA commands ATA_CMD_READ_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_READ
> or ATA_CMD_READ_EXT will be used since ATA does not define a FUA version
> of these. This means that the REQ_FUA flag will be ignored: this entire
> code is broken as it is assuming that the read command processing on the
> drive is consistent with executions of ATA_CMD_WRITE_MULTI_FUA_EXT or
> ATA_CMD_WRITE_FUA_EXT. I do not want to bet on that, especially with old
> drives.
> 
Now you got me confused.
What exactly would be the semantics of a READ request with the FUA bit 
set? Ignore the cache and read from disk?
That would only make sense if the cache went out of sync with the drive, 
which really shouldn't happen, no?

> I would be tempted to restrict FUA support to drives that support NCQ,
> given that with NCQ, both READ FPDMA QUEUED and READ FPDMA WRITE have the
> FUA bit. But then, the problem is that if the user changes the queue depth
> of the drive to 1 through sysfs, ncq is turned off and we are back to
> using the EXT read & write commands, that is, only write has FUA.
> 
Hmm. Is this a requirement? We _could_ use the NCQ variants even with a 
queue depth of 1, no?

> So if we want a solid ata FUA support, we would need to always use NCQ
> regardless of the drive max queue depth setting...
> 
Sure, that would be the way I would be going.
If the drive supports NCQ we should always be using the FPDMA variants, 
irrespective of the queue depth.
Additionally we _might_ make FUA dependent on NCQ, and disallow FUA for 
non-NCQ drives.
(Where it's questionable anyway; if you only have a single command 
outstanding the pressure on any internal cache is far less as with NCQ.)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

