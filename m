From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Wed, 20 Jun 2007 00:07:19 +0400
Message-ID: <46783777.10607@ru.mvista.com>
References: <20070618175713.GD5836@austin.ibm.com> <4677FFF1.2010308@ru.mvista.com> <20070619164854.GR5836@austin.ibm.com> <200706192043.40298.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:39852 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762080AbXFSUFj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jun 2007 16:05:39 -0400
In-Reply-To: <200706192043.40298.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linas Vepstas <linas@austin.ibm.com>, Stuart_Hayes@dell.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>There are two distinct issues.
>>-- libata locks up in partition table read on an hpt366+old maxtor disk
>>   that has ben working fine for many years with old ide driver. (It
>>   still works fine when I boot to the alternate ide-based kernel).

>>-- ide driver locks up on hpt366+new maxtor disk under heavy 
>>   i/o load. I was able to copy 60GB from old to new disk without a
>>   problem; however, raid reconstruction locks it up, maybe after 5-15
>>   seconds.

>>   This probably is "hardware related"; its something that the new 
>>   hard drive does. Given that its being sold at a big discount, it
>>   may even be that the sellers know that this is a crappy disk. :-)

>>   All I want is some way of resetting the disk, and continuing on.

> It would be useful to see hdparm --Istdout output for *both* disks.

>>I'm stalled in debugging; I'm not sue what I'm looking for.

> Sergei, do you think that testing the drive with DMA disabled may
> tell us something new?

    Not sure. I'll try to come up with a patch esetting the state machine in 
dma_timeout() method (following Alan's idea) -- HPT366 regs are different 
enough to use the one for HPT370.

> Thanks,
> Bart

MBR, Sergei
