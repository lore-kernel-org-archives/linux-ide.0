From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Sat, 24 Sep 2011 10:58:59 +0900
Message-ID: <20110924015859.GZ29319@htj.dyndns.org>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:49689 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab1IXB7F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Sep 2011 21:59:05 -0400
Received: by yib18 with SMTP id 18so3039501yib.19
        for <linux-ide@vger.kernel.org>; Fri, 23 Sep 2011 18:59:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ming.lei@canonical.com
Cc: alan@linux.intel.com, linux-ide@vger.kernel.org, seth.heasley@intel.com, Jeff Garzik <jgarzik@pobox.com>

Hello,

(cc'ing Jeff)

On Thu, Sep 22, 2011 at 09:55:12AM +0800, ming.lei@canonical.com wrote:
> From: Ming Lei <ming.lei@canonical.com>
> 
> This quirk patch fixes one kind of bug inside Intel Sandybridge CPT
> chipset, see reports from
> 
> 	https://bugzilla.kernel.org/show_bug.cgi?id=40592.
> 
> Many guys also have reported the problem before:
> 
> 	https://bugs.launchpad.net/bugs/737388
> 	https://bugs.launchpad.net/bugs/794642
> 	......
> 
> With help from Tejun, the problem is found to be caused by 32bit PIO
> mode, so introduce the quirk patch to disable 32bit PIO on SATA piix
> for Sandybridge CPT chipset.

Have we successfully localized the problem to SNB?  If so, great.

>  static struct ata_port_operations piix_vmw_ops = {
> @@ -1585,6 +1586,15 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
>  				"on poweroff and hibernation\n");
>  	}
>  
> +	/*
> +	 * Sandybridge chipset H61/P67/H67 have broken 32 mode up to now
> +	 * see https://bugzilla.kernel.org/show_bug.cgi?id=40592
> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device == 0x1c00)
> +		piix_sata_ops.inherits = &ata_bmdma_port_ops;
> +	else
> +		piix_sata_ops.inherits = &ata_bmdma32_port_ops;
> +

No, this wouldn't work.  Ops inheritance isn't dynamic.

Please define a separate ata_port_operations for controller which
require 16bit PIO - piix_pata16_ops, create a new controller id (say,
ich_snb_pata), add an accompanying port_info entry and device_id
entry.

Thank you.

-- 
tejun
