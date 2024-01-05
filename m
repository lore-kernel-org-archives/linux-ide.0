Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E82D602
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr2U9DB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3D4C433CC;
	Fri,  5 Jan 2024 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704458564;
	bh=r5rtLd+8WNJGdaejgh5lOv0JYq3pnxFEvuoDKXjaF+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pr2U9DB5E9UusNu3irk3g8vL/hblf6juSh4GjPm2FOjPQRdqw5rqqxB2I3aN4q/0s
	 9OuCvBEXSNpmegYB3K2KBdPv1GaAsDKFMPBVoXzKj/OZwCOUrxtlkjvr+N2f+ySYwk
	 WZZG9O2mLHwLoRUW1iul5KdQeZToz58P0L35J01SNp83CkNHoQyiO9KYSct/ppOo7N
	 9zrgxszCcoEP2maNP/2ncB5vyadvGhU+mrjHualpF8b1Ki2Z6LVqFBK5t5KUdrK/oc
	 shkY6sempp6HcxgXOardqC3ZWs7Ry4HGPmwvQf6ikx2ISUK2Vr9C6LOsXgPIEhMaRC
	 abAXRpqaLj5PQ==
Message-ID: <9d75da13-de73-4156-8ef4-5fbadd6e56b4@kernel.org>
Date: Fri, 5 Jan 2024 21:42:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] libata: don't start PuiS disks on resume
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-4-phill@thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240104223940.339290-4-phill@thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 07:39, Phillip Susi wrote:
> Disks with Power Up In Standby enabled that required the
> SET FEATURES command to start up were being issued the
> command during resume.  Suppress this until the disk
> is actually accessed.
> ---
>  drivers/ata/libata-core.c | 24 ++++++++++++++++++++++--
>  drivers/ata/libata-eh.c   | 12 +++++++++++-
>  drivers/ata/libata.h      |  1 +
>  include/linux/libata.h    |  1 +
>  4 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d9e889fa2881..3f6187c75b16 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1912,7 +1912,25 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  			goto err_out;
>  	}
>  
> -	if (!tried_spinup && (id[2] == 0x37c8 || id[2] == 0x738c)) {
> +	if (flags & ATA_READID_NOSTART && id[2] == 0x37c8)
> +	{
> +		/*
> +		 * the drive has powered up in standby, and returned incomplete IDENTIFY info
> +		 * so we can't revalidate it yet.  We have also been asked to avoid starting the
> +		 * drive, so stop  here and leave the drive asleep and the EH pending, to be
> +		 * restarted on later IO request
> +		 */
> +		ata_tf_init(dev, &tf);
> +		tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> +		tf.protocol = ATA_PROT_NODATA;
> +		tf.command = ATA_CMD_SLEEP;
> +		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
> +		ata_dev_info(dev, "PuiS detected, putting drive to sleep");

Why ? The drive is in standby. What is the point of putting it into sleep state
? Furthermore, if you check ACS-6 specs, you will see that there is no
transitions defined from PUIS state to sleep state. You have to spin-up the
drive first. So the above is outside the specified behavior and thus not
reliable (even though many drive may actually allow this transition).

> +		return -EAGAIN;
> +	}
> +
> +	if (!(flags & ATA_READID_NOSTART) &&
> +	    !tried_spinup && (id[2] == 0x37c8 || id[2] == 0x738c)) {
>  		tried_spinup = 1;
>  		/*
>  		 * Drive powered-up in standby mode, and requires a specific
> @@ -3973,6 +3991,8 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>  
>  	/* re-read ID */
>  	rc = ata_dev_reread_id(dev, readid_flags);
> +	if (rc == -EAGAIN)
> +		return rc;
>  	if (rc)
>  		goto fail;
>  
> @@ -5241,7 +5261,7 @@ static void ata_port_suspend(struct ata_port *ap, pm_message_t mesg,
>  	 * http://thread.gmane.org/gmane.linux.ide/46764
>  	 */
>  	ata_port_request_pm(ap, mesg, 0,
> -			    ATA_EHI_QUIET | ATA_EHI_NO_AUTOPSY |
> +			    ATA_EHI_QUIET | ATA_EHI_NO_AUTOPSY | ATA_EHI_NOSTART
>  			    ATA_EHI_NO_RECOVERY,
>  			    async);
>  }
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 799a1b8bc384..74e0d54a204e 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -22,6 +22,7 @@
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_dbg.h>
>  #include "../scsi/scsi_transport_api.h"
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/libata.h>
>  
> @@ -3046,6 +3047,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  
>  		if (ehc->i.flags & ATA_EHI_DID_RESET)
>  			readid_flags |= ATA_READID_POSTRESET;
> +		if (ehc->i.flags & ATA_EHI_NOSTART)
> +			readid_flags |= ATA_READID_NOSTART;
>  
>  		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
>  			WARN_ON(dev->class == ATA_DEV_PMP);
> @@ -3075,9 +3078,16 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
>  			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
>  						readid_flags);
> -			if (rc)
> +			if (rc == -EAGAIN) {

Rather than playing with the return values, it may be easier to use a device
flag (similar to ATA_DFLAG_SLEEPING) to track standby/spun-down state.

> +				rc = 0; /* start required but suppressed, handle later */
> +				ehc->i.dev_action[dev->devno] &= ~ATA_EH_SET_ACTIVE;
> +				ata_dev_warn(dev, "Leaving PuiS disk asleep for now");
> +				continue;
> +			}
> +			else if (rc)
>  				goto err;
>  
> +			pm_runtime_resume(&dev->sdev->sdev_gendev);

What does this do ??? This look really out of place.

>  			ata_eh_done(link, dev, ATA_EH_REVALIDATE);
>  
>  			/* Configuration may have changed, reconfigure
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 43ad1ef9b63a..cff3facad055 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -19,6 +19,7 @@
>  enum {
>  	/* flags for ata_dev_read_id() */
>  	ATA_READID_POSTRESET	= (1 << 0), /* reading ID after reset */
> +	ATA_READID_NOSTART	= (1 << 1), /* do not start drive */
>  
>  	/* selector for ata_down_xfermask_limit() */
>  	ATA_DNXFER_PIO		= 0,	/* speed down PIO */
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 1dbb14daccfa..50d6fa933946 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -328,6 +328,7 @@ enum {
>  
>  	/* ata_eh_info->flags */
>  	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
> +	ATA_EHI_NOSTART		= (1 << 1),  /* don't start the disk */
>  	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
>  	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
>  	ATA_EHI_NO_RECOVERY	= (1 << 4),  /* no recovery */

-- 
Damien Le Moal
Western Digital Research

