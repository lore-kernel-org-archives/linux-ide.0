From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] AHCI: Remove an unnecessary flush from ahci_qc_issue
Date: Fri, 11 Jul 2008 09:49:37 -0400
Message-ID: <487764F1.6070707@pobox.com>
References: <1215350600-5179-1-git-send-email-matthew@wil.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56038 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760192AbYGKNtm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jul 2008 09:49:42 -0400
In-Reply-To: <1215350600-5179-1-git-send-email-matthew@wil.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ide@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>

Matthew Wilcox wrote:
> In an I/O heavy workload (IOZone), ahci_qc_issue is the second-highest
> consumer of CPU cycles.  Removing the flush gets us approximately 10%
> bandwidth improvement.  I believe this to be because the CPU can start
> queueing the next request instead of waiting for the readl() to flush the
> writes to the device.  The flush isn't necessary because we're using a
> 'queue' metaphor; we don't guarantee the command has got to the device,
> nor do we need to guarantee the command has got to the controller.
> 
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
>  drivers/ata/ahci.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 6a7a70a..58915bd 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1846,7 +1846,6 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
>  	if (qc->tf.protocol == ATA_PROT_NCQ)
>  		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
>  	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
> -	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
>  

applied


