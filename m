From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 02:02:11 -0400
Message-ID: <46552A63.4080002@pobox.com>
References: <20070515061239.611A2DDEE9@ozlabs.org> <1179209697.32247.153.camel@localhost.localdomain> <20070523144217.5abd9fdf@the-village.bc.nu> <1179960518.32247.948.camel@localhost.localdomain> <20070524003123.77b9c81c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40934 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757607AbXEXGCS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 02:02:18 -0400
In-Reply-To: <20070524003123.77b9c81c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

MMIO has always been like this (libata-core.c):

         /* software reset.  causes dev0 to be selected */
         iowrite8(ap->ctl, ioaddr->ctl_addr);
         udelay(20);     /* FIXME: flush */
         iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
         udelay(20);     /* FIXME: flush */
         iowrite8(ap->ctl, ioaddr->ctl_addr);

The problem is mainly in finding registers you can read without side 
effects or confusing the controller which might also be doing in-silicon 
reset procedures.

The above is not correct per PCI posting, hence the FIXME, but it works 
so far for all tested cases.

The timing is irrelevant for SATA (this merely triggers a FIS to be 
sent).  Most of PATA is not MMIO, so this problem is avoided.  Thus the 
potential affected cases are PATA MMIO, which is largely PDC and SiI, IIRC.

Ben's patch got merged because it does not change the status quo.  This 
warrants looking at -- its a core problem as shown above -- but it 
requires thinking and testing on a problematic platform :)  Maybe we can 
read a PCI config register or innocuous vendor-specific register, for 
the flush, on the few cases where it matters.

	Jeff



