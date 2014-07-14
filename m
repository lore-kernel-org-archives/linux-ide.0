From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] MAINTAINERS: Add Hans de Goede as ahci-platform maintainer
Date: Mon, 14 Jul 2014 15:22:22 +0200
Message-ID: <1405344142-3051-2-git-send-email-hdegoede@redhat.com>
References: <1405344142-3051-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120AbaGNNW1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jul 2014 09:22:27 -0400
In-Reply-To: <1405344142-3051-1-git-send-email-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6813d0a..5396f54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8007,6 +8007,15 @@ F:	drivers/ata/
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
+
 SERVER ENGINES 10Gbps iSCSI - BladeEngine 2 DRIVER
 M:	Jayamohan Kallickal <jayamohan.kallickal@emulex.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.0.0

