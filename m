From: Mikael Pettersson <mikpe@it.uu.se>
Subject: sata_promise.c:pdc_irq_clear() buglet?
Date: Sun, 11 May 2008 23:21:01 +0200
Message-ID: <18471.25405.877617.621279@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38425 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760565AbYEKVVL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 May 2008 17:21:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff,

In the 2.6.8 kernel you added sata_promise.c:pdc_irq_clear()
which looks as follows:

>static void pdc_irq_clear(struct ata_port *ap)
>{
>        struct ata_host *host = ap->host;
>        void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
>
>        readl(mmio + PDC_INT_SEQMASK);
>}

I have two issues with this code:
1. It reads from the SEQMASK register, which is global for
   all ports. Hence, calling pdc_irq_clear() on one port
   potentially affects all ports.
2. Promise's drivers (both 1st and 2nd generation chip drivers)
   instead read the port's ATA Command/Status register when
   they want to clear any pending IRQs.

Did you write the code this way on purpose, or did you just
accidentally use the wrong mechanism?

If you have no objections, I intend to change this to read
Command/Status instead.

/Mikael
