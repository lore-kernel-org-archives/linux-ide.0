From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/6] The definition of ahci_start_fis_rx() and ahci_stop_fis_rx()
Date: Sat, 3 Jun 2006 21:51:20 +0900
Message-ID: <20060603125120.GB25958@htj.dyndns.org>
References: <1149234295.13451.54.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.203]:53110 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWFCMv1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jun 2006 08:51:27 -0400
Received: by wx-out-0102.google.com with SMTP id h28so488768wxd
        for <linux-ide@vger.kernel.org>; Sat, 03 Jun 2006 05:51:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1149234295.13451.54.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, hare@suse.de, axboe@suse.de, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Fri, Jun 02, 2006 at 03:44:55PM +0800, zhao, forrest wrote:
> +static int ahci_stop_fis_rx(void __iomem *port_mmio)
> +{
> +	u32 tmp;
> +	int work = 1000;
> +
> +	/*
> +	 * Get current status
> +	 */
> +	tmp = readl(port_mmio + PORT_CMD);
> +
> +	/* Check if FIS RX is already disabled */
> +	if ((tmp & PORT_CMD_FIS_RX) == 0)
> +		return 0;
> +
> +	/*
> +	 * AHCI Rev 1.1 section 10.3.2
> +	 * Software shall not clear PxCMD.FRE while
> +	 * PxCMD.ST or PxCMD.CR is set to '1'
> +	 */
> +	if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_START)) {
> +		return -EPERM;
> +	}

Same here.  I'm not sure whether the above two tests are necessary,
but that might be just me.  :)

> +	/*
> +	 * Disable FIS reception
> +	 *
> +	 * AHCI Rev 1.1 Section 10.1.2:
> +	 * If PxCMD.FRE is set to '1', software should clear it
> +	 * to '0' and wait at least 500 milliseconds for PxCMD.FR
> +	 * to return '0' when read. If PxCMD.FR does not clear
> +	 * '0' correctly, then software may attempt a port reset
> +	 * of a full HBA reset to recover.
> +	 */
> +	tmp &= ~(PORT_CMD_FIS_RX);
> +	writel(tmp, port_mmio + PORT_CMD);
> +
> +	mdelay(500);
> +	work = 1000;
> +	while (work-- > 0) {
> +		tmp = readl(port_mmio + PORT_CMD);
> +		if ((tmp & PORT_CMD_FIS_ON) == 0)
> +			return 0;
> +		udelay(10);
> +	}

Please convert to ata_wait_register().  Also, I share Jens' opinion.
The way I read the spec is that the timeout should be at least 500ms
not that we have to wait 500ms before polling for !FIS_ON.

-- 
tejun
