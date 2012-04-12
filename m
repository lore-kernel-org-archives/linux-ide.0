From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] ata: libata-eh.c: local functions should not be exposed globally
Date: Thu, 12 Apr 2012 15:40:37 -0700
Message-ID: <201204121540.37253.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail160.messagelabs.com ([216.82.253.99]:36696 "EHLO
	mail160.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757869Ab2DLWkw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2012 18:40:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

The function ata_ering_clear_cb is only referenced in this file and
should be marked static to prevent it from being exposed globally.

This quiets the sparse warning:

warning: symbol 'ata_ering_clear_cb' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Jeff Garzik <jgarzik@pobox.com>

---

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b02748b..1ae0417 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -419,7 +419,7 @@ int ata_ering_map(struct ata_ering *ering,
 	return rc;
 }
 
-int ata_ering_clear_cb(struct ata_ering_entry *ent, void *void_arg)
+static int ata_ering_clear_cb(struct ata_ering_entry *ent, void *void_arg)
 {
 	ent->eflags |= ATA_EFLAG_OLD_ER;
 	return 0;
