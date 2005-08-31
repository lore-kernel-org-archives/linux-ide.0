From: "Mueller Daniel" <daniel.mueller@siemens.com>
Subject: patch: sata_promise.c
Date: Wed, 31 Aug 2005 09:54:13 +0200
Message-ID: <294F5689D10BCC41B35DD1F24BF210E402FB0E35@KHED163A.ww004.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dragon3.khe.siemens.de ([195.27.237.233]:33739 "EHLO
	dragon3.khe.siemens.de") by vger.kernel.org with ESMTP
	id S932472AbVHaHy3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2005 03:54:29 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff Garzik
 
The "Promise FastTrak TX2300 2-Port 3Gb/s SATA RAID 0/1 PCI-Adapter"
was not detected correctly with vanilla Linux 2.6.13 kernel.

With my 2 liner patch applied, the controller works fine.

some info:
sata_promise.c - Promise SATA
#define DRV_NAME        "sata_promise"
#define DRV_VERSION     "1.02"

Daniel Mueller
Siemens AG

------------------- attached udiff patch ----------------------

--- linux-2.6.13/drivers/scsi/sata_promise.c    2005-08-29
01:41:01.000000000 +0200
+++ linux-2.6.13-dm1/drivers/scsi/sata_promise.c        2005-08-31
09:13:04.030142728 +0200
@@ -164,6 +164,8 @@
 static struct pci_device_id pdc_ata_pci_tbl[] = {
        { PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_2037x },
+       { PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_2037x },
        { PCI_VENDOR_ID_PROMISE, 0x3571, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_2037x },
        { PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
