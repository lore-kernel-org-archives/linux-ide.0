From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Fri, 2 Nov 2007 12:16:01 +0100
Message-ID: <200711021216.03088.rjw@sisk.pl>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com> <20071101100435.7c80785e@the-village.bc.nu> <1193967158.13603.4.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52581 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529AbXKBK7I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Nov 2007 06:59:08 -0400
In-Reply-To: <1193967158.13603.4.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Len Brown <lenb@kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Friday, 2 November 2007 02:32, Shaohua Li wrote:
> On Thu, 2007-11-01 at 10:04 +0000, Alan Cox wrote:
> > > +	max_devices = ata_link_max_devices(&ap->link);
> > > +
> > > +	for (i = 0; i < max_devices; ++i) {
> > > +		struct ata_device *dev = &ap->link.device[i];
> > 
> > Better to use:
> ok.
> > 	ata_link_for_each_dev(dev, &ap->link) {		
> > 
> > > +
> > > +		if (dev->acpi_handle)
> > > +			acpi_bus_set_power(dev->acpi_handle,
> > > +				state.event == PM_EVENT_ON ?
> > > +				ACPI_STATE_D0: ACPI_STATE_D3);
> > > +	}
> > 
> > Also should you not check ata_dev_enabled(dev) ?
> Not sure, this is just to call a BIOS routine, but a check should be
> safer. Thanks!
> 
> ACPI spec (ver 3.0a, p289) requires IDE power on/off executes ACPI _PSx
> methods. As recently most PATA drivers use libata, this patch adds _PSx
> method support in libata. ACPI spec doesn't mention if SATA requires the
> same _PSx method.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> Acked-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/ata/libata-acpi.c |   29 +++++++++++++++++++++++++++++
>  drivers/ata/libata-eh.c   |    3 +++
>  drivers/ata/libata.h      |    2 ++
>  3 files changed, 34 insertions(+)
> 
> Index: linux/drivers/ata/libata-acpi.c
> ===================================================================
> --- linux.orig/drivers/ata/libata-acpi.c	2007-11-01 10:54:25.000000000 +0800
> +++ linux/drivers/ata/libata-acpi.c	2007-11-02 09:14:12.000000000 +0800
> @@ -652,6 +652,35 @@ void ata_acpi_on_resume(struct ata_port 
>  }
>  
>  /**
> + * ata_acpi_set_state - set the port power state
> + * @ap: target ATA port
> + * @state: state, on/off
> + *
> + * This function executes the _PS0/_PS3 ACPI method to set the power state.
> + * ACPI spec requires _PS0 when IDE power on and _PS3 when power off
> + */
> +void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)

I wouldn't use pm_message_t here.

We're seriously considering removing it in the future and the caller passes
constants explicitly anyway.

IMO, it might be cleaner to define two separate functions, one for switching
to D0 and one for switching to D3, and call them as appropriate.  Then, you
could get rid of some conditionals below.

> +{
> +	struct ata_device *dev;
> +
> +	if (!ap->acpi_handle || (ap->flags & ATA_FLAG_ACPI_SATA))
> +		return;
> +
> +	/* channel first and then drives for power on and verse versa for power off */
> +	if (state.event == PM_EVENT_ON)
> +		acpi_bus_set_power(ap->acpi_handle, ACPI_STATE_D0);
> +
> +	ata_link_for_each_dev(dev, &ap->link) {
> +		if (dev->acpi_handle && ata_dev_enabled(dev))
> +			acpi_bus_set_power(dev->acpi_handle,
> +				state.event == PM_EVENT_ON ?
> +				ACPI_STATE_D0: ACPI_STATE_D3);
> +	}
> +	if (state.event != PM_EVENT_ON)
> +		acpi_bus_set_power(ap->acpi_handle, ACPI_STATE_D3);
> +}
> +
> +/**
>   * ata_acpi_on_devcfg - ATA ACPI hook called on device donfiguration
>   * @dev: target ATA device
>   *
> Index: linux/drivers/ata/libata-eh.c
> ===================================================================
> --- linux.orig/drivers/ata/libata-eh.c	2007-11-01 10:54:25.000000000 +0800
> +++ linux/drivers/ata/libata-eh.c	2007-11-02 09:01:41.000000000 +0800
> @@ -2796,6 +2796,7 @@ static void ata_eh_handle_port_suspend(s
>  	if (ap->ops->port_suspend)
>  		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
>  
> +	ata_acpi_set_state(ap, PMSG_SUSPEND);
>   out:
>  	/* report result */
>  	spin_lock_irqsave(ap->lock, flags);
> @@ -2841,6 +2842,8 @@ static void ata_eh_handle_port_resume(st
>  
>  	WARN_ON(!(ap->pflags & ATA_PFLAG_SUSPENDED));
>  
> +	ata_acpi_set_state(ap, PMSG_ON);
> +
>  	if (ap->ops->port_resume)
>  		rc = ap->ops->port_resume(ap);
>  
> Index: linux/drivers/ata/libata.h
> ===================================================================
> --- linux.orig/drivers/ata/libata.h	2007-11-01 10:54:25.000000000 +0800
> +++ linux/drivers/ata/libata.h	2007-11-02 09:01:41.000000000 +0800
> @@ -111,12 +111,14 @@ extern void ata_acpi_associate(struct at
>  extern int ata_acpi_on_suspend(struct ata_port *ap);
>  extern void ata_acpi_on_resume(struct ata_port *ap);
>  extern int ata_acpi_on_devcfg(struct ata_device *adev);
> +extern void ata_acpi_set_state(struct ata_port *ap, pm_message_t state);
>  #else
>  static inline void ata_acpi_associate_sata_port(struct ata_port *ap) { }
>  static inline void ata_acpi_associate(struct ata_host *host) { }
>  static inline int ata_acpi_on_suspend(struct ata_port *ap) { return 0; }
>  static inline void ata_acpi_on_resume(struct ata_port *ap) { }
>  static inline int ata_acpi_on_devcfg(struct ata_device *adev) { return 0; }
> +static inline void ata_acpi_set_state(struct ata_port *ap, pm_message_t state) { }
>  #endif
>  
>  /* libata-scsi.c */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Greetings,
Rafael
