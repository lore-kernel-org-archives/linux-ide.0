From: "Andrew" <andrew@nelless.net>
Subject: Re: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 12:47:42 +0100 (BST)
Message-ID: <35163.86.7.220.119.1193312862.squirrel@wmbeta.mxes.net>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>
    <47207466.6030507@garzik.org> <200710251343.50743.bzolnier@gmail.com>
Reply-To: "Andrew" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout-04.mxes.net ([216.86.168.179]:4743 "EHLO
	mxout-04.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467AbXJYLrn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 07:47:43 -0400
In-Reply-To: <200710251343.50743.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, October 25, 2007 12:43, Bartlomiej Zolnierkiewicz wrote:
>
>
> From the quick look:
>
>
> static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent) ...
> ppi[0] = &nv_port_info[type]; ...
> if (type == ADMA) { rc = nv_adma_host_init(host); if (rc) return rc; } else if (type ==
SWNCQ &&
> swncq_enabled) {
>
> --> this is the only place when swncq_enabled is read
>
>
> dev_printk(KERN_NOTICE, &pdev->dev, "Using SWNCQ mode\n"); nv_swncq_host_init(host);
>
> --> nw_swncq_host_init() controls only _hardware_ side of SWNCQ enable
> }
>
>
> pci_set_master(pdev); return ata_host_activate(host, pdev->irq, ppi[0]->irq_handler,
> IRQF_SHARED, ppi[0]->sht);
>
>
> --> since ppi[0] _always_ points nv_port_info[SWNCQ], it could happen
> that if SWNCQ has already been enabled by BIOS/firmware swncq_enabled setting will be ignored
> ...
>
>
> If this is the case the obvious fix will be to s/SWNCQ/GENERIC/ in
> nv_pci_tbl[] and assign ppi[0] to nv_port_info[SWNCQ] in nv_init_one() only if (type == GENERIC
> && swncq_enabled).
>
>
> Thanks,
> Bart
>
>

Hi,

I think my netconsole log will confirm your analysis.

It's available here:
http://andotnet.nfshost.com/linux/2.6.24-rc1-swncq.txt

Notice that "Using SWNCQ mode" is not printed.

Andrew.

