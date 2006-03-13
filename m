From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Mon, 13 Mar 2006 03:09:33 -0500
Message-ID: <441528BD.8070708@pobox.com>
References: <441525DB.40905@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43744 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932345AbWCMIJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 03:09:36 -0500
In-Reply-To: <441525DB.40905@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> ata_check_atapi_dma() fix for LLDDs with the ATA_FLAG_PIO_POLLING flag.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> We don't support polling DMA.
> If the LLDD handles only interrupts in the HSM_ST_LAST state 
> (indicated by the ATA_FLAG_PIO_POLLING flag) and the ATAPI device
> generates CDB interrupts, we have to use the polling PIO protocol.
> (Otherwise, the CDB interrupts might confuse the LLDD.)
> 
> We just set the protocol to PIO here in ata_check_atapi_dma().
> Later in ata_qc_issue_prot(), the PIO protocol will be set as "polling"
> for those LLDDs.
> 
> Patch against the irq-pio branch +
> (1) irq-pio minor fixes (respin) +
> (2) integrate polling pio with irq-pio (respin)

Applied, though I think its an open question what happens with 
CDB-interrupt ATAPI devices want to do DMA.  Perhaps we just get an 
interrupt event that we clear, then life proceeds as normal.

Does anybody actually have such a device anywhere?  :)

	Jeff



