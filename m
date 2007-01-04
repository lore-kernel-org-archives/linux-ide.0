From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.20-rc3 IRQ race upon resume? => killing SATA IRQ
Date: Thu, 04 Jan 2007 13:37:49 +0900
Message-ID: <459C849D.4070904@gmail.com>
References: <Pine.LNX.4.64.0701040006300.15167@localhost.localdomain> <Pine.LNX.4.64.0701040244300.15167@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:9950 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242AbXADEiC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jan 2007 23:38:02 -0500
Received: by wx-out-0506.google.com with SMTP id h27so6640813wxd
        for <linux-ide@vger.kernel.org>; Wed, 03 Jan 2007 20:38:01 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701040244300.15167@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: linux-ide@vger.kernel.org

Bjorn Wesen wrote:
> Just adding some info here!
> 
> I added this to the bottom of ata_interrupt in libata-core.c which fixed
> the problem:
> 
>         if(!handled) {
>           printk("ata_interrupt nobody cared. Trying to clear irq src\n");
>           for (i = 0; i < host->n_ports; i++) {
>             struct ata_port *ap;
> 
>             ap = host->ports[i];
> 
>             ata_bmdma_irq_clear(ap);
>           }
>           handled = 1;
>         }
> 
> The result was that the above message comes 3 times in a row during
> resume, then it silences and everything works. Also, I noticed that
> ata_host_intr is not called in these cases, so when the interrupt
> reaches the driver after the resume, it ignores it probably because it
> thinks it has no QC active (correctly probably). Question is, where is
> the irq coming from then.
> 
> Obviously this is a horribly wrong fix, since if the interrupt is
> shared, we will shadow the other interrupt so it never gets run (and
> corrupt our own BM DMA operations).

It is not that horribly wrong.  The only problem you'll cause by
returning spurious non-zero handled is defeating 'nobody cared'
detection logic.  So, if the other device sharing interrupt was raising
spurious interrupt (not likely, most modern controllers have irq pending
bit and drivers can reliably tell whether it is raising interrupt or
not, IDE interface is just ooooold), the machine will lock up hard.

I'll investigate deeper when when I get some spare time but for the time
being, you solution should suffice.  Another solution would be switching
the controller into ahci mode which is much better.

-- 
tejun
