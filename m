From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ahci: improve and limit spurious interrupt messages, take#3
Date: Thu, 25 Jan 2007 21:04:52 -0500
Message-ID: <45B961C4.10404@pobox.com>
References: <20070115090117.GL10987@htj.dyndns.org> <20070116065239.GO10987@htj.dyndns.org> <45B806DA.1050107@pobox.com> <45B8626B.9090002@gmail.com> <20070125101628.GA8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41728 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030586AbXAZCE5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 21:04:57 -0500
In-Reply-To: <20070125101628.GA8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> +		const u32 *f = pp->rx_fis + RX_FIS_SDB;
> +
> +		ata_port_printk(ap, KERN_INFO, "Spurious SDB FIS during NCQ "
> +				"issue=0x%x SAct=0x%x FIS=%08x:%08x%s\n",
> +				readl(port_mmio + PORT_CMD_ISSUE),
> +				readl(port_mmio + PORT_SCR_ACT), f[0], f[1],


Direct access to f[] would appear to be an endian problem...

	Jeff


