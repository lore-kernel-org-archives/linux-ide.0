From: gp <poppitzg@iomega.com>
Subject: SATAPI timing
Date: Fri, 28 Jan 2005 08:37:27 -0700
Message-ID: <83EB8C3C-7142-11D9-B91E-000A95D2AC6A@iomega.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-mx1.iomega.com ([147.178.1.72]:37055 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261454AbVA1Pnh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 10:43:37 -0500
Received: from emailmx0.iomega.com (hubble [147.178.1.70])
	by email.iomega.com (Postfix) with ESMTP id 24F122C6A
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 08:43:37 -0700 (MST)
Received: from royntex01.iomegacorp.com (unknown [147.178.90.120])
	by emailmx0.iomega.com (Postfix) with ESMTP id 1D6436D4
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 15:43:37 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff

I think I may have found an issue in the ATAPI code in the function 
atapi_packet_task.

 From my testing with the sata_via driver, I have been getting a timeout 
when sending the first inquiry command.


Here is the section of code of interest:


	/* make sure DRQ is set */
	status = ata_chk_status(ap);
	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
		goto err_out;

	/* send SCSI cdb */
	DPRINTK("send cdb\n");
	assert(ap->cdb_len >= 12);
	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);

** Wait is needed here to work correctly
DPRINTK("Wait for a bit\n");

	/* if we are DMA'ing, irq handler takes over from here */
	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
		ap->ops->bmdma_start(qc);	    /* initiate bmdma */


In the test case, the dma transfer is being used. From my perusal of 
the ATA spec in section 9.8, it looks like there needs to be a definite 
state transition before issuing the bmdma_start.

Would you take a look at this and verify my theory?
Thanks for all the hard work on these drivers.

Gary

