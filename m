From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 13 May 2004 15:36:26 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084484186.4524.3.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9> <40A3E595.8000003@pobox.com><40A3E7E5.
	6060403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:35220 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264161AbUEMVgu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 17:36:50 -0400
In-Reply-To: <40A3E7E5.6060403@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> Are you willing to work 

Yes I want to learn.

I figure I can learn fastest by helping.

> on a separate, pre-requisite patch:
> 
> We need to split ata_bmdma_start_{pio,mmio} into separate "setup" and 
> "start" pieces.
> 
> This would involve adding a "bmdma_setup" hook to struct 
> ata_port_operations in include/linux/libata.h, and then doing a simple
> update of all the SATA drivers, to use the default libata-core 
> implementations.

Sorry as yet I understand very little of the above.

Until corrected I will guess I should next:

1) Find a spare PATA UDMA HDD, with UDMA mode above 2 to suit the SATA/
PATA bridge.

2) Connect Linux to SATA/ PATA to PATA UDMA HDD.

3) Turn ATA_DEBUG ATA_VERBOSE_DEBUG on in 2.6.6-bk1.

4) Report back here for next assignment.

Pat LaVarre

