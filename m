From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Fri, 21 Sep 2007 11:20:49 +0900
Message-ID: <46F32A81.8030508@gmail.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>	 <46F2ED71.3070603@pobox.com> <1190337402.16463.3.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:11092 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbXIUCU6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 22:20:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so820256wah
        for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 19:20:58 -0700 (PDT)
In-Reply-To: <1190337402.16463.3.camel@sli10-conroe.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Hello,

Shaohua Li wrote:
> +	/* channel first and then drives for power on and verse versa for power off */
> +	if (state.event == PM_EVENT_ON)
> +		acpi_bus_set_power(ap->acpi_handle, ACPI_STATE_D0);
> +
> +	if (ap->flags & ATA_FLAG_SLAVE_POSS)
> +		max_devices++;

ata_port_max_devices()?

> Index: linux/drivers/ata/libata-eh.c
> ===================================================================
> --- linux.orig/drivers/ata/libata-eh.c	2007-09-14 10:28:25.000000000 +0800
> +++ linux/drivers/ata/libata-eh.c	2007-09-21 08:56:40.000000000 +0800
> @@ -2349,6 +2349,7 @@ static void ata_eh_handle_port_suspend(s
>  	if (ap->ops->port_suspend)
>  		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
>  
> +	ata_acpi_set_state(ap, PMSG_SUSPEND);
>   out:
>  	/* report result */
>  	spin_lock_irqsave(ap->lock, flags);
> @@ -2394,6 +2395,8 @@ static void ata_eh_handle_port_resume(st
>  
>  	WARN_ON(!(ap->pflags & ATA_PFLAG_SUSPENDED));
>  
> +	ata_acpi_set_state(ap, PMSG_ON);
> +
>  	if (ap->ops->port_resume)
>  		rc = ap->ops->port_resume(ap);

Can these be moved into ata_acpi_on_suspend() and ata_acpi_on_resume()?
 Or do they have to be placed on the other side of ->port_suspend/resume
callbacks?

Thanks.

-- 
tejun
