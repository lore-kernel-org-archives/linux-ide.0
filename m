From: Nick Piggin <npiggin@suse.de>
Subject: Re: patch "libata-sff: Fix oops for pnp devices with no ctl" causes regression
Date: Thu, 5 Jun 2008 12:21:29 +0200
Message-ID: <20080605102129.GB11366@wotan.suse.de>
References: <20080605050923.GD11811@wotan.suse.de> <20080605102424.0cf56c37@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:34243 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985AbYFEKVb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jun 2008 06:21:31 -0400
Content-Disposition: inline
In-Reply-To: <20080605102424.0cf56c37@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@redhat.com, linux-ide@vger.kernel.org

On Thu, Jun 05, 2008 at 10:24:24AM +0100, Alan Cox wrote:
> > And when booting with the commit applied, I instead get a whole lot of
> > messages like this (this is the first one, copied by hand):
> > 
> > ata2.00: exception Emask 0x0 SAct 0x0 Serr 0x10000000 action 0x6 frozen
> > ata2: SError: { }
> > ata2.00: cmd c8/00:02:42:08:20/00:00:00:00:00/e0 tag 0 dma 1024 in
> >          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> > ata2.00: status: { DRDY }
> > ata2: hard resetting link
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata2.00: configured for UDMA/133
> > ata2: EH complete
> 
> Well I've been over the patch twice now and I cannot see a single point
> at which the sequence of code that *should* be executed is any different.

If it is of any help to you, doing this:
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 90d20c6..f6cb8d7 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1583,6 +1583,12 @@ inline unsigned int ata_sff_host_intr(struct ata_port *ap
        if (status & ATA_BUSY)
                goto idle_irq;

+       /* check main status, clearing INTRQ */
+       status = ap->ops->sff_check_status(ap);
+       if (unlikely(status & ATA_BUSY))
+               goto idle_irq;
+
+
        /* ack bmdma irq events */
        ap->ops->sff_irq_clear(ap);

Gets it working again...


> Stick wmb();rmb(); (or similar barriers to compiler optimisation and I/O
> fencing) at the start and end of your ata_sff_altstatus() and see what
> happens, if it suddenly decides to behave or forcing it no inline makes
> it behave then that would be useful info.

Will give that a try next

