From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Wed, 27 Oct 2004 10:02:56 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <417FD4C0.20107@osdl.org>
References: <58cb370e04102706074c20d6d7@mail.gmail.com> <200410271215.55472.gene.heskett@verizon.net> <58cb370e04102709221d6a9103@mail.gmail.com> <200410271305.06265.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fire.osdl.org ([65.172.181.4]:3528 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262544AbUJ0RSQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Oct 2004 13:18:16 -0400
In-Reply-To: <200410271305.06265.gene.heskett@verizon.net>
List-Id: linux-ide@vger.kernel.org
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, torvalds@osdl.org, linux-ide@vger.kernel.org

Gene Heskett wrote:
> On Wednesday 27 October 2004 12:22, Bartlomiej Zolnierkiewicz wrote:
> 
>>On Wed, 27 Oct 2004 12:15:55 -0400, Gene Heskett
>>
>><gene.heskett@verizon.net> wrote:
>>
>>>On Wednesday 27 October 2004 09:07, Bartlomiej Zolnierkiewicz 
> 
> wrote:
> 
>>>>Please do a
>>>>
>>>>bk pull bk://bart.bkbits.net/ide-2.6
>>>>
>>>>This will update the following files:
>>>>
>>>>drivers/ide/ide-disk.c         |    1 +
>>>>drivers/ide/ide-dma.c          |   32
>>>
>>>Even after fixing the 4 wrapped lines in the patch, I'm not going
>>>in cleanly here:
>>>
>>>patching file drivers/ide/ide-dma.c
>>>Hunk #1 FAILED at 681.
>>>1 out of 1 hunk FAILED -- saving rejects to file
>>>drivers/ide/ide-dma.c.rej
>>>
>>>The first 'grep' line of the patch is found at an offset of about
>>>+180 lines in the original file.
>>>
>>>The rest of it seems to have found a home, but at offsets in
>>>excess of 159 lines for a few of them.
>>>
>>>This was against a 2.6.9 tree, and 2.6.9-mm1 failed in similar
>>>fashion.  What src tree is this to be applied to?
>>
>>current linus' -bk tree, latest -bk snapshot should also be OK
> 
> 
> Drat.  I can't afford bitkeeper, either the time or the resources.
> So I assume this will be in 2.6.10-rc2 or 3?

Gene,

BK isn't required.  Just get the daily snapshot from
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/
and apply it to 2.6.10-rc1 (or whatever is latest).

-- 
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
