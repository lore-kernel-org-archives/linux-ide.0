From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] CONFIG_PM=n slim: drivers/ide/pci/sc1200.c
Date: Sat, 12 Aug 2006 02:03:19 +0400
Message-ID: <20060811220319.GC6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:10682 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932437AbWHKWDV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Aug 2006 18:03:21 -0400
Received: by nf-out-0910.google.com with SMTP id a4so1049201nfc
        for <linux-ide@vger.kernel.org>; Fri, 11 Aug 2006 15:03:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ide/pci/sc1200.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -323,6 +323,7 @@ static void sc1200_tuneproc (ide_drive_t
  	}
 }
 
+#ifdef CONFIG_PM
 static ide_hwif_t *lookup_pci_dev (ide_hwif_t *prev, struct pci_dev *dev)
 {
 	int	h;
@@ -451,6 +452,7 @@ static int sc1200_resume (struct pci_dev
 	}
 	return 0;
 }
+#endif
 
 /*
  * This gets invoked by the IDE driver once for each channel,
@@ -499,8 +501,10 @@ static struct pci_driver driver = {
 	.name		= "SC1200_IDE",
 	.id_table	= sc1200_pci_tbl,
 	.probe		= sc1200_init_one,
+#ifdef CONFIG_PM
 	.suspend	= sc1200_suspend,
 	.resume		= sc1200_resume,
+#endif
 };
 
 static int sc1200_ide_init(void)

