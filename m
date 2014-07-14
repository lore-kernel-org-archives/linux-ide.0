From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] MAINTAINERS: Add Hans de Goede as ahci-platform maintainer
Date: Mon, 14 Jul 2014 14:46:22 +0200
Message-ID: <1405341982-1356-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28216 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250AbaGNMq2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jul 2014 08:46:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6813d0a..540be5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8007,6 +8007,14 @@ F:	drivers/ata/
 F:	include/linux/ata.h
 F:	include/linux/libata.h
 
+SERIAL ATA AHCI PLATFORM devices support
+M:	Hans de Goede <hdegoede@redhat.com>
+M:	Tejun Heo <tj@kernel.org>
+L:	linux-ide@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+S:	Supported
+F:	drivers/ata/ahci_platform.c
+
 SERVER ENGINES 10Gbps iSCSI - BladeEngine 2 DRIVER
 M:	Jayamohan Kallickal <jayamohan.kallickal@emulex.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.0.0

