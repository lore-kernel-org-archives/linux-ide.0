From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Add PCI ID for the Intel IDE Controller which is in the Intel Mac Minis shipped in first quarter 2006
Date: Fri, 12 May 2006 10:00:41 +0200
Message-ID: <20060512080041.GC7120@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:21478 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751066AbWELIAo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 04:00:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

---

 drivers/scsi/ata_piix.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

43413e721732100d165d004e34da6a74ad5c9fe6
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 6dc8814..e1c2ecc 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -159,6 +159,7 @@ #ifdef ATA_ENABLE_PATA
 	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix4_pata },
 	{ 0x8086, 0x24db, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
 	{ 0x8086, 0x25a2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
+	{ 0x8086, 0x27df, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
 #endif
 
 	/* NOTE: The following PCI ids must be kept in sync with the
-- 
1.3.2.g639c
