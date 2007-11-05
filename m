From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Mon, 05 Nov 2007 09:26:12 +0800
Message-ID: <1194225972.32766.6.camel@sli10-conroe.sh.intel.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
	 <20071101100435.7c80785e@the-village.bc.nu>
	 <1193967158.13603.4.camel@sli10-conroe.sh.intel.com>
	 <200711021216.03088.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4211 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbXKEBcq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 20:32:46 -0500
In-Reply-To: <200711021216.03088.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Len Brown <lenb@kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2007-11-02 at 12:16 +0100, Rafael J. Wysocki wrote:
> > 
> > Index: linux/drivers/ata/libata-acpi.c
> > ===================================================================
> > --- linux.orig/drivers/ata/libata-acpi.c	2007-11-01 10:54:25.000000000 +0800
> > +++ linux/drivers/ata/libata-acpi.c	2007-11-02 09:14:12.000000000 +0800
> > @@ -652,6 +652,35 @@ void ata_acpi_on_resume(struct ata_port 
> >  }
> >  
> >  /**
> > + * ata_acpi_set_state - set the port power state
> > + * @ap: target ATA port
> > + * @state: state, on/off
> > + *
> > + * This function executes the _PS0/_PS3 ACPI method to set the power state.
> > + * ACPI spec requires _PS0 when IDE power on and _PS3 when power off
> > + */
> > +void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
> 
> I wouldn't use pm_message_t here.
> 
> We're seriously considering removing it in the future and the caller passes
> constants explicitly anyway.
> 
> IMO, it might be cleaner to define two separate functions, one for switching
> to D0 and one for switching to D3, and call them as appropriate.  Then, you
> could get rid of some conditionals below.
It doesn't make sense to add a new one just for ata_acpi and we don't
misuse pm_message_t here. If you will remove it, lets clean up it then.

Thanks,
Shaohua
