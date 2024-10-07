Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02168155C97
	for <linux-ide@vger.kernel.org>; Mon,  7 Oct 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340315; cv=none; b=YVvMcww+xpWRP8T8u80r39omKIcK7GDbvuZ8mIBK3geCWVzDXzz6/BZXhk8I9yTHuDHyaf1fuFCvKMSBmKQph8hrD+O7e767DCLUCcvF5LXVlMZCbT6zWLmATYhuc4ekEs1EqUc9P7qI15J3elfGZ/F10c6GMV2++MFPq8sWh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340315; c=relaxed/simple;
	bh=ha/IWf/mhaP23GqBAUrqRCFZ5W98aPf8hjUiEQAHXP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbF9nvNfYhjCruSh1XF1izLYQ6dYzd6WxYGLPXGeo8v9qDZC8KVwA/iTwdwP//WvPONz0enEKTn7OpWb0Yhy8+UPOQsgaujzjkfXHYGwl0oYnRUbDNK4xrpvyd2Njxne4TIaAPXWVJM6kH7dv0O/BgQIRjvRE+YtVbs6ZmRD4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug/ULg3Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug/ULg3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4840C4CEC6;
	Mon,  7 Oct 2024 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728340314;
	bh=ha/IWf/mhaP23GqBAUrqRCFZ5W98aPf8hjUiEQAHXP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ug/ULg3ZofZATR7+Ln/vUXBIKrsxop3ZFUB2rybwGM0uv4T+q75PTb1+Ru37c+pGT
	 zCzk1Kp4bCPu+K+J7ssFQKyAycGaDIcA60jKY8UbPgjqc1X3zq9AK0Yr2/bp3e2fS0
	 jFcYgJsxlXPS8dd2+yBT5ekzxn9S1r6XceZZw3B8rnwU74wOL7MHiNbqvYagUbFKen
	 yG7TBD4aPvDo4jo1eRXP91VXhs9/MW187GEVcGCr9tS9d2qcrNTOdxhe109brn0fpl
	 UPOiAuDLBH1VOqpCn6lvxfuZx5X+Fup+Y/fxsLy39/67OkK8klAz/kJ6WGvqoxvXBE
	 3cXMw/mLTBTxQ==
Message-ID: <daa51b7a-796d-494f-b77f-dd4e89f00480@kernel.org>
Date: Tue, 8 Oct 2024 07:31:52 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: avoid superfluous disk spin down + spin up
 during hibernation
To: Niklas Cassel <cassel@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
Cc: W <linuxcdeveloper@gmail.com>, linux-ide@vger.kernel.org
References: <20241007171544.1222925-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241007171544.1222925-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 02:15, Niklas Cassel wrote:
> A user reported that commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi
> device manage_system_start_stop") introduced a spin down + immediate spin
> up of the disk both when entering and when resuming from hibernation.
> This behavior was not there before, and causes an increased latency both
> when when entering and when resuming from hibernation.
> 
> Hibernation is done by three consecutive PM events, in the following order:
> 1) PM_EVENT_FREEZE
> 2) PM_EVENT_THAW
> 3) PM_EVENT_HIBERNATE
> 
> Commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi device
> manage_system_start_stop") modified ata_eh_handle_port_suspend() to call
> ata_dev_power_set_standby() (which spins down the disk), for both event
> PM_EVENT_FREEZE and event PM_EVENT_HIBERNATE.
> 
> Documentation/driver-api/pm/devices.rst, section "Entering Hibernation",
> explicitly mentions that PM_EVENT_FREEZE does not have to be put the device
> in a low-power state, and actually recommends not doing so. Thus, let's not
> spin down the disk on PM_EVENT_FREEZE. (The disk will instead be spun down
> during the subsequent PM_EVENT_HIBERNATE event.)
> 
> This way, PM_EVENT_FREEZE will behave as it did before commit aa3998dbeb3a
> ("ata: libata-scsi: Disable scsi device manage_system_start_stop"), while
> PM_EVENT_HIBERNATE will continue to spin down the disk.
> 
> This will avoid the superfluous spin down + spin up when entering and
> resuming from hibernation, while still making sure that the disk is spun
> down before actually entering hibernation.
> 
> Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")

You forgot to add Cc: stable@vger.kernel.org

With that added, looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-eh.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3f0144e7dc80..fa41ea57a978 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4099,10 +4099,20 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
>  
>  	WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
>  
> -	/* Set all devices attached to the port in standby mode */
> -	ata_for_each_link(link, ap, HOST_FIRST) {
> -		ata_for_each_dev(dev, link, ENABLED)
> -			ata_dev_power_set_standby(dev);
> +	/*
> +	 * We will reach this point for all of the PM events:
> +	 * PM_EVENT_SUSPEND (if runtime pm, PM_EVENT_AUTO will also be set)
> +	 * PM_EVENT_FREEZE, and PM_EVENT_HIBERNATE.
> +	 *
> +	 * We do not want to perform disk spin down for PM_EVENT_FREEZE.
> +	 * (Spin down will be performed by the subsequent PM_EVENT_HIBERNATE.)
> +	 */
> +	if (!(ap->pm_mesg.event & PM_EVENT_FREEZE)) {
> +		/* Set all devices attached to the port in standby mode */
> +		ata_for_each_link(link, ap, HOST_FIRST) {
> +			ata_for_each_dev(dev, link, ENABLED)
> +				ata_dev_power_set_standby(dev);
> +		}
>  	}
>  
>  	/*


-- 
Damien Le Moal
Western Digital Research
