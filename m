From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sis: fix flags handling for the secondary port
Date: Mon, 23 Oct 2006 12:48:21 +0900
Message-ID: <20061023034821.GI13677@htj.dyndns.org>
References: <453A3F0C.3000406@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:15005 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751220AbWJWDsb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 23:48:31 -0400
Received: by nf-out-0910.google.com with SMTP id c2so2256195nfe
        for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 20:48:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <453A3F0C.3000406@trash.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: Patrick McHardy <kaber@trash.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

sis_init_one() modifies probe_ent->port_flags after allocating and
initializing it using ata_pci_init_native_mode().  This makes
port_flags for the secondary port (probe_ent->pinfo2->flags) go out of
sync resulting in misdetection of device due to incorrectly
initialized SCR access flag.

This patch make probe_ent alloc/init happen after the final port flags
value is determined.  This is fragile but probe_ent and all the
related mess are scheduled to go away soon for exactly this reason.
We just need to hold everything together till then.

This has been spotted and diagnosed by Patrick McHardy.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Patric McHardy <kaber@trash.net>
---
Patrick, can you test this patch and post result?

Jeff, please don't apply this patch till Patrick acks it.

Thanks.

--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -240,7 +240,7 @@ static int sis_init_one (struct pci_dev 
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
-	struct ata_port_info *ppi[2];
+	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
 	int pci_dev_busy = 0;
 	u8 pmr;
 	u8 port2_start;
@@ -265,27 +265,20 @@ static int sis_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	ppi[0] = ppi[1] = &sis_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-
 	/* check and see if the SCRs are in IO space or PCI cfg space */
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
-		probe_ent->port_flags |= SIS_FLAG_CFGSCR;
+		pi.flags |= SIS_FLAG_CFGSCR;
 
 	/* if hardware thinks SCRs are in IO space, but there are
 	 * no IO resources assigned, change to PCI cfg space.
 	 */
-	if ((!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) &&
+	if ((!(pi.flags & SIS_FLAG_CFGSCR)) &&
 	    ((pci_resource_start(pdev, SIS_SCR_PCI_BAR) == 0) ||
 	     (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
 		genctl &= ~GENCTL_IOMAPPED_SCR;
 		pci_write_config_dword(pdev, SIS_GENCTL, genctl);
-		probe_ent->port_flags |= SIS_FLAG_CFGSCR;
+		pi.flags |= SIS_FLAG_CFGSCR;
 	}
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
@@ -306,6 +299,12 @@ static int sis_init_one (struct pci_dev 
 		port2_start = 0x20;
 	}
 
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
 	if (!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);
