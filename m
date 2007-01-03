From: Bjorn Wesen <bjorn.wesen@axis.com>
Subject: 2.6.20-rc3 IRQ race upon resume? => killing SATA IRQ
Date: Thu, 4 Jan 2007 00:26:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0701040006300.15167@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bart.se.axis.com ([193.13.178.9]:39843 "EHLO bart.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198AbXACXtd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 18:49:33 -0500
Received: from bart.se.axis.com (bart.se.axis.com [127.0.0.1])
	by bart.se.axis.com (Postfix) with ESMTP id 9C2BD641BB
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2007 00:26:54 +0100 (CET)
Received: from godzilla.se.axis.com (godzilla.se.axis.com [10.84.17.11])
	by bart.se.axis.com (Postfix) with ESMTP id 8E987641BA
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2007 00:26:54 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi folks,

There is only one thing keeping suspend-to-ram on my Sony Vaio SZ2 laptop 
from working currently, and that is that most of the times I suspend/resume, 
the SATA HD becomes blocked. Looking closer it is because an irq occurs 
during resume, which reaches ata_interrupt, it does not handle it, and Linux 
responds by blocking it permanently (the dreaded irq X: nobody cared).

The SZ2 has a Core Duo CPU, ICH7 and SATA is handled by the ata_piix driver. 
No other PCI interrupts are mapped or enabled to the same interrupt.

I can't help thinking this looks like a race, because it resumes correctly 
sometimes and then the HD works perfectly fine. Perhaps the SATA driver 
hasn't recovered itself at the time the first irq occurs and thus it feels 
it shouldn't handle it ?

I can't paste in the dmesg because the HD locks when it happens and thus 
it's not written to it, but essentially, the "nobody cared" msg comes after 
the extra CPU core is brought up, then the irq is disabled, then the ata 
driver is trying to reconfigure the devices and then it locks up.

I can debug it but I'd need some pointers on where to start. For example, 
one strategy could be to try forcing an acknowledge of the interrupt somehow 
in the bottom of ata_interrupt if it feels it can't handle an interrupt 
(I've only programmed embedded linux before not i386 so I don't know where 
to ack such an irq - in the PCI bridge itself, or in the ATA device ? :).

Another strategy could be to find the reason why the interrupt is not 
handled by enabling some debug or something which I haven't really looked 
into yet...

Any ideas ?

Regards,

Bjorn
