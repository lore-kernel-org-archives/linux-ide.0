From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Tue, 13 Nov 2007 08:49:15 -0500
Message-ID: <4739AB5B.7000703@rtr.ca>
References: <471C6C44.2030607@gmail.com> <471CEDD4.5040201@garzik.org> <471D25D0.9020702@rtr.ca> <47397784.9070205@tw.ibm.com> <47397CC0.1070401@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1284 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbXKMNtR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Nov 2007 08:49:17 -0500
In-Reply-To: <47397CC0.1070401@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> After an error condition, some ATAPI tape drives set DRQ=1 together with ERR=1
> when asking the host to transfer the CDB of the next packet command (i.e. request sense).
> This patch workarounds the problem by ignoring the ERR bit and proceed REQUEST SENSE.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Mark Lord <liml@rtr.ca>
..
> +			if (qc->tf.protocol == ATA_PROT_PIO ||
> +			    qc->cdb[0] != REQUEST_SENSE) {
> +				ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
> +						"error, dev_stat 0x%X\n", status);
> +				qc->err_mask |= AC_ERR_HSM;
> +				ap->hsm_task_state = HSM_ST_ERR;
> +				goto fsm_start;
> +			}
..

NAK.  There's no guarantee that the next command after an error
will always be REQUEST_SENSE.   Or is there?

I think we should just ignore the ERR bit when DRQ is set for PACKET command.
Period.  Possibly only for tape drives (since they all seem to do this),
and maybe not for non-tape drives.

Cheers

