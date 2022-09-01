Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D67AECAAD8
	for <linux-ide@archiver.kernel.org>; Thu,  1 Sep 2022 06:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiIAGNr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 1 Sep 2022 02:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiIAGNq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Sep 2022 02:13:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF11195C4
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 23:13:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB2221FA76;
        Thu,  1 Sep 2022 06:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662012822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3v+EpcS8KnmbSzuZUy60J0KuaqBn91KLqahGQvld8bc=;
        b=L/snPvRr6qr5f7tKddbAu1tr+zh/lNrgmh0QZNUTackQhMSq2JjIR+jbUGWrjZ1MXtrOSs
        FSDPSuLIIVkwArgqUUMJmXaxTXyOaTtg2xpnjuiO8iM9kl2hfsoO1B5WU9Iavl8kAmMuOo
        WiEfSO7jT/gzzVhUNVoihg9r77iGmLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662012822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3v+EpcS8KnmbSzuZUy60J0KuaqBn91KLqahGQvld8bc=;
        b=qv1WBbK8uh8zi+gsXxo7VGwWukP1dpdLU3K9IuQ2nmq1RVnq6nUi11CwTiTAr9oScBiOKF
        UbQ0uKVN3kcgzwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E63413316;
        Thu,  1 Sep 2022 06:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bu6qHJZNEGOWFwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 01 Sep 2022 06:13:42 +0000
Message-ID: <ed854cd3-3456-4dfc-e589-40f4946bb0e7@suse.de>
Date:   Thu, 1 Sep 2022 08:13:42 +0200
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
 <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
 <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com>
 <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
 <CAHXXO6HZDNdsUC69COBU9MpEgkCCKJNw3OceBgW23WSAG+_wBw@mail.gmail.com>
 <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/1/22 00:54, Damien Le Moal wrote:
> On 8/31/22 22:30, Peter Fröhlich wrote:
>> Sorry for spamming replies and quoting myself.
>>
>> On Wed, Aug 31, 2022 at 12:21 PM Peter Fröhlich
>> <peter.hans.froehlich@gmail.com> wrote:
>>> On Wed, Aug 31, 2022 at 9:48 AM Damien Le Moal
>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>> On 8/31/22 16:15, Hannes Reinecke wrote:
>>>>> Oh, of course :-)
>>>>> That was when doing SMR support for libata.
>>>>> I dimly remember that some pre-spec drives had been using the DRDY bit
>>>>> to signal an unaligned write. Which never made it into the spec, but the
>>>>> decoding stayed.
>>>>
>>>> Any idea where the other bits come from ? Except for bit 5 (device fault),
>>>> I do not see anything else in the specs that mandate these definitions...
>>>
>>> I have since discovered the "SCSI to ATA" specification which has two
>>> tables about mapping ATA errors to SCSI errors. Among those I was able
>>> to find an "unaligned write" case as well, but I cannot properly parse
>>> the rest of the two tables yet. They are in sections 11.6 and 11.7 of
>>> that document.
>>
>> So I've re-read everything I can get my hands on and from what I can
>> tell the overall "flow" of ata_to_sense_error() is not what the
>> specifications would imply. For example we look at BSY on entry and
>> then say "ah, it's set, then let's ignore the error field" when the
>> specification (the way I read it) instead says "BSY is transport
>> dependent, so we say nothing about it here; but check the error bit in
>> status, if it is set, interpret the error field, otherwise there's
>> nothing for you in the error field". Of course I am a complete noob
>> when it comes to this ATA/SATA/SCSI/AHCI stuff, so please divide by at
>> least two. Sorry if this adds more confusion on top.
> 
> I had a quick look at the specs again. I already spotted an error: when
> the status device fault bit is set, the sense should be HARDWARE ERROR /
> INTERNAL TARGET FAILURE and not ABORTED COMMAND / 0x47 like now. That is
> according to SAT-5. But looking at ACS-5, sections 6 and 7.1.6, there are
> *a lot* of cases that need to be taken care of. It looks like the
> sense_table does that, but need to cross check.
> 
> As for the stat_table, except for the first buggy entry as mentioned
> above, I have no clue where these come from. SAT only defines the HARDWARE
> ERROR / INTERNAL TARGET FAILURE for when the status field device fault bit
> is set. Need to dig further, but I am afraid this code may be due to years
> of supporting drives returning weird errors that got mapped to sensible
> sense codes instead of a pure implementation of the specs...
> 
> I need to spend some quality time with ACS and SAT documents to sort out
> this one... And lots of coffee too probably :)
> 
And, to make matters ever more complicated, the error and status bits 
changed over time. And even the SAT translation changed between versions.
So there really is no clear "that's the way to go" style of thing; if we 
want to be correct we would need to evaluate the ATA version for that 
device, and have different translation tables depending on the version.

Not sure if it's worth it, though; in the end it's just an error 
description which will get changed. Commands will be aborted in either 
case, so the net result is close to zero :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
