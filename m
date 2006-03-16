From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Linux v2.6.16-rc6
Date: Thu, 16 Mar 2006 16:58:04 -0500
Message-ID: <4419DF6C.7000103@tmr.com>
References: <1142189154.21274.20.camel@blaze.homeip.net>	 <4414A6BF.3030604@garzik.org> <1142205571.10354.1.camel@blaze.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:50967 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964857AbWCPV4P
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Mar 2006 16:56:15 -0500
In-Reply-To: <1142205571.10354.1.camel@blaze.homeip.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Paul Blazejowski wrote:
> On Sun, 2006-03-12 at 17:54 -0500, Jeff Garzik wrote:
>> Paul Blazejowski wrote:
>>> sata_nv 0000:00:07.0: version 0.8
>> sata_nv
>>
>>> ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
>>> ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
>> host max udma6
>>
>>> ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
>>> ata3: dev 0 configured for UDMA/100
>> dev max udma5, configured for max speed
>>
>>> ata4: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
>>> ata4: dev 0 configured for UDMA/133
>> dev max udma6, configured for max speed
>>
>> Everything is correct.
>>
>> 	Jeff
>>
>>
>>
> 
> Jeff, thank you for confirming that everything looks correct. Next time
> i will be buying matching drives at the same time :-).

Since they are the same drive modulo firmware, you might contemplate 
upgrading all to the same level. NOTE: that's just a comment, not a 
recommendation.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
