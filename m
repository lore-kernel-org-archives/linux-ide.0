From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: when limited to a single DRQ block per disk transaction
Date: 14 May 2004 14:12:18 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084565538.3084.27.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  
	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084563455.87
	52.49.camel@patibmrh9>  <40A522F8.2080904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:983 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262499AbUENUMm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 16:12:42 -0400
In-Reply-To: <40A522F8.2080904@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> This limit does not apply to DMA.
> Only to PIO, PIO multi, and ATAPI PIO.

Understood.

> > Do we mean to be discussing a limit of one PATA DRQ INTRQ per CDB?
> 
> Correct.
> 
> If DRQ block size is 16 sectors, then each CDB is limited to a maximum 
> of 16 sectors.

To me, the limit looks worse than that.  [If I still don't get this in
your next reply, I'll now volunteer to wait a day before I reply again
in this thread.]

In PATA ATA PIO, distinct from ATAPI PIO, to guarantee at most one PATA
DRQ INTRQ per CDB when reading or writing more than one LBA/CDB, we have
to resort to ops x C4 C5 C6 = "READ MULTIPLE", "WRITE MULTIPLE", "SET
MULTIPLE MODE".  linux-2.6.6-bk1/include/linux/* gives these ops the
names WIN_SETMULT WIN_MULTREAD WIN_MULTWRITE.

In PATA ATAPI PIO, distinct from ATA PIO, we cannot guarantee at most
one PATA DRQ INTRQ per CDB, unless we limit the host to reading at most
one LBA/CDB, because the ATAPI device may issue more than the minimum
number of INTRQ that a chosen byte count limit guarantees.

Therefore the AHCI limit of at most one PATA DRQ INTRQ per CDB is in
effect an abolition of ATAPI PIO block i/o, except for the mostly
theoretical possibility of hosts and devices that together tolerate the
overhead of shattering a stream into single blocks.

Else I've misunderstood something vital.

Pat LaVarre


