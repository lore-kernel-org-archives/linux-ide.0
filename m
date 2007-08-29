From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/10] ide: remove .init_setup from ide_pci_device_t
Date: Wed, 29 Aug 2007 23:25:21 +0200
Message-ID: <200708292325.21691.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:44265 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756868AbXH2VZY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 17:25:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so293505nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:25:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Now that all users were fixed we can safely remove it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    1 -
 1 file changed, 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1271,7 +1271,6 @@ enum {
 
 typedef struct ide_pci_device_s {
 	char			*name;
-	int			(*init_setup)(struct pci_dev *, struct ide_pci_device_s *);
 	unsigned int		(*init_chipset)(struct pci_dev *, const char *);
 	void			(*init_iops)(ide_hwif_t *);
 	void                    (*init_hwif)(ide_hwif_t *);
