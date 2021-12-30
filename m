Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA7C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 30 Dec 2021 13:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhL3Nrw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Dec 2021 08:47:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhL3Nrv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2021 08:47:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE1E71F37C;
        Thu, 30 Dec 2021 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640872070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HK86uqN7T/niRMWbddbxO36UoKIkrcmT1FYaI3FRnfU=;
        b=CXpL3F14eFHk8L8E+6E7hRH9qNFMbFqAQotwoQKPpwZb2Www4RMe+CHmb8NGivaVVfbHDD
        aSHL20QWvl4SL+yp0s+K7pVTC31ySfHrUXGzKLDLO+K35SIcS4sgINnlcoAvKxFezY8of4
        dQmplkTxSsePio1ZWSLuwEIO9eMLUOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640872070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HK86uqN7T/niRMWbddbxO36UoKIkrcmT1FYaI3FRnfU=;
        b=QNi0vZHSKsChsjIOb0t4kF2X9kcMROKdHeladmdkdrcHKCrLBSidzS4oIhgGeObx07eFTu
        4hx8hrrn5CXlrDCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92F2513BDA;
        Thu, 30 Dec 2021 13:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D0h7Ioa4zWFaTAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 30 Dec 2021 13:47:50 +0000
Subject: Re: [PATCHv3 00/68] libata: rework logging, take II
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211221072131.46673-1-hare@suse.de>
 <e22c1fc6-b707-a6f0-74bf-d911adec4a5b@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <08361e45-f5b9-f2c5-7861-e042c6ace044@suse.de>
Date:   Thu, 30 Dec 2021 14:47:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e22c1fc6-b707-a6f0-74bf-d911adec4a5b@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/30/21 6:19 AM, Damien Le Moal wrote:
> On 12/21/21 16:20, Hannes Reinecke wrote:
>> Hi all,
>>
>> after some prodding from individual persons I've resurrected my
>> patchset to put libata logging on a even keel, and use structured
>> logging for everything.
>> So this patch does away with DPRINTK, ATA_DEBUG or ata_msg_XXX()
>> calls, and moves everything over to structured logging
>> (ie the dev_XXX() calls).
>> Additionally I've added tracepoints to trace command flow,
>> error handling, host state machine etc.
>>
>> So everything is looking far saner now.
>>
>> As usual, comments and reviews are welcome.
>>
>> I know that the device names suck. Blame Tejun.
> 
> I applied this series, temporarily, to the branch for-5.17-logging, with
> the fixes I commented about.
> 
> After some light testing, seems OK, but need to hammer this a little more.
> 
> My main concern is the change in patch 12: using the dev_xxx() macros
> directly changes the messages from being all prefixed with "ataX.X" to
> different flavors (devX.X, linkX.X, portX.X, etc). While I do like the
> code simplification, this makes reading dmesg to track how a device is
> behaving very hard.
> 
And that was exactly what I had been hinting at with my last sentence :-)

Original sin here is to have completely generic names for ata device 
objects (link-X? C'mon).

And trying to twiddle with the devnames will land you in the mess we are 
in now, _and_ you lose the link between device names in sysfs and what's 
printed in the logging message, making debugging ever so much fun.
(And I'm not even going into the _very_ slim distinction between port, 
link, and dev here ...)

> Defining dev_fmt() everywhere the ata_{port,link,dev}_XXX functions are
> used would solve this, but that is annoying as almost all drivers would
> need to define that. Looking at the dev_XXX() macros, I do not see an
> easy solution. Any idea ?
> 
I guess the only sane solution would be to have a clean break by 
introducing a new config variable like ATA_NEW_SYSFS_NAMING.
Then we could have 'sane' sysfs names like 'ata_port', 'ata_link', and 
'ata_dev', _and_ would avoid the 'sysfs is ABI and cannot be modified'
trap.

Plan would be to send a prep patch to partially revert patch 12, so as 
to re-introduce the original formatting, but keeping the new accessors.
And then have an additional patch to introduce the new-style sysfs 
layout, with the new config option. Which clearly would default to 'n' 
for now.

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
