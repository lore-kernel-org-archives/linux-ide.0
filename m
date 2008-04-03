From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Thu, 03 Apr 2008 09:49:52 +0900
Message-ID: <47F429B0.7020204@gmail.com>
References: <47F1736F.8020104@rtr.ca> <47F1755F.9000303@rtr.ca> <47F2F002.9070401@gmail.com> <47F3E3A8.10309@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:22625 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbYDCAuB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 20:50:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3138154wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2008 17:49:58 -0700 (PDT)
In-Reply-To: <47F3E3A8.10309@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
> ..
>>> +    /* FIXME:
>>> +     * Except for the outer do-while construct below, this function
>>> +     * is an exact clone of sata_std_hardreset() from libata-core.c.
>>> +     *
>>> +     * Once this driver is stable, we should re-org libata so we can 
>>> share
>>> +     * more of that code, rather than duplicating so much of it here
>>> +     * and in other drivers.
>>> +     */
>>
>> After modularize patchsets, sata_link_hardreset() does all the chores 
>> needed around hardreset and sata_mv should be able to just build a 
>> loop around it.
> ..
> 
> Mmm... I don't see how this helps.
> 
> The bulk of mv_sata_hardreset() is from sata_std_hardreset().
> 
> The only part those two do *not* have in common, is that
> sata_mv needs to do it's own equivalent of sata_link_hardreset(),
> so sata_link_hardreset() cannot be reused here.  Wrapper or not.
> 
> Now, if we had a per-LLD .link_hardreset op, defaulting to 
> sata_link_hardreset,
> then this would be trivial.

The MV specific part is retry-if-offline w/ lower link speed, right? 
You can do that just as well by looping outside of 
sata_link_hardreset().  It will fail fast if link is offline (not very 
different from your inner loop) and do everything you need to w/ proper 
check_ready() callback on success path.  Am I missing something?

Thanks.

-- 
tejun
