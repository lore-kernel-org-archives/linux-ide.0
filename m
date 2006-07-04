From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 05/24] pata_ali: Revisions below 0x20 need CD config poking too
Date: Tue, 4 Jul 2006 18:14:32 +0000 (UTC)
Message-ID: <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45454 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932302AbWGDSOS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:18 -0400
Date: Maw, 04 Gor 2006 19:01:29 +0100
In-Reply-To: <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_ali.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

4592b74f2e12f8da82f18f2ee073907398daaac1
diff --git a/drivers/scsi/pata_ali.c b/drivers/scsi/pata_ali.c
index eacc13b..91f00c7 100644
--- a/drivers/scsi/pata_ali.c
+++ b/drivers/scsi/pata_ali.c
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.6.3"
+#define DRV_VERSION "0.6.4"
 
 /*
  *	Cable special cases
@@ -283,6 +283,7 @@ static void ali_set_dmamode(struct ata_p
 	struct ata_device *pair = ata_dev_pair(adev);
 	struct ata_timing t;
 	unsigned long T =  1000000000 / 33333;	/* PCI clock based */
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
 
 	if (adev->class == ATA_DEV_ATA)
@@ -627,7 +628,7 @@ static int ali_init_one(struct pci_dev *
 		 * via 0x54/55.
 		 */
 		pci_read_config_byte(pdev, 0x53, &tmp);
-		if (rev == 0x20)
+		if (rev <= 0x20)
 			tmp &= ~0x02;
 		if (rev == 0xc7)
 			tmp |= 0x03;
-- 
1.2.GIT

