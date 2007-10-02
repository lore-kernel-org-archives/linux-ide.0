From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/15] qd65xx: fix deadlock on error handling
Date: Tue, 02 Oct 2007 16:59:40 +0400
Message-ID: <470240BC.9070707@ru.mvista.com>
References: <200710012333.02643.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:22363 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756055AbXJBM77 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 08:59:59 -0400
In-Reply-To: <200710012333.02643.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Stop abusing ide_lock lock (switch to a private locking).

> Fixes same issue as fixed by Alan Cox in atiixp host driver with
> commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/legacy/qd65xx.c
> ===================================================================
> --- a/drivers/ide/legacy/qd65xx.c
> +++ b/drivers/ide/legacy/qd65xx.c
> @@ -89,13 +89,15 @@
>  
>  static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
>  
> +static DEFINE_SPINLOCK(qd65xx_lock);
> +
>  static void qd_write_reg (u8 content, unsigned long reg)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&ide_lock, flags);
> +	spin_lock_irqsave(&qd65xx_lock, flags);
>  	outb(content,reg);
> -	spin_unlock_irqrestore(&ide_lock, flags);
> +	spin_unlock_irqrestore(&qd65xx_lock, flags);
>  }
>  
>  static u8 __init qd_read_reg (unsigned long reg)
> @@ -103,9 +105,9 @@ static u8 __init qd_read_reg (unsigned l
>  	unsigned long flags;
>  	u8 read;
>  
> -	spin_lock_irqsave(&ide_lock, flags);
> +	spin_lock_irqsave(&qd65xx_lock, flags);
>  	read = inb(reg);
> -	spin_unlock_irqrestore(&ide_lock, flags);
> +	spin_unlock_irqrestore(&qd65xx_lock, flags);
>  	return read;
>  }

    I don't see why all the locking above is needed at all -- isn't these 
atomic functions? :-/

> @@ -301,16 +303,15 @@ static void qd6580_set_pio_mode(ide_driv
>  
>  static int __init qd_testreg(int port)
>  {
> -	u8 savereg;
> -	u8 readreg;
>  	unsigned long flags;
> +	u8 savereg, readreg;
>  
> -	spin_lock_irqsave(&ide_lock, flags);
> +	spin_lock_irqsave(&qd65xx_lock, flags);
>  	savereg = inb_p(port);
>  	outb_p(QD_TESTVAL, port);	/* safe value */
>  	readreg = inb_p(port);
>  	outb(savereg, port);
> -	spin_unlock_irqrestore(&ide_lock, flags);
> +	spin_unlock_irqrestore(&qd65xx_lock, flags);
>  
>  	if (savereg == QD_TESTVAL) {
>  		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");

    Heh, 486 with VLB hardly needed spinlocks at all... although there *were* 
486 SMP machines -- with external LAPICs.

MBR, Sergei
