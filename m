From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 04/14] libata: implement ata_platform_remove_one()
Date: Fri, 02 Nov 2012 23:12:21 +0300
Message-ID: <50942925.7070407@mvista.com>
References: <1351842388-27210-5-git-send-email-computersforpeace@gmail.com> <1351883393-32354-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49990 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935443Ab2KBTN1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 15:13:27 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2846658lbo.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 12:13:25 -0700 (PDT)
In-Reply-To: <1351883393-32354-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 11/02/2012 10:09 PM, Brian Norris wrote:

> This relatively simple boiler-plate code is repeated in several platform
> drivers. We should implement a common version in libata.

> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---
> v2: fix whitespace

>  drivers/ata/libata-core.c | 23 +++++++++++++++++++++++
>  include/linux/libata.h    |  4 ++++
>  2 files changed, 27 insertions(+)

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 611050d..7bf1199 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
[...]
> @@ -6350,6 +6351,26 @@ int ata_pci_device_resume(struct pci_dev *pdev)
>  
>  #endif /* CONFIG_PCI */
>  
> +/**
> + *      ata_platform_remove_one- Platform layer callback for device removal

   A space before hyphen is needed.

> + *      @pdev: Platform device that was removed
> + *
> + *      Platform layer indicates to libata via this hook that hot-unplug or
> + *      module unload event has occurred.  Detach all ports.  Resource
> + *      release is handled via devres.
> + *
> + *      LOCKING:
> + *      Inherited from platform layer (may sleep).
> + */

   I actually meant indenting with tabs within the comment too. :-)

WBR, Sergei

