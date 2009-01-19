From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 2.6.29-rc2] palm_bk3710 buildfix
Date: Mon, 19 Jan 2009 14:21:10 +0100
Message-ID: <200901191421.10717.bzolnier@gmail.com>
References: <200901180833.53969.david-b@pacbell.net> <200901191300.48836.bzolnier@gmail.com> <49747A0A.2000305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:38341 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbZASNVq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 08:21:46 -0500
Received: by bwz14 with SMTP id 14so8343877bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2009 05:21:44 -0800 (PST)
In-Reply-To: <49747A0A.2000305@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-ide@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Monday 19 January 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>  CC      drivers/ide/palm_bk3710.o
> >>>drivers/ide/palm_bk3710.c: In function 'palm_bk3710_probe':
> >>>drivers/ide/palm_bk3710.c:382: warning: assignment makes integer from pointer without a cast
> 
> >>>Someone should fix hw_regs_t to neither be a typedef, nor
> >>>use "unsigned long" where it should use "void __iomem *".
> 
> >>    It cannot use pointers of course -- as the addresses can be I/O ports.
> 
> >>>Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> >>>--- a/drivers/ide/palm_bk3710.c
> >>>+++ b/drivers/ide/palm_bk3710.c
> >>>@@ -346,7 +346,8 @@ static int __init palm_bk3710_probe(stru
> >>> {
> >>> 	struct clk *clk;
> >>> 	struct resource *mem, *irq;
> >>>-	unsigned long base, rate;
> >>>+	void __iomem *base;
> >>>+	unsigned long rate;
> >>> 	int i, rc;
> >>> 	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
> >>> 
> >>>@@ -382,11 +383,13 @@ static int __init palm_bk3710_probe(stru
> >>> 	base = IO_ADDRESS(mem->start);
> >>> 
> >>> 	/* Configure the Palm Chip controller */
> >>>-	palm_bk3710_chipinit((void __iomem *)base);
> >>>+	palm_bk3710_chipinit(base);
> >>> 
> >>> 	for (i = 0; i < IDE_NR_PORTS - 2; i++)
> >>>-		hw.io_ports_array[i] = base + IDE_PALM_ATA_PRI_REG_OFFSET + i;
> >>>-	hw.io_ports.ctl_addr = base + IDE_PALM_ATA_PRI_CTL_OFFSET;
> >>>+		hw.io_ports_array[i] = (unsigned long)
> >>>+				(base + IDE_PALM_ATA_PRI_REG_OFFSET + i);
> >>>+	hw.io_ports.ctl_addr = (unsigned long)
> >>>+			(base + IDE_PALM_ATA_PRI_CTL_OFFSET);
> 
> >>    Ugh. I suggest adding another variable...
> 
> >>--- a/drivers/ide/palm_bk3710.c
> >>+++ b/drivers/ide/palm_bk3710.c
> >>@@ -346,7 +346,8 @@ static int __init palm_bk3710_probe(stru
> >>  {
> >>  	struct clk *clk;
> >>  	struct resource *mem, *irq;
> >>  	unsigned long base, rate;
> >>+	void __iomem *regs;
> >>  	int i, rc;
> >>  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
> >>
> >>@@ -379,11 +380,11 @@ static int __init palm_bk3710_probe(stru
> >>  		return -EBUSY;
> >>  	}
> >>
> >>- 	base = IO_ADDRESS(mem->start);
> >>+ 	regs = IO_ADDRESS(mem->start);
> >>
> >>  	/* Configure the Palm Chip controller */
> >>-	palm_bk3710_chipinit((void __iomem *)base);
> >>+	palm_bk3710_chipinit(regs);
> >>
> >>+	base = (unsigned long)regs;
> >>  	for (i = 0; i < IDE_NR_PORTS - 2; i++)
> >>  		hw.io_ports_array[i] = base + IDE_PALM_ATA_PRI_REG_OFFSET + i;
> >>  	hw.io_ports.ctl_addr = base + IDE_PALM_ATA_PRI_CTL_OFFSET;
> 
> > I applied original patch since having one additional cast has overally lower
> > complexity than having an additional variable...
> 
>     Grr... as if the stack use aren't optimized by gcc based on the variable 
> lifetimes. I can recast the patch myself BTW.

I meant code complexity in the maintainance / readability context here.

You know what this variable is for (at least now but a year from now it may
result in a brief WTF moment when looking at base/regs) and that it is short
lived but some random person who will need to update this driver won't...

Thanks,
Bart
