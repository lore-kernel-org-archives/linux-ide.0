From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] IDE: terminate ACPI DMI list
Date: Thu, 10 Jan 2008 23:59:18 -0500
Message-ID: <20080111045918.GA17491@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:34992 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756799AbYAKE7V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 23:59:21 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Fix oops reported by Trond.

Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
---
 drivers/ide/ide-acpi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index fe6768a..899d565 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -85,6 +85,8 @@ static const struct dmi_system_id ide_acpi_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "KAM1.60")
 		},
 	},
+
+	{ }	/* terminate list */
 };
 
 static int ide_acpi_blacklist(void)
