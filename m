From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] libata: Add firmware_default LPM policy
Date: Wed, 22 Apr 2015 10:48:12 -0400
Message-ID: <20150422144812.GA10592@htj.duckdns.org>
References: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
 <1429370796-5881-3-git-send-email-mjg59@coreos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429370796-5881-3-git-send-email-mjg59@coreos.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@coreos.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kristen@linux.intel.com
List-Id: linux-ide@vger.kernel.org

Hello, Matthew.

On Sat, Apr 18, 2015 at 08:26:35AM -0700, Matthew Garrett wrote:
> +firmware_defaults	Inherit configuration from the state programmed by
> +			the firmware during system init.

Do we lose anything by naming the policy just "firmware"?

> @@ -701,9 +702,9 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  
>  	if (hpriv->cap & HOST_CAP_ALPM) {
>  		u32 cmd = readl(port_mmio + PORT_CMD);
> +		cmd &= ~(PORT_CMD_ASP | PORT_CMD_ALPE);

Prolly worth nothing in the changelog?

>  
>  		if (policy == ATA_LPM_MAX_POWER || !(hints & ATA_LPM_HIPM)) {
> -			cmd &= ~(PORT_CMD_ASP | PORT_CMD_ALPE);
>  			cmd |= PORT_CMD_ICC_ACTIVE;
>  
>  			writel(cmd, port_mmio + PORT_CMD);
...
> @@ -2024,7 +2024,7 @@ retry:
>  		}
>  	}
>  
> -	if (id[79] & SATA_DIPM)
> +	if (id[79] & (1 << SATA_DIPM))
>  		dev->init_dipm = true;

Does this chunk belong here?

Thanks.

-- 
tejun
