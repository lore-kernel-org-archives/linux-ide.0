From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 14 May 2004 12:28:29 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084559309.4017.59.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:27078 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262020AbUENS2x
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 14:28:53 -0400
In-Reply-To: <40A3E595.8000003@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > +static unsigned int atapi_xlat(struct ata_queued_cmd *qc, u8
> *scsicmd)
> > +{
> > +     int bcl = (8 * 0x400); /* PIO "byte count limit" */
> 
> Make this a more obvious "8 * 1024".
> 
> For the sake of correctness, I prefer to call this "DRQ block size" 
> rather than the more ambigous "byte count limit".
> 
> This is important because some AHCI SATA controllers can only transfer
> a _single_ DRQ block per disk transaction.  In anticipation of the
> demise of PIO, no doubt :)

Perhaps I should check:

Are we agreed that this bcl is the max permissible byte count for a PIO
DRQ, distinct from the actual byte count of a PIO DRQ?

For example, if our limit is x800, then the t13.org texts let the device
reply with x200 + x600 + x800 + x400 ...  They allow any distribution of
addends, so long as no single INTRQ asks for more than the limit we set.

ATAPI often, but not reliably, implies x800 bytes/lba = 2 KiB/lba, by
way of implying but not requiring PDT x05 MMC = DVD/CD.

Pat LaVarre


