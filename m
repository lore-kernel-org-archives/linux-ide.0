From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 04/14] libata: implement ata_platform_remove_one()
Date: Fri, 02 Nov 2012 15:07:09 +0400
Message-ID: <5093A95D.6090403@mvista.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com> <1351842388-27210-5-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:45845 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab2KBLIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 07:08:23 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2517311lag.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 04:08:22 -0700 (PDT)
In-Reply-To: <1351842388-27210-5-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Hello.

On 02-11-2012 11:46, Brian Norris wrote:

> This relatively simple boiler-plate code is repeated in several platform
> drivers. We should implement a common version in libata.

> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---
>   drivers/ata/libata-core.c | 23 +++++++++++++++++++++++
>   include/linux/libata.h    |  4 ++++
>   2 files changed, 27 insertions(+)

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 611050d..820e47f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
[...]
> @@ -6350,6 +6351,26 @@ int ata_pci_device_resume(struct pci_dev *pdev)
>
>   #endif /* CONFIG_PCI */
>
> +/**
> + *      ata_platform_remove_one- Platform layer callback for device removal
> + *      @pdev: Platform device that was removed
> + *
> + *      Platform layer indicates to libata via this hook that hot-unplug or
> + *      module unload event has occurred.  Detach all ports.  Resource
> + *      release is handled via devres.
> + *
> + *      LOCKING:
> + *      Inherited from platform layer (may sleep).
> + */
> +int ata_platform_remove_one(struct platform_device *pdev)
> +{
> +        struct ata_host *host = platform_get_drvdata(pdev);
> +
> +        ata_host_detach(host);

    Indent with tabs, not spaces, as below.

> +
> +	return 0;
> +}
> +
>   static int __init ata_parse_force_one(char **cur,
>   				      struct ata_force_ent *force_ent,
>   				      const char **reason)

MBR, Sergei

