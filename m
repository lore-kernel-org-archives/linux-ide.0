From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Date: Wed, 04 May 2005 13:59:28 -0400
Message-ID: <42790D80.6020300@tmr.com>
References: <66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local><66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local> <20050503172845.GA12944@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:18576 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261244AbVEDR7Q
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 May 2005 13:59:16 -0400
In-Reply-To: <20050503172845.GA12944@oskar>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Oskar Liljeblad <oskar@osk.mine.nu>
Cc: Drew Winstel <DWinstel@Miltope.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Oskar Liljeblad wrote:
> On Tuesday, May 03, 2005 at 11:53, Drew Winstel wrote:
> 
>>I think I know what the problem is.
>>
>>In include/linux/libata.h, make sure the preprocessor declarations are as 
>>follows.  I think the defaults have ATA_ENABLE_PATA undefined.
>>
>>#define ATA_ENABLE_ATAPI        /* undefine to disable ATAPI support */
>>#define ATA_ENABLE_PATA          /* define to enable PATA support in some
>>                                 * low-level drivers */
> 
> 
> Thanks, now it loads correctly. Unfortunately the clock drift still occurs
> with pata_pdc2027x. I'm guessing here, but can clock drift have anything
> to do with IRQs? Also, is it normal to see errors in /proc/interrupt?

Are you by chance running ntpd? And have you checked to see if it dies 
as soon as it starts? There's a bug in the ntp M/L wrt execstack.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
