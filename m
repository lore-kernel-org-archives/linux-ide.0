From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] ahci: avoton port-disable reset-quirk
Date: Fri, 8 May 2015 11:44:23 -0400
Message-ID: <20150508154423.GD28439@htj.duckdns.org>
References: <20150507184529.25927.35320.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36401 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbbEHPo1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2015 11:44:27 -0400
Received: by qku63 with SMTP id 63so50528310qku.3
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2015 08:44:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150507184529.25927.35320.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

Hello, Dan.

On Thu, May 07, 2015 at 02:45:50PM -0400, Dan Williams wrote:
> The field reports success with this patch, but I wonder what problems I
> might induce by bouncing the port aggressively upon seeing SStatus == 1?
> Otherwise, if this looks good, please merge.

I don't think it's too likely that this breaks anything.  It's a bit
of brute force approach but if this is what makes things work
smoothly...  Just some nitpicks.

Please add detailed function comment here explaining why this function
exists and what it tries to achieve.

> +static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
> +			      unsigned long deadline)
> +{
> +	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
> +	struct ata_port *ap = link->ap;
> +	struct ahci_port_priv *pp = ap->private_data;
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
> +	unsigned long tmo = deadline - jiffies;
> +	struct ata_taskfile tf;
> +	bool online;
> +	int rc, i;
> +
> +	DPRINTK("ENTER\n");
> +
> +	ahci_stop_engine(ap);
> +
> +	for (i = 0; i < 2; i++) {
> +		u32 sstatus;
> +
> +		/* clear D2H reception area to properly wait for D2H FIS */
> +		ata_tf_init(link->device, &tf);
> +		tf.command = ATA_BUSY;
> +		ata_tf_to_fis(&tf, 0, 0, d2h_fis);
> +
> +		rc = sata_link_hardreset(link, timing, deadline, &online,
> +				ahci_check_ready);
> +
> +		/*
> +		 * If the the link is stuck at DET==1 after a reset try
> +		 * bouncing the port and retrying the reset.
> +		 */
> +		if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
> +				(sstatus & 0xf) == 1) {
> +			u16 val;
> +			int port = ap->port_no;
> +			struct ata_host *host = ap->host;
> +			struct pci_dev *pdev = to_pci_dev(host->dev);
> +
> +			ata_link_printk(link, KERN_INFO, "avn bounce port%d\n",
> +					port);
> +
> +			/* bounce port-enable in PCS */
> +			pci_read_config_word(pdev, 0x92, &val);
> +			val &= ~(1 << port);
> +			pci_write_config_word(pdev, 0x92, val);
> +			ata_msleep(ap, 1000);
> +			val |= 1 << port;
> +			pci_write_config_word(pdev, 0x92, val);
> +			deadline += tmo;
> +		} else
> +			break;

This looks weird.  Maybe just do if (counter_cond) break;?

Thanks.

-- 
tejun
