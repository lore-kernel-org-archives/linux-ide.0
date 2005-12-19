From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/14] libata: implement new reset mechanism
Date: Mon, 19 Dec 2005 00:31:37 -0500
Message-ID: <43A645B9.8050009@pobox.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218133833.GC31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:9861 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030270AbVLSFcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 00:32:01 -0500
In-Reply-To: <20051218133833.GC31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> +int ata_reset(struct ata_port *ap, unsigned int flags, unsigned int *r_classes)
> +{
> +	const unsigned int unknown[2] = { ATA_DEV_UNKNOWN, ATA_DEV_UNKNOWN };
> +	unsigned int classes[2];
> +	int ret = 0;
> +
> +	DPRINTK("ENTER\n");
> +
> +	if (ap->ops->soft_reset == NULL)
> +		flags &= ~ATA_RESET_SOFT;
> +	if (ap->ops->hard_reset == NULL)
> +		flags &= ~ATA_RESET_HARD;
> +
> +	if (!(flags & (ATA_RESET_SOFT | ATA_RESET_HARD))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> + retry:
> +	if (flags & ATA_RESET_SOFT) {
> +		memcpy(classes, unknown, sizeof(classes));
> +		ret = ap->ops->soft_reset(ap, classes);
> +		if (ret == 0) {
> +			if (!(flags & ATA_RESET_CLASSIFY) ||
> +			    classes[0] != ATA_DEV_UNKNOWN)
> +				goto success;
> +			/* no signature on SRST, try HRST */
> +			flags &= ~ATA_RESET_SOFT;
> +			ret = -ENODEV;	/* no sigature */
> +		}
> +		/* SRST failed, try HRST */
> +	}
> +
> +	if (flags & ATA_RESET_HARD) {
> +		memcpy(classes, unknown, sizeof(classes));
> +		ret = ap->ops->hard_reset(ap, classes);
> +		if (ret == 0) {
> +			if (!(flags & ATA_RESET_CLASSIFY) ||
> +			    classes[0] != ATA_DEV_UNKNOWN)
> +				goto success;
> +			/* no signature on HRST, retry SRST */
> +			flags &= ~ATA_RESET_HARD;
> +			ret = -ENODEV;	/* no sigature */
> +			goto retry;
> +		}
> +		/* HRST failed, give up */
> +	}
> +
> +	goto out;

Fundamental problem:  you should not hard code this execution order. 
Each controller has a different way it likes to handle global and port 
resets.  Sometimes COMRESET is automatically executed for you, when you 
do a controller reset (AHCI does this).

Looking at the bigger picture of error handling, we will want to 
basically run the entire probe sequence, after we reset.  I would look 
into a few key areas:

* figuring out how to safely stop SCSI from submitting commands, while 
you are doing the reset (important!).  SCSI errors are delivered to SATA 
ports -- thus if you are doing a global reset in the EH path, only one 
port's command submission is frozen, and the SCSI layer is happily 
sending commands to the other ports.

* get libata error handlers to start using scsi_eh_flush_done_q() and 
scsi_eh_finish_cmd(), which enables retrying of commands.

* making sure ata_bus_probe() can be called again and again

* implementing srst and hard-reset as taskfile protocols, and supporting 
them via qc_prep/qc_issue

	Jeff


