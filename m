Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B43C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 07:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiAEH7B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 02:59:01 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:21303 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229880AbiAEH7A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 02:59:00 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTMLq5Z4Lz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 23:58:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641369539; x=1643961540; bh=o0QRKaMlO8RbT7xxKfQwpTtKyFvV3CKIvFo
        5UW3tv+M=; b=FJ8hpwmKeco9r87oivir3xeoUJmLkmz6BAiUXAhFeldi0bOap17
        amN//6u922GofBJ+datRoZ5XgbXRAnat+T6IkgTq/gKwPb0WFMrPVDT9ghBL5KmJ
        qFAdfMstQSknB23qG9JJXSqjoINV0hxtdSpWIfTRuw9LwXChkq3U9Ht3iU3zUrOb
        AteAnHxxdw/FDCeuQUAT6I87rmI5HGFBClQFyDHaXnQzj92JKik6iEBh2kLq4rgM
        okh8b7U1DAOMGyLUeAXDAG5CZfcgsYJeIGIXLcJIFzSln1MBwFIj5iiROP0lW7pi
        3m0BdE9up4pEK+TdmMDlbmWZ0TRZgXkEpWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4tYKAmI-WU_B for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 23:58:59 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTMLp4Smwz1VSkV;
        Tue,  4 Jan 2022 23:58:58 -0800 (PST)
Message-ID: <51c33926-ea08-bf96-c6fd-4e031034e0ff@opensource.wdc.com>
Date:   Wed, 5 Jan 2022 16:58:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] libata: sysfs naming option
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220103090939.36238-1-hare@suse.de>
 <e48f13f0-f79a-e8a9-d8c2-cf53657d8072@opensource.wdc.com>
 <8cc29e34-2d26-5976-9176-dbeac8d602b3@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8cc29e34-2d26-5976-9176-dbeac8d602b3@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/5/22 16:41, Hannes Reinecke wrote:
> On 1/5/22 07:18, Damien Le Moal wrote:
>> On 1/3/22 18:09, Hannes Reinecke wrote:
>>> This patch adds a config option ATA_SYSFS_NAMING to align the libata
>>> device names in sysfs with those in the kernel message log.
>>> It adds a new dummy bus 'ata', which collects all ata device objects
>>> like ata_port, ata_link, and ata_dev, and adds an 'ata' prefix to the
>>> message log.
>>> For consistency the 'ata_dev' name has been changed from 'ata' to 'dev';
>>> as this induces a sysfs change the config option is disabled per default.
>>>
>>> Patch is relative to the 'for-5.17-logging' branch from Damien.
>>
>> FYI, I queued the logging series in for-5.17, minus this patch.
>> Everything is in for-next too to check that nothing is broken.
>>
>> For this patch, as I commented, I think we can keep a backward
>> compatible naming using sysfs symlinks. But I am not entirely sure if
>> that can work with port-multiplier setups. Let's work on that for the
>> next cycle ?
>>
> Well, I'm not terribly happy about the current port multiplier 
> implementation, either.
> Currently they are named 'ataX.Y.0', making them the only ata objects 
> with three levels. Personally I would take the PATA master/slave thingie 
> as an example, and just increase the last number (such that we would 
> have ata1.0, ata1.1, ata1.2 etc).
> Reasoning here is that PMP is pretty much an SATA thing, and 'slave' 
> drives is a PATA thing. So they'll never clash.

Sounds sane to me.

> 
> As for the 'ataX.Y' link; that'll require even more sysfs trickery.

Hmm, as long as we can create sysfs paths that are compatible with the
old naming scheme (which seem to differ only for the root port object
name), it may be as simple as calling sysfs_create_link() for the port
objects ?

> Let's see if I can come up with something.
> So yeah, let's hold off the patch for now.
> 
> First I need to get a PMP cable to test things out :-)

I do have some in the lab, so I can test. Just need to go to the lab,
for once :)

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
