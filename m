From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/6] The definition of ahci_port_standby() and ahci_port_spinup()
Date: Sat, 3 Jun 2006 22:23:54 +0900
Message-ID: <20060603132354.GC25958@htj.dyndns.org>
References: <1149234328.13451.56.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:53171 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750779AbWFCNYH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jun 2006 09:24:07 -0400
Received: by wr-out-0506.google.com with SMTP id 69so943808wri
        for <linux-ide@vger.kernel.org>; Sat, 03 Jun 2006 06:24:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1149234328.13451.56.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, hare@suse.de, axboe@suse.de, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Fri, Jun 02, 2006 at 03:45:28PM +0800, zhao, forrest wrote:
> +static int ahci_port_standby(void __iomem *port_mmio, u32 cap)
> +{
> +	u32 tmp, scontrol, sstatus;
> +
> +	tmp = readl(port_mmio + PORT_CMD);
> +	/*
> +	 * AHCI Rev1.1 Section 5.3.2.3:
> +	 * Software is only allowed to program the PxCMD.FRE,
> +	 * PxCMD.POD, PxSCTL.DET, and PxCMD.SUD register bits
> +	 * when PxCMD.ST is set to '0'
> +	 */
> +	if (tmp & PORT_CMD_START)
> +		return -EBUSY;

Same here.

> +	if (cap & HOST_CAP_SSC) {
> +		/*
> +		 * Enable transitions to slumber mode
> +		 */
> +		scontrol = readl(port_mmio + PORT_SCR_CTL);
> +		if ((scontrol & 0x0f00) > 0x100) {
> +			scontrol &= ~0xf00;
> +			writel(scontrol, port_mmio + PORT_SCR_CTL);
> +		}
> +		/*
> +		 * Put device into slumber mode
> +		 */
> +		tmp |= PORT_CMD_ICC_SLUMBER;
> +		writel(tmp, port_mmio + PORT_CMD);
> +		tmp = readl(port_mmio + PORT_CMD);
> +
> +		/*
> +		 * Actually, we should wait for the device to
> +		 * enter slumber mode by checking
> +		 * sstatus & 0xf00 == 6
> +		 */
> +		sstatus = readl(port_mmio + PORT_SCR_STAT);
> +	}

AHCI rev1.1 says at the beginning of 8.3.3 HBA D3 state,

"After the interface and device have been put into a low power state,
the HBA may be put into a low power state."

But, it also says the following at the end of 8.2

"Note: The Phy is not required to be in a Slumber state when the
device is in a D1, D2 or D3 state, nor is it required to be in a
Slumber state when the HBA is in a D3 state.  While this may be the
likely condition of the interface when the devices connected to the
interface are in a low power state, it is not requirement, and the
interface shall break out of these states on a power management
event."

My gut feeling is that above SLUMBER/SCR listen code is not strictly
necessary, but I don't know whether we should keep or drop it.

> + 
> +	/*
> +	 * Put device into listen mode
> +	 */
> +	scontrol = readl(port_mmio + PORT_SCR_CTL);
> +	scontrol &= ~0xf;
> +	writel(scontrol, port_mmio + PORT_SCR_CTL);

Above code is to put the HBA into listening mode, right?  If so,
please put above code into the following if block and update comment.

> + 
> +	tmp = readl(port_mmio + PORT_CMD);
> +	if (cap & HOST_CAP_SSS) {

Why not use hpriv->cap?

> +		/*
> +		 * Spin down the device for staggered spin-up support
> +		 */
> +		tmp &= ~PORT_CMD_SPIN_UP;
> +		writel(tmp, port_mmio + PORT_CMD);
> +		readl(port_mmio + PORT_CMD); /* flush */

Clearing PORT_CMD_SPIN_UP does not spin down the device.  Please
correct the comment.

> +	}
> + 
> +	return 0;
> +}
> +
> +static int ahci_port_spinup(void __iomem *port_mmio, u32 cap)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(port_mmio + PORT_CMD);
> +	/*
> +	 * AHCI Rev1.1 Section 5.3.2.3:
> +	 * Software is only allowed to program the PxCMD.FRE,
> +	 * PxCMD.POD, PxSCTL.DET, and PxCMD.SUD register bits
> +	 * when PxCMD.ST is set to '0'
> +	 */
> +	if (tmp & PORT_CMD_START)
> +		return -EBUSY;

Ditto...

> +	/*
> +	 * Power on device if supported
> +	 */
> +	if (tmp & PORT_CMD_CPD) {
> +		tmp |= PORT_CMD_POWER_ON;
> +		writel(tmp, port_mmio + PORT_CMD);
> +		tmp = readl(port_mmio + PORT_CMD);
> +	}

IMGO, it would be better to add cold presence detection support after
we have such hardware and test the code on it.

> +	/*
> +	 * Spin up device
> +	 */
> +	if (cap & HOST_CAP_SSS) {
> +		tmp |= PORT_CMD_SPIN_UP;
> +		writel(tmp, port_mmio + PORT_CMD);
> +		tmp = readl(port_mmio + PORT_CMD);
> +	}
> +
> +	if ((tmp & PORT_CMD_ICC_MASK) != PORT_CMD_ICC_ACTIVE) {
> +		tmp |= PORT_CMD_ICC_ACTIVE;
> +		writel(tmp, port_mmio + PORT_CMD);
> +		tmp = readl(port_mmio + PORT_CMD);
> +	}

Again, I think it's better to do things like above unconditionally.
ie. Just tell the controller to transit to active.

-- 
tejun
