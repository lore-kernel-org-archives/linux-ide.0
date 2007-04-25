From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175
 init_sched_clock()
Date: Wed, 25 Apr 2007 11:21:46 +0100
Message-ID: <20070425112146.16d076c0@the-village.bc.nu>
References: <462E4C4D.9020806@gmail.com>
	<20070425011654.222a2b4b.akpm@linux-foundation.org>
	<462F1481.8010807@gmail.com>
	<20070425085432.GD17130@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40108 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751042AbXDYKSV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 06:18:21 -0400
In-Reply-To: <20070425085432.GD17130@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Berck E. Nash" <flyboy@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

>  static void ahci_freeze(struct ata_port *ap)
>  {
> +	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  
>  	/* turn IRQ off */
>  	writel(0, port_mmio + PORT_IRQ_MASK);
> +
> +	/* clear IRQ pending bit */
> +	writel(1 << ap->port_no, mmio + HOST_IRQ_STAT);


Neither of those two are going to help in all cases. They are PCI writes
to mmio so they are posted. You don't know they hit the device until a
read cycle coming back has completed, so you need to read something after
doing this to be sure.
