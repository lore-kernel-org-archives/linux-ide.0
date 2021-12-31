Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF59C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 31 Dec 2021 04:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbhLaEtl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Dec 2021 23:49:41 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:47940 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237595AbhLaEtk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2021 23:49:40 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JQCNh1S09z1RtVc
        for <linux-ide@vger.kernel.org>; Thu, 30 Dec 2021 20:49:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640926179; x=1643518180; bh=kWNh95J9hLfgwoZI+wWVd2G6wcUw1dcGvRN
        q5GD38QM=; b=EH2JxVGklI8cetmF386ICBnQIH/Y97yGpktWBS0HCMOHIWuNNy4
        2Ls2f0JmToSeG/gvMuKqRf8OYC1i9wtXilFaCb90mdb0jvm/7HYdUYoCNzPTwnmf
        GMnq/5F7cTbYr2U/HxRr7Hfl194PZFuyWaDcBwIHJgyCXUVN3uyxV/rQXNtGDp0Z
        o6P4i2L+o0deZBfF9/P8UXjgfNTMClcYaHGfqKzDyOSF5a3vpNVE37aIejF1hrzG
        rgfhx7B3tJ+QJCw5hwjlVGbta2XhWG/XRl+sMMcXq51NNR0Co1A1olTTH990JpUo
        BPakEKzW676CQc/WRe/jlmBLeXzYnM0a9FA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u8ClzLKquPHv for <linux-ide@vger.kernel.org>;
        Thu, 30 Dec 2021 20:49:39 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JQCNg1wCQz1RtVG;
        Thu, 30 Dec 2021 20:49:39 -0800 (PST)
Message-ID: <b00d657e-50d5-d17d-4f27-677d73e0be00@opensource.wdc.com>
Date:   Fri, 31 Dec 2021 13:49:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv3 00/68] libata: rework logging, take II
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211221072131.46673-1-hare@suse.de>
 <e22c1fc6-b707-a6f0-74bf-d911adec4a5b@opensource.wdc.com>
 <08361e45-f5b9-f2c5-7861-e042c6ace044@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <08361e45-f5b9-f2c5-7861-e042c6ace044@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/30/21 22:47, Hannes Reinecke wrote:
> On 12/30/21 6:19 AM, Damien Le Moal wrote:
>> On 12/21/21 16:20, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> after some prodding from individual persons I've resurrected my
>>> patchset to put libata logging on a even keel, and use structured
>>> logging for everything.
>>> So this patch does away with DPRINTK, ATA_DEBUG or ata_msg_XXX()
>>> calls, and moves everything over to structured logging
>>> (ie the dev_XXX() calls).
>>> Additionally I've added tracepoints to trace command flow,
>>> error handling, host state machine etc.
>>>
>>> So everything is looking far saner now.
>>>
>>> As usual, comments and reviews are welcome.
>>>
>>> I know that the device names suck. Blame Tejun.
>>
>> I applied this series, temporarily, to the branch for-5.17-logging, with
>> the fixes I commented about.
>>
>> After some light testing, seems OK, but need to hammer this a little more.
>>
>> My main concern is the change in patch 12: using the dev_xxx() macros
>> directly changes the messages from being all prefixed with "ataX.X" to
>> different flavors (devX.X, linkX.X, portX.X, etc). While I do like the
>> code simplification, this makes reading dmesg to track how a device is
>> behaving very hard.
>>
> And that was exactly what I had been hinting at with my last sentence :-)
> 
> Original sin here is to have completely generic names for ata device 
> objects (link-X? C'mon).
> 
> And trying to twiddle with the devnames will land you in the mess we are 
> in now, _and_ you lose the link between device names in sysfs and what's 
> printed in the logging message, making debugging ever so much fun.
> (And I'm not even going into the _very_ slim distinction between port, 
> link, and dev here ...)
> 
>> Defining dev_fmt() everywhere the ata_{port,link,dev}_XXX functions are
>> used would solve this, but that is annoying as almost all drivers would
>> need to define that. Looking at the dev_XXX() macros, I do not see an
>> easy solution. Any idea ?
>>
> I guess the only sane solution would be to have a clean break by 
> introducing a new config variable like ATA_NEW_SYSFS_NAMING.
> Then we could have 'sane' sysfs names like 'ata_port', 'ata_link', and 
> 'ata_dev', _and_ would avoid the 'sysfs is ABI and cannot be modified'
> trap.
> 
> Plan would be to send a prep patch to partially revert patch 12, so as 
> to re-introduce the original formatting, but keeping the new accessors.
> And then have an additional patch to introduce the new-style sysfs 
> layout, with the new config option. Which clearly would default to 'n' 
> for now.
> 
> Hmm?

For the ata_xxx_printk() functions, what about something simpler like this:

+#define ata_port_printk(level, ap, fmt, ...)                   \
+       pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)

 #define ata_port_err(ap, fmt, ...)                             \
-       ata_port_printk(ap, KERN_ERR, fmt, ##__VA_ARGS__)
+       ata_port_printk(err, ap, fmt, ##__VA_ARGS__)
 #define ata_port_warn(ap, fmt, ...)                            \
-       ata_port_printk(ap, KERN_WARNING, fmt, ##__VA_ARGS__)
+       ata_port_printk(warn, ap, fmt, ##__VA_ARGS__)
 #define ata_port_notice(ap, fmt, ...)                          \
-       ata_port_printk(ap, KERN_NOTICE, fmt, ##__VA_ARGS__)
+       ata_port_printk(notice, ap, fmt, ##__VA_ARGS__)
 #define ata_port_info(ap, fmt, ...)                            \
-       ata_port_printk(ap, KERN_INFO, fmt, ##__VA_ARGS__)
+       ata_port_printk(info, ap, fmt, ##__VA_ARGS__)
 #define ata_port_dbg(ap, fmt, ...)                             \
-       ata_port_printk(ap, KERN_DEBUG, fmt, ##__VA_ARGS__)
+       ata_port_printk(debug, ap, fmt, ##__VA_ARGS__)
+
+#define ata_link_printk(level, link, fmt, ...)                 \
+do {                                                           \
+       if (sata_pmp_attached((link)->ap) ||                    \
+           (link)->ap->slave_link)                             \
+               pr_ ## level ("ata%u.%02u: " fmt,               \
+                             (link)->ap->print_id,             \
+                             (link)->pmp,                      \
+                             ##__VA_ARGS__);                   \
+        else                                                   \
+               pr_ ## level ("ata%u: " fmt,                    \
+                             (link)->ap->print_id,             \
+                             ##__VA_ARGS__);                   \
+} while (0)

 #define ata_link_err(link, fmt, ...)                           \
-       ata_link_printk(link, KERN_ERR, fmt, ##__VA_ARGS__)
+       ata_link_printk(err, link, fmt, ##__VA_ARGS__)
 #define ata_link_warn(link, fmt, ...)                          \
-       ata_link_printk(link, KERN_WARNING, fmt, ##__VA_ARGS__)
+       ata_link_printk(warn, link, fmt, ##__VA_ARGS__)
 #define ata_link_notice(link, fmt, ...)                        \
-       ata_link_printk(link, KERN_NOTICE, fmt, ##__VA_ARGS__)
+       ata_link_printk(notice, link, fmt, ##__VA_ARGS__)
 #define ata_link_info(link, fmt, ...)                          \
-       ata_link_printk(link, KERN_INFO, fmt, ##__VA_ARGS__)
+       ata_link_printk(info, link, fmt, ##__VA_ARGS__)
 #define ata_link_dbg(link, fmt, ...)                           \
-       ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
+       ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
+
+#define ata_dev_printk(level, dev, fmt, ...)                   \
+        pr_ ## level("ata%u.%02u: " fmt,                       \
+               (dev)->link->ap->print_id,                      \
+              (dev)->link->pmp + (dev)->devno,                 \
+              ##__VA_ARGS__)

 #define ata_dev_err(dev, fmt, ...)                             \
-       ata_dev_printk(dev, KERN_ERR, fmt, ##__VA_ARGS__)
+       ata_dev_printk(err, dev, fmt, ##__VA_ARGS__)
 #define ata_dev_warn(dev, fmt, ...)                            \
-       ata_dev_printk(dev, KERN_WARNING, fmt, ##__VA_ARGS__)
+       ata_dev_printk(warn, dev, fmt, ##__VA_ARGS__)
 #define ata_dev_notice(dev, fmt, ...)                          \
-       ata_dev_printk(dev, KERN_NOTICE, fmt, ##__VA_ARGS__)
+       ata_dev_printk(notice, dev, fmt, ##__VA_ARGS__)
 #define ata_dev_info(dev, fmt, ...)                            \
-       ata_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
+       ata_dev_printk(info, dev, fmt, ##__VA_ARGS__)
 #define ata_dev_dbg(dev, fmt, ...)                             \
-       ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
+       ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)

And the remaining of the patch is the same. Instead of dev_xxx() this
uses pr_xxx() so we have the same dynamic debug feature and we preserve
the messages as they were until now.

Thoughts ?

I updated the for-5.17-logging branch with this, adding the following
fixes too:
* Patch 21: we need to use dev_dbg() as we cannot easily get the struct
ata_device for ata_dev_dbg().
* Build-bot warning fixes in drivers/ata/pata_atp867x.c (patch 47) and
also in sata_mv.c (patch 16). I wonder why these 2 show up now... The
warnings should exist already... Very weird.

Will test more next week after restart.

Happy new year !

Cheers.

-- 
Damien Le Moal
Western Digital Research
