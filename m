From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [PATCH broken-out-2007-07-20-00-22] drivers/ata/libata-core.c build
 fix
Date: Fri, 20 Jul 2007 17:32:57 +0200
Message-ID: <46A0D5A9.4080207@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:33667 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936548AbXGTPed (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 11:34:33 -0400
Received: by ug-out-1314.google.com with SMTP id j3so637739ugf
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 08:34:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hi Kristen,

Hmmm...
ata-ahci-alpm-enable-link-power-management-for-ata-drivers.patch

drivers/ata/libata-core.c: In function 'ata_dev_configure':
drivers/ata/libata-core.c:2039: error: implicit declaration of function 'ata_device_blacklisted'
make[2]: *** [drivers/ata/libata-core.o] Error 1
make[1]: *** [drivers/ata] Error 2
make: *** [drivers] Error 2

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

--- linux-work3-clean/drivers/ata/libata-core.c	2007-07-20 16:53:26.000000000 +0200
+++ linux-work3/drivers/ata/libata-core.c	2007-07-20 17:26:30.000000000 +0200
@@ -2036,7 +2036,7 @@ int ata_dev_configure(struct ata_device 
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
 					 dev->max_sectors);
 
-	if (ata_device_blacklisted(dev) & ATA_HORKAGE_ALPM) {
+	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_ALPM) {
 		dev->horkage |= ATA_HORKAGE_ALPM;
 
 		/* reset link pm_policy for this port to no pm */
