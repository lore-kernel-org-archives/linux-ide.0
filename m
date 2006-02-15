From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: fix comment regarding setting cable type
Date: Wed, 15 Feb 2006 15:01:42 +0900
Message-ID: <1139983302106-git-send-email-htejun@gmail.com>
References: <11399833022059-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:56468 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422992AbWBOGBr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 01:01:47 -0500
Received: by zproxy.gmail.com with SMTP id 14so1504425nzn
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 22:01:46 -0800 (PST)
In-Reply-To: <11399833022059-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The comment above ata_std_postreset() specified that setting cable
type is the responsibility of postreset(), which isn't possible /
optimal depending on controller / driver.  This patch kills the
comment.  Setting cable type is responsibility of ->probe_reset.
libata doesn't care whether it's done in probeinit, reset or
postreset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

823d5f6f8de896e7b6437a4f140d807bbab1e7bd
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 61cba39..51191d1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2106,7 +2106,6 @@ int sata_std_hardreset(struct ata_port *
  *	This function is invoked after a successful reset.  Note that
  *	the device might have been reset more than once using
  *	different reset methods before postreset is invoked.
- *	postreset is also reponsible for setting cable type.
  *
  *	This function is to be used as standard callback for
  *	ata_drive_*_reset().
@@ -2118,7 +2117,7 @@ void ata_std_postreset(struct ata_port *
 {
 	DPRINTK("ENTER\n");
 
-	/* set cable type */
+	/* set cable type if it isn't already set */
 	if (ap->cbl == ATA_CBL_NONE && ap->flags & ATA_FLAG_SATA)
 		ap->cbl = ATA_CBL_SATA;
 
-- 
1.1.5


