From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: kill illegal kfree(id)
Date: Tue, 28 Feb 2006 17:38:10 +0900
Message-ID: <20060228083810.GA16942@htj.dyndns.org>
References: <Pine.LNX.4.58.0602271015370.22195@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:13398 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750726AbWB1IiP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 03:38:15 -0500
Received: by zproxy.gmail.com with SMTP id 13so1116467nzn
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 00:38:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602271015370.22195@shark.he.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Kill kfree(id) in failure path of ata_dev_read_id().  id is not
dynamically allocated yet.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>

---

That was a leftover from patch reordering.

Jeff, I'll regenerate patches #3-6 of reorganize ata_dev_identify()
patchset ASAP.  So, at the moment, there's no pending patch waiting
for your review.

Sorry.

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2006-02-28 17:25:39.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2006-02-28 17:33:05.000000000 +0900
@@ -1036,7 +1036,6 @@ static int ata_dev_read_id(struct ata_po
  err_out:
 	printk(KERN_WARNING "ata%u: dev %u failed to IDENTIFY (%s)\n",
 	       ap->id, dev->devno, reason);
-	kfree(id);
 	return rc;
 }
 
