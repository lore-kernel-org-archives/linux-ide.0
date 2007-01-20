From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] sata_promise: issue ATAPI commands as normal packets
Date: Fri, 19 Jan 2007 19:13:16 -0500
Message-ID: <45B15E9C.1070309@garzik.org>
References: <200701132031.l0DKV5Z7010283@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53730 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964769AbXATANS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 19:13:18 -0500
In-Reply-To: <200701132031.l0DKV5Z7010283@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> This patch (against libata #upstream + the ATAPI cleanup patch)
> reimplements sata_promise's ATAPI support to format ATAPI DMA
> commands as normal packets, and to issue them via the hardware's
> normal packet machinery.
> 
> It turns out that the only reason for issuing ATAPI DMA
> commands via the pdc_issue_atapi_pkt_cmd() procedure was to
> perform two interrupt-fiddling steps for ATA_DFLAG_CDB_INTR
> devices. But these steps aren't needed because sata_promise
> sets ATA_FLAG_PIO_POLLING, which disables DMA for those devices.
> The remaining steps can easily be done in ATA taskfile packets.
> 
> Concrete changes:
> - pdc_atapi_dma_pkt() is extended to program all packet setup
>   steps, and not just contain the CDB; the sequence of steps
>   exactly mirrors what pdc_issue_atapi_pkt_cmd() did
> - pdc_atapi_dma_pkt() needed more parameters: simplify it by
>   just passing 'qc' and having it extract the data it needs
> - pdc_issue_atai_pkt_cmd() and its two helper procedures
>   pdc_wait_for_drq() and pdc_wait_on_busy() are removed
> 
> Tested on first- and second-generation chips, SATAPI and PATAPI,
> with no observable regressions.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Applied patches 1-2.

ATAPI handling looks _so_ much better, now that you're using packets, 
doesn't it?  :)

	Jeff



