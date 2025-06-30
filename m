Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD55199BC;
	Mon, 30 Jun 2025 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751252042; cv=none; b=jeuwszYhuLgUXpONMjYd8uwH6pXoWMztCdRECw3B1ZK/7XCTA9vBqYiclxvQKr9NKm//7VCMXplC+dfNZRN4UszJKiwJcBs6LbTyxSW73xhYjo4uquiIRFA2EHQdrXRj00IC/h+E/OGfDB/Haj40ZxAlFLNiSzbGr6eXPhNLJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751252042; c=relaxed/simple;
	bh=54Say1SOTnuZO5ZvOloKIxYm5TB/+LjiHHVkLV/s41Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOJPonzvyM84dqVTdGMebvHzhQYz12X76a1yqxA7YEGRPlguIoCn3JSe6G+elzGYT6W/zT6qkNEbTpckjTxViMpxSq5ipk/F+W4iMXzwRqOO1jTXPqXw4NlBB5hn4vy5y/C0EWEV9Ni+qJA3OIkMpgv8jr+AQPBhz1pqE7ZHZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpBRmFkC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpBRmFkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6880CC4CEEB;
	Mon, 30 Jun 2025 02:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751252042;
	bh=54Say1SOTnuZO5ZvOloKIxYm5TB/+LjiHHVkLV/s41Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KpBRmFkCEu1xa+PII5+QsaOEFgPcCRlXrV7xeLL1lSSglGo3dlTTwl5kKX3FPHMHf
	 rUY9dFnNvPTVBnbFxmAfo7lpHDXdz2VcnfBNOYCx8XeyBjpBQSRgRGbqEYjIb/SEIv
	 hmg7BTZMFMn1ZSxhTNL/coKyKNzMPERUVYxXzY9nPcdwsu/ibkjr1o/lAG6FFPf2mr
	 ANQ4/6jqSv83sl7/ZJYY6ugM5K2YJLxqhj1H2gMUpN0IwnItmHfR0yGk6XZvVG3rB/
	 SEArTVM3zAtboRnaGp4Hkjv0p1I8cWdRWgV9iyctrnz//+Z4kQ/7KWZyuypWA9oMM/
	 BxyXnKLtu47+A==
Message-ID: <826118ef-a95d-4c1c-afe4-bc22a7473f71@kernel.org>
Date: Mon, 30 Jun 2025 11:51:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Add ALPM power state accounting to the AHCI
 driver
To: Paul Menzel <pmenzel@molgen.mpg.de>, Niklas Cassel <cassel@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
References: <20250629192456.3761-2-pmenzel@molgen.mpg.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250629192456.3761-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/30/25 4:24 AM, Paul Menzel wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> PowerTOP wants to be able to show the user how effective the ALPM link
> power management is for the user. ALPM is worth around 0.5W on a quiet
> link; PowerTOP wants to be able to find cases where the "quiet link" isn't
> actually quiet.
> 
> This patch adds state accounting functionality to the AHCI driver for
> PowerTOP to use.
> 
> The parts of the patch are
> 
> 1)  the sysfs logic of exposing the stats for each state in sysfs
> 2)  the basic accounting logic that gets update on link change interrupts
>     (or when the user accesses the info from sysfs)
> 3)  an "accounting enable" flag; in order to get the accounting to work,
>     the driver needs to get phyrdy interrupts on link status changes.
>     Normally and currently this is disabled by the driver when ALPM is
>     on (to reduce overhead); when PowerTOP is running this will need
>     to be on to get usable statistics... hence the sysfs tunable.
> 
> The PowerTOP output currently looks like this:
> 
>     Recent SATA AHCI link activity statistics
>     Active	Partial	Slumber	Device name
>       0.5%	 99.5%	  0.0%	host0
> 
> (work to resolve "host0" to a more human readable name is in progress)
> 
>     [root@dyn-252 host1]# grep ^ ahci_alpm_*
>     ahci_alpm_accounting:1
>     ahci_alpm_active:1334912
>     ahci_alpm_devslp:251547
>     ahci_alpm_partial:0
>     ahci_alpm_slumber:1020283
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> [rebased from https://raw.github.com/fenrus75/powertop/master/patches/linux-3.3.0-ahci-alpm-accounting.patch]
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> [rebased from https://lore.kernel.org/all/1364473277.14860.33.camel@i7.infradead.org/
> and slightly modify commit message and update David’s email address]
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> See https://lore.kernel.org/all/20091113192429.4dfc9c39@infradead.org/
> for the original discussion
> 
>  drivers/ata/ahci.h    |  17 ++++
>  drivers/ata/libahci.c | 212 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 227 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 2c10c8f440d1..d02dd726adfd 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -304,6 +304,14 @@ struct ahci_em_priv {
>  	struct ata_link *link;
>  };
>  
> +enum ahci_port_states {
> +	AHCI_PORT_NOLINK = 0,
> +	AHCI_PORT_ACTIVE = 1,
> +	AHCI_PORT_PARTIAL = 2,
> +	AHCI_PORT_SLUMBER = 3,
> +	AHCI_PORT_DEVSLP = 4
> +};

See below. These should probably be called SATA_xxx and be defined in
drivers/ata/libata.h.

> +
>  struct ahci_port_priv {
>  	struct ata_link		*active_link;
>  	struct ahci_cmd_hdr	*cmd_slot;
> @@ -324,6 +332,15 @@ struct ahci_port_priv {
>  	/* enclosure management info per PM slot */
>  	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
>  	char			*irq_desc;	/* desc in /proc/interrupts */
> +
> +	/* ALPM accounting state and stats */
> +	unsigned int 		accounting_active:1;
> +	u64			active_jiffies;
> +	u64			partial_jiffies;
> +	u64			slumber_jiffies;
> +	u64			devslp_jiffies;
> +	int			previous_state;
> +	int			previous_jiffies;
>  };

I wonder if this is the right place to put this... The SSTATUS register that
defines the IPM field used to determine the interface state is not an AHCI only
register. It is defined by the SATA-IO specification (v3.5a, section 14.2.2)
and so this is also all valid for a libsas HBA. So may be this should be moved
to ata_port instead and the sysfs attributes code moved to libata-sata.c.
That will also allow supporting AHCI-platform devices and other SATA adapters
that are not AHCI. These all should work too.

There is also the problem of port multipliers devices, which have several ports
behind a single physical link. Would need further checks there to see if this
really should be attached to ata_port or if this should go to ata_link... Still
scratching my head on this one. Will need more time to check.

Though it begs the question: does PowerTop really expect the names
ahci_alpm_xxx ? It that something that is already coded in that tool ? Or is
this a new feature that is being added now ? (in which case we can still change
the names to be more generic)

>  struct ahci_host_priv {
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 4e9c82f36df1..4b787eb246bd 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -85,6 +85,19 @@ static ssize_t ahci_activity_store(struct ata_device *dev,
>  				   enum sw_activity val);
>  static void ahci_init_sw_activity(struct ata_link *link);
>  
> +static ssize_t ahci_alpm_show_active(struct device *dev,
> +				  struct device_attribute *attr, char *buf);
> +static ssize_t ahci_alpm_show_slumber(struct device *dev,
> +				  struct device_attribute *attr, char *buf);
> +static ssize_t ahci_alpm_show_devslp(struct device *dev,
> +				  struct device_attribute *attr, char *buf);
> +static ssize_t ahci_alpm_show_partial(struct device *dev,
> +				  struct device_attribute *attr, char *buf);
> +static ssize_t ahci_alpm_show_accounting(struct device *dev,
> +				  struct device_attribute *attr, char *buf);
> +static ssize_t ahci_alpm_set_accounting(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count);
>  static ssize_t ahci_show_host_caps(struct device *dev,
>  				   struct device_attribute *attr, char *buf);
>  static ssize_t ahci_show_host_cap2(struct device *dev,
> @@ -106,6 +119,13 @@ static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
>  static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
>  static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
>  static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
> +static DEVICE_ATTR(ahci_alpm_active, S_IRUGO, ahci_alpm_show_active, NULL);
> +static DEVICE_ATTR(ahci_alpm_partial, S_IRUGO, ahci_alpm_show_partial, NULL);
> +static DEVICE_ATTR(ahci_alpm_slumber, S_IRUGO, ahci_alpm_show_slumber, NULL);
> +static DEVICE_ATTR(ahci_alpm_devslp, S_IRUGO, ahci_alpm_show_devslp, NULL);
> +static DEVICE_ATTR(ahci_alpm_accounting, S_IRUGO | S_IWUSR,
> +		ahci_alpm_show_accounting, ahci_alpm_set_accounting);
> +
>  static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
>  		   ahci_read_em_buffer, ahci_store_em_buffer);
>  static DEVICE_ATTR(em_message_supported, S_IRUGO, ahci_show_em_supported, NULL);
> @@ -118,6 +138,11 @@ static struct attribute *ahci_shost_attrs[] = {
>  	&dev_attr_ahci_host_cap2.attr,
>  	&dev_attr_ahci_host_version.attr,
>  	&dev_attr_ahci_port_cmd.attr,
> +	&dev_attr_ahci_alpm_active.attr,
> +	&dev_attr_ahci_alpm_partial.attr,
> +	&dev_attr_ahci_alpm_slumber.attr,
> +	&dev_attr_ahci_alpm_devslp.attr,
> +	&dev_attr_ahci_alpm_accounting.attr,
>  	&dev_attr_em_buffer.attr,
>  	&dev_attr_em_message_supported.attr,
>  	NULL
> @@ -257,6 +282,183 @@ static void ahci_rpm_put_port(struct ata_port *ap)
>  	pm_runtime_put(ap->dev);
>  }
>  
> +static int get_current_alpm_state(struct ata_port *ap)

Naming not consistent. I would prefer you keep ahci_lpm_ prefix. But that
depends if we move this to libata-sata.c.

> +{
> +	u32 status = 0;

	u8 ipm;

> +
> +	ahci_scr_read(&ap->link, SCR_STATUS, &status);

Check for errors ?

> +
> +	/* link status is in bits 11-8 */
> +	status = status >> 8;
> +	status = status & 0xf;

Please use the field name: it is "Interface Power Management (IPM)". So:

	ipm = (status >> 8) & 0x0f;

> +
> +	if (status == 8)
> +		return AHCI_PORT_DEVSLP;
> +	if (status == 6)
> +		return AHCI_PORT_SLUMBER;
> +	if (status == 2)
> +		return AHCI_PORT_PARTIAL;
> +	if (status == 1)
> +		return AHCI_PORT_ACTIVE;
> +	return AHCI_PORT_NOLINK;

This clearly needs to be a switch/case. And to match the specifications (AHCI
1.3.1, section 3.3.10), please use hex values. E.g.:

	switch (ipm) {
	case 0x01:
		/* Interface in active state */
		return AHCI_PORT_ACTIVE;
	case 0x02:
		/* Interface in Partial power management state */
		return AHCI_PORT_PARTIAL;
	case 0x06:
		/* Interface in Slumber power management state */
		return AHCI_PORT_SLUMBER;
	case 0x08:
		/* Interface in DevSleep power management state */
		return AHCI_PORT_DEVSLP;
	case 0x00:
	default:
		/* Device not present or communication not established */
		return AHCI_PORT_NOLINK;
	}


> +}
> +
> +static void account_alpm_stats(struct ata_port *ap)

Missing ahci_lpm_ prefix...
May be call this ahci_alpm_update_stats() ? Or sata_lpm_xxx if we move the code
to libata-sata.c.

> +{
> +	struct ahci_port_priv *pp;
> +
> +	int new_state;
> +	u64 new_jiffies, jiffies_delta;
> +
> +	if (ap == NULL)
> +		return;
> +	pp = ap->private_data;
> +
> +	if (!pp) return;
> +
> +	new_state = get_current_alpm_state(ap);
> +	new_jiffies = jiffies;
> +
> +	jiffies_delta = new_jiffies - pp->previous_jiffies;
> +
> +	switch (pp->previous_state) {
> +	case AHCI_PORT_NOLINK:
> +		pp->active_jiffies = 0;
> +		pp->partial_jiffies = 0;
> +		pp->slumber_jiffies = 0;
> +		break;
> +	case AHCI_PORT_ACTIVE:
> +		pp->active_jiffies += jiffies_delta;
> +		break;
> +	case AHCI_PORT_PARTIAL:
> +		pp->partial_jiffies += jiffies_delta;
> +		break;
> +	case AHCI_PORT_SLUMBER:
> +		pp->slumber_jiffies += jiffies_delta;
> +		break;
> +	case AHCI_PORT_DEVSLP:
> +		pp->devslp_jiffies += jiffies_delta;
> +		break;
> +	default:
> +		break;
> +	}
> +	pp->previous_state = new_state;
> +	pp->previous_jiffies = new_jiffies;
> +}
> +
> +static ssize_t ahci_alpm_show_active(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct ata_port *ap = ata_shost_to_port(shost);
> +	struct ahci_port_priv *pp;
> +
> +	if (!ap || ata_port_is_dummy(ap))
> +		return -EINVAL;

Why not showing "0" ?

> +
> +	pp = ap->private_data;
> +	account_alpm_stats(ap);
> +
> +	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->active_jiffies));
> +}
> +
> +static ssize_t ahci_alpm_show_partial(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct ata_port *ap = ata_shost_to_port(shost);
> +	struct ahci_port_priv *pp;
> +
> +	if (!ap || ata_port_is_dummy(ap))
> +		return -EINVAL;

Same. And same for the other states.

> +
> +	pp = ap->private_data;
> +	account_alpm_stats(ap);
> +
> +	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->partial_jiffies));
> +}
> +

[...]

> +static ssize_t ahci_alpm_set_accounting(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	unsigned long flags;
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct ata_port *ap = ata_shost_to_port(shost);
> +	struct ahci_port_priv *pp;
> +	void __iomem *port_mmio;
> +
> +	if (!ap || ata_port_is_dummy(ap))
> +		return 1;

Return a proper error code please. Otherwise, it looks like you wrote 1 character.

> +
> +	pp = ap->private_data;
> +	port_mmio = ahci_port_base(ap);
> +
> +	if (!pp)
> +		return 1;

Same here. But I fail to see how this can happen.

> +	if (buf[0] == '0')
> +		pp->accounting_active = 0;
> +	if (buf[0] == '1')
> +		pp->accounting_active = 1;

Make accounting_active a bool and use kstrtobool().

> +
> +	/* we need to enable the PHYRDY interrupt when we want accounting */
> +	if (pp->accounting_active) {
> +		spin_lock_irqsave(ap->lock, flags);
> +		pp->intr_mask |= PORT_IRQ_PHYRDY;
> +		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
> +		spin_unlock_irqrestore(ap->lock, flags);
> +	}

Hmmm... This would allow enabling that interrupt at random, even when EH is
running. Not sure that is wise.... Do we need to define an EH action to set this ?

Also, if accounting_active was set to 0 (false), PORT_IRQ_PHYRDY should be
masked again, no ?

> +
> +	return count;
> +}
> +
>  static ssize_t ahci_show_host_caps(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -821,9 +1023,14 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  		 * Disable interrupts on Phy Ready. This keeps us from
>  		 * getting woken up due to spurious phy ready
>  		 * interrupts.
> +		 *
> +		 * However, when accounting_active is set, we do want
> +		 * the interrupts for accounting purposes.
>  		 */
> -		pp->intr_mask &= ~PORT_IRQ_PHYRDY;
> -		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
> +		if (!pp->accounting_active) {
> +			pp->intr_mask &= ~PORT_IRQ_PHYRDY;
> +			writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
> +		}

Is this interrupt always already enabled by default ?

>  
>  		sata_link_scr_lpm(link, policy, false);
>  	}
> @@ -1903,6 +2110,7 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
>  
>  	if (sata_lpm_ignore_phy_events(&ap->link)) {
>  		status &= ~PORT_IRQ_PHYRDY;
> +		account_alpm_stats(ap);
>  		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
>  	}
>  


-- 
Damien Le Moal
Western Digital Research
