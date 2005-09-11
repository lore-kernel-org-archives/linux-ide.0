From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: patch for sata_sis.c
Date: Sun, 11 Sep 2005 17:03:35 +0200
Message-ID: <43244747.3020504@gmx.net>
References: <20050909031207.GA25014@havoc.gtf.org> <4321561A.7040904@gmx.net> <4321C16C.9000901@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090300060201080307090403"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:50607 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964799AbVIKPDi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Sep 2005 11:03:38 -0400
In-Reply-To: <4321C16C.9000901@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300060201080307090403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Jeff,

There is an uninitialized variable issue in sata_sis.c, version
2.6.13-git10. Please check the patch.

Uwe Koziolek


--------------090300060201080307090403
Content-Type: text/x-patch;
 name="sata_sis.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_sis.c.patch"

diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -159,7 +159,7 @@ static u32 sis_scr_cfg_read (struct ata_
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev->device);
-	u32 val, val2;
+	u32 val, val2 = 0;
 	u8 pmr;
 
 	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */

--------------090300060201080307090403--
