Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C522FB624
	for <linux-ide@vger.kernel.org>; Fri, 22 Aug 2025 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866099; cv=none; b=oFWUiCF10wE1D7SKTe+7tqN7gFD0C36UrR2OX0B/KDQleSeC4M0Qr7AMSPq260PS9UkP6zdo+Qx869UADhzXPpcNQq64ULqpP5wdLyTpdpBUrGK7oqpHciewZ/6OP9BT/XVSjgiT38yKVaeI+8k2wLOZmQSZAInBHQIWMk+GBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866099; c=relaxed/simple;
	bh=f6C5kpl27Wa3H3lS7KPYpZBS/yQk8jmuTyDaot5uMcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON2/z4zICuIlohqrmNv1My1RBJVQMsQE5oQ3SrxCoXGZu8g9WaBIq4KPIJBasDq0QDnBMt5S9Dc8khunUzLdm6PO53hw8CoDd+yiOldzHvZX47C3y/n/fbSC+sIt4tsgqYBRFs05hXUIIE8jxYzP2SLdYRra9z+MOa99kLSe5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl6uH159; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl6uH159"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF988C4CEED;
	Fri, 22 Aug 2025 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755866098;
	bh=f6C5kpl27Wa3H3lS7KPYpZBS/yQk8jmuTyDaot5uMcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl6uH159qb6FUlAjYIOACs7bH2DtxdhxMZeyXfvQKT//LAxV89LIm43x/NJYX4LfW
	 WohB16YFBscfFWlhGuxAecASRhxhy+oSQ/xev6WH51KB2iZVAPgZJCX37tIGOrFbYl
	 gH5pCTHMU7VMDizk5pw0SLolj25sbKaKl5DHB1qTQqJh6UOLwAZlah8dbtfEl18zz+
	 6nhpiyJcvfmShwm/mwAluGvlPmdZsVNwaDEqDdUojHl6+IzSkIgS/xdCk/GyBczH4j
	 jiS+W/nN/ttjzi44WphKco9Kg64qeIAgwU9M3FO7EThvn8iY8oNaVz9OX94DuoC1eM
	 9zu0PRu015dgg==
Date: Fri, 22 Aug 2025 14:34:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: [PATCH v2] ata: ahci: Allow ignoring the external/hotplug
 capability of ports
Message-ID: <aKhj7prAFmQ9U95z@ryzen>
References: <20250821080651.65800-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821080651.65800-1-dlemoal@kernel.org>

On Thu, Aug 21, 2025 at 05:06:51PM +0900, Damien Le Moal wrote:
> Commit 4edf1505b76d ("ata: ahci: Disallow LPM policy control for
> external ports") introduced disabling link power management (LPM) for
> ports that are advertized as external/hotplug capable. This is necessary
> to force the maximum power policy (ATA_LPM_MAX_POWER) onto the port link
> to ensure that the hotplug capability of the port is functional.
> 
> However, doing so blindly for all ports can prevent systems from going
> into a low power state, even if the external/hotplug ports on the system
> are unused. E.g., a laptop may see the internal SATA slot of a docking
> station as an external hotplug capable port, and in such case, the user
> may prefer to not use the port and to privilege instead enabling LPM

s/to privilege instead enabling/to instead favor enabling/
or
s/to privilege instead enabling/to instead prioritize enabling/


> to allow the laptop to transition to low power states.
> 
> Since there is no easy method to automatically detect such choice,
> introduce the new mask_port_ext module parameter to allow a user to
> ignore the external/hotplug capability of a port. The format for this
> parameter value is identical to the format used for the mask_port_map
> parameter: a mask can be defined for all AHCI adapters of a system or
> for a particular adapters identified with their PCI IDs (bus:dev.func
> format).
> 
> The function ahci_get_port_map_mask() is renamed to ahci_get_port_mask()
> and modified to return a mask, either for the port map maks of an

s/maks/


> adapter (to ignore ports) or for the external/hotplug capability of an

> adapter ports. Differentiation between map_port_mask and

s/adapter/adapter (to ignore ports)/


> map_port_ext_mask is done by passing the parameter string to
> ahci_get_port_mask() as a second argument.
> 
> To be consistent with this change, the function
> ahci_apply_port_map_mask() is renamed ahci_port_mask() and changed to
> return a mask value.
> 
> The mask for the external/hotplug capability for an adapter, if defined
> by the map_port_ext_mask parameter, is stored in the new field
> mask_port_ext of struct ahci_host_priv. ahci_mark_external_port() is
> modified to not set the ATA_PFLAG_EXTERNAL flag for a port if
> hpriv->mask_port_ext includes the number of the port. In such case,
> an information message is printed to notify that the external/hotplug
> capability is being ignored.
> 
> Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220465
> Fixes: 4edf1505b76d ("ata: ahci: Disallow LPM policy control for external ports")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> Changes from v1:
>  - v1 was the wrong patch... v2 uses the correct name "mask_port_ext"
>    instead of "mask_port_ext_map"
> 
>  drivers/ata/ahci.c | 57 ++++++++++++++++++++++++++++++++--------------
>  drivers/ata/ahci.h |  1 +
>  2 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index e1c24bbacf64..7a7f88b3fa2b 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -689,40 +689,50 @@ MODULE_PARM_DESC(mask_port_map,
>  		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
>  		 "form \"domain:bus:dev.func\"");
>  
> -static void ahci_apply_port_map_mask(struct device *dev,
> -				     struct ahci_host_priv *hpriv, char *mask_s)
> +static char *ahci_mask_port_ext;
> +module_param_named(mask_port_ext, ahci_mask_port_ext, charp, 0444);
> +MODULE_PARM_DESC(mask_port_ext,
> +		 "32-bits mask to ignore the external/hotplug capability of ports. "
> +		 "Valid values are: "
> +		 "\"<mask>\" to apply the same mask to all AHCI controller "
> +		 "devices, and \"<pci_dev>=<mask>,<pci_dev>=<mask>,...\" to "
> +		 "specify different masks for the controllers specified, "
> +		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
> +		 "form \"domain:bus:dev.func\"");
> +
> +static u32 ahci_port_mask(struct device *dev, char *mask_s)
>  {
>  	unsigned int mask;
>  
>  	if (kstrtouint(mask_s, 0, &mask)) {
>  		dev_err(dev, "Invalid port map mask\n");
> -		return;
> +		return 0;
>  	}
>  
> -	hpriv->mask_port_map = mask;
> +	return mask;
>  }
>  
> -static void ahci_get_port_map_mask(struct device *dev,
> -				   struct ahci_host_priv *hpriv)
> +static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
>  {
>  	char *param, *end, *str, *mask_s;
>  	char *name;
> +	u32 mask = 0;
>  
> -	if (!strlen(ahci_mask_port_map))
> -		return;
> +	if (!mask_p || !strlen(mask_p))
> +		return 0;
>  
> -	str = kstrdup(ahci_mask_port_map, GFP_KERNEL);
> +	str = kstrdup(mask_p, GFP_KERNEL);
>  	if (!str)
> -		return;
> +		return 0;
>  
>  	/* Handle single mask case */
>  	if (!strchr(str, '=')) {
> -		ahci_apply_port_map_mask(dev, hpriv, str);
> +		mask = ahci_port_mask(dev, str);
>  		goto free;
>  	}
>  
>  	/*
> -	 * Mask list case: parse the parameter to apply the mask only if
> +	 * Mask list case: parse the parameter to get the mask only if
>  	 * the device name matches.
>  	 */
>  	param = str;
> @@ -752,11 +762,13 @@ static void ahci_get_port_map_mask(struct device *dev,
>  			param++;
>  		}
>  
> -		ahci_apply_port_map_mask(dev, hpriv, mask_s);
> +		mask = ahci_port_mask(dev, mask_s);
>  	}
>  
>  free:
>  	kfree(str);
> +
> +	return mask;
>  }
>  
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
> @@ -782,8 +794,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  	}
>  
>  	/* Handle port map masks passed as module parameter. */
> -	if (ahci_mask_port_map)
> -		ahci_get_port_map_mask(&pdev->dev, hpriv);
> +	hpriv->mask_port_map =
> +		ahci_get_port_mask(&pdev->dev, ahci_mask_port_map);
> +	hpriv->mask_port_ext =
> +		ahci_get_port_mask(&pdev->dev, ahci_mask_port_ext);
>  
>  	ahci_save_initial_config(&pdev->dev, hpriv);
>  }
> @@ -1757,11 +1771,20 @@ static void ahci_mark_external_port(struct ata_port *ap)
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	u32 tmp;
>  
> -	/* mark external ports (hotplug-capable, eSATA) */
> +	/*
> +	 * Mark external ports (hotplug-capable, eSATA), unless we were asked to
> +	 * ignore this feature.
> +	 */

Hm.. we also have libata.force=<port>:external
which marks a port as external.

I think it makes most sense for mask_port_ext, since it defines a whole mask
for all ports, to take precedence over properties enabled for individual port.

I.e. I think that mask_port_ext should ignore external, regardless if the port
was marked as external using firmware, or using libata.force=<port>:external.


>  	tmp = readl(port_mmio + PORT_CMD);
>  	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
> -	    (tmp & PORT_CMD_HPCP))
> +	    (tmp & PORT_CMD_HPCP)) {
> +		if (hpriv->mask_port_ext & (1U << ap->port_no)) {
> +			ata_port_info(ap,
> +				"Ignoring external/hotplug capability\n");
> +			return;
> +		}
>  		ap->pflags |= ATA_PFLAG_EXTERNAL;
> +	}

Perhaps something like:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e1c24bbacf64..bd68373efc24 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1762,6 +1762,12 @@ static void ahci_mark_external_port(struct ata_port *ap)
 	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
 	   (tmp & PORT_CMD_HPCP))
 		ap->pflags |= ATA_PFLAG_EXTERNAL;
+
+	/* mask_port_ext clears ATA_PFLAG_EXTERNAL no matter how it was set. */
+	if (hpriv->mask_port_ext & (1U << ap->port_no)) {
+		ata_port_info(ap, "Ignoring external/hotplug capability\n");
+		ap->pflags &= ~ATA_PFLAG_EXTERNAL;
+	}
 }
 



But do we really want a introduce a module parameter for this?
I know that commit 4edf1505b76d ("ata: ahci: Disallow LPM policy control for
external ports")
if external, both:
1) sets initial lpm policy to MAX_POWER (so that hot plug works by default)
2) sets ATA_FLAG_NO_LPM, so that you cannot change the LPM policy using sysfs

I think that 1) is good.

However, why should we forbid the user to override to policy via sysfs just
because the port is external?
If a system admin has installed a udev rule or similar to set a lpm policy,
why should we not respect that?

Yes, I know that many distros supply a rule that just enables LPM
unconditionally for all disks...

But... instead of forbidding the user to change to policy using sysfs, perhaps
a better way would be for the system admin/distros to improve their udev rules?

We have a sysfs property that says if the port supports LPM.
Perhaps we should have a sysfs attribute that says if the port is external.

The udev rules can then be smarter and just set the LPM policy if the port is
not external. But the user would still have the option to set a LPM policy
(using the same interface), if they don't care about hotplug.

It seems more user friendly for a user that has a laptop with a docking
station with hotplug capable ports, to install a udev rule to set an LPM
policy, than to set a kernel module param.

What do you think?


Kind regards,
Niklas
