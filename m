From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Thu, 13 May 2004 17:25:57 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A3E7E5.6060403@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com> <1084403654.3196.31.camel@patibmrh9> <40A3E595.8000003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265130AbUEMV0K
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 17:26:10 -0400
In-Reply-To: <40A3E595.8000003@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> For an ATA device, we
> * write the taskfile, except for command
> * set up the DMA engine
> * write the command
> * write DMA-start bit
> 
> And the functions used by the low-level drivers, ata_bmdma_start_mmio 
> and ata_bmdma_start_pio, are hardcoded to use this ordering.  By 
> contrast, for ATAPI you should do:
> * set up DMA engine
> * write entire taskfile, including command
> * proceed through state diagram until DRQ==1
> * write SCSI CDB
> * write DMA-start bit


So...

Are you willing to work on a separate, pre-requisite patch:

We need to split ata_bmdma_start_{pio,mmio} into separate "setup" and 
"start" pieces.

This would involve adding a "bmdma_setup" hook to struct 
ata_port_operations in include/linux/libata.h, and then doing a simple 
update of all the SATA drivers, to use the default libata-core 
implementations.

	Jeff



