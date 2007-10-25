From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 13:43:50 +0200
Message-ID: <200710251343.50743.bzolnier@gmail.com>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net> <47207466.6030507@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:9377 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbXJYLiK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 07:38:10 -0400
Received: by fk-out-0910.google.com with SMTP id z23so451682fkz
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 04:38:09 -0700 (PDT)
In-Reply-To: <47207466.6030507@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew <andrew@nelless.net>, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>


Hi,

On Thursday 25 October 2007, Jeff Garzik wrote:
> Andrew wrote:
> > Hi,
> > 
> > I've noticed a thread reporting that SWNCQ can't be disabled
> > on the sata_nv.
> > 
> > Gerhard Dirschl
> > *	BUG: sata_nv swncq cannot be disabled
> > 
> > and another with a patch switching MCP61 to GENERIC instead
> > of SWNCQ
> > 
> > Kuan Luo
> > *	[PATCH] ata: sata_nv MCP61 using GENERIC instead of SWNCQ
> > 
> > 
> > I would like to to report that the MCP51 on my Asus A8NVM CSM
> > mainboard is dead due to timeouts with SWNCQ. Reverting sata_nv.c
> > to the version prior to git commit
> > f140f0f12fc8dc7264d2f97cbe663564e7d24f6d works around the problem.
> > 
> > My drives are all Seagate drives, ST3320620AS, ST3500630AS,
> > ST3300831AS.
> 
> 
> Really?  That's a showstopper bug, as swncq is supposed to be disabled 
> by default. 

>From the quick look:

static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
...
        ppi[0] = &nv_port_info[type];
...
        if (type == ADMA) {
                rc = nv_adma_host_init(host);
                if (rc)
                        return rc;
        } else if (type == SWNCQ && swncq_enabled) {

--> this is the only place when swncq_enabled is read

                dev_printk(KERN_NOTICE, &pdev->dev, "Using SWNCQ mode\n");
                nv_swncq_host_init(host);

--> nw_swncq_host_init() controls only _hardware_ side of SWNCQ enable
        }

        pci_set_master(pdev);
        return ata_host_activate(host, pdev->irq, ppi[0]->irq_handler,
                                 IRQF_SHARED, ppi[0]->sht);

--> since ppi[0] _always_ points nv_port_info[SWNCQ], it could happen
    that if SWNCQ has already been enabled by BIOS/firmware swncq_enabled
    setting will be ignored
...

If this is the case the obvious fix will be to s/SWNCQ/GENERIC/ in
nv_pci_tbl[] and assign ppi[0] to nv_port_info[SWNCQ] in nv_init_one()
only if (type == GENERIC && swncq_enabled).

Thanks,
Bart
