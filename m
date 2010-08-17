From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 17 Aug 2010 18:19:25 +0200
Message-ID: <4C6AB68D.8000102@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53430 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757844Ab0HQQXA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2010 12:23:00 -0400
In-Reply-To: <20100810155559.7620.79711.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On 08/10/2010 05:56 PM, Alan Cox wrote:
> Intel IDE-R devices are part of the Intel AMT management setup. They don't
> have any special configuration registers or settings so the ata_generic
> driver will support them fully.
> 
> Rather than add a huge table of IDs for each chipset and keep sending in
> new ones this patch autodetects them.
> 
> (And yes Jeff I'll resurrect the delay patches in a couple of weeks)
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
...
> +static int is_intel_ider(struct pci_dev *dev)
> +{
> +	/* For Intel IDE the value at 0xF8 is only zero on IDE-R
> +	   interfaces */
> +	u32 r;
> +	u16 t;
> +
> +	pci_read_config_dword(dev, 0xF8, &r);
> +	/* Not IDE-R: punt so that ata_(old)piix gets it */
> +	if (r != 0)
> +		return 0;
> +	/* 0xF8 is also be zero on some early Intel IDE devices
> +	   but they will have a sane timing register */
> +	pci_read_config_word(dev, 0x40, &t);
> +	if (t != 0)
> +		return 0;
> +	/* Finally check if the timing register is writable so that
> +	   we eliminate any early devices hot-docked in a docking
> +	   station */
> +	pci_write_config_word(dev, 0x40, 1);
> +	pci_read_config_word(dev, 0x40, &t);
> +	if (t) {
> +		pci_write_config_word(dev, 0x40, 0);
> +		return 0;
> +	}
> +	return 1;
> +}

This looks scary to me.  Is this something documented somewhere?  It's
not like we can avoid adding PCI device IDs completely anyway, so I
would suggest just doing it good old fashioned way.

Thanks.

-- 
tejun
