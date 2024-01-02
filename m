Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41017982
	for <linux-ide@vger.kernel.org>; Tue,  2 Jan 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVuBmfa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA310C433C7;
	Tue,  2 Jan 2024 23:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704237433;
	bh=OqmNTHjPB7wzzJt76jlphrpnRD2tv1XGkmZakwcMxpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OVuBmfa2mlFTnSAER5BQ0g1bJIoQuZAsbRY4zjnV/3y4iy8xaOA6/NTlR/0amwur+
	 AuJJ3XOII5XR5ZkV6QGbgfbpXynt1GJ3oUK2DS5SUrhMmURkrRxKrgMae4pKfndSFW
	 JIpe5VZAGA1nWa2l61RJmaF09hKIyu2MDnmGnHIthnciQ8sFNac7pYMny7xsk+Gfny
	 BGT/dH2wGLbpLX/qc53BEHNv0p1MftG5wQDNbY0d0QZl81a3xnyJSpEbDQ5NGSjCZT
	 3hssrtBtQsI3JL7A7MYCrkMdRTpNW08183RRuXFBnM/1IXOI0ST8o177Swyb1YmJtm
	 TwfILKe4IWDaQ==
Message-ID: <decd3317-ed44-4ddc-b6b3-5b33bc72727c@kernel.org>
Date: Wed, 3 Jan 2024 08:17:11 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libata: only wake a drive once on system resume
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ide@vger.kernel.org
References: <20231225151915.258816-1-phill@thesusis.net>
 <20231230182128.296675-1-phill@thesusis.net>
 <20231230182128.296675-2-phill@thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231230182128.296675-2-phill@thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/23 03:21, Phillip Susi wrote:
> In the event that more than one pass of EH is needed during system resume,
> only request the drive be started once.

This is not an improvement... What if the verify command that wakes-up the drive
fails to be issued, or EH does not reach the call to ata_dev_power_set_active()
on the first run ? You would want to retry it but your patch will prevent that.

I do not really see any fundamental issue here given that calling
ata_dev_power_set_active() is indeed useless if the drive is already active, but
that does not hurt either. The only overhead is issuing a check power mode
command (see the call to ata_dev_power_is_active() in ata_dev_power_set_active()).

Are you seeing different behavior with your system ? Any error ?

> ---
>  drivers/ata/libata-core.c | 4 ++--
>  drivers/ata/libata-eh.c   | 4 ----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d1389ce6943e..ca3ca8107a3e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5223,7 +5223,7 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
>  	/* on system resume, don't wake PuiS drives */
>  	if (mesg.event == PM_EVENT_RESUME)
>  		ehi_flags |= ATA_EHI_NOSTART;
> -	
> +
>  	/* Request PM operation to EH */
>  	ap->pm_mesg = mesg;
>  	ap->pflags |= ATA_PFLAG_PM_PENDING;
> @@ -5297,7 +5297,7 @@ static int ata_port_pm_poweroff(struct device *dev)
>  static void ata_port_resume(struct ata_port *ap, pm_message_t mesg,
>  			    bool async)
>  {
> -	ata_port_request_pm(ap, mesg, ATA_EH_RESET,
> +	ata_port_request_pm(ap, mesg, ATA_EH_RESET | ATA_EH_SET_ACTIVE,
>  			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET,
>  			    async);
>  }
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 120f7d7fb450..f44ce7068a8b 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -711,10 +711,6 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
>  			ehc->saved_xfer_mode[devno] = dev->xfer_mode;
>  			if (ata_ncq_enabled(dev))
>  				ehc->saved_ncq_enabled |= 1 << devno;
> -
> -			/* If we are resuming, wake up the device */
> -			if (ap->pflags & ATA_PFLAG_RESUMING)
> -				ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
>  		}
>  	}
>  

-- 
Damien Le Moal
Western Digital Research

