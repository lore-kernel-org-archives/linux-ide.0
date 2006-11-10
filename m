From: Alexey Dobriyan <adobriyan@openvz.org>
Subject: [PATCH] pata_artop: fix "& (1 >>" typo
Date: Fri, 10 Nov 2006 22:52:46 +0300
Message-ID: <20061110195246.GC5872@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:33392 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161871AbWKJPq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Nov 2006 10:46:56 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, devel@openvz.org

Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 drivers/ata/pata_artop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -92,7 +92,7 @@ static int artop6260_pre_reset(struct at
 		return -ENOENT;
 
 	pci_read_config_byte(pdev, 0x49, &tmp);
-	if (tmp & (1 >> ap->port_no))
+	if (tmp & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;

