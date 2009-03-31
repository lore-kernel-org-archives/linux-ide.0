From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ata_piix: VGN-BX297XP wants the controller
 power up on suspend
Date: Tue, 31 Mar 2009 10:44:34 +0900
Message-ID: <49D17582.7090208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51809 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754565AbZCaBrO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Mar 2009 21:47:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, GNUtoo@no-log.org

Sony VGN-BX297XP fails suspend if the controller is powered down when
calling into ACPI suspend.  Add the machine to piix_broken_suspend
list.

This problem was reported by GNUtoo@no-log.org on bko#10293.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: GNUtoo@no-log.org
---
 drivers/ata/ata_piix.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index e5cbe80..942d14a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1053,6 +1053,13 @@ static int piix_broken_suspend(void)
 				DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE M500"),
 			},
 		},
+		{
+			.ident = "VGN-BX297XP",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-BX297XP"),
+			},
+		},
 
 		{ }	/* terminate list */
 	};
