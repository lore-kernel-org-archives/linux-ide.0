From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Wed, 27 Oct 2004 13:05:06 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410271305.06265.gene.heskett@verizon.net>
References: <58cb370e04102706074c20d6d7@mail.gmail.com> <200410271215.55472.gene.heskett@verizon.net> <58cb370e04102709221d6a9103@mail.gmail.com>
Reply-To: gene.heskett@verizon.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out010pub.verizon.net ([206.46.170.133]:50595 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262473AbUJ0RFK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 13:05:10 -0400
In-Reply-To: <58cb370e04102709221d6a9103@mail.gmail.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org

On Wednesday 27 October 2004 12:22, Bartlomiej Zolnierkiewicz wrote:
>On Wed, 27 Oct 2004 12:15:55 -0400, Gene Heskett
>
><gene.heskett@verizon.net> wrote:
>> On Wednesday 27 October 2004 09:07, Bartlomiej Zolnierkiewicz 
wrote:
>> >Please do a
>> >
>> > bk pull bk://bart.bkbits.net/ide-2.6
>> >
>> >This will update the following files:
>> >
>> > drivers/ide/ide-disk.c         |    1 +
>> > drivers/ide/ide-dma.c          |   32
>>
>> Even after fixing the 4 wrapped lines in the patch, I'm not going
>> in cleanly here:
>>
>> patching file drivers/ide/ide-dma.c
>> Hunk #1 FAILED at 681.
>> 1 out of 1 hunk FAILED -- saving rejects to file
>> drivers/ide/ide-dma.c.rej
>>
>> The first 'grep' line of the patch is found at an offset of about
>> +180 lines in the original file.
>>
>> The rest of it seems to have found a home, but at offsets in
>> excess of 159 lines for a few of them.
>>
>> This was against a 2.6.9 tree, and 2.6.9-mm1 failed in similar
>> fashion.  What src tree is this to be applied to?
>
>current linus' -bk tree, latest -bk snapshot should also be OK

Drat.  I can't afford bitkeeper, either the time or the resources.
So I assume this will be in 2.6.10-rc2 or 3?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
