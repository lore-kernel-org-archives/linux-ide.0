From: Tejun Heo <htejun@gmail.com>
Subject: Re: Comments - using the qc_defer hook for serializing controllers
 ?
Date: Mon, 10 Dec 2007 17:46:01 +0900
Message-ID: <475CFCC9.8000408@gmail.com>
References: <20071205152658.563466b7@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:55236 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbXLJIqH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 03:46:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1549513rvb
        for <linux-ide@vger.kernel.org>; Mon, 10 Dec 2007 00:46:07 -0800 (PST)
In-Reply-To: <20071205152658.563466b7@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> +/**
> + *	sl82c105_qc_defer	-	implement serialization
> + *	@qc: command
> + *
> + *	We must issue one command per host not per channel because
> + *	of the reset bug.
> + *
> + *	Q: is the scsi host lock sufficient ?
> + */
> +
> +static int sl82c105_qc_defer(struct ata_queued_cmd *qc)
> +{
> +	struct ata_host *host = qc->ap->host;
> +	int rc;
> +
> +	/* First apply the usual rules */	
> +	rc = ata_std_qc_defer(qc);
> +	if (rc != 0)
> +		return rc;
> +
> +	/* Now apply serialization rules. Only allow a command if the
> +	   other channel state machine is idle */
> +	if (host->port[0] != qc->ap && 
> +			host->port[0]->hsm_task_state != HSM_ST_IDLE)
> +		return	ATA_DEFER_PORT;
> +	if (host->port[1] != qc->ap && 
> +			host->port[1]->hsm_task_state != HSM_ST_IDLE)
> +		return	ATA_DEFER_PORT;
> +	return 0;
> +}

hsm_task_state is not necessarily protected by host lock.  I think
testing ap->qc_active would be better.

-- 
tejun
