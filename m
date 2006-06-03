From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/6] The definition of ahci_start_engine() and ahci_stop_engine()
Date: Sat, 3 Jun 2006 21:46:48 +0900
Message-ID: <20060603124648.GA25958@htj.dyndns.org>
References: <1149234599.13451.63.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:22685 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750827AbWFCMq6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jun 2006 08:46:58 -0400
Received: by wr-out-0506.google.com with SMTP id i22so668961wra
        for <linux-ide@vger.kernel.org>; Sat, 03 Jun 2006 05:46:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1149234599.13451.63.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, hare@suse.de, axboe@suse.de, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Fri, Jun 02, 2006 at 03:49:59PM +0800, zhao, forrest wrote:
> -static int ahci_stop_engine(struct ata_port *ap)
> +static int ahci_stop_engine(void __iomem *port_mmio)
>  {
> -	void __iomem *mmio = ap->host_set->mmio_base;
> -	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
>  	int work;
>  	u32 tmp;
>  
>  	tmp = readl(port_mmio + PORT_CMD);
> +
> +	/* Check if the HBA is idle */
> +	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
> +		return 0;

I'm not really sure whether this short circuiting is necessary.  I
think blindly turning the bit off is simpler and more robust.

> +
> +	/* Setting HBA to idle */
>  	tmp &= ~PORT_CMD_START;
>  	writel(tmp, port_mmio + PORT_CMD);
>  
> @@ -507,16 +513,49 @@ static int ahci_stop_engine(struct ata_p
>  	return -EIO;
>  }
>  
> -static void ahci_start_engine(struct ata_port *ap)
> +static int ahci_start_engine(void __iomem *port_mmio)
>  {
> -	void __iomem *mmio = ap->host_set->mmio_base;
> -	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
>  	u32 tmp;
> +	int work = 1000;
>  
> +	/*
> +	 * Get current status
> +	 */
>  	tmp = readl(port_mmio + PORT_CMD);
> +
> +	/*
> +	 * AHCI rev 1.1 section 10.3.1:
> +	 * Software shall not set PxCMD.ST to '1' until it verifies
> +	 * that PxCMD.CR is '0' and has set PxCMD.FRE to '1'
> +	 */
> +	if ((tmp & PORT_CMD_FIS_RX) == 0)
> +		return -EPERM;

Here, again, I don't think this type of checking is necessary.  If the
controller is behaving correctly, above condition should be guaranteed
by driver control flow.  If the controller is acting weird, the driver
probably had chance to detect above condition earlier (when turning
off the engine) and determined to ignore it.

> +
> +	/*
> +	 * wait for engine to become idle.
> +	 */
> +	while (work-- > 0) {
> +		tmp = readl(port_mmio + PORT_CMD);
> +		if ((tmp & PORT_CMD_LIST_ON) == 0)
> +			break;
> +		udelay(10);
> +	}
> +
> +	if (!work) {
> +		/*
> +		 * We need to do a port reset / HBA reset here
> +		 */
> +		return -EBUSY;
> +	}

Please convert above to ata_wait_register().  It would be nice if you
can convert ahci_stop_engine(), too.

-- 
tejun
