From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: Turn off DMA engines when there's no device attached
Date: Mon, 29 Mar 2010 17:30:55 -0400
Message-ID: <4BB11C0F.2090308@pobox.com>
References: <1268253150-24050-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:33139 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab0C2Va5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Mar 2010 17:30:57 -0400
Received: by ywh2 with SMTP id 2so5279917ywh.33
        for <linux-ide@vger.kernel.org>; Mon, 29 Mar 2010 14:30:57 -0700 (PDT)
In-Reply-To: <1268253150-24050-1-git-send-email-mjg@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On 03/10/2010 03:32 PM, Matthew Garrett wrote:
> +static int ahci_is_device_present(struct ata_port *ap)
> +{
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u8 status = readl(port_mmio + PORT_TFDATA)&  0xff;
> +
> +	/* Make sure PxTFD.STS.BSY and PxTFD.STS.DRQ are 0 */
> +	if (status&  (ATA_BUSY | ATA_DRQ))
> +		return 0;
> +
> +	/* Make sure PxSSTS.DET is 3h */
> +	status = readl(port_mmio + PORT_SCR_STAT)&  0xf;
> +	if (status != 3)
> +		return 0;
> +	return 1;


Note that this last test, reading SATA Control Register (SCR) Status, 
does not account for in-transition status, ie. devices that were just 
plugged in.

	Jeff


