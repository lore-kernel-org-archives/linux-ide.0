From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support (revised)
Date: Wed, 30 Apr 2008 15:17:18 +0400
Message-ID: <4818553E.6040606@ru.mvista.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>	<20080428094123.59d055c7@core>	<20080428170751.097bdbe6@dxy.sh.intel.com>	<200804282101.33012.bzolnier@gmail.com>	<20080429113905.757703fd@dxy.sh.intel.com>	<48174EF9.8020208@ru.mvista.com> <20080430104931.3aaab288@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:35892 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757344AbYD3LR7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 07:17:59 -0400
In-Reply-To: <20080430104931.3aaab288@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, rob.rhoads@intel.com

Hello.

Alek Du wrote:

>>    NAK this patch completely -- both libata and IDE parts.

   In the future it would be worth to post 2 separate patches, one for IDE and 
one for libata -- since they should go thru the different maintainer trees.

>>    Luckily, I have just had a quick look at the datasheet to which you've
>>linked and that was enough to conclude that SCH is *not* compatible to
>>ICH/PIIX family, so absolutely needs a separate driver!

> Most registers are same

    Well, if you mean the standard BMDMA and standard PCI config. space 
registers (0x00 thru 0x3f), then those are mostly the same for the majority of 
the PCI IDE controllers.  Why not stick your code into one of the other driver 
instead? ;-)

> except for port enable bit, IOCFG and DMA timing. Now

    And also PIO and UDMA timings/enable. Actually, all the vendor-specific 
PCI config. registers are different from PIIX/ICH -- and that's what makes the 
PATA drivers different from each other.

> I know why my patch just works -- the BIOS set the timing correctly.

    Yeah, and we have the special drivers which rely on the BIOS doing all the 
mode programming...

> Thanks for point this out. I will post a separate driver patch later.

    In the meantwhile the only viable solution would be to stick your code 
into drivers/ide/pci/generic.c and drivers/ata/ata_generic.c.  No more hacks, 
please. :-)

> Thanks,
> Alek

MBR, Sergei
