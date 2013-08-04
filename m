From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Add HDIO_DRIVE_RESET ioctl to libata.
Date: Sun, 4 Aug 2013 10:06:17 -0400
Message-ID: <20130804140617.GA2792@htj.dyndns.org>
References: <1375485028-11712-1-git-send-email-lucas.magasweran@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:63347 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3HDOGU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Aug 2013 10:06:20 -0400
Received: by mail-qc0-f180.google.com with SMTP id j10so1218009qcx.11
        for <linux-ide@vger.kernel.org>; Sun, 04 Aug 2013 07:06:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375485028-11712-1-git-send-email-lucas.magasweran@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lucas Magasweran <lucas.magasweran@wdc.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Fri, Aug 02, 2013 at 04:10:28PM -0700, Lucas Magasweran wrote:
> +static int ata_drive_reset_ioctl(struct scsi_device *scsidev, struct ata_port *ap)
> +{
> +	unsigned long deadline = ata_deadline(jiffies, ATA_TMOUT_INTERNAL_QUICK);
> +	unsigned int class;
> +	int rc = 0;
> +	unsigned long sleep_ms = ATA_TMOUT_INTERNAL_QUICK;
> +	/* unsigned long flags; */
> +
> +	if (ap->ops->softreset) {
> +		/* block further commands from being queued during reset */
> +		rc = scsi_internal_device_block(scsidev);
> +
> +		/*
> +		 * TODO Find the worst-case timeout value and sleep until it completes.
> +		 * Alternatively, we can blk_abort_request in-flight commands as
> +		 * done in ata_qc_schedule_eh() if the SRST should be immediate.
> +		 */
> +		while ( ap->qc_active && sleep_ms > 0 ) {
> +			ata_msleep(ap, sleep_ms);
> +			sleep_ms -= 1000;
> +		}

Whoa...

> +		/* should not need to acquire ap->lock since command queue is blocked */
> +		/* spin_lock_irqsave(ap->lock, flags); */
> +
> +		/* send ATA Software Reset SRST */
> +		rc = ap->ops->softreset(&ap->link, &class, deadline);

Nope nope nope.

It can actually be pretty trivially implemented by scheduling EH with
SRST action.  That said, I don't konw what use this would be?  Why is
the ioctl even necessary?

Thanks.

-- 
tejun
