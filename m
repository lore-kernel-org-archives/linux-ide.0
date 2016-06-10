From: Brian King <brking@linux.vnet.ibm.com>
Subject: [RFC] [PATCH 1/3] ipr: Wait to do async scan until scsi host is
 initialized
Date: Fri, 10 Jun 2016 16:36:46 -0500
Message-ID: <575B32EE.8080403@linux.vnet.ibm.com>
References: <CAOS58YO65A8TpH22tEdM4SUcn8ncpY1f_YFMzomCN09OvhoRaQ@mail.gmail.com>
 <57470450.3070000@linux.vnet.ibm.com> <575B3215.5070602@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56327 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752100AbcFJVgw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2016 17:36:52 -0400
Received: from pps.filterd (m0082756.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5ALXikb005866
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 17:36:51 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23g1eenevs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 17:36:51 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-ide@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Fri, 10 Jun 2016 17:36:50 -0400
In-Reply-To: <575B3215.5070602@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>


When performing an async scan, make sure the kthread doing scanning
doesn't start before the scsi host is fully initialized.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 drivers/scsi/ipr.c |    9 +++++++++
 drivers/scsi/ipr.h |    1 +
 2 files changed, 10 insertions(+)

diff -puN drivers/scsi/ipr.c~ipr_async_scan_fixup drivers/scsi/ipr.c
--- linux-2.6.git/drivers/scsi/ipr.c~ipr_async_scan_fixup	2016-06-01 21:04:14.088698640 -0500
+++ linux-2.6.git-bjking1/drivers/scsi/ipr.c	2016-06-10 15:35:56.738201739 -0500
@@ -3287,6 +3287,11 @@ static void ipr_worker_thread(struct wor
 		return;
 	}
 
+	if (!ioa_cfg->scan_enabled) {
+		spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+		return;
+	}
+
 restart:
 	do {
 		did_work = 0;
@@ -10360,6 +10365,7 @@ static void ipr_remove(struct pci_dev *p
 static int ipr_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 {
 	struct ipr_ioa_cfg *ioa_cfg;
+	unsigned long flags;
 	int rc, i;
 
 	rc = ipr_probe_ioa(pdev, dev_id);
@@ -10412,7 +10418,10 @@ static int ipr_probe(struct pci_dev *pde
 		}
 	}
 
+	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
+	ioa_cfg->scan_enabled = 1;
 	schedule_work(&ioa_cfg->work_q);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
 	return 0;
 }
 
diff -puN drivers/scsi/ipr.h~ipr_async_scan_fixup drivers/scsi/ipr.h
--- linux-2.6.git/drivers/scsi/ipr.h~ipr_async_scan_fixup	2016-06-01 21:04:17.186678232 -0500
+++ linux-2.6.git-bjking1/drivers/scsi/ipr.h	2016-06-10 15:35:56.739201727 -0500
@@ -1475,6 +1475,7 @@ struct ipr_ioa_cfg {
 	u8 in_ioa_bringdown:1;
 	u8 ioa_unit_checked:1;
 	u8 dump_taken:1;
+	u8 scan_enabled:1;
 	u8 scan_done:1;
 	u8 needs_hard_reset:1;
 	u8 dual_raid:1;
_

