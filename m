From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] atapi request sense work
Date: Fri, 21 May 2004 19:45:23 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40AE9493.1040701@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu	 .	pl><1085162347.4791.24.camel@patibmrh9> <1085170025.3083.91.camel@patibm	r h9><40AE79E1.9020005@pobox.com> <1085182749.3122.15.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9187 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265171AbUEUXph
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 19:45:37 -0400
In-Reply-To: <1085182749.3122.15.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> kernel: ata_host_intr: BUS_NODATA (drv_stat 0x50)
> kernel: irq 18: nobody cared!


Can you print out the BMDMA status register (often called 'host_stat' in 
the code)?  I wonder if that indicates ATA_DMA_INTR for example.

	Jeff


