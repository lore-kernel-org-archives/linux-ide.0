From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 2/6] The definition of ahci_start_fis_rx() and  ahci_stop_fis_rx()
Date: Fri, 2 Jun 2006 11:15:44 +0200
Message-ID: <20060602091544.GA4400@suse.de>
References: <1149234295.13451.54.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:42075 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751346AbWFBJNd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 05:13:33 -0400
Content-Disposition: inline
In-Reply-To: <1149234295.13451.54.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, hare@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Fri, Jun 02 2006, zhao, forrest wrote:
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

The spec states that you should wait up to 500msec for this condition to
happen, not wait 500msec before looking at it! So please rework this
bit, a half second potentially wasted busy loop is quite nasty.

Other than that, this part looks good too. If you fix it up, I can add
my signed-off to this bit as well.

-- 
Jens Axboe

