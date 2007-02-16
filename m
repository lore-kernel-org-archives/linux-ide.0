From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Patch: slight shrink of vt6421_init_addrs()
Date: Fri, 16 Feb 2007 19:46:56 +0800
Message-ID: <20070216194656.A4375@freya>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.217.24.227] ([221.217.24.227]:43598 "EHLO
	freya.yggdrasil.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932123AbXBPMnz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 07:43:55 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tejun and Jeff,

	The discussion about the vt6421 problems caused me to glance
at the code and try a very minor clean-up to vt6421_init_addrs().
Please note that I don't have a vt6421, so this patch is UNTESTED.
The patch does two things:

	1. Elminate the bmdma_addr variable, which was only used once,
	   in an assignment to a field also named bmdma_addr.  So having
	   a separate variable served no documentary purpose.  This change
	   causes the value to be computed a little later, so please make
	   sure that that is OK.  The effect is just to make the source
	   code one line smaller.  The binary size is unchanged by this
	   modification, at least on my x86 configuration, which has
	   SMP and lots of debugging options activated.

	2. Add a variable ata_ports, to replace the six times the
	   same value appeared to be computed.  I assume the compiler
	   was smart enough to avoid most of the recomputation, but
	   this change shrinks the .text by 7 bytes in my configuration,
	   makes the routine more readable and reduces opportunities for
	   typos.

	If it looks OK to everyone, please forward it upstream as
appropriate.

Adam Richter

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vt6421.patch"

--- drivers/ata/sata_via.c.tejun	2007-02-16 19:16:40.000000000 +0800
+++ drivers/ata/sata_via.c	2007-02-16 19:23:45.000000000 +0800
@@ -406,18 +406,18 @@
 static void vt6421_init_addrs(struct ata_probe_ent *probe_ent,
 			      void __iomem * const *iomap, unsigned int port)
 {
 	void __iomem *reg_addr = iomap[port];
-	void __iomem *bmdma_addr = iomap[4] + (port * 8);
+	struct ata_ioports *ata_ports = &probe_ent->port[port];
 
-	probe_ent->port[port].cmd_addr = reg_addr;
-	probe_ent->port[port].altstatus_addr =
-	probe_ent->port[port].ctl_addr = (void __iomem *)
+	ata_ports->cmd_addr = reg_addr;
+	ata_ports->altstatus_addr =
+	ata_ports->ctl_addr = (void __iomem *)
 		((unsigned long)(reg_addr + 8) | ATA_PCI_CTL_OFS);
-	probe_ent->port[port].bmdma_addr = bmdma_addr;
-	probe_ent->port[port].scr_addr = vt6421_scr_addr(iomap[5], port);
+	ata_ports->bmdma_addr = iomap[4] + (port * 8);
+	ata_ports->scr_addr = vt6421_scr_addr(iomap[5], port);
 
-	ata_std_ports(&probe_ent->port[port]);
+	ata_std_ports(ata_ports);
 }
 
 static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
 {

--NzB8fVQJ5HfG6fxh--
