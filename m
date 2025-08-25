Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B84C92
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2025 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089547; cv=none; b=XEXZgPxuTO4LYEKjgQeREU9xDBK7GpFYlrlLT3/LuTpdVm32MirS9ZPWW9jNqcms2EMFMH9DInPE0S3zpJbkPO/8X5cmdeKvBgoY3Pa5gVio4JXd8v9gsJ8CEyaTfiYGfU8mplZySWOdQ46EH+rMPO/vvbZqcyDJ0tV6S80/dSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089547; c=relaxed/simple;
	bh=7olmRwGfGhdUS0j34d72rHzMD5uWkBPVSoR1m5y5dw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOKJHEp5bU9ydv0X4J3XT9yyBmyExv9sBSpLVvsg0aB5iKbGeAH5c5DnpWel5STAtQ3hm6P/z6q24SSprNQX/bs2ur8qH7nGEUbun4wjYnN4DvkDyZvWL/kUzyy+jNEIaT+aYBAEtTmqsHv3QnITU76eU2rdodtAxvjR8ETIQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPYua9PO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPYua9PO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594EDC4CEF4;
	Mon, 25 Aug 2025 02:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756089546;
	bh=7olmRwGfGhdUS0j34d72rHzMD5uWkBPVSoR1m5y5dw0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gPYua9POHcV597OgXUO2nSF6k9LvdDWgjTIBF1Ep+5fpOi2OHmdtLDkzPKHo++/EV
	 x4sovz/KVoYBdXFA/cvuWmY+R27izr7AW5d5K7Ldr9r7bzDDq/NLCHie1HOPf0vs/m
	 NgoHG490QXGTIbcIYPpWJIRfms2nwGAhO3nQjkYgVV2jeVECo1A3nNZykxtkxggt9A
	 0mplz16YqL2MnGC5mHa8pPWWC4R3c56sMcntLFFJhhO/aa/ZRZxt1GkD7LLewKujOX
	 k5Crj+XT3w39ta/dK2Zeuj6kpVmAs61VEPTnq1js2bucTfAR67yMz9lbNf7SB/Qd7J
	 /J9sc386QuDtA==
Message-ID: <b3b3feba-4198-45bc-85fe-59dc9ceb5e0f@kernel.org>
Date: Mon, 25 Aug 2025 11:36:18 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: Allow ignoring the external/hotplug
 capability of ports
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Dieter Mummenschanz <dmummenschanz@web.de>
References: <20250821080651.65800-1-dlemoal@kernel.org>
 <aKhj7prAFmQ9U95z@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aKhj7prAFmQ9U95z@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 9:34 PM, Niklas Cassel wrote:
> On Thu, Aug 21, 2025 at 05:06:51PM +0900, Damien Le Moal wrote:
>> Commit 4edf1505b76d ("ata: ahci: Disallow LPM policy control for
>> external ports") introduced disabling link power management (LPM) for
>> ports that are advertized as external/hotplug capable. This is necessary
>> to force the maximum power policy (ATA_LPM_MAX_POWER) onto the port link
>> to ensure that the hotplug capability of the port is functional.
>>
>> However, doing so blindly for all ports can prevent systems from going
>> into a low power state, even if the external/hotplug ports on the system
>> are unused. E.g., a laptop may see the internal SATA slot of a docking
>> station as an external hotplug capable port, and in such case, the user
>> may prefer to not use the port and to privilege instead enabling LPM
> 
> s/to privilege instead enabling/to instead favor enabling/
> or
> s/to privilege instead enabling/to instead prioritize enabling/
> 
> 
>> to allow the laptop to transition to low power states.
>>
>> Since there is no easy method to automatically detect such choice,
>> introduce the new mask_port_ext module parameter to allow a user to
>> ignore the external/hotplug capability of a port. The format for this
>> parameter value is identical to the format used for the mask_port_map
>> parameter: a mask can be defined for all AHCI adapters of a system or
>> for a particular adapters identified with their PCI IDs (bus:dev.func
>> format).
>>
>> The function ahci_get_port_map_mask() is renamed to ahci_get_port_mask()
>> and modified to return a mask, either for the port map maks of an
> 
> s/maks/
> 
> 
>> adapter (to ignore ports) or for the external/hotplug capability of an
> 
>> adapter ports. Differentiation between map_port_mask and
> 
> s/adapter/adapter (to ignore ports)/
> 
> 
>> map_port_ext_mask is done by passing the parameter string to
>> ahci_get_port_mask() as a second argument.
>>
>> To be consistent with this change, the function
>> ahci_apply_port_map_mask() is renamed ahci_port_mask() and changed to
>> return a mask value.
>>
>> The mask for the external/hotplug capability for an adapter, if defined
>> by the map_port_ext_mask parameter, is stored in the new field
>> mask_port_ext of struct ahci_host_priv. ahci_mark_external_port() is
>> modified to not set the ATA_PFLAG_EXTERNAL flag for a port if
>> hpriv->mask_port_ext includes the number of the port. In such case,
>> an information message is printed to notify that the external/hotplug
>> capability is being ignored.
>>
>> Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220465
>> Fixes: 4edf1505b76d ("ata: ahci: Disallow LPM policy control for external ports")
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>> Changes from v1:
>>  - v1 was the wrong patch... v2 uses the correct name "mask_port_ext"
>>    instead of "mask_port_ext_map"
>>
>>  drivers/ata/ahci.c | 57 ++++++++++++++++++++++++++++++++--------------
>>  drivers/ata/ahci.h |  1 +
>>  2 files changed, 41 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index e1c24bbacf64..7a7f88b3fa2b 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -689,40 +689,50 @@ MODULE_PARM_DESC(mask_port_map,
>>  		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
>>  		 "form \"domain:bus:dev.func\"");
>>  
>> -static void ahci_apply_port_map_mask(struct device *dev,
>> -				     struct ahci_host_priv *hpriv, char *mask_s)
>> +static char *ahci_mask_port_ext;
>> +module_param_named(mask_port_ext, ahci_mask_port_ext, charp, 0444);
>> +MODULE_PARM_DESC(mask_port_ext,
>> +		 "32-bits mask to ignore the external/hotplug capability of ports. "
>> +		 "Valid values are: "
>> +		 "\"<mask>\" to apply the same mask to all AHCI controller "
>> +		 "devices, and \"<pci_dev>=<mask>,<pci_dev>=<mask>,...\" to "
>> +		 "specify different masks for the controllers specified, "
>> +		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
>> +		 "form \"domain:bus:dev.func\"");
>> +
>> +static u32 ahci_port_mask(struct device *dev, char *mask_s)
>>  {
>>  	unsigned int mask;
>>  
>>  	if (kstrtouint(mask_s, 0, &mask)) {
>>  		dev_err(dev, "Invalid port map mask\n");
>> -		return;
>> +		return 0;
>>  	}
>>  
>> -	hpriv->mask_port_map = mask;
>> +	return mask;
>>  }
>>  
>> -static void ahci_get_port_map_mask(struct device *dev,
>> -				   struct ahci_host_priv *hpriv)
>> +static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
>>  {
>>  	char *param, *end, *str, *mask_s;
>>  	char *name;
>> +	u32 mask = 0;
>>  
>> -	if (!strlen(ahci_mask_port_map))
>> -		return;
>> +	if (!mask_p || !strlen(mask_p))
>> +		return 0;
>>  
>> -	str = kstrdup(ahci_mask_port_map, GFP_KERNEL);
>> +	str = kstrdup(mask_p, GFP_KERNEL);
>>  	if (!str)
>> -		return;
>> +		return 0;
>>  
>>  	/* Handle single mask case */
>>  	if (!strchr(str, '=')) {
>> -		ahci_apply_port_map_mask(dev, hpriv, str);
>> +		mask = ahci_port_mask(dev, str);
>>  		goto free;
>>  	}
>>  
>>  	/*
>> -	 * Mask list case: parse the parameter to apply the mask only if
>> +	 * Mask list case: parse the parameter to get the mask only if
>>  	 * the device name matches.
>>  	 */
>>  	param = str;
>> @@ -752,11 +762,13 @@ static void ahci_get_port_map_mask(struct device *dev,
>>  			param++;
>>  		}
>>  
>> -		ahci_apply_port_map_mask(dev, hpriv, mask_s);
>> +		mask = ahci_port_mask(dev, mask_s);
>>  	}
>>  
>>  free:
>>  	kfree(str);
>> +
>> +	return mask;
>>  }
>>  
>>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>> @@ -782,8 +794,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>>  	}
>>  
>>  	/* Handle port map masks passed as module parameter. */
>> -	if (ahci_mask_port_map)
>> -		ahci_get_port_map_mask(&pdev->dev, hpriv);
>> +	hpriv->mask_port_map =
>> +		ahci_get_port_mask(&pdev->dev, ahci_mask_port_map);
>> +	hpriv->mask_port_ext =
>> +		ahci_get_port_mask(&pdev->dev, ahci_mask_port_ext);
>>  
>>  	ahci_save_initial_config(&pdev->dev, hpriv);
>>  }
>> @@ -1757,11 +1771,20 @@ static void ahci_mark_external_port(struct ata_port *ap)
>>  	void __iomem *port_mmio = ahci_port_base(ap);
>>  	u32 tmp;
>>  
>> -	/* mark external ports (hotplug-capable, eSATA) */
>> +	/*
>> +	 * Mark external ports (hotplug-capable, eSATA), unless we were asked to
>> +	 * ignore this feature.
>> +	 */
> 
> Hm.. we also have libata.force=<port>:external
> which marks a port as external.
> 
> I think it makes most sense for mask_port_ext, since it defines a whole mask
> for all ports, to take precedence over properties enabled for individual port.
> 
> I.e. I think that mask_port_ext should ignore external, regardless if the port
> was marked as external using firmware, or using libata.force=<port>:external.
> 
> 
>>  	tmp = readl(port_mmio + PORT_CMD);
>>  	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
>> -	    (tmp & PORT_CMD_HPCP))
>> +	    (tmp & PORT_CMD_HPCP)) {
>> +		if (hpriv->mask_port_ext & (1U << ap->port_no)) {
>> +			ata_port_info(ap,
>> +				"Ignoring external/hotplug capability\n");
>> +			return;
>> +		}
>>  		ap->pflags |= ATA_PFLAG_EXTERNAL;
>> +	}
> 
> Perhaps something like:
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index e1c24bbacf64..bd68373efc24 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1762,6 +1762,12 @@ static void ahci_mark_external_port(struct ata_port *ap)
>  	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
>  	   (tmp & PORT_CMD_HPCP))
>  		ap->pflags |= ATA_PFLAG_EXTERNAL;
> +
> +	/* mask_port_ext clears ATA_PFLAG_EXTERNAL no matter how it was set. */
> +	if (hpriv->mask_port_ext & (1U << ap->port_no)) {
> +		ata_port_info(ap, "Ignoring external/hotplug capability\n");
> +		ap->pflags &= ~ATA_PFLAG_EXTERNAL;

I can add this, but I do not think this is useful since libata.force is applied
*after* probing the adapter, which is is the one that will call the above. So
when this runs, libata has not yet touched the ports and not forced any flags.


> +	}
>  }
>  
> 
> 
> 
> But do we really want a introduce a module parameter for this?
> I know that commit 4edf1505b76d ("ata: ahci: Disallow LPM policy control for
> external ports")
> if external, both:
> 1) sets initial lpm policy to MAX_POWER (so that hot plug works by default)
> 2) sets ATA_FLAG_NO_LPM, so that you cannot change the LPM policy using sysfs
> 
> I think that 1) is good.
> 
> However, why should we forbid the user to override to policy via sysfs just
> because the port is external?
> If a system admin has installed a udev rule or similar to set a lpm policy,
> why should we not respect that?
> 
> Yes, I know that many distros supply a rule that just enables LPM
> unconditionally for all disks...
> 
> But... instead of forbidding the user to change to policy using sysfs, perhaps
> a better way would be for the system admin/distros to improve their udev rules?

Sure, but that is something do be done with the distro. Because from
libata-sata sysfs handling, we do not know if the sysfs
link_power_management_policy is being changed by the distro systemd rules or
manually by the user.

Since most distro systemd try to favor power savings, without 4edf1505b76d,
hotplug never works because systemd changes max_power to some lower policy, and
that make hotplug non-functional.

> We have a sysfs property that says if the port supports LPM.
> Perhaps we should have a sysfs attribute that says if the port is external.

Yes, but see my comment on your other patch. Problem is that we need an
extensive cleanup of the port, link and device flags to differentiate between
"X is supported" and "X is enabled/disabled". Right now, we can't, which makes
any runtime change unreliable and potentially dangerous.

> The udev rules can then be smarter and just set the LPM policy if the port is
> not external. But the user would still have the option to set a LPM policy
> (using the same interface), if they don't care about hotplug.
> 
> It seems more user friendly for a user that has a laptop with a docking
> station with hotplug capable ports, to install a udev rule to set an LPM
> policy, than to set a kernel module param.
> 
> What do you think?

I completely agree. We should not rely on module parameters that force things.
But as mentioned above, that's the only solution to fix issues for now. We need
to do some more cleanup of the flags. It is a mess and long overdue anyway :)



-- 
Damien Le Moal
Western Digital Research
