From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: separate out ahci_fill_cmd_slot()
Date: Fri, 10 Feb 2006 07:05:44 -0500
Message-ID: <43EC8198.4090302@pobox.com>
References: <20060123081626.GA664@htj.dyndns.org> <43D99CBA.4090801@pobox.com> <20060201170452.GA22989@htj.dyndns.org> <20060210082547.GA17734@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:20416 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751114AbWBJMFs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 07:05:48 -0500
In-Reply-To: <20060210082547.GA17734@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out ahci_fill_cmd_slot() from ahci_qc_prep().
> ahci_fill_cmd_slot() can later be used to issue non-standard commands.
> (e.g. softreset)
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied, with comment:

> +static void ahci_fill_cmd_slot(struct ata_port *ap, u32 opts)
> +{
> +	struct ahci_port_priv *pp = ap->private_data;
> +	pp->cmd_slot[0].opts = cpu_to_le32(opts);
> +	pp->cmd_slot[0].status = 0;
> +	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
> +	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
> +}

Probably should just pass 'pp' directly to ahci_fill_cmd_slot() as an 
argument, rather than 'ap'.

	Jeff



