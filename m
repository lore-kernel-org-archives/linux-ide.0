From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:sil24] nit pickings
Date: Sat, 8 Oct 2005 12:10:43 +0900
Message-ID: <20051008031043.GA13957@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:10873 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932679AbVJHDKx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2005 23:10:53 -0400
Received: by zproxy.gmail.com with SMTP id 13so450569nzn
        for <linux-ide@vger.kernel.org>; Fri, 07 Oct 2005 20:10:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, efalk@google.com
Cc: linux-ide@vger.kernel.org

 Hello, Jeff & Edward.

 This patch removes unused NR_PORTS macro and adds termination entry
to sil24_pci_tbl.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -43,8 +43,6 @@
 #define DRV_NAME	"sata_sil24"
 #define DRV_VERSION	"0.21"	/* Silicon Image's preview driver was 0.10 */
 
-#define NR_PORTS	4
-
 /*
  * Port request block (PRB) 32 bytes
  */
@@ -244,6 +242,7 @@ static int sil24_init_one(struct pci_dev
 static struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
 	{ 0x1095, 0x3132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3132 },
+	{ } /* terminate list */
 };
 
 static struct pci_driver sil24_pci_driver = {

