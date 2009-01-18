From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2.6.29-rc2] palm_bk3710 buildfix
Date: Sun, 18 Jan 2009 20:14:02 +0300
Message-ID: <4973635A.2050302@ru.mvista.com>
References: <200901180833.53969.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:24900 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759898AbZARRN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2009 12:13:29 -0500
In-Reply-To: <200901180833.53969.david-b@pacbell.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Hello.

David Brownell wrote:

>   CC      drivers/ide/palm_bk3710.o
> drivers/ide/palm_bk3710.c: In function 'palm_bk3710_probe':
> drivers/ide/palm_bk3710.c:382: warning: assignment makes integer from pointer without a cast

> Someone should fix hw_regs_t to neither be a typedef, nor
> use "unsigned long" where it should use "void __iomem *".

    It cannot use pointers of course -- as the addresses can be I/O ports.

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

> --- a/drivers/ide/palm_bk3710.c
> +++ b/drivers/ide/palm_bk3710.c
> @@ -346,7 +346,8 @@ static int __init palm_bk3710_probe(stru
>  {
>  	struct clk *clk;
>  	struct resource *mem, *irq;
> -	unsigned long base, rate;
> +	void __iomem *base;
> +	unsigned long rate;
>  	int i, rc;
>  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
>  
> @@ -382,11 +383,13 @@ static int __init palm_bk3710_probe(stru
>  	base = IO_ADDRESS(mem->start);
>  
>  	/* Configure the Palm Chip controller */
> -	palm_bk3710_chipinit((void __iomem *)base);
> +	palm_bk3710_chipinit(base);
>  
>  	for (i = 0; i < IDE_NR_PORTS - 2; i++)
> -		hw.io_ports_array[i] = base + IDE_PALM_ATA_PRI_REG_OFFSET + i;
> -	hw.io_ports.ctl_addr = base + IDE_PALM_ATA_PRI_CTL_OFFSET;
> +		hw.io_ports_array[i] = (unsigned long)
> +				(base + IDE_PALM_ATA_PRI_REG_OFFSET + i);
> +	hw.io_ports.ctl_addr = (unsigned long)
> +			(base + IDE_PALM_ATA_PRI_CTL_OFFSET);

    Ugh. I suggest adding another variable...

--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -346,7 +346,8 @@ static int __init palm_bk3710_probe(stru
  {
  	struct clk *clk;
  	struct resource *mem, *irq;
  	unsigned long base, rate;
+	void __iomem *regs;
  	int i, rc;
  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };

@@ -379,11 +380,11 @@ static int __init palm_bk3710_probe(stru
  		return -EBUSY;
  	}

- 	base = IO_ADDRESS(mem->start);
+ 	regs = IO_ADDRESS(mem->start);

  	/* Configure the Palm Chip controller */
-	palm_bk3710_chipinit((void __iomem *)base);
+	palm_bk3710_chipinit(regs);

+	base = (unsigned long)regs;
  	for (i = 0; i < IDE_NR_PORTS - 2; i++)
  		hw.io_ports_array[i] = base + IDE_PALM_ATA_PRI_REG_OFFSET + i;
  	hw.io_ports.ctl_addr = base + IDE_PALM_ATA_PRI_CTL_OFFSET;

MBR, Sergei
