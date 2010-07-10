From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: If I have a single bad sector, how many failed reads should
 simple dd report?
Date: Sat, 10 Jul 2010 09:14:31 -0500
Message-ID: <1278771271.2911.18.camel@mulgrave.site>
References: <AANLkTil2Zfhpkq24qrCoHZVx1vlbIPTcDMrZ508yODta@mail.gmail.com>
	 <AANLkTimWfp4mLF9DCpxtnnUQsYQ08gXmh491EfhARe1x@mail.gmail.com>
	 <4C37CA99.1040104@teksavvy.com>  <4C37CBB8.1040909@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35017 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709Ab0GJOOi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jul 2010 10:14:38 -0400
In-Reply-To: <4C37CBB8.1040909@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

On Fri, 2010-07-09 at 21:24 -0400, Mark Lord wrote:
> On 09/07/10 09:19 PM, Mark Lord wrote:
> > On 09/07/10 03:04 PM, Greg Freemyer wrote:
> > ..
> >>> When I re-ran it, /var/log/messages reported 10 bad logical blocks.
> >>> And even worse, dd reported 20 bad blocks. I examined the data dd
> >>> read and it had 80KB of zero'ed out data. So that's 160 sectors worth
> >>> of data lost because of a single bad sector. At most I was expecting
> >>> 4KB of zero'ed out data.
> > ..
> >
> > That's just the standard, undesirable result of the current SCSI EH
> > when used with libata for (mainly) desktop computers.
> >
> > I have patches (against older kernels) to fix it, but have yet to
> > get both myself and James B. interested enough simultaneously to
> > actually get the kernel fixed. :)
> ..
> 
> Here (attached and inline below) are my most recent patches for this.
> Still outdated, though.  These are against the SLES11 2.6.27.19 kernel:
> 
> -----------------------------snip----------------------------
> 
> Stop the SCSI EH from performing tons of retries on unrecoverable medium errors,
> so that error-handling fails more quickly and we (EMC) avoid unneeded node resets.
> 
> The ugliness of this patch matches the ugliness of SCSI EH.
> Does *anyone* actually understand this code completely?
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/scsi/scsi_error.c	2009-06-04 09:46:55.000000000 -0400
> +++ linux/drivers/scsi/scsi_error.c	2009-06-04 12:08:48.000000000 -0400
> @@ -423,6 +423,52 @@
>   	}
>   }
>   
> +/*
> + * The problem with scsi_check_sense(), is that it is (designed to be)
> + * called only after retries are exhausted.  But for MEDIUM_ERRORs (only)
> + * we don't want any retries here at all.
> + *
> + * So this function below is a clone of the necessary parts from scsi_check_sense(),
> + * to check for unrecoverable MEDIUM_ERRORs when deciding whether to retry or not.
> + */
> +static int scsi_unrecoverable_medium_error(struct scsi_cmnd *scmd)
> +{
> +	struct scsi_sense_hdr sshdr;
> +
> +	if (! scsi_command_normalize_sense(scmd, &sshdr))
> +		return 0;	/* no valid sense data */
> +
> +	if (scsi_sense_is_deferred(&sshdr))
> +		return 0;
> +
> +	if (sshdr.response_code == 0x70) {
> +		/* fixed format */
> +		if (scmd->sense_buffer[2] & 0xe0)
> +			return 0;
> +	} else {
> +		/*
> +		 * descriptor format: look for "stream commands sense data
> +		 * descriptor" (see SSC-3). Assume single sense data
> +		 * descriptor. Ignore ILI from SBC-2 READ LONG and WRITE LONG.
> +		 */
> +		if ((sshdr.additional_length > 3) &&
> +		    (scmd->sense_buffer[8] == 0x4) &&
> +		    (scmd->sense_buffer[11] & 0xe0))
> +			return 0;
> +	}
> +
> +	switch (sshdr.sense_key) {
> +	case MEDIUM_ERROR:
> +		if (sshdr.asc == 0x11 || /* UNRECOVERED READ ERR */
> +		    sshdr.asc == 0x13 || /* AMNF DATA FIELD */
> +		    sshdr.asc == 0x14) { /* RECORD NOT FOUND */
> +			//printk(KERN_WARNING "%s: MEDIUM_ERROR\n", __func__);
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}


> +
>   /**
>    * scsi_eh_completed_normally - Disposition a eh cmd on return from LLD.
>    * @scmd:	SCSI cmd to examine.
> @@ -1334,6 +1380,8 @@
>   
>   	switch (status_byte(scmd->result)) {
>   	case CHECK_CONDITION:
> +		if (scsi_unrecoverable_medium_error(scmd))
> +			return 1;
>   		/*
>   		 * assume caller has checked sense and determinted
>   		 * the check condition was retryable.

The check is redundant:  scsi_decide_disposition is where we check for
retries or error handling.  If you look, it already picks out your three
cases and returns success for them (meaning pass straight through).  in
sd_done() MEDIUM_ERROR means complete immediately.


> 
> On encountering a bad sector, report and skip over it,
> then continue with the remainder of the request.
> Otherwise we would fail perfectly good sectors,
> making a bad situation even worse.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/scsi/scsi_lib.c	2009-06-04 12:26:52.000000000 -0400
> +++ linux/drivers/scsi/scsi_lib.c	2009-06-04 14:40:11.000000000 -0400
> @@ -952,6 +952,12 @@
>   	 */
>   	if (sense_valid && !sense_deferred) {
>   		switch (sshdr.sense_key) {
> +		case MEDIUM_ERROR:
> +		/* Bad sector.  Fail it, and then continue the rest of the request. */
> +		if (this_count && scsi_end_request(cmd, -EIO, cmd->device->sector_size, 1) == NULL) {
> +			cmd->retries = 0;       // go around again..
> +			return;
> +		}
>   		case UNIT_ATTENTION:
>   			if (cmd->device->removable) {
>   				/* Detected disc change.  Set a bit

This one's in the wrong place.  Normal MEDIUM_ERRORS complete above
this.

I also don't think the skip is right.  We're supposed to communicate to
block what we've done, and all we have to do that with is good bytes.
If we skip over a bad sector and try to complete the rest, we've lost
the error position.

The failure return from Medium error is defined to be the number of
bytes we actually wrote, which is everything up to the medium error.

James


