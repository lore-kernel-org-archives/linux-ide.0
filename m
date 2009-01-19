From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2.6.29-rc2] palm_bk3710 buildfix
Date: Mon, 19 Jan 2009 16:03:06 +0300
Message-ID: <49747A0A.2000305@ru.mvista.com>
References: <200901180833.53969.david-b@pacbell.net> <4973635A.2050302@ru.mvista.com> <200901191300.48836.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:50954 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758917AbZASNCf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 08:02:35 -0500
In-Reply-To: <200901191300.48836.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linux-ide@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>  CC      drivers/ide/palm_bk3710.o
>>>drivers/ide/palm_bk3710.c: In function 'palm_bk3710_probe':
>>>drivers/ide/palm_bk3710.c:382: warning: assignment makes integer from pointer without a cast

>>>Someone should fix hw_regs_t to neither be a typedef, nor
>>>use "unsigned long" where it should use "void __iomem *".

>>    It cannot use pointers of course -- as the addresses can be I/O ports.

>>>Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

>>>--- a/drivers/ide/palm_bk3710.c
>>>+++ b/drivers/ide/palm_bk3710.c
>>>@@ -346,7 +346,8 @@ static int __init palm_bk3710_probe(stru
>>> {
>>> 	struct clk *clk;
>>> 	struct resource *mem, *irq;
>>>-	unsigned long base, rate;
>>>+	void __iomem *base;
>>>+	unsigned long rate;
>>> 	int i, rc;
>>> 	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
>>> 
>>>@@ -382,11 +383,13 @@ static int __init palm_bk3710_probe(stru
>>> 	base = IO_ADDRESS(mem->start);
>>> 
>>> 	/* Configure the Palm Chip controller */
>>>-	palm_bk3710_chipinit((void __iomem *)base);
>>>+	palm_bk3710_chipinit(base);
>>> 
>>> 	for (i = 0; i < IDE_NR_PORTS - 2; i++)
>>>-		hw.io_ports_array[i] = base + IDE_PALM_ATA_PRI_REG_OFFSET + i;
>>>-	hw.io_ports.ctl_addr = base + IDE_PALM_ATA_PRI_CTL_OFFSET;
>>>+		hw.io_ports_array[i] = (unsigned long)
>>>+				(base + IDE_PALM_ATA_PRI_REG_OFFSET + i);
>>>+	hw.io_ports.ctl_addr = (unsigned long)
>>>+			(base + IDE_PALM_ATA_PRI_CTL_OFFSET);

>>    Ugh. I suggest adding another variable...

>>--- a/drivers/ide/palm_bk3710.c
>>+++ b/drivers/ide/palm_bk3710.c
>>@@ -346,7 +346,8 @@ static int __init palm_bk3710_probe(stru
>>  {
>>  	struct clk *clk;
>>  	struct resource *mem, *irq;
>>  	unsigned long base, rate;
>>+	void __iomem *regs;
>>  	int i, rc;
>>  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
>>
>>@@ -379,11 +380,11 @@ static int __init palm_bk3710_probe(stru
>>  		return -EBUSY;
>>  	}
>>
>>- 	base = IO_ADDRESS(mem->start);
>>+ 	regs = IO_ADDRESS(mem->start);
>>
>>  	/* Configure the Palm Chip controller */
>>-	palm_bk3710_chipinit((void __iomem *)base);
>>+	palm_bk3710_chipinit(regs);
>>
>>+	base = (unsigned long)regs;
>>  	for (i = 0; i < IDE_NR_PORTS - 2; i++)
>>  		hw.io_ports_array[i] = base + IDE_PALM_ATA_PRI_REG_OFFSET + i;
>>  	hw.io_ports.ctl_addr = base + IDE_PALM_ATA_PRI_CTL_OFFSET;

> I applied original patch since having one additional cast has overally lower
> complexity than having an additional variable...

    Grr... as if the stack use aren't optimized by gcc based on the variable 
lifetimes. I can recast the patch myself BTW.

MBR, Sergei
