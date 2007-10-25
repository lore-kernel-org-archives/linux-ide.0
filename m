From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 14:06:05 +0200
Message-ID: <200710251406.05804.bzolnier@gmail.com>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net> <200710251343.50743.bzolnier@gmail.com> <35163.86.7.220.119.1193312862.squirrel@wmbeta.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:43581 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036AbXJYMAC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 08:00:02 -0400
Received: by nf-out-0910.google.com with SMTP id g13so461926nfb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 05:00:01 -0700 (PDT)
In-Reply-To: <35163.86.7.220.119.1193312862.squirrel@wmbeta.mxes.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew <andrew@nelless.net>
Cc: linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Jeff Garzik <jeff@garzik.org>


[ adding Kuan and Jeff back to cc: ]

On Thursday 25 October 2007, Andrew wrote:
> On Thu, October 25, 2007 12:43, Bartlomiej Zolnierkiewicz wrote:
> >
> >
> > From the quick look:
> >
> >
> > static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent) ...
> > ppi[0] = &nv_port_info[type]; ...
> > if (type == ADMA) { rc = nv_adma_host_init(host); if (rc) return rc; } else if (type ==
> SWNCQ &&
> > swncq_enabled) {
> >
> > --> this is the only place when swncq_enabled is read
> >
> >
> > dev_printk(KERN_NOTICE, &pdev->dev, "Using SWNCQ mode\n"); nv_swncq_host_init(host);
> >
> > --> nw_swncq_host_init() controls only _hardware_ side of SWNCQ enable
> > }
> >
> >
> > pci_set_master(pdev); return ata_host_activate(host, pdev->irq, ppi[0]->irq_handler,
> > IRQF_SHARED, ppi[0]->sht);
> >
> >
> > --> since ppi[0] _always_ points nv_port_info[SWNCQ], it could happen
> > that if SWNCQ has already been enabled by BIOS/firmware swncq_enabled setting will be ignored

Update: BIOS/firmware doesn't matter -> SWNCQ methods will be used anyway

> > ...
> >
> >
> > If this is the case the obvious fix will be to s/SWNCQ/GENERIC/ in
> > nv_pci_tbl[] and assign ppi[0] to nv_port_info[SWNCQ] in nv_init_one() only if (type == GENERIC
> > && swncq_enabled).
> >
> >
> > Thanks,
> > Bart
> >
> >
> 
> Hi,
> 
> I think my netconsole log will confirm your analysis.
> 
> It's available here:
> http://andotnet.nfshost.com/linux/2.6.24-rc1-swncq.txt
> 
> Notice that "Using SWNCQ mode" is not printed.

Thanks, could you try this patch?

[PATCH] sata_nv: respect swncq_enabled setting

SWNCQ is always used despite swncq_enabled setting (which is disabled by
default).  Fix it by using GENERIC nv_port_info[] entry for SWNCQ controllers
if swncq_enabled is not enabled.

Thanks to Andrew for bisecting the problem to commit
f140f0f12fc8dc7264d2f97cbe663564e7d24f6d.

Cc: Kuan Luo <kluo@nvidia.com>
Cc: Andrew <andrew@nelless.net>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ata/sata_nv.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

Index: b/drivers/ata/sata_nv.c
===================================================================
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -49,7 +49,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"3.5"
+#define DRV_VERSION			"3.6"
 
 #define NV_ADMA_DMA_BOUNDARY		0xffffffffUL
 
@@ -361,13 +361,13 @@ static const struct pci_device_id nv_pci
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2), CK804 },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA), CK804 },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2), CK804 },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA), SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2), SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA), SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2), SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA), SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2), SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), SWNCQ },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), GENERIC },
 
 	{ } /* terminate list */
 };
@@ -2381,7 +2381,11 @@ static int nv_init_one (struct pci_dev *
 		type = ADMA;
 	}
 
+	if (type == GENERIC && swncq_enabled)
+		type = SWNCQ;
+
 	ppi[0] = &nv_port_info[type];
+
 	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
