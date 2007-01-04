From: Bjorn Wesen <bjorn.wesen@axis.com>
Subject: Re: 2.6.20-rc3 IRQ race upon resume? => killing SATA IRQ
Date: Thu, 4 Jan 2007 02:55:49 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0701040244300.15167@localhost.localdomain>
References: <Pine.LNX.4.64.0701040006300.15167@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bart.se.axis.com ([193.13.178.9]:42725 "EHLO bart.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbXADBzu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 20:55:50 -0500
Received: from bart.se.axis.com (bart.se.axis.com [127.0.0.1])
	by bart.se.axis.com (Postfix) with ESMTP id AD3236416D
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2007 02:55:49 +0100 (CET)
Received: from godzilla.se.axis.com (godzilla.se.axis.com [10.84.17.11])
	by bart.se.axis.com (Postfix) with ESMTP id A0EB3640FA
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2007 02:55:49 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0701040006300.15167@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Just adding some info here!

I added this to the bottom of ata_interrupt in libata-core.c which fixed the 
problem:

         if(!handled) {
           printk("ata_interrupt nobody cared. Trying to clear irq src\n");
           for (i = 0; i < host->n_ports; i++) {
             struct ata_port *ap;

             ap = host->ports[i];

             ata_bmdma_irq_clear(ap);
           }
           handled = 1;
         }

The result was that the above message comes 3 times in a row during resume, 
then it silences and everything works. Also, I noticed that ata_host_intr is 
not called in these cases, so when the interrupt reaches the driver after 
the resume, it ignores it probably because it thinks it has no QC active 
(correctly probably). Question is, where is the irq coming from then.

Obviously this is a horribly wrong fix, since if the interrupt is shared, we 
will shadow the other interrupt so it never gets run (and corrupt our own 
BM DMA operations).

A bit troubling that it seems to happen 3 times in a row, so anything simple 
like clearing the BM IRQ status bit during the first stage of resume is not 
enough perhaps (and I guess it already does that when re-initializing?).

For reference, I found this message from november about ICH7 and spurious BM 
interrupts and a (not optimal) solution:

http://marc.theaimsgroup.com/?l=linux-ide&m=116373296023279&w=2

/Bjorn

On Thu, 4 Jan 2007, Bjorn Wesen wrote:

> Hi folks,
>
> There is only one thing keeping suspend-to-ram on my Sony Vaio SZ2 laptop 
> from working currently, and that is that most of the times I suspend/resume, 
> the SATA HD becomes blocked. Looking closer it is because an irq occurs 
> during resume, which reaches ata_interrupt, it does not handle it, and Linux 
> responds by blocking it permanently (the dreaded irq X: nobody cared).
>
> The SZ2 has a Core Duo CPU, ICH7 and SATA is handled by the ata_piix driver. 
> No other PCI interrupts are mapped or enabled to the same interrupt.
>
> I can't help thinking this looks like a race, because it resumes correctly 
> sometimes and then the HD works perfectly fine. Perhaps the SATA driver 
> hasn't recovered itself at the time the first irq occurs and thus it feels it 
> shouldn't handle it ?
>
> I can't paste in the dmesg because the HD locks when it happens and thus it's 
> not written to it, but essentially, the "nobody cared" msg comes after the 
> extra CPU core is brought up, then the irq is disabled, then the ata driver 
> is trying to reconfigure the devices and then it locks up.
>
> I can debug it but I'd need some pointers on where to start. For example, one 
> strategy could be to try forcing an acknowledge of the interrupt somehow in 
> the bottom of ata_interrupt if it feels it can't handle an interrupt (I've 
> only programmed embedded linux before not i386 so I don't know where to ack 
> such an irq - in the PCI bridge itself, or in the ATA device ? :).
>
> Another strategy could be to find the reason why the interrupt is not handled 
> by enabling some debug or something which I haven't really looked into yet...
>
> Any ideas ?
>
> Regards,
>
> Bjorn
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
