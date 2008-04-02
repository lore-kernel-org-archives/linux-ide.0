From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Wed, 02 Apr 2008 15:51:04 -0400
Message-ID: <47F3E3A8.10309@rtr.ca>
References: <47F1736F.8020104@rtr.ca> <47F1755F.9000303@rtr.ca> <47F2F002.9070401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1105 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760543AbYDBTvF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Apr 2008 15:51:05 -0400
In-Reply-To: <47F2F002.9070401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
> Mark Lord wrote:
..
>> +    /* FIXME:
>> +     * Except for the outer do-while construct below, this function
>> +     * is an exact clone of sata_std_hardreset() from libata-core.c.
>> +     *
>> +     * Once this driver is stable, we should re-org libata so we can 
>> share
>> +     * more of that code, rather than duplicating so much of it here
>> +     * and in other drivers.
>> +     */
> 
> After modularize patchsets, sata_link_hardreset() does all the chores 
> needed around hardreset and sata_mv should be able to just build a loop 
> around it.
..

Mmm... I don't see how this helps.

The bulk of mv_sata_hardreset() is from sata_std_hardreset().

The only part those two do *not* have in common, is that
sata_mv needs to do it's own equivalent of sata_link_hardreset(),
so sata_link_hardreset() cannot be reused here.  Wrapper or not.

Now, if we had a per-LLD .link_hardreset op, defaulting to sata_link_hardreset,
then this would be trivial.

??
