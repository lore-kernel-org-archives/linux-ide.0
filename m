From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pata_acpi: fix build breakage if !CONFIG_PM
Date: Wed, 17 Oct 2007 15:24:16 +0900
Message-ID: <20071017062416.GA18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:38789 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbXJQGYX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 02:24:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1655329rvb
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 23:24:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Avuton Olrich <avuton@gmail.com>

There are configurations where CONFIG_ACPI but !CONFIG_PM.  In this
case, pata_acpi can be selected but won't build.  Fix it.

Reported by Avuton Olrich.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Avuton Olrich <avuton@gmail.com>
---
 drivers/ata/pata_acpi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 5d3920f..0f6f7bc 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -370,8 +370,10 @@ static struct pci_driver pacpi_pci_driver = {
 	.id_table		= pacpi_pci_tbl,
 	.probe			= pacpi_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int __init pacpi_init(void)
