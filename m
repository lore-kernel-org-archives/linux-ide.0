From: Pat LaVarre <p.lavarre@ieee.org>
Subject: when limited to a single DRQ block per disk transaction
Date: 14 May 2004 13:37:35 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084563455.8752.49.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455 9
	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:43729 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262339AbUENTh7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 15:37:59 -0400
In-Reply-To: <40A51604.8070208@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> > > Re: SATA ATAPI work in progress
> > > ...
> > > some AHCI SATA controllers can only transfer a _single_ DRQ block
> > > per disk transaction.  In anticipation of the demise
> > > of PIO, no doubt :)
> ...
> for controllers that are limited to a single DRQ block per 
> disk transaction,

Please can you say which controllers exhibit this limitation?

> the OS driver _must_ limit each ATA taskfile to no 
> more than a DRQ block's worth of sector.  If the ATAPI byte count limit 
> is 8K, then the OS driver must guarantee that a single ATA taskfile does 
> not transfer more than 8K.

Please can you give an example of a disk transaction that doesn't work
on some controllers?

I ask because I think somehow even this late in our thread I do not yet
understand what the limitation under discussion is.

Do we mean to be discussing a limit of one PATA DRQ INTRQ per CDB?

Pat LaVarre


