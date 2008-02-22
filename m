From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Register for dock events when the drive is	inside
 a dock station
Date: Fri, 22 Feb 2008 10:34:24 +0900
Message-ID: <47BE26A0.2040708@gmail.com>
References: <20080214124048.GB9708@homac.suse.de> <20080214125615.GD9708@homac.suse.de> <47BC5F44.605@garzik.org> <20080221115305.GB5032@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:5074 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936620AbYBVBe3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 20:34:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so261833wah.23
        for <linux-ide@vger.kernel.org>; Thu, 21 Feb 2008 17:34:29 -0800 (PST)
In-Reply-To: <20080221115305.GB5032@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

> If a device/bay is inside a docking station, we need to register for dock
> events additionally to bay events. If a dock event occurs, the dock driver
> will call the appropriate handler (ata_acpi_ap_notify() or
> ata_acpi_dev_notify()) for us.
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>
> ---
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 9e8ec19..563ad72 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -191,20 +191,33 @@ void ata_acpi_associate(struct ata_host *host)
>  		else
>  			ata_acpi_associate_ide_port(ap);
>  
> -		if (ap->acpi_handle)
> +		if (ap->acpi_handle) {
>  			acpi_install_notify_handler (ap->acpi_handle,
>  						     ACPI_SYSTEM_NOTIFY,
>  						     ata_acpi_ap_notify,
>  						     ap);
> +#ifdef CONFIG_ACPI_DOCK_MODULE

Heh, you need

  #if defined(CONFIG_ACPI_DOCK) || defined(CONFIG_ACPI_DOCK_MODULE)

Also, another question.  Is there a way to tell whether the device or
port is connected behind a dock or not?  Just notifying hotplug signal
is fine for hotplugging but to make hot unplug safe for PATA, libata
should be able to tell whether the device is actually gonna go away and
kill it explicitly.

Thanks.

-- 
tejun
