From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 8/20] libata: reimplement ata_pci_init_one() using new
 init helpers
Date: Tue, 19 Sep 2006 01:32:21 -0400
Message-ID: <450F80E5.7080009@pobox.com>
References: <11559779723326-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19615 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752072AbWISFch (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:32:37 -0400
In-Reply-To: <11559779723326-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:

Nevermind previous question about legacy resources.

It does seem like the change is split across these two patches though... 
  so the previous patch is incorrect without this one.


> +int ata_pci_init_one(struct pci_dev *pdev, struct ata_port_info **pinfo_ar,
> +		     unsigned int n_ports)
> +
> +{
> +	unsigned int mask = ATA_PORT_PRIMARY | ATA_PORT_SECONDARY;
> +	unsigned int legacy_mask = 0;
> +	struct ata_host *host;
> +	int rc;
> +
> +	DPRINTK("ENTER\n");
> +
> +	/* legacy mode? */
> +	if (!(pinfo_ar[0]->flags & ATA_FLAG_NO_LEGACY))
> +		legacy_mask = ata_pci_legacy_mask(pdev);
> +

NAK -- you can't do anything with the PCI device before calling 
pci_enable_device()

