Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1147EC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 31 Dec 2021 09:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhLaJpb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 31 Dec 2021 04:45:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51100 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLaJpa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 31 Dec 2021 04:45:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60BDA21101;
        Fri, 31 Dec 2021 09:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640943929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9jbWyBQ0NV9MlW7kq9agGuTM9zDKMiwazofHJes3aA=;
        b=hTOYnBebtTyJBQq3hZGlzvW853eAyKV7iRkYmhRnAgf+BAuJVdZ4r2VzXWkzHRW73GzPyu
        Th8KQ2YL6SYS1/G7KE38Hkpi7FpgzGBVsGNiGha2wn7n5cd/mCfwaOxwAwk/alq939wPoT
        tygBcq73ZtCm5BQdiRITV6ZqRoFG/pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640943929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9jbWyBQ0NV9MlW7kq9agGuTM9zDKMiwazofHJes3aA=;
        b=xSMVH2gMkLs9T4KAsTNauZBoWjNB0wfuXt//EVAbxI+f+qKYIbWI9VWiDtl/gTmy3bOasz
        GAX+OBjclhKi3zCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4312313C2F;
        Fri, 31 Dec 2021 09:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8X75DjnRzmG0DwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 31 Dec 2021 09:45:29 +0000
Subject: Re: [PATCHv3 00/68] libata: rework logging, take II
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211221072131.46673-1-hare@suse.de>
 <e22c1fc6-b707-a6f0-74bf-d911adec4a5b@opensource.wdc.com>
 <08361e45-f5b9-f2c5-7861-e042c6ace044@suse.de>
 <b00d657e-50d5-d17d-4f27-677d73e0be00@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f0887300-7886-02c2-d6be-032778beb2ac@suse.de>
Date:   Fri, 31 Dec 2021 10:45:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b00d657e-50d5-d17d-4f27-677d73e0be00@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/31/21 5:49 AM, Damien Le Moal wrote:
> On 12/30/21 22:47, Hannes Reinecke wrote:
>> On 12/30/21 6:19 AM, Damien Le Moal wrote:
>>> On 12/21/21 16:20, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> after some prodding from individual persons I've resurrected my
>>>> patchset to put libata logging on a even keel, and use structured
>>>> logging for everything.
>>>> So this patch does away with DPRINTK, ATA_DEBUG or ata_msg_XXX()
>>>> calls, and moves everything over to structured logging
>>>> (ie the dev_XXX() calls).
>>>> Additionally I've added tracepoints to trace command flow,
>>>> error handling, host state machine etc.
>>>>
>>>> So everything is looking far saner now.
>>>>
>>>> As usual, comments and reviews are welcome.
>>>>
>>>> I know that the device names suck. Blame Tejun.
>>>
>>> I applied this series, temporarily, to the branch for-5.17-logging, with
>>> the fixes I commented about.
>>>
>>> After some light testing, seems OK, but need to hammer this a little more.
>>>
>>> My main concern is the change in patch 12: using the dev_xxx() macros
>>> directly changes the messages from being all prefixed with "ataX.X" to
>>> different flavors (devX.X, linkX.X, portX.X, etc). While I do like the
>>> code simplification, this makes reading dmesg to track how a device is
>>> behaving very hard.
>>>
>> And that was exactly what I had been hinting at with my last sentence :-)
>>
>> Original sin here is to have completely generic names for ata device
>> objects (link-X? C'mon).
>>
>> And trying to twiddle with the devnames will land you in the mess we are
>> in now, _and_ you lose the link between device names in sysfs and what's
>> printed in the logging message, making debugging ever so much fun.
>> (And I'm not even going into the _very_ slim distinction between port,
>> link, and dev here ...)
>>
>>> Defining dev_fmt() everywhere the ata_{port,link,dev}_XXX functions are
>>> used would solve this, but that is annoying as almost all drivers would
>>> need to define that. Looking at the dev_XXX() macros, I do not see an
>>> easy solution. Any idea ?
>>>
>> I guess the only sane solution would be to have a clean break by
>> introducing a new config variable like ATA_NEW_SYSFS_NAMING.
>> Then we could have 'sane' sysfs names like 'ata_port', 'ata_link', and
>> 'ata_dev', _and_ would avoid the 'sysfs is ABI and cannot be modified'
>> trap.
>>
>> Plan would be to send a prep patch to partially revert patch 12, so as
>> to re-introduce the original formatting, but keeping the new accessors.
>> And then have an additional patch to introduce the new-style sysfs
>> layout, with the new config option. Which clearly would default to 'n'
>> for now.
>>
>> Hmm?
> 
> For the ata_xxx_printk() functions, what about something simpler like this:
> 
> +#define ata_port_printk(level, ap, fmt, ...)                   \
> +       pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
> 
>   #define ata_port_err(ap, fmt, ...)                             \
> -       ata_port_printk(ap, KERN_ERR, fmt, ##__VA_ARGS__)
> +       ata_port_printk(err, ap, fmt, ##__VA_ARGS__)
>   #define ata_port_warn(ap, fmt, ...)                            \
> -       ata_port_printk(ap, KERN_WARNING, fmt, ##__VA_ARGS__)
> +       ata_port_printk(warn, ap, fmt, ##__VA_ARGS__)
>   #define ata_port_notice(ap, fmt, ...)                          \
> -       ata_port_printk(ap, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +       ata_port_printk(notice, ap, fmt, ##__VA_ARGS__)
>   #define ata_port_info(ap, fmt, ...)                            \
> -       ata_port_printk(ap, KERN_INFO, fmt, ##__VA_ARGS__)
> +       ata_port_printk(info, ap, fmt, ##__VA_ARGS__)
>   #define ata_port_dbg(ap, fmt, ...)                             \
> -       ata_port_printk(ap, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +       ata_port_printk(debug, ap, fmt, ##__VA_ARGS__)
> +
> +#define ata_link_printk(level, link, fmt, ...)                 \
> +do {                                                           \
> +       if (sata_pmp_attached((link)->ap) ||                    \
> +           (link)->ap->slave_link)                             \
> +               pr_ ## level ("ata%u.%02u: " fmt,               \
> +                             (link)->ap->print_id,             \
> +                             (link)->pmp,                      \
> +                             ##__VA_ARGS__);                   \
> +        else                                                   \
> +               pr_ ## level ("ata%u: " fmt,                    \
> +                             (link)->ap->print_id,             \
> +                             ##__VA_ARGS__);                   \
> +} while (0)
> 
>   #define ata_link_err(link, fmt, ...)                           \
> -       ata_link_printk(link, KERN_ERR, fmt, ##__VA_ARGS__)
> +       ata_link_printk(err, link, fmt, ##__VA_ARGS__)
>   #define ata_link_warn(link, fmt, ...)                          \
> -       ata_link_printk(link, KERN_WARNING, fmt, ##__VA_ARGS__)
> +       ata_link_printk(warn, link, fmt, ##__VA_ARGS__)
>   #define ata_link_notice(link, fmt, ...)                        \
> -       ata_link_printk(link, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +       ata_link_printk(notice, link, fmt, ##__VA_ARGS__)
>   #define ata_link_info(link, fmt, ...)                          \
> -       ata_link_printk(link, KERN_INFO, fmt, ##__VA_ARGS__)
> +       ata_link_printk(info, link, fmt, ##__VA_ARGS__)
>   #define ata_link_dbg(link, fmt, ...)                           \
> -       ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +       ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
> +
> +#define ata_dev_printk(level, dev, fmt, ...)                   \
> +        pr_ ## level("ata%u.%02u: " fmt,                       \
> +               (dev)->link->ap->print_id,                      \
> +              (dev)->link->pmp + (dev)->devno,                 \
> +              ##__VA_ARGS__)
> 
>   #define ata_dev_err(dev, fmt, ...)                             \
> -       ata_dev_printk(dev, KERN_ERR, fmt, ##__VA_ARGS__)
> +       ata_dev_printk(err, dev, fmt, ##__VA_ARGS__)
>   #define ata_dev_warn(dev, fmt, ...)                            \
> -       ata_dev_printk(dev, KERN_WARNING, fmt, ##__VA_ARGS__)
> +       ata_dev_printk(warn, dev, fmt, ##__VA_ARGS__)
>   #define ata_dev_notice(dev, fmt, ...)                          \
> -       ata_dev_printk(dev, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +       ata_dev_printk(notice, dev, fmt, ##__VA_ARGS__)
>   #define ata_dev_info(dev, fmt, ...)                            \
> -       ata_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
> +       ata_dev_printk(info, dev, fmt, ##__VA_ARGS__)
>   #define ata_dev_dbg(dev, fmt, ...)                             \
> -       ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +       ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
> 
> And the remaining of the patch is the same. Instead of dev_xxx() this
> uses pr_xxx() so we have the same dynamic debug feature and we preserve
> the messages as they were until now.
> 
> Thoughts ?
> 
Well, yes, that would serve as a 'workaround' to restore the original 
names in the kernel message log.

But the overall problem remains: device names in the message log do not 
correspond with the names in sysfs. This makes debugging really hard as 
one has to figure out how the device names are generated in order to 
find the correct sysfs entry; and I even do think that we can't 
distinguish between 'link' and 'device' names in the message log, making 
things even harder.

That is something I really like to fix, and get the libata stack in line 
with driver core standards such that we can use the standard 
dev_printk() macros.

Cheers, and indeed happy new year,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
