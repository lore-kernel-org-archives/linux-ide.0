Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF9DDD2;
	Wed,  2 Oct 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909263; cv=none; b=Bma/MENQFSGWbew43boEf4xLj9LfVTrkqkX1CEcTY6ozXzGTip9AVROO8By+0WuMYx9hvzEJsxdW4ciSpaLVYiVJRF2KrmQBQqZwmesJ0O+ZP+wx4Ix+03RWS8QPwjqTIKtzGv8Ba69z5xSqCfyb9TkR+OMIau+YLX1t/pyO418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909263; c=relaxed/simple;
	bh=M5M2hKrU2v2SP1cbiBEkklptQK8AknDAgduCYJQ/gyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx2fzdkVnoPVxq60kl6bD0CY9+wttASCZ/EdqEWM6uDAiTfJc2/5FUDqYm81ngLtzLAUk9OUZbYIQiDXrFt/2J7sO/jfGLEV2X+OJ0Tf8NV1GeegCD9aSFGxTzpbNeTn6qHAJHnlJcNNJ32BwG/h1dSY6vWQHVPP/ORVw05t8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMl6vg6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMl6vg6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BF5C4CEC2;
	Wed,  2 Oct 2024 22:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727909263;
	bh=M5M2hKrU2v2SP1cbiBEkklptQK8AknDAgduCYJQ/gyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kMl6vg6LYHuT562uq16eluCGYFdOUu0Dsm7pGWksUa7rQsXoSaiFOrUNXEDa/cZCT
	 DecelHODAQDNNgAMnTGPUfIpPDaAVBBWkI4FZBDPlNwdXEg2xVajsu0JoDTMNc00bW
	 BtmuV0fj2tCyCdIfLBI7aEggv6e7fgO69eWtEfhVGdzl4RmCZoTJBOxZNe72fHa89x
	 EdRT0fgrg+uFmTB9M7emAYPVxsuI+3N1w6n4egz2xb4B4U6W/Ia7pM+ILuJcdtHBM+
	 ihzmK4xSATpFXCoqiBj2R7Tx3hK7Y6zUgIXqUD/ZIfE1Ldopwfc4VX0dw4fkIltV5I
	 ttlrETlaiUsmw==
Message-ID: <07f85f4a-71c7-465b-b38c-127a02721423@kernel.org>
Date: Thu, 3 Oct 2024 07:47:41 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: libahci driver and power switching HDD on newer kernels
To: Niklas Cassel <cassel@kernel.org>, W <linuxcdeveloper@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-ide@vger.kernel.org
References: <7882faa8-d5ec-4868-b158-0b942b669cc0@gmail.com>
 <c4f1c690-6e97-44de-985f-dc9eadd18d23@leemhuis.info>
 <c7880a6f-04d4-4572-9255-1575f6668b4e@kernel.org>
 <a0c34406-3bb3-4880-9513-0876aacd4de6@gmail.com> <Zv25MQWh-1yYAcVC@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Zv25MQWh-1yYAcVC@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 06:20, Niklas Cassel wrote:
> On Tue, Sep 24, 2024 at 12:42:10PM +0200, W wrote:
>>>
>>> Given that you had 6.4.12 working OK, it is likely some commit that introduced a
>>> regression. If you can git bisect it, we will have a better idea how to remove
>>> the regression.
>>
>> Please take a look at bugzilla report:
>> https://bugzilla.kernel.org/show_bug.cgi?id=219296 - there are the details.
>>
>> I'm wondering what is the better way for communication - here on mailing
>> list or put the comments in bugzilla ticket?
>> Probably here will be better idea...
>>
>> W
>>
> 
> Hello W,
> 
> Could you please try the following patch,
> and see if it helps:
> 
> 
> From dba01b7d68fffc26f3abf3252296082311a767a0 Mon Sep 17 00:00:00 2001
> From: Niklas Cassel <cassel@kernel.org>
> Date: Wed, 2 Oct 2024 21:40:41 +0200
> Subject: [PATCH] ata: libata: do not spin down disk on PM event freeze
> 
> Currently, ata_eh_handle_port_suspend() will return early if
> ATA_PFLAG_PM_PENDING is not set, or if the PM event has flag
> PM_EVENT_RESUME set.
> 
> This means that the following PM callbacks:
> .suspend = ata_port_pm_suspend,
> .freeze = ata_port_pm_freeze,
> .poweroff = ata_port_pm_poweroff,
> .runtime_suspend = ata_port_runtime_suspend,
> will actually make ata_eh_handle_port_suspend() perform some work.
> 
> ata_eh_handle_port_suspend() will spin down the disks (by calling
> ata_dev_power_set_standby()), regardless of the PM event.
> 
> Documentation/driver-api/pm/devices.rst, section "Entering Hibernation",
> explicitly mentions that .freeze() does not have to be put the device in
> a low-power state, and actually recommends not doing so. Thus, let's not
> spin down the disk for the .freeze() callback. (The disk will instead be
> spun down during the succeeding .poweroff() callback.)
> 
> Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-eh.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3f0144e7dc80..45a0d9af2d54 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4099,10 +4099,20 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
>  
>         WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
>  
> -       /* Set all devices attached to the port in standby mode */
> -       ata_for_each_link(link, ap, HOST_FIRST) {
> -               ata_for_each_dev(dev, link, ENABLED)
> -                       ata_dev_power_set_standby(dev);
> +       /*
> +        * We will reach this point for all of the PM events:
> +        * PM_EVENT_SUSPEND (if runtime pm, PM_EVENT_AUTO will also be set)
> +        * PM_EVENT_FREEZE, and PM_EVENT_HIBERNATE.
> +        *
> +        * We do not want to perform disk spin down for PM_EVENT_FREEZE.
> +        * (Spin down will be performed by the succeeding PM_EVENT_HIBERNATE.)
> +        */
> +       if (!(ap->pm_mesg.event & PM_EVENT_FREEZE)) {

This feels odd: not doing anything to the drive for PM_EVENT_FREEZE will still
endup freezing the port, which will later cause a reset. And we still endup
calling the port suspend op and ata_acpi_set_state(), which seems to be doing
nothing for freeze...

So I wonder if a simpler approach would not be to simply remove the
ata_port_pm_freeze() method entirely and do nothing for freeze events ?

> +               /* Set all devices attached to the port in standby mode */
> +               ata_for_each_link(link, ap, HOST_FIRST) {
> +                       ata_for_each_dev(dev, link, ENABLED)
> +                               ata_dev_power_set_standby(dev);
> +               }
>         }
>  
>         /*


-- 
Damien Le Moal
Western Digital Research
