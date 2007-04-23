From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] libata: skip FLUSH and STADNBYNOW1 during shutdown if
 device is already spun down
Date: Mon, 23 Apr 2007 17:24:49 -0600
Message-ID: <462D4041.7030508@shaw.ca>
References: <20070423191202.GO10619@htj.dyndns.org>
 <20070423191257.GP10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:36175 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXDWX0D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 19:26:03 -0400
Received: from pd3mr1so.prod.shaw.ca
 (pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JGZ005E551RHU70@l-daemon> for linux-ide@vger.kernel.org; Mon,
 23 Apr 2007 17:25:03 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
 by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JGZ00ERU51MLSU0@pd3mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 23 Apr 2007 17:25:00 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JGZ00I1M51K7T30@l-daemon> for linux-ide@vger.kernel.org; Mon,
 23 Apr 2007 17:24:58 -0600 (MDT)
In-reply-to: <20070423191257.GP10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, liml@rtr.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, linux-ide@vger.kernel.org, Stephen.Clark@seclark.us, fabio.comolli@gmail.com, a.p.zijlstra@chello.nl

Tejun Heo wrote:
> libata didn't use to spin down disks properly on shutdown and userland
> shutdown(8) worked around it by synchronizing cache and spinning down
> by itself before telling the kernel to shutdown.  However, this
> userland work around collides with libata shutdown because some drives
> spin up if it receives FLUSH or STANDBYNOW1 while spun down.  This
> results in unpleasant spin down-up-down sequence.
> 
> This patch makes libata skip FLUSH and STANDBYNOW1 during shutdown if
> the drive is already spun down.  Note that whether FLUSH has been
> performed is not checked.  This is because some userland shutdown(8)'s
> only do STANDBYNOW1.  Transition to standby mode implies cache flush,
> so this should be safe.

Are we sure this is true in all cases? The ATA spec doesn't explicitly 
say that STANDBY IMMEDIATE implies a cache flush. Granted it would be 
retarded for a drive to spin itself down with data still pending in the 
write cache, but firmware people have done some strange things..

> 
> libata prints informational messages when skipping commands.  This is
> for debugging and to urge distributions to update shutdown(8) such
> that it doesn't do superflous flush and spindown.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-scsi.c |   29 +++++++++++++++++++++++++++++
>  include/linux/libata.h    |    1 +
>  2 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 8f80019..2a0717c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1309,6 +1309,7 @@ nothing_to_do:
>  static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  {
>  	struct ata_port *ap = qc->ap;
> +	struct ata_device *adev = qc->dev;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	u8 *cdb = cmd->cmnd;
>   	int need_sense = (qc->err_mask != 0);
> @@ -1349,6 +1350,13 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  		}
>  	}
>  
> +	/* Set spundown status.  Some userland tools use STANDBY
> +	 * instead of STANDBYNOW1.  Take both into account.
> +	 */
> +	if (unlikely(qc->tf.command == ATA_CMD_STANDBY ||
> +		     qc->tf.command == ATA_CMD_STANDBYNOW1))
> +		adev->flags |= ATA_DFLAG_SPUNDOWN;

Is checking for STANDBY really valid here? STANDBY does not do an 
immediate entry to standby mode, it only sets the standby timer. 
Therefore just because userspace issued a standby command, does not mean 
the drive is really spun down currently.

Could we use CHECK POWER MODE to see if the drive is currently spun down 
rather than tracking whether a standby was already issued? That would 
handle the case above as well, we could tell if the drive had actually 
spun down on a timer or not.


> +
>  	if (need_sense && !ap->ops->error_handler)
>  		ata_dump_status(ap->print_id, &qc->result_tf);
>  
> @@ -1454,6 +1462,27 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	if (xlat_func(qc))
>  		goto early_finish;
>  
> +	/* Some userland shutdown(8) spins down device to work around
> +	 * previous kernel bugs.  Issuing cache flush or spin down
> +	 * again might spin up some drives.  Skip cache flush and
> +	 * spindown for ->shutdown if it's already spun down.
> +	 */
> +	switch (qc->tf.command) {
> +	case ATA_CMD_FLUSH:
> +	case ATA_CMD_FLUSH_EXT:
> +	case ATA_CMD_STANDBYNOW1: /* ->shutdown always uses STANDBYNOW1 */
> +		if (unlikely((system_state > SYSTEM_RUNNING) &&
> +			     (dev->flags & ATA_DFLAG_SPUNDOWN))) {
> +			ata_dev_printk(dev, KERN_INFO, "already spun down, "
> +				       "skipping cmd 0x%x\n", qc->tf.command);
> +			cmd->result = SAM_STAT_GOOD;
> +			goto early_finish;
> +		}
> +		break;
> +	default:
> +		dev->flags &= ~ATA_DFLAG_SPUNDOWN;
> +	}
> +
>  	/* select device, send command to hardware */
>  	ata_qc_issue(qc);
>  
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 6ef4055..fa551fd 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -136,6 +136,7 @@ enum {
>  	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
>  	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
>  	ATA_DFLAG_FLUSH_EXT	= (1 << 4), /* do FLUSH_EXT instead of FLUSH */
> +	ATA_DFLAG_SPUNDOWN	= (1 << 5), /* device is spun down by user */
>  	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
>  
>  	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
