From: Rainer Koenig <Rainer.Koenig@fujitsu-siemens.com>
Subject: [PATCH 2.6.12.4] sata_sis.c: Introducing device ID 0x182
Date: Thu, 11 Aug 2005 10:44:55 +0200
Message-ID: <8764ucdfqw.fsf@ABG3595C.abg.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:23160 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1030228AbVHKIpM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 04:45:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Our new SIS based AMD desktop systems come with a very new SIS chipset
that has a Serial ATA controller that has the device ID 0x182. Without
this patch the system won't be able to use the hard disk in native mode.
As a proof of concept we patched the kernel on a system with an older SIS
chipset and then transfered the hard disk to the new system, looks like
the new chipset is compatible enough to run without problems.

Regards
Rainer

Patch signed-off-by: Rainer Koenig <Rainer.Koenig@fujitsu-siemens.com>

--- linux-2.6.12.4/drivers/scsi/sata_sis.c	2005-08-05 09:04:37.000000000 +0200
+++ linux/drivers/scsi/sata_sis.c	2005-08-11 10:22:07.000000000 +0200
@@ -62,6 +62,7 @@
 static struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+        { PCI_VENDOR_ID_SI, 0x182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 	{ }	/* terminate list */
 };
 

-- 
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux
Business Clients
Fujitsu Siemens Computers 
VP BC E SW OS
Phone: +49-821-804-3321
Fax:   +49-821-804-2131
 
