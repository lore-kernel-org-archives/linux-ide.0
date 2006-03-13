From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/5] libata-dev: Let ata_hsm_move() work with both irq-pio
 and polling pio
Date: Mon, 13 Mar 2006 02:55:52 -0500
Message-ID: <44152588.10908@pobox.com>
References: <440FEA4B.10500@tw.ibm.com> <44136D61.4020007@pobox.com> <4415203F.4070103@tw.ibm.com> <4415231B.1090906@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:15328 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932329AbWCMHzz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 02:55:55 -0500
In-Reply-To: <4415231B.1090906@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> +static int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
> +			 u8 status, int in_wq)
>  {
> +	unsigned long flags = 0;
> +	int poll_next;
> +
>  	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
>  
> +	/* Make sure ata_qc_issue_prot() does not throw things
> +	 * like DMA polling into the workqueue. Notice that
> +	 * in_wq is not equivalent to (qc->tf.flags & ATA_TFLAG_POLLING).
> +	 */
> +	WARN_ON(in_wq != ((qc->tf.flags & ATA_TFLAG_POLLING) ||
> +			  (ap->hsm_task_state == HSM_ST_FIRST &&
> +			   ((qc->tf.protocol == ATA_PROT_PIO &&
> +			     (qc->tf.flags & ATA_TFLAG_WRITE)) ||
> +			    (is_atapi_taskfile(&qc->tf) &&
> +			     !(qc->dev->flags & ATA_DFLAG_CDB_INTR))))));


applied patches 1-5 to the irq-pio branch.

Please provide a follow-up patch which makes the above test more 
readable.  For example:

static inline int things_ok_in_wq(input...)
{
	if (test 1)
		return 0;
	if (test 2)
		return 0;
	return 1;	
}

