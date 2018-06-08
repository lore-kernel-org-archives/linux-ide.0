From: John Garry <john.garry@huawei.com>
Subject: [PATCH] libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()
Date: Fri, 8 Jun 2018 18:26:33 +0800
Message-ID: <1528453593-225313-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, John Garry <john.garry@huawei.com>
List-Id: linux-ide@vger.kernel.org

Currently smatch warns of possible Spectre-V1 issue in ahci_led_store():
drivers/ata/libahci.c:1150 ahci_led_store() warn: potential spectre issue 'pp->em_priv' (local cap)

Userspace controls @pmp from following callchain:
em_message->store()
->ata_scsi_em_message_store()
-->ap->ops->em_store()
--->ahci_led_store()

After the mask+shift @pmp is effectively an 8b value, which is used to
index into an array of length 8, so sanitize the array index.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 7adcf3c..4ce5bb4 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -1142,10 +1143,12 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 
 	/* get the slot number from the message */
 	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
-	if (pmp < EM_MAX_SLOTS)
+	if (pmp < EM_MAX_SLOTS) {
+		pmp = array_index_nospec(pmp, EM_MAX_SLOTS);
 		emp = &pp->em_priv[pmp];
-	else
+	} else {
 		return -EINVAL;
+	}
 
 	/* mask off the activity bits if we are in sw_activity
 	 * mode, user should turn off sw_activity before setting
-- 
1.9.1
