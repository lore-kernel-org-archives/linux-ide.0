From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/15] libata-hp: add hotplug hooks into regular EH
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648472663-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:52965 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751292AbWDKOOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102585nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:14 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug handling into ata_eh_analyze_serror() and ata_eh_revive()
such that they schedule probe or detach if it seems appropriate.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

a335b73795061654e9dee96c2fc5f161e92780c7
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 6a61c5c..443f81f 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -855,7 +855,8 @@ static unsigned int ata_eh_analyze_tf(st
  *	@p_err_mask: Resulting err_mask
  *
  *	Analyze SError if available and further determine cause of
- *	failure.
+ *	failure.  This function also schedules probing if PHY status
+ *	has changed.
  *
  *	LOCKING:
  *	None.
@@ -885,6 +886,11 @@ static unsigned int ata_eh_analyze_serro
 		*p_err_mask |= AC_ERR_SYSTEM;
 		action |= ATA_PORT_SOFTRESET;
 	}
+	if (serror & (SERR_PHYRDY_CHG | SERR_DEV_XCHG)) {
+		*p_err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_PORT_SOFTRESET;
+		ata_schedule_probe(ap);
+	}
 
 	return action;
 }
@@ -1282,8 +1288,10 @@ int ata_eh_revive(struct ata_port *ap, u
 
  fail:
 	switch (rc) {
-	case -EINVAL:
 	case -ENODEV:
+		ata_schedule_probe(ap);
+	case -EINVAL:
+		ata_eh_detach_dev(ap, dev);
 		tries[dev->devno] = 0;
 		break;
 	case -EIO:
-- 
1.2.4


