From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/15] ahci: add hotplug support
Date: Tue, 11 Apr 2006 23:14:08 +0900
Message-ID: <11447648483742-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:19875 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751296AbWDKOOW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:22 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102564nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:21 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug support by enabling PORT_IRQ_PHYRDY.  Standard EH will do
the right thing and schedule probe after analyzing SError.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

ded75cede39c99d38376691e952327cff47bb4f6
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 7f478c4..975618e 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -135,6 +135,7 @@ enum {
 	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
 				  PORT_IRQ_IF_ERR |
 				  PORT_IRQ_CONNECT |
+				  PORT_IRQ_PHYRDY |
 				  PORT_IRQ_UNK_FIS,
 	PORT_IRQ_ERROR		= PORT_IRQ_FREEZE |
 				  PORT_IRQ_TF_ERR |
@@ -801,10 +802,12 @@ static unsigned int ahci_eh_autopsy(stru
 		desc_sz -= rc;
 	}
 
-	if (irq_stat & PORT_IRQ_CONNECT) {
+	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_PORT_SOFTRESET;
-		rc = scnprintf(desc, desc_sz, ", connection status changed");
+		rc = scnprintf(desc, desc_sz, ", %s",
+			       irq_stat & PORT_IRQ_CONNECT ?
+			       "connection status changed" : "PHY RDY changed");
 		desc += rc;
 		desc_sz -= rc;
 	}
-- 
1.2.4


