From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] hook ACPI _PSx method to IDE power on/off
Date: Wed, 22 Aug 2007 21:26:10 -0400
Message-ID: <200708222126.11045.lenb@kernel.org>
References: <1186035248.29979.5.camel@sli10-conroe.sh.intel.com> <200708042155.24843.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45977 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757197AbXHWB0R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Aug 2007 21:26:17 -0400
In-Reply-To: <200708042155.24843.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org

On Saturday 04 August 2007 15:55, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 02 August 2007, Shaohua Li wrote:
> > ACPI spec defines the sequence of IDE power on/off:
> > Powering down:
> > 	Call _GTM.
> > 	Power down drive (calls _PS3 method and turns off power planes).
> > Powering up:
> > 	Power up drive (calls _PS0 method if present and turns on power planes).
> > 	Call _STM passing info from _GTM (possibly modified), with ID data from
> > 	each drive.
> > 	Initialize the channel.
> > 	May modify the results of _GTF.
> > 	For each drive:
> > 		Call _GTF.
> > 		Execute task file (possibly modified).
> > This patch adds the missed _PS0/_PS3 methods call.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> applied, thanks
> 
> Len, are you OK with the ACPI part of the patch (below)?

yes.
Acked-by: Len Brown <len.brown@intel.com>

thanks,
-Len

> > Index: linux/drivers/acpi/bus.c
> > ===================================================================
> > --- linux.orig/drivers/acpi/bus.c	2007-08-02 13:35:06.000000000 +0800
> > +++ linux/drivers/acpi/bus.c	2007-08-02 13:56:56.000000000 +0800
> > @@ -262,10 +262,12 @@ int acpi_bus_set_power(acpi_handle handl
> >  		printk(KERN_WARNING PREFIX
> >  			      "Transitioning device [%s] to D%d\n",
> >  			      device->pnp.bus_id, state);
> > -	else
> > +	else {
> > +		device->power.state = state;
> >  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >  				  "Device [%s] transitioned to D%d\n",
> >  				  device->pnp.bus_id, state));
> > +	}
> >  
> >  	return result;
> >  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
