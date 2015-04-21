From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] libata: Stash initial power management configuration
Date: Tue, 21 Apr 2015 17:26:49 -0400
Message-ID: <20150421212649.GH9455@htj.duckdns.org>
References: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
 <1429370796-5881-2-git-send-email-mjg59@coreos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429370796-5881-2-git-send-email-mjg59@coreos.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@coreos.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kristen@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-ide@vger.kernel.org

Hello, Matthew.

On Sat, Apr 18, 2015 at 08:26:34AM -0700, Matthew Garrett wrote:
> @@ -313,6 +313,12 @@ struct ahci_port_priv {
>  	/* enclosure management info per PM slot */
>  	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
>  	char			*irq_desc;	/* desc in /proc/interrupts */

Can you please add a comment here referring to
ahci_setup_port_privdata()?

> +	bool			init_alpe;	/* alpe enabled by default */
> +	bool			init_asp;	/* asp enabled by default */
> +	bool			init_devslp;	/* devslp enabled by default */
> +	u32			init_dito;	/* initial dito configuration */
> +	u32			init_deto;	/* initial deto configuration */
> +	u32			init_mdat;	/* initial mdat configuration */
>  };
...
> +/*
> + * Allocate port privdata and read back initial power management configuration
> + */

And convert this to proper function comment which explains where it's
supposed to be called from and why it does what it does there?

> +int ahci_setup_port_privdata(struct ata_port *ap)
> +{
...
> @@ -5583,11 +5586,11 @@ void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
>  }
>  
>  /**
> - *	sata_link_init_spd - Initialize link->sata_spd_limit
> - *	@link: Link to configure sata_spd_limit for
> + *	sata_link_init_config - Initialize link->sata_spd_limit and init_lpm
> + *	@link: Link to configure sata_spd_limit and init_lpm for
>   *
> - *	Initialize @link->[hw_]sata_spd_limit to the currently
> - *	configured value.
> + *	Initialize @link->[hw_]sata_spd_limit and @link->init_lpm to the
> + *	currently configured value.

And I think it probably would be a better idea to make the libata core
dipm part a separate patch.

Other than that, looks good to me.

Thanks.

-- 
tejun
