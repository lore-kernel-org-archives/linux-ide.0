From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: add Tecra M3 to broken suspend blacklist
Date: Fri, 27 Jul 2007 14:55:07 +0900
Message-ID: <46A988BB.10200@gmail.com>
References: <20070710063605.GA21994@htj.dyndns.org>	<20070710065543.GA23568@htj.dyndns.org>	<46A66842.6040803@garzik.org> <20070724225747.1dd4d141@the-village.bc.nu> <46A677C3.9090107@garzik.org> <46A98607.7000401@gmail.com> <46A98858.5090209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:33188 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbXG0FzM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 01:55:12 -0400
Received: by rv-out-0910.google.com with SMTP id k20so79624rvb
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 22:55:11 -0700 (PDT)
In-Reply-To: <46A98858.5090209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

Add Tecra M3 to the broken suspend blacklist.  Tecra M3 doesn't have
proper DMI_PRODUCT_NAME but has an OEM_STRING instead.  Match it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: work/drivers/ata/ata_piix.c
===================================================================
--- work.orig/drivers/ata/ata_piix.c
+++ work/drivers/ata/ata_piix.c
@@ -916,10 +916,18 @@ static int piix_broken_suspend(void)
 		},
 		{ }
 	};
+	static const char *oemstrs[] = {
+		"Tecra M3,",
+	};
+	int i;
 
 	if (dmi_check_system(sysids))
 		return 1;
 
+	for (i = 0; i < ARRAY_SIZE(oemstrs); i++)
+		if (dmi_find_device(DMI_DEV_TYPE_OEM_STRING, oemstrs[i], NULL))
+			return 1;
+
 	return 0;
 }
 
