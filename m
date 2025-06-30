Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A32737E7;
	Mon, 30 Jun 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293074; cv=none; b=Wx3q9/kcF3y43o7LdFJJmQsVuChtZgTuxZIIxmw/m/cedGJGLWY1OAj7MwzgXn2t3WrGO9UHQzaP4kEVcr4Vu4exZ81BhU+D92+A7RUhVCuNfwT6M1wpE+PiUujMQ5TMwCB3Or4MNGNaEP9IHQXohU/YcfBU/uUNV+1FMBrcdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293074; c=relaxed/simple;
	bh=Hoq5sGTixBJVzJVvxNML6eYs+K0BJfP4vhXsArkwxss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuLf0+04es9EYE7RvwgRCA2IvR8ILa3C01EMdl3hhSp29NR/t9zabG3PN8oiQYCbnQG4N40YL1GQmt0YNHcTrT7lNtrKm0fnkqqLrrhMVRvvtbxYSsa1qkF76xYAygmCbCHe4Ny45u5kVavmy1xpK+HhkMitQT4g/3cFLBFJ+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4PZgli5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4PZgli5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62314C4CEE3;
	Mon, 30 Jun 2025 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751293073;
	bh=Hoq5sGTixBJVzJVvxNML6eYs+K0BJfP4vhXsArkwxss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4PZgli5HjOBLVVoq3TSy9KSoo5w/mXPsq+PE9Mm6oJxeXDYiV0W3jn6QjkoWD3Un
	 /lF3LlH22+VLcyoDFm2PApENvsIRr5q6xuqX965sR3GRF4Uydcz4NLD22Aftn8vK+Q
	 sxLxadvB2/WR8r9Axhc4g0jGpPs+sjijbxJj96evTM9K76TyzB0Mel6P8YQNraD0hX
	 01S9brvkkmPY/odQ9p9o4kevf72LYM0DdaDFq+4xhXdGMhVY9SWqzsAeYWlWN6h1XA
	 J65vW4Q5AMTGWoRdtBllEfPDPD47tVjZBTgj+47jbIvr/BFVoBA6BIE1O8fGkC6cTh
	 UCtl/CCidoyYQ==
Date: Mon, 30 Jun 2025 16:17:49 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Add ALPM power state accounting to the AHCI
 driver
Message-ID: <aGKcjQL1puLzrV_D@ryzen>
References: <20250629192456.3761-2-pmenzel@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250629192456.3761-2-pmenzel@molgen.mpg.de>

Hello Paul,

On Sun, Jun 29, 2025 at 09:24:55PM +0200, Paul Menzel wrote:
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

No DevSleep?


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
>  
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
> +{
> +	u32 status = 0;
> +
> +	ahci_scr_read(&ap->link, SCR_STATUS, &status);
> +
> +	/* link status is in bits 11-8 */
> +	status = status >> 8;
> +	status = status & 0xf;
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
> +}
> +
> +static void account_alpm_stats(struct ata_port *ap)
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

pp->devslp_jiffies = 0; ?


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

I'm not the biggest fan of this, because it seems like we will just account
the time to the previous state, which might or might not be correct.

For example, a DevSleep is entered when the DEVSLP timer has expired
(PxDEVSLP.DITO).

When this happens, the device can be in Active, Partial, or Slumber.

From AHCI 1.3.1 "8.5.1 Aggressive Device Sleep Management":


  There is no requirement that the interface be in the Partial or Slumber state
  prior to assertion of DEVSLP signal unless CAP2.DESO is set to ‘1’; The DEVSLP
  signal may be asserted by the HBA at anytime provided that the link is idle
  (or in low power state) and no commands are outstanding. If CAP2.DESO is set
  to ‘1’, The DEVSLP signal may only be asserted by the HBA if the interface is
  in Slumber (PxSSTS.IPM = ‘6h’).


Also see SATA 3.5a, "8.5.1 DEVSLP overview".

PhyRdy Changed will be asserted when the device enters Partial/Slumber,
but I don't see anything that will re-raise PhyRdy Changed one the DEVSLP
timer has expired.

This means that the code can incorrectly account time as Partial/Slumber
when the device was really in DevSleep.


Perhaps rather than accounting time for each state, perhaps we could simply
have a "lpm_state" attibute, and user space could sample this how often it
wants. That way, we would also avoid the extra overhead of the spurious
wakeups (because you could keep PhyRdy Changed IRQ disabled).




Actually, looking at SATA 3.5a, "14.2.2 SStatus register":
  The IPM field value is guaranteed to indicate that the interface has entered a
  low power state, however, it may not represent the interface low power state
  of the host or device currently. See 13.17 for further information regarding
  Automatic Partial to Slumber transitions.

While Linux doesn't enable Automatic Partial to Slumber transitions, it could
theoretically be enabled for systems using LPM policy "Keep FW settings" +
"skip_host_reset" module param.

Thus, would perhaps debugfs be a better place for a "lpm_state" attribute?


Kind regards,
Niklas
