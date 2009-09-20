From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: display all AHCI 1.3 HBA capability flags
Date: Sun, 20 Sep 2009 16:39:52 -0400
Message-ID: <4AB69318.5050904@garzik.org>
References: <4AB6718C.2050107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59732 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbZITUjx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Sep 2009 16:39:53 -0400
In-Reply-To: <4AB6718C.2050107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On 09/20/2009 02:16 PM, Robert Hancock wrote:
> @@ -2534,13 +2535,14 @@ static void ahci_print_info(struct ata_host *host)
>   	struct ahci_host_priv *hpriv = host->private_data;
>   	struct pci_dev *pdev = to_pci_dev(host->dev);
>   	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
> -	u32 vers, cap, impl, speed;
> +	u32 vers, cap, cap2, impl, speed;
>   	const char *speed_s;
>   	u16 cc;
>   	const char *scc_s;
>
>   	vers = readl(mmio + HOST_VERSION);
>   	cap = hpriv->cap;
> +	cap2 = readl(mmio + HOST_CAP2);


1) We cannot unconditionally read from this register location on all 
chips, as it's undefined for many chips.  Add a chip version check or 
somesuch.

2) Treat cap2 in the same manner as cap, to prepare for potential future 
usages.

	Jeff


