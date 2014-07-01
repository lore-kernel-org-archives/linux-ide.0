From: Larry Baker <baker@usgs.gov>
Subject: Re: [PATCH #upstream] libata: implement dump_id force param
Date: Tue, 1 Jul 2014 11:51:54 -0700
Message-ID: <56B984A8-0CA0-4FED-A3D2-6CDE82AA5FE4@usgs.gov>
References: <4BF90A7F.80309@kernel.org> <4BFC6059.3080505@garzik.org> <C734FD3F-7CAB-40C4-A3AB-916A30E173DE@usgs.gov>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from SMTP5.doi.gov ([137.227.28.11]:45460 "EHLO smtp5.doi.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbaGAS5S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jul 2014 14:57:18 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so10479507pdb.25
        for <linux-ide@vger.kernel.org>; Tue, 01 Jul 2014 11:51:56 -0700 (PDT)
In-Reply-To: <C734FD3F-7CAB-40C4-A3AB-916A30E173DE@usgs.gov>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Jeff and Tejun,

I see what happened.  Tejun sent me two sets of patches: one to implement the driver dump_id kernel parameter and the other to fix the problem with the buggy CF card.  (It lies that it supports ATA MULTI -- which is actually required by the standard!)  Jeff only saw the first set, which is what he applied.  They are in the current Linux source tree.  What are missing are the patches to recover from multi-block transfer failures by falling back to use single-block transfers.  Here's Tejun's e-mail to me with those patches (ready to go?).

Thank you again,

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov

On 23 May 2010, at 6:58 AM, Tejun Heo wrote:

> On 05/20/2010 11:50 AM, Tejun Heo wrote:
>>> If the failed command is one of the READ/WRITE MULTI commands (entries
>>> 0-4 in ata_rw_cmds[]), and the device response is ABORT, use your
>>> HORKAGE mechanism to set a flag like ATA_HORKAGE_BROKEN_MULTI to skip
>>> setting dev->multi_count in libata-core.c (the code in 2., above), i.e.,
>>> disable multi-sector transfers, then reconfigure the device to disable
>>> multi-sector transfers (call ata_dev_configure(), I guess, so the new
>>> configuration gets printed out in dmesg) and retry the transfer.  Any
>>> future calls to ata_dev_configure() for that device will not attempt to
>>> enable multi-sector transfers because the ATA_HORKAGE_BROKEN_MULTI is set:
>>> 
>>> +        /* don't try to enable R/W multi if it is broken */
>>> +        if (!(dev->horkage & ATA_HORKAGE_BROKEN_MULTI))
>> 
>> So, turn off MULTI on ABORT....  Oh yeah, I can add that to the
>> existing speed down logic.  Would you be available to test patches?
> 
> Something like the following.  Please test whether it works as
> expected.  It should turn off muti after two device errors during
> partition scan.
> 
> Thanks.
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c47373f..1f97189 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2416,7 +2416,8 @@ int ata_dev_configure(struct ata_device *dev)
> 		dev->n_sectors = ata_id_n_sectors(id);
> 
> 		/* get current R/W Multiple count setting */
> -		if ((dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
> +		if (!(dev->flags & ATA_DFLAG_MULTI_OFF) &&
> +		    (dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
> 			unsigned int max = dev->id[47] & 0xff;
> 			unsigned int cnt = dev->id[59] & 0xff;
> 			/* only recognize/allow powers of two here */
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index f77a673..60b352f 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -53,6 +53,7 @@ enum {
> 	ATA_EH_SPDN_SPEED_DOWN		= (1 << 1),
> 	ATA_EH_SPDN_FALLBACK_TO_PIO	= (1 << 2),
> 	ATA_EH_SPDN_KEEP_ERRORS		= (1 << 3),
> +	ATA_EH_SPDN_MULTI_OFF		= (1 << 4),
> 
> 	/* error flags */
> 	ATA_EFLAG_IS_IO			= (1 << 0),
> @@ -1805,13 +1806,13 @@ static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
>  *	   occurred during last 5 mins, SPEED_DOWN and FALLBACK_TO_PIO.
>  *
>  *	2. If more than one DUBIOUS_TOUT_HSM or DUBIOUS_UNK_DEV errors
> - *	   occurred during last 5 mins, NCQ_OFF.
> + *	   occurred during last 5 mins, NCQ_OFF and MULTI_OFF.
>  *
>  *	3. If more than 8 ATA_BUS, TOUT_HSM or UNK_DEV errors
>  *	   ocurred during last 5 mins, FALLBACK_TO_PIO
>  *
>  *	4. If more than 3 TOUT_HSM or UNK_DEV errors occurred
> - *	   during last 10 mins, NCQ_OFF.
> + *	   during last 10 mins, NCQ_OFF and MULTI_OFF.
>  *
>  *	5. If more than 3 ATA_BUS or TOUT_HSM errors, or more than 6
>  *	   UNK_DEV errors occurred during last 10 mins, SPEED_DOWN.
> @@ -1841,7 +1842,8 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
> 
> 	if (arg.nr_errors[ATA_ECAT_DUBIOUS_TOUT_HSM] +
> 	    arg.nr_errors[ATA_ECAT_DUBIOUS_UNK_DEV] > 1)
> -		verdict |= ATA_EH_SPDN_NCQ_OFF | ATA_EH_SPDN_KEEP_ERRORS;
> +		verdict |= ATA_EH_SPDN_NCQ_OFF | ATA_EH_SPDN_MULTI_OFF |
> +			ATA_EH_SPDN_KEEP_ERRORS;
> 
> 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
> 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] +
> @@ -1855,7 +1857,7 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)
> 
> 	if (arg.nr_errors[ATA_ECAT_TOUT_HSM] +
> 	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 3)
> -		verdict |= ATA_EH_SPDN_NCQ_OFF;
> +		verdict |= ATA_EH_SPDN_NCQ_OFF | ATA_EH_SPDN_MULTI_OFF;
> 
> 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
> 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] > 3 ||
> @@ -1908,6 +1910,14 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
> 		goto done;
> 	}
> 
> +	/* turn off multi? */
> +	if ((verdict & ATA_EH_SPDN_MULTI_OFF) && (dev->flags & ATA_DFLAG_PIO)) {
> +		dev->flags |= ATA_DFLAG_MULTI_OFF;
> +		ata_dev_printk(dev, KERN_WARNING,
> +			       "PIO multi disabled due to excessive errors\n");
> +		goto done;
> +	}
> +
> 	/* speed down? */
> 	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
> 		/* speed down SATA link speed if possible */
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index ee84e7e..a145d80 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -147,6 +147,7 @@ enum {
> 	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
> 	ATA_DFLAG_NO_UNLOAD	= (1 << 17), /* device doesn't support unload */
> 	ATA_DFLAG_UNLOCK_HPA	= (1 << 18), /* unlock HPA */
> +	ATA_DFLAG_MULTI_OFF	= (1 << 19), /* turn off PIO multi mode */
> 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,
> 
> 	ATA_DFLAG_DETACH	= (1 << 24),


On 1 Jul 2014, at 11:36 AM, Larry Baker wrote:

> Jeff and Tejun,
> 
> We had some exchanges in 2010 regarding CF card problems.  Tejun wrote patches which we use on our desktop playback systems and Jeff said he applied them (below).  However, they seem to not be in any of the kernel source trees when i browse http://lxr.free-electrons.com/source/drivers/ata/.  I think we may be running into similar problems with the CF cards used in some embedded Linux data acquisition systems we bought that are running a 2.6 kernel.  I was going to advise them to look for Tejun's work in a later kernel.  But, alas, his work is not there.  Any idea what happened to Jeff's "applied"?  I can forward our e-mail conversations, which include the patches Tejun sent to me.
> 
> Thank you,
> 
> Larry Baker
> US Geological Survey
> 650-329-5608
> baker@usgs.gov
> 
> 
> 
> On 25 May 2010, at 4:42 PM, Jeff Garzik wrote:
> 
>> On 05/23/2010 06:59 AM, Tejun Heo wrote:
>>> Add dump_id libata.force parameter.  If specified, libata dumps full
>>> IDENTIFY data during device configuration.  This is to aid debugging.
>>> 
>>> Signed-off-by: Tejun Heo<tj@kernel.org>
>>> Cc: Larry Baker<baker@usgs.gov>
>>> ---
>>>  Documentation/kernel-parameters.txt |    2 ++
>>>  drivers/ata/libata-core.c           |    9 +++++++++
>>>  include/linux/libata.h              |    1 +
>> 
>> applied
>> 
>> 
> 

