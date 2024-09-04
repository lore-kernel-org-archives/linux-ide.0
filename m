Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E773211
	for <linux-ide@vger.kernel.org>; Wed,  4 Sep 2024 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414569; cv=none; b=Tc8tfD5RUiMKN5RkwY7uh3WCN36P6IEZxoB+NGWKuHCO5z6VbZ1Tlicn9Dr4usA92OzdgN/bNZY9mRBBfkAvERDTsyPzqo8zg9BCnG+7Z6L2gYBIKT61EjKLi/BgtNV+0YgRoVT+f/oYdPIkSVJLcGWj6we/gQDEba/lUOp87LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414569; c=relaxed/simple;
	bh=9DmAppULiGWgySfkYOZm2E2papgKeS3FLZ8FsDL9xEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5IlqhulsBPs7s125aZP1O4J+OBbVeDX81+DYO/X6kyOOBmVpLYwhkb3stC1U4aq8jELR07IbwbY0KUv93BB+c1OAeg0CiFNr4jdcED+u/RPgFWNsc/+50hSUU/gLfpdw7nQNQeiSaTlrSPrwtcTWAGt8vf8jKuint+XWls3gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow4pZRYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow4pZRYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EAAC4CEC4;
	Wed,  4 Sep 2024 01:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725414569;
	bh=9DmAppULiGWgySfkYOZm2E2papgKeS3FLZ8FsDL9xEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ow4pZRYo0HEPdQ9o5uDHdUCmYnET3aQg/+sedYBJTsrX0q3232IY57V6cEHmjktfb
	 UcyL89ifmXO1JYa4CX0xDYdiTuA6auKZxbDcf3fa62z/R/eV62VDs2d3oh6PhgS91O
	 KbeTLv0N3GKcaz63Vmz/dWJe7RhrSZ5z0PiKmc54njT6Cbjv7GbP8VWxxuwMANjYKV
	 3ZwGiGJAtil1vaxcUVRTrQ2gi/ARCFRph1mzTPbDhdtJralKT6yVPGJrvgrg3zoQd+
	 cYT7lqpSUBTTe9+eurHP8lQlE8qpjXgiRZfS2sCYL40GUvd0FwTVKQiedxYyRmw0vN
	 vpZr4SebNfB8w==
Message-ID: <c4a43f75-6826-4ace-a5da-dd44d0042748@kernel.org>
Date: Wed, 4 Sep 2024 10:49:27 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] ata: libata: Improve CDL resource management
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240902115400.166881-1-dlemoal@kernel.org>
 <20240902115400.166881-8-dlemoal@kernel.org> <ZtYoTn8kydZ9u4gA@x1-carbon.lan>
 <847eed24-dc05-4f6f-b933-63687ba22ccc@kernel.org>
 <ZtbCYtohqKZozLbi@ryzen.lan>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZtbCYtohqKZozLbi@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/03 17:01, Niklas Cassel wrote:
> On Tue, Sep 03, 2024 at 07:55:05AM +0900, Damien Le Moal wrote:
>> On 9/3/24 06:04, Niklas Cassel wrote:
>>>> @@ -6000,11 +6018,19 @@ static void ata_port_detach(struct ata_port *ap)
>>>>  	ata_port_wait_eh(ap);
>>>>  
>>>>  	mutex_lock(&ap->scsi_scan_mutex);
>>>> +
>>>> +	/* Cleanup CDL device resources */
>>>> +	ata_for_each_link(link, ap, HOST_FIRST) {
>>>> +		ata_for_each_dev(dev, link, ALL)
>>>> +			ata_dev_cleanup_cdl_resources(dev);
>>>
>>> Here you clean up resources.
>>> Why?
>>> Resources will get cleaned up when ata_port_free() is called,
>>> which will be called by ata_devres_release() -> ata_host_put()
>>> -> ata_host_release() -> ata_port_free(), when the device is
>>> removed.
>>
>> That happens only if the host (=port) is removed, but not if only the device is
>> being removed, e.g. because it was yanked out of its slot (hotplug) or the user
>> removed it using sysfs. In such case, the port remains and is not deleted, so
>> ata_port_free() is not called. Ports exists for as long as the adapter exist.
>>
>>> I don't see any reason to free it here as well.
>>
>> Hotplug of drives :)
> 
> ?
> 
> This code is in ata_port_detach(), which is called only by ata_host_detach().
> 
> So the code you have added here is only when the port is detached, not when
> the device is detached / hotplug removed.

Indeed. I screwed-up with this one :)

> For hotplug it is these functions:
> ata_eh_detach_dev() and ata_scsi_handle_link_detach() that will be called.

And that's the path I should have modified.

> We know that the struct ata_device is never freed until the port is freed,
> but if you want to be nice and free the device's resources on hotplug,
> then I think it is better to remove the freeing for the resources in
> ata_port_free(), and only perform it in ata_eh_dev_disable(), since
> ata_eh_dev_disable() is called both on hotplug removals (by ata_eh_detach_dev())
> and on unload (by ata_eh_unload()).
> 
> Unload is performed by ata_port_detach(), so ata_eh_unload() ->
> ata_eh_dev_disable() will always be called, there is no need for an additional
> freeing in ata_port_detach() (or in ata_port_free()).
> 
> I suggest something like the following on top of your v4:
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index afc245b2f7cc..57e40987b10a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5463,11 +5463,6 @@ void ata_port_free(struct ata_port *ap)
>         if (!ap)
>                 return;
>  
> -       ata_for_each_link(link, ap, HOST_FIRST) {
> -               ata_for_each_dev(dev, link, ALL)
> -                       ata_dev_cleanup_cdl_resources(dev);
> -       }
> -
>         kfree(ap->pmp_link);
>         kfree(ap->slave_link);
>         ida_free(&ata_ida, ap->print_id);
> @@ -6019,12 +6014,6 @@ static void ata_port_detach(struct ata_port *ap)
>  
>         mutex_lock(&ap->scsi_scan_mutex);
>  
> -       /* Cleanup CDL device resources */
> -       ata_for_each_link(link, ap, HOST_FIRST) {
> -               ata_for_each_dev(dev, link, ALL)
> -                       ata_dev_cleanup_cdl_resources(dev);
> -       }
> -
>         spin_lock_irqsave(ap->lock, flags);
>  
>         /* Remove scsi devices */
> @@ -6055,13 +6044,6 @@ static void ata_port_detach(struct ata_port *ap)
>         cancel_delayed_work_sync(&ap->hotplug_task);
>         cancel_delayed_work_sync(&ap->scsi_rescan_task);
>  
> -       /* clean up zpodd on port removal */
> -       ata_for_each_link(link, ap, HOST_FIRST) {
> -               ata_for_each_dev(dev, link, ALL) {
> -                       if (zpodd_dev_enabled(dev))
> -                               zpodd_exit(dev);
> -               }
> -       }
>         if (ap->pmp_link) {
>                 int i;
>                 for (i = 0; i < SATA_PMP_MAX_PORTS; i++)
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 41f1bee0b434..9e870e01509d 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -494,13 +494,21 @@ void ata_eh_release(struct ata_port *ap)
>         mutex_unlock(&ap->host->eh_mutex);
>  }
>  
> +static void ata_eh_dev_free_resources(struct ata_device *dev)
> +{
> +       if (zpodd_dev_enabled(dev))
> +               zpodd_exit(dev);
> +
> +       ata_dev_cleanup_cdl_resources(dev);
> +}
> +
>  static void ata_eh_dev_disable(struct ata_device *dev)
>  {
>         ata_acpi_on_disable(dev);
>         ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 | ATA_DNXFER_QUIET);
>         dev->class++;
>  
> -       ata_dev_cleanup_cdl_resources(dev);
> +       ata_eh_dev_free_resources(dev);
>  
>         /* From now till the next successful probe, ering is used to
>          * track probe failures.  Clear accumulated device error info.
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3407e764a5ff..8cd241d39c14 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4612,9 +4612,6 @@ static void ata_scsi_handle_link_detach(struct ata_link *link)
>                 dev->flags &= ~ATA_DFLAG_DETACHED;
>                 spin_unlock_irqrestore(ap->lock, flags);
>  
> -               if (zpodd_dev_enabled(dev))
> -                       zpodd_exit(dev);
> -
>                 ata_scsi_remove_dev(dev);
>         }
>  }
> 
> 
> So that we keep all the freeing of struct ata_device's resources in a single
> function.

Looks better. I will integrate that in patch 7. Thanks.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

