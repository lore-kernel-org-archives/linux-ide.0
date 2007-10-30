From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make ata_scsi_lpm_get() static
Date: Wed, 31 Oct 2007 00:50:23 +0100
Message-ID: <20071030235023.GT7227@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35810 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752914AbXJ3XuZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Jeff Garzik <jgarzik@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

ata_scsi_lpm_get() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
380046f657271be470566bb5c762c1599569bac6 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 93bd36c..c4f0c6c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -120,7 +120,7 @@ static const struct {
 	{ MEDIUM_POWER, "medium_power" },
 };
 
-const char *ata_scsi_lpm_get(enum link_pm policy)
+static const char *ata_scsi_lpm_get(enum link_pm policy)
 {
 	int i;
 

