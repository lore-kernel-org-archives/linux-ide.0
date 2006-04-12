From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC] ahci: add support for VIA VT8251
Date: Wed, 12 Apr 2006 09:42:32 +0900
Message-ID: <20060412004232.GA31115@htj.dyndns.org>
References: <200604111915.45564.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:57124 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751222AbWDLAmc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 20:42:32 -0400
Received: by pproxy.gmail.com with SMTP id i49so1546271pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 17:42:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200604111915.45564.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: linux-ide@vger.kernel.org

Hello, Bastiaan.

On Tue, Apr 11, 2006 at 07:15:45PM +0200, Bastiaan Jacques wrote:
> +static void ahci_clo(struct ata_port *ap)
> +{
> +	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
> +	u32 tmp;
> +
> +	tmp = readl(port_mmio + PORT_CMD);
> +	tmp |= PORT_CMD_CLO;
> +	writel(tmp, port_mmio + PORT_CMD);
> +	readl(port_mmio + PORT_CMD); /* flush */
> +}

Can you please make ahci_clo() check for HOST_CAP_CLO and return
-EOPNOTSUPP (or whatever) if it's not supported?

Thanks.

-- 
tejun
