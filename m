From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: when limited to a single DRQ block per disk transaction
Date: Fri, 14 May 2004 15:50:16 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A522F8.2080904@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455 9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com> <1084563455.8752.49.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21696 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262388AbUENTu2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 15:50:28 -0400
In-Reply-To: <1084563455.8752.49.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> Please can you say which controllers exhibit this limitation?

AHCI.

PIO is being deprecated...  future ATA will be DMA-only.


> Do we mean to be discussing a limit of one PATA DRQ INTRQ per CDB?

Correct.

If DRQ block size is 16 sectors, then each CDB is limited to a maximum 
of 16 sectors.

This limit does not apply to DMA.  Only to PIO, PIO multi, and ATAPI PIO.

	Jeff



