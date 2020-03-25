Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A36C54FCF
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D9020774
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 17:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCYRBd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:01:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:49264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgCYRBd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 25 Mar 2020 13:01:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 144BBADCC;
        Wed, 25 Mar 2020 17:01:32 +0000 (UTC)
Subject: Re: [PATCH] sata_fsl: build fix
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Guenter Roeck <linux@roeck-us.net>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
References: <CGME20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81@eucas1p1.samsung.com>
 <98bf5f87-3601-efd5-57ce-58e6db308e95@samsung.com>
 <87a9e403-efd2-5464-9e8c-4d966ed1ab39@kernel.dk>
 <5e52900b-6674-4220-15e4-8156ebd98df5@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4eaa5514-ea9b-1682-60b2-7da173529cfc@suse.de>
Date:   Wed, 25 Mar 2020 18:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5e52900b-6674-4220-15e4-8156ebd98df5@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/20 5:25 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 3/25/20 4:17 PM, Jens Axboe wrote:
>> On 3/25/20 9:15 AM, Bartlomiej Zolnierkiewicz wrote:
>>> Fix incorrect DPRINTK() conversion in sata_fsl_init_controller()
>>> (dev_dbg() should be used instead of ata_port_dbg()).
>>
>> Thanks Bart, another piece of fallout. Applied.
>>
>> With the recent discussion as well, I wonder if we should just kill
>> this series entirely.
> I hate to admit it but probably yes..
> 
> It seems that the one of base concepts needs to be redesigned and
> we are at -rc7 so it is a bit too late do it now..
> 
> I've also tried to find a way to revert it partially but changes are
> inter-dependent and it doesn't seem to be easy way to do it..
> 
> Hannes?
> 
Seeing that we are late in the game and the dev_printk() fallacies are 
indeed there I fear that you are correct.
Jens, again, sorry for the mess.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
