From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/2] allow user to power off unused ports via sysfs
Date: Fri, 11 Jul 2008 09:50:47 -0400
Message-ID: <48776537.4020802@garzik.org>
References: <20080702225743.518230210@intel.com> <20080702161401.0fac6613@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56063 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760602AbYGKNuv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jul 2008 09:50:51 -0400
In-Reply-To: <20080702161401.0fac6613@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kristen.c.accardi@intel.com
Cc: linux-ide@vger.kernel.org

kristen.c.accardi@intel.com wrote:
> This patch expands the definition of link power management to 
> include the notion of simply powering the entire port off.  
> We add a new valid value for link_power_management_policy:
> 
> power_off:  phy is not on at all.
> min_power:  driver uses minimum possible power. hotplug
>             may or may not be available.
> medium_power: best power/performance tradeoff.  hotplug
>             may or may not be available
> max_performance: max performance without regard to power
>             hot plug is available.
> 
> Additionally - this patch modifies the libata-core to
> power off the port automatically at init time if the
> driver marks the port as not hotpluggable.
> 
> The user may not power off a port if it is occupied.
> If the port is powered off, and a new drive is plugged
> in, the drive will not be detected until the port is
> powered back up by setting the link_power_management_policy
> to "max_performance".
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> ---
>  drivers/ata/libata-core.c |   58 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/ata/libata-scsi.c |    1 
>  include/linux/libata.h    |    2 +
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> Index: linux-ahci-phy/drivers/ata/libata-core.c
> ===================================================================
> --- linux-ahci-phy.orig/drivers/ata/libata-core.c	2008-06-27 13:32:51.000000000 -0700
> +++ linux-ahci-phy/drivers/ata/libata-core.c	2008-07-01 16:33:00.000000000 -0700
> @@ -162,6 +162,19 @@ MODULE_DESCRIPTION("Library module for A
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRV_VERSION);
>  
> +static void ata_phy_offline(struct ata_link *link)
> +{
> +	u32 scontrol;
> +	int rc;
> +
> +	/* set DET to 4 */
> +	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
> +	if (rc)
> +		return;
> +	scontrol &= ~0xf;
> +	scontrol |= (1 << 2);
> +	sata_scr_write(link, SCR_CONTROL, scontrol);
> +}
>  
>  /**
>   *	ata_force_cbl - force cable type according to libata.force
> @@ -953,6 +966,7 @@ static int ata_dev_set_dipm(struct ata_d
>  		 * disallow all transitions which effectively
>  		 * disable DIPM anyway.
>  		 */
> +	default:
>  		break;
>  	}
>  
> @@ -980,6 +994,22 @@ void ata_dev_enable_pm(struct ata_device
>  	int rc = 0;
>  	struct ata_port *ap = dev->link->ap;
>  
> +	/*
> +	 * if we don't have a device attached, all we can
> +	 * do is power off
> +	 */
> +	if (!ata_dev_enabled(dev) && policy == POWER_OFF) {
> +		ap->flags |= ATA_FLAG_NO_HOTPLUG;
> +		ata_phy_offline(&ap->link);
> +		goto enable_pm_out;
> +	}
> +
> +	/*
> +         * if there's no device attached, we are done
> +	 */
> +	if (!ata_dev_enabled(dev))
> +		return;
> +
>  	/* set HIPM first, then DIPM */
>  	if (ap->ops->enable_pm)
>  		rc = ap->ops->enable_pm(ap, policy);
> @@ -1020,10 +1050,24 @@ static void ata_dev_disable_pm(struct at
>  
>  void ata_lpm_schedule(struct ata_port *ap, enum link_pm policy)
>  {
> -	ap->pm_policy = policy;
>  	ap->link.eh_info.action |= ATA_EH_LPM;
> +
> +	/*
> +	 * if we are coming from a state of OFF to ON, we need
> +	 * to reset the link and scan for devices in case someone
> +	 * plugged something in while we were off.
> +	 * Clear the NO_HOTPLUG flag because we are leaving the
> +	 * phy on now.
> +	 */
> +	if (ap->pm_policy == POWER_OFF && policy != POWER_OFF) {
> +		ap->flags &= ~ATA_FLAG_NO_HOTPLUG;
> +		ap->link.eh_info.probe_mask |= ATA_ALL_DEVICES;
> +		ap->link.eh_info.flags |= ATA_EH_RESET;
> +	}
>  	ap->link.eh_info.flags |= ATA_EHI_NO_AUTOPSY;
> +	ap->pm_policy = policy;
>  	ata_port_schedule_eh(ap);
> +	ata_port_wait_eh(ap);
>  }
>  
>  #ifdef CONFIG_PM

just a question... why wait for EH?


> @@ -2678,6 +2722,7 @@ void ata_port_disable(struct ata_port *a
>  	ap->link.device[0].class = ATA_DEV_NONE;
>  	ap->link.device[1].class = ATA_DEV_NONE;
>  	ap->flags |= ATA_FLAG_DISABLED;
> +	ata_phy_offline(&ap->link);
>  }
>  
>  /**

do we really want to unconditionally assume SATA here?

