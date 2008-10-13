From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Mon, 13 Oct 2008 22:53:34 +0900
Message-ID: <48F352DE.8060001@kernel.org>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru> <48F2F138.6020103@kernel.org> <48F34CB9.3020000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39856 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbYJMN7y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 09:59:54 -0400
In-Reply-To: <48F34CB9.3020000@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Anton Vorontsov wrote:
>>> When no irq specified the pata_of_platform fills the irq_res with -1,
>>> which is wrong to do for two reasons:
>>>
>>> 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
>>> 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
>>>    is unsigned type, the check will be true for `-1'.
>>>
>>> Reported-by: Steven A. Falco <sfalco@harris.com>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>
>> applied to #tj-upstream (will soon be sent upstream)
> 
> I have returned!  muhahahahahaha....

Ah.. great.  Hope you enjoyed the vacation.  Can you please pull from
#tj-upstream?

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git tj-upstream
 http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=tj-upstream

Nothing much.  Rafael's skip-spin-off patchset + Elias's small fix +
ATA_HORKAGE_ATAPI_MOD16_DMA + pata_of_platform irq fix.

Gwendal posted patches to enable FIS based switching when NCQ is
disabled on sata_mv but I think this should be put into separate
branch and stay in linux-next till Mark Lord comes back and reviews it
as I don't know much about the driver and don't know of anyone other
than Gwendal and Mark who do.

sata_nv detection problem is still not resolved.  I figured out
generic and ck804 but nf2/3 is still malfunctioning.  I asked for more
tests and am waiting for results.

Eh... I guess that's about it.  Enjoy your INBOX.  :-P

-- 
tejun
