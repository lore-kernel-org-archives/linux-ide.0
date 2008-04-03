From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Thu, 03 Apr 2008 12:15:23 +0900
Message-ID: <47F44BCB.7030005@gmail.com>
References: <47F1736F.8020104@rtr.ca> <47F1755F.9000303@rtr.ca> <47F2F002.9070401@gmail.com> <47F3E3A8.10309@rtr.ca> <47F429B0.7020204@gmail.com> <47F44572.5010100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:43183 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758922AbYDCDPa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 23:15:30 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3198338wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2008 20:15:30 -0700 (PDT)
In-Reply-To: <47F44572.5010100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
>> The MV specific part is retry-if-offline w/ lower link speed, right? 
>> You can do that just as well by looping outside of 
>> sata_link_hardreset().  
> ..
> 
> Yes, the code already has a loop "outside of sata_link_hardreset()"
> for the speed errata handling.  So nothing new there.
> 
> And the rest of that routine is a line-by-line clone of 
> ata_std_hardreset().
> This is smaller than what other drivers have cloned for these routines,
> and a lot better than the old code from sata_mv that it replaces.
> 
> The comment in my patch above is just a reminder that someday we could
> go back in and address those things.  In *all* LLDs, not just sata_mv.
> 
> I guess I'd better stop adding such comments in the future..  :)
> 
> Still think it needs any changes ?

The modularize patchset is not in libata-dev#upstream yet.  Please take 
a look at the following.

http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=blob;f=drivers/ata/libata-core.c;h=7646523899c0bac8b06d2d0bfcde428e4583e04d;hb=731e61759c56d564322d56b9ff6f393fda1fbec4#l3533

I meant that you wouldn't need to copy the post-reset stuff and just 
could loop around new sata_link_hardreset() after the patchset.  I 
thought about breaking sata_link_hardreset() into two such that the 
post-reset part can be used separately but couldn't find any in-tree 
driver which would need such function.

-- 
tejun
