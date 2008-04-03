From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Thu, 03 Apr 2008 10:04:20 -0400
Message-ID: <47F4E3E4.5080706@rtr.ca>
References: <47F1736F.8020104@rtr.ca> <47F1755F.9000303@rtr.ca> <47F2F002.9070401@gmail.com> <47F3E3A8.10309@rtr.ca> <47F429B0.7020204@gmail.com> <47F44572.5010100@rtr.ca> <47F44BCB.7030005@gmail.com> <47F4E341.9080609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1631 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757492AbYDCOEV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Apr 2008 10:04:21 -0400
In-Reply-To: <47F4E341.9080609@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> Tejun Heo wrote:
>
>> The modularize patchset is not in libata-dev#upstream yet.  Please 
>> take a look at the following.
>>
>> http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=blob;f=drivers/ata/libata-core.c;h=7646523899c0bac8b06d2d0bfcde428e4583e04d;hb=731e61759c56d564322d56b9ff6f393fda1fbec4#l3533 
>>
>> I meant that you wouldn't need to copy the post-reset stuff and just 
>> could loop around new sata_link_hardreset() after the patchset.  I 
>> thought about breaking sata_link_hardreset() into two such that the 
>> post-reset part can be used separately but couldn't find any in-tree 
>> driver which would need such function.
> ..
> 
> Ah well, that's all of no use then, because sata_mv has to go upstream 
> now for 2.6.26.
> People have been waiting for this driver to improve for a very long time 
> now.
> 
> Given the time lag of the submission pipeline I'm forced to use for it,
> there likely is not enough time left to wait for another major rework
> of libata, and then rework sata_mv to match.
..

Though, mind you.. as soon as your rework *does* hit upstream,
I'll happily submit further sata_mv patches to take full advantage.

The less custom code in sata_mv in the end, the happier I'll be.
That's why there's a comment there right now reminding me of it.
 
> Basically, anything I do to sata_mv has to be tested here first,
> then broken into Jeff-size bites, fed to Marvell, approved by them,
> then posted here, then reworked according to the whims of the day,
> then resent to Marvell, reapproved by them, then reposted here, ...
> 
> It just takes too long overall.
> 
> Cheers
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

