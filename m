From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE Hotswap
Date: Wed, 29 Sep 2004 18:46:23 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096479982.15905.71.camel@localhost.localdomain>
References: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com>
	 <200409291408.55211.bzolnier@elka.pw.edu.pl>
	 <1096468515.15905.43.camel@localhost.localdomain>
	 <200409292020.25192.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:58762 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268834AbUI2Sth (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 14:49:37 -0400
In-Reply-To: <200409292020.25192.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Suresh Grandhi <Sureshg@ami.com>, "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>

On Mer, 2004-09-29 at 19:20, Bartlomiej Zolnierkiewicz wrote:
> > Doesn't occur in the 2.4 situation or the 2.6 stuff with the locking in
> > the 2.6.8.1-ac patch.
> 
> I will verify this in a few days, I have some real work to do first.

2.6 is the important stuff sure.

> > > - double unlock obvious mistake
> > Details ?
> 
> 2003/08/16 alan               | 	/* Drive shutdown sequence done */
> 2003/08/16 alan               | 	/* Prevent new opens ?? */
> 2003/08/16 alan               | 	spin_unlock_irqrestore(&io_request_lock, flags);
> 2003/08/16 alan               | 	/*
> 2003/08/16 alan               | 	 * Flush kernel side caches, and dump the /proc files
> 2003/08/16 alan               | 	 */
> 2003/08/16 alan               | 	spin_unlock_irqrestore(&io_request_lock, flags);
> 

Thanks. I'll go over this when I dig out the one little bit 2.4.2x needs
for hotplug to behave right with hard disks that I should get to
Marcelo.

> OK BKL protects us against i.e. concurrent HDIO_GETGEO
> and hotplug ioctl.  There is however no protection for controller
> hotplug.

Agreed.


