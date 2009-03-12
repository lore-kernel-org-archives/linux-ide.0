From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch 1/3] libata: change drive ready wait after hard reset
 to 5s
Date: Thu, 12 Mar 2009 11:19:37 +0900
Message-ID: <49B87139.3080700@kernel.org>
References: <200903041959.n24Jxl2X028532@imap1.linux-foundation.org> <49B76AA9.2030707@kernel.org> <DFEF91B22ED07447AB6AA4B237F913F902185BD2@ausx3mpc125.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37147 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbZCLCU3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 22:20:29 -0400
In-Reply-To: <DFEF91B22ED07447AB6AA4B237F913F902185BD2@ausx3mpc125.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stuart_Hayes@Dell.com
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org

Hello,

Stuart_Hayes@Dell.com wrote:
> Tejun Heo wrote:
>> Hello,
>>
>> akpm@linux-foundation.org wrote:
>>> From: Stuart Hayes <stuart_hayes@dell.com>
>>>
>>> This fixes problems during resume with drives that take longer than
>>> 1s to be ready.  The ATA-6 spec appears to allow 5 seconds for a
>>> drive to be ready. 
>>>
>>> On one affected system, this patch changes "PM: resume devices
>>> took..." message from 17 seconds to 4 seconds, and gets rid of a lot
>>> of ugly timeout/error messages.
>> Can you please attach log for this?  Which controller was it?
>>
> 
> Here's the relevant bits of the log... I don't have a copy of a whole
> log, but I should be able to get one if there's something missing that
> you need from this.  I had a more detailed description of what was
> happening in a question I posted to linux-scsi back in January
> (http://kerneltrap.org/index.php?q=mailarchive/linux-scsi/2009/1/20/4777
> 124).

After looking at the code, I think your patch is doing the right
thing.  I was worried about controllers which don't have any mechanism
to pass in the first D2H Reg FIS to the driver (sil24, for example)
but in those cases the wait logic there isn't used at all.  The only
problem would be with some port multipliers which don't send first D2H
Reg FIS after hardreset on controllers which can act on them (ahci).
This will incur 5sec detection delay on those devices but well I think
we can trade them off for more common cases.

late-but-Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
