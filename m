From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:passthru] passthru fixes
Date: Wed, 14 Sep 2005 08:18:07 -0400
Message-ID: <432814FF.7000103@pobox.com>
References: <20050913142636.GB5679@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:11181 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932746AbVINMSP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2005 08:18:15 -0400
In-Reply-To: <20050913142636.GB5679@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Raubitschek <jhr@google.com>
Cc: linux-ide@vger.kernel.org

Jeff Raubitschek wrote:
> Fix a few problems seen with the passthru branch:
> 
> - leaked scsi_request on buffer allocate failure
> - passthru sense routines were refering to tf->command
>   which is not read in tf_read, instead use drv_stat for
>   status register.

tf->command is not read, because Command is a write-only register.

Store drv_stat in tf->command like the current code does, nicely 
encapsulating the data in struct ata_taskfile, and do not add a bunch of 
'drv_stat' function arguments.


> - passthru sense passed back to user on ata_task_ioctl
> 
> Patch is against the current libata-dev passthru branch.

Patch generally OK, but needs some cleanup.  See above and below.


> Signed-off-by: Jeff Raubitschek <jhr@google.com>
> 
> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -116,8 +116,10 @@ int ata_cmd_ioctl(struct scsi_device *sc
>  	if (args[3]) {
>  		argsize = SECTOR_SIZE * args[3];
>  		argbuf = kmalloc(argsize, GFP_KERNEL);
> -		if (argbuf == NULL)
> -			return -ENOMEM;
> +		if (argbuf == NULL) {
> +			rc = -ENOMEM;
> +			goto error;
> +		}
>  
>  		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
>  		scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
> @@ -182,6 +184,7 @@ int ata_task_ioctl(struct scsi_device *s
>  	u8 scsi_cmd[MAX_COMMAND_SIZE];
>  	u8 args[7];
>  	struct scsi_request *sreq;
> +	unsigned char *sb;
>  
>  	if (NULL == (void *)arg)
>  		return -EINVAL;
> @@ -192,7 +195,7 @@ int ata_task_ioctl(struct scsi_device *s
>  	memset(scsi_cmd, 0, sizeof(scsi_cmd));
>  	scsi_cmd[0]  = ATA_16;
>  	scsi_cmd[1]  = (3 << 1); /* Non-data */
> -	/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
> +	scsi_cmd[2]  = 0x20; /* Always ask for sense data */
>  	scsi_cmd[4]  = args[1];
>  	scsi_cmd[6]  = args[2];
>  	scsi_cmd[8]  = args[3];
> @@ -211,15 +214,29 @@ int ata_task_ioctl(struct scsi_device *s
>  	   from scsi_ioctl_send_command() for default case... */
>  	scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
>  
> -	if (sreq->sr_result) {
> +	sb = sreq->sr_sense_buffer;
> +
> +	/* Retrieve data from check condition */
> +	if((sb[1] == NO_SENSE) && (sb[2] == 0) && (sb[3] == 0x1D)) {

add whitespace after the 'if'

> +		unsigned char *desc= sb + 8;

add whitespace after '='

> +
> +		args[0]=desc[13];
> +		args[1]=desc[3];
> +		args[2]=desc[5];
> +		args[3]=desc[7];
> +		args[4]=desc[9];
> +		args[5]=desc[11];

add whitespace before and after '='


> +	} else if (sreq->sr_result) {
>  		rc = -EIO;
>  		goto error;
>  	}
>  
> -	/* Need code to retrieve data from check condition? */
> -
>  error:
>  	scsi_release_request(sreq);
> +
> +	if (rc == 0 && copy_to_user(arg, args, sizeof(args)))
> +		return -EFAULT;

do we really want to do this on error?

	Jeff


