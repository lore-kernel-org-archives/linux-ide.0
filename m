Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0747C0502A
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 07:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiHaHTS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 03:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiHaHSe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 03:18:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687879EFD
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 00:15:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AEAE81FE6F;
        Wed, 31 Aug 2022 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661930129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHmdqo9CznwwLiqCmHU1iJNQUxak0+5TlrlmLi/Trig=;
        b=qg8QXzxZrhY9KnGHmvBbQfPOej/39tMnqlDDVF+y2XkEe0OLLGkhLUm2U2V34nMOsPD8As
        q39cjFkjB51UCyOMtG+6U2+gMAfDeJBLArXIHwxJ88d25wwl5D88Dqre+dsNQYbzgRTnCG
        OMOpidZGAQQ4bCkN+P2DfFez9ntiiwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661930129;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHmdqo9CznwwLiqCmHU1iJNQUxak0+5TlrlmLi/Trig=;
        b=41T0TCnmiFvvtVMt2+0fSVjwPe9HdDb3vZPBf/N0/uw4uAyZBpbl9CIiZ8X//9HEgJxE2M
        TMdeRTTRJM1LgpDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96C271332D;
        Wed, 31 Aug 2022 07:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cOupI5EKD2PuCQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 31 Aug 2022 07:15:29 +0000
Message-ID: <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
Date:   Wed, 31 Aug 2022 09:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?Q?Peter_Fr=c3=b6hlich?= <peter.hans.froehlich@gmail.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com>
 <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com>
 <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
 <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/31/22 03:40, Damien Le Moal wrote:
> On 2022/08/30 16:02, Peter Fröhlich wrote:
>> On Tue, Aug 30, 2022 at 1:26 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>>> On Mon, 2022-08-29 at 08:04 +0200, Peter Fröhlich wrote:
>>>> That's the sense_table, I was referring to the stat_table. That table
>>>> is consulted when we fail to convert via the sense_table.
>>> ...
>>> So looking at the right code again, this is all very strange. E.g. the
>>> ACS specs define bit 5 of the status field as the "device fault" bit,
>>> but the code looks at 0x08, so bit 3. For write command, the definition
>>> is:
>>>
>>> STATUS
>>> Bit Description
>>> 7:6 Transport Dependent – See 6.2.11
>>> 5 DEVICE FAULT bit – See 6.2.6
>>> 4 N/A
>>> 3 Transport Dependent – See 6.2.11
>>> 2 N/A
>>> 1 SENSE DATA AVAILABLE bit – See 6.2.9
>>> 0 ERROR bit – See 6.2.8
>>>
>>> And the code is:
>>>
>>>          static const unsigned char stat_table[][4] = {
>>>                  /* Must be first because BUSY means no other bits valid
>>> */
>>>                  {0x80,          ABORTED_COMMAND, 0x47, 0x00},
>>>                  // Busy, fake parity for now
>>>                  {0x40,          ILLEGAL_REQUEST, 0x21, 0x04},
>>>                  // Device ready, unaligned write command
>>>                  {0x20,          HARDWARE_ERROR,  0x44, 0x00},
>>>                  // Device fault, internal target failure
>>>                  {0x08,          ABORTED_COMMAND, 0x47, 0x00},
>>>                  // Timed out in xfer, fake parity for now
>>>                  {0x04,          RECOVERED_ERROR, 0x11, 0x00},
>>>                  // Recovered ECC error    Medium error, recovered
>>>                  {0xFF, 0xFF, 0xFF, 0xFF}, // END mark
>>>          };
>>>
>>> So this does not match at all. Something wrong here, or, the "status"
>>> field being observed here is not the one I am thinking of. Checking
>>> AHCI & SATA-IO specs, I do not see anything matching there either.
>>
>> Thank you for confirming that this section *is* confusing. I was down
>> the same rabbit-hole checking "status" in whatever ATA spec I could
>> get my hands on, and it didn't help. Specifically for "WRITE DMA"
>> where I usually see the error, it seems that bit 6 has no other
>> meaning than "transport dependent" which for SATA means (I believe)
>> "drive ready" as it's always been. But that 0x40 is *not* an
>> "unaligned write" whatever else it may be. My suspicion is that maybe
>> it went in by accident since it's also in a "whitespace" commit. On
>> the other hand, it has an explicit comment. I wasn't going to bother
>> the original author before, but maybe now I should?
> 
> +Hannes
> 
> Except for bit 0x20 (device fault), the other bits do not match anything
> sensible either. So I wonder what specs this is against. Hannes ? 7-years old
> patch... I am sure your memory is very fresh about this one :)
> 
Oh, of course :-)
That was when doing SMR support for libata.
I dimly remember that some pre-spec drives had been using the DRDY bit 
to signal an unaligned write. Which never made it into the spec, but the 
decoding stayed.

Will be sending a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
