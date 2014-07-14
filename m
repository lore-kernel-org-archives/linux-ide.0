From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3] MAINTAINERS: Add Hans de Goede as ahci-platform maintainer
Date: Mon, 14 Jul 2014 15:41:25 +0200
Message-ID: <1405345285-4669-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48486 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbaGNNla (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jul 2014 09:41:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--
Changes in v2: Add drivers/ata/libahci_platform.c to file list
Changes in v3: Add include/linux/ahci_platform.h to file list
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6813d0a..b18e5ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8007,6 +8007,16 @@ F:	drivers/ata/
 F:	include/linux/ata.h
 F:	include/linux/libata.h
 
+SERIAL ATA AHCI PLATFORM devices support
+M:	Hans de Goede <hdegoede@redhat.com>
+M:	Tejun Heo <tj@kernel.org>
+L:	linux-ide@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+S:	Supported
+F:	drivers/ata/ahci_platform.c
+F:	drivers/ata/libahci_platform.c
+F:	include/linux/ahci_platform.h
+
 SERVER ENGINES 10Gbps iSCSI - BladeEngine 2 DRIVER
 M:	Jayamohan Kallickal <jayamohan.kallickal@emulex.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.0.0

