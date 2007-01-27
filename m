From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: use 0x80 as wait stat value instead of 0xff
Date: Sat, 27 Jan 2007 10:33:16 +0900
Message-ID: <45BAABDC.1040606@gmail.com>
References: <20070126063720.GG8606@htj.dyndns.org> <45BA8091.1080509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:46774 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbXA0BdY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2007 20:33:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so862208uga
        for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2007 17:33:23 -0800 (PST)
In-Reply-To: <45BA8091.1080509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Before hardreset, ahci initialized stat part of received FIS area to
>> 0xff to wait for the first D2H Reg FIS which would change the value to
>> device ready state.  This used to work but now libata considers status
>> value of 0xff as device not present making this wait prone to failure.
>>
>> This patch makes ahci use 0x80 for the wait stat value instead of
>> 0xff to fix the above problem.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>  drivers/ata/ahci.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> For the future, please make sure to include the "---" terminator prior
> to the diffstat, otherwise it will get copied into the kernel changelog.

Argh... sure.  My mistake.  Sorry.

-- 
tejun
