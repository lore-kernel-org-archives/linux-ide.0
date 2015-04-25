From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Ignore spurious PHY events on LPM policy change
Date: Sat, 25 Apr 2015 11:37:51 -0400
Message-ID: <20150425153751.GA31335@htj.duckdns.org>
References: <20150424214214.GD27034@htj.duckdns.org>
 <1429954469-27892-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429954469-27892-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Apr 25, 2015 at 11:34:29AM +0200, Gabriele Mazzotta wrote:
> When the LPM policy is set to ATA_LPM_MAX_POWER, the device might
> generate a spurious PHY event that might cause errors on the link.
> Ignore this event if it occurred within 10s after the policy change.
> 
> The timeout was chosen observing that on a Dell XPS13 9333 these
> spurious events can occur up to roughly 6s after the policy change.

Just a couple things.

Can you please add the following tag?

Link: http://lkml.kernel.org/g/<MSG-ID of the first message in this thread>

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 61a9c07..59a2517 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1700,6 +1700,9 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
>  	struct ahci_port_priv *pp = ap->private_data;
>  	struct ahci_host_priv *hpriv = ap->host->private_data;
>  	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
> +	unsigned long lpm_timeout = ap->link.last_lpm_change +
> +				    msecs_to_jiffies(ATA_TMOUT_SPURIOUS_PHY);
> +	bool ignore_event = false;
>  	u32 qc_active = 0;
>  	int rc;
>  
> @@ -1707,8 +1710,16 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
>  	if (unlikely(resetting))
>  		status &= ~PORT_IRQ_BAD_PMP;
>  
> +	/* ignore the first PHY event after the LPM policy changed
> +	 * as it is might be spurious
> +	 */
> +	if ((ap->link.flags & ATA_LFLAG_CHANGED) &&
> +	    time_before(jiffies, lpm_timeout))
> +		ignore_event = true;

Maybe the following is better?

	ignore_event = (ap->link.flags & ATA_LFLAG_CHANGED) &&
		       time_before(jiffies, lpm_timeout);

> +
>  	/* if LPM is enabled, PHYRDY doesn't mean anything */
> -	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER) {
> +	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER || ignore_event) {
> +		ap->link.flags &= ~ATA_LFLAG_CHANGED;
>  		status &= ~PORT_IRQ_PHYRDY;
>  		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
>  	}

I thought more about it and it's weird to have ATA_LFLAG_CHANGED and
last_lpm_change timestamp in libata core side and then open-code the
actual logic in ahci.  How about implementing a generic helper, say,
bool sata_lpm_ignore_phy_events(link) in libata core and use it in
specific drivers?  It can test both the current lpm_policy and the
timeout (preferably a separate patch to introduce the function and
factor out lpm policy testing).

Thanks.

-- 
tejun
