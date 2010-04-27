From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] add port information for ATA devices in sysfs
Date: Mon, 26 Apr 2010 20:42:10 -0700
Message-ID: <20100427034210.GB4759@kroah.com>
References: <201004261829.04687.nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:59578 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289Ab0D0DoC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Apr 2010 23:44:02 -0400
Content-Disposition: inline
In-Reply-To: <201004261829.04687.nschichan@freebox.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Maxime Bizon <mbizon@freebox.fr>

On Mon, Apr 26, 2010 at 06:29:04PM +0200, Nicolas Schichan wrote:
> 
> Hi,
> 
> Currently, it is  not possible to know on what  particular port an ata
> device is located  with sysfs.  the current scheme  creates an host<x>
> directory directly under  the sata host device node  like this (with a
> sata_mv driver, having two sata ports):
> 
> /sys/platform/sata_mv.0/host<x>
> /sys/platform/sata_mv.0/host<y>
> 
> If the  system probes successfully  other scsi devices  before probing
> the sata bus, we have no guarantees that the same numbers will be used
> all the  time, and if we  rmmod/modprobe sata_mv the  host numbers are
> not persistent accross module insertion.
> 
> The  inlined patch  fixes  this by  adding  a port<x>  device that  is
> parented to the sata controller device  and uses this device as a base
> to create the scsi hosts for the devices behind a given sata port. <x>
> is set to be the value of the port_no field in struct ata_port.
> 
> the  naming then looks  like this  (assuming two  sata ports  behind a
> sata_mv driver):
> 
> /sys/platform/sata_mv.0/port0/host<x>
> /sys/platform/sata_mv.0/port1/host<y>
> 
> My  patch adds a  struct device  inside struct  ata_port for  the sole
> purpose of having this port0,port1,... directory under sata_mv.
> 
> This patch also moves the  assignation of port_no to ata_port_alloc to
> ease the initialisation of the device structure embedded in sata_port.
> this most  likely messes up  the ata_sas_port_alloc code  which always
> sets port_no to 0 and will make device_add complain loudly in dmesg if
> this function  is called more than  once. Unfortunately I  do not have
> any SAS devices at hand to fix this.
> 
> I do  not know yet  how this would  behave with sata devices  behind a
> SATA port multiplier but I would  guess that no new scsi host would be
> created in this  case and that the other  fields of target<host>:x:y:z
> would be used by the scsi subsystem.
> 
> This is not a very polished patch  and it is aimed to know whether the
> approach  used  is correct  and  I would  like  to  have your  advices
> regarding this.
> 
> Regards,
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> 
> -- 
> Nicolas Schichan
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 91fed3c..179abad 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5660,6 +5660,10 @@ int sata_link_init_spd(struct ata_link *link)
>  	return 0;
>  }
>  
> +static void ata_port_dev_release(struct device *dev)
> +{
> +}

{sigh}

By doing the above, you have guaranteed that I will make fun of this
code.  Consider this the ridicule it deserves.

(hint, read the kobject documentation for why I get to make fun of
it...)

Think about why you created an empty release function, to try to get the
kernel to stop spitting out a message to you.  Didn't you think that the
message was there for a reason, and it was not to be worked around?

{sigh}

greg k-h
