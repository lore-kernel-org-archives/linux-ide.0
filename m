From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 18:12:58 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085184778.3090.1.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <
	40AE9493.1040701@pobox.com><1085184407.3289.6.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:28664 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265014AbUEVANJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 20:13:09 -0400
In-Reply-To: <1085184407.3289.6.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> kernel: ata_host_intr: (host_stat 0x24)
> kernel: ata_host_intr: BUS_NODATA (drv_stat 0x50)
> kernel: irq 18: nobody cared!

Further munging of the code shows that ATA_PROT_ATAPI_DMA ordinarily
ends by clearing x04 ATA_DMA_INTR.

I'll next try clearing x04 ATA_DMA_INTR for the no-data case too.

Pat LaVarre


