From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] scsi: export scsi_forget_host()
Date: Fri, 07 Mar 2008 12:08:20 +0900
Message-ID: <47D0B1A4.2040104@gmail.com>
References: <20080222200951.GI16995@parisc-linux.org>	 <47BF3E54.9050609@rtr.ca>  <47CFA9A6.2040506@gmail.com>	 <1204817301.3062.3.camel@localhost.localdomain>	 <47D08478.8010700@gmail.com>	 <1204848119.3062.94.camel@localhost.localdomain>	 <47D08892.3080209@gmail.com>	 <1204849353.3062.107.camel@localhost.localdomain>	 <47D08C32.8060907@gmail.com> <1204850398.3062.111.camel@localhost.localdomain> <47D08FAA.7070001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:44362 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756992AbYCGDIb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 22:08:31 -0500
Received: by rn-out-0910.google.com with SMTP id v46so474486rnb.15
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 19:08:30 -0800 (PST)
In-Reply-To: <47D08FAA.7070001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <liml@rtr.ca>, Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Export scsi_forget_host(), will be used by libata.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/scsi/scsi_priv.h |    1 -
 drivers/scsi/scsi_scan.c |    1 +
 include/scsi/scsi_host.h |    1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

Index: work1/drivers/scsi/scsi_priv.h
===================================================================
--- work1.orig/drivers/scsi/scsi_priv.h
+++ work1/drivers/scsi/scsi_priv.h
@@ -98,7 +98,6 @@ extern void scsi_exit_procfs(void);
 /* scsi_scan.c */
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
 				   unsigned int, unsigned int, int);
-extern void scsi_forget_host(struct Scsi_Host *);
 extern void scsi_rescan_device(struct device *);
 
 /* scsi_sysctl.c */
Index: work1/drivers/scsi/scsi_scan.c
===================================================================
--- work1.orig/drivers/scsi/scsi_scan.c
+++ work1/drivers/scsi/scsi_scan.c
@@ -1845,6 +1845,7 @@ void scsi_forget_host(struct Scsi_Host *
 	}
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
+EXPORT_SYMBOL(scsi_forget_host);
 
 /*
  * Function:    scsi_get_host_dev()
Index: work1/include/scsi/scsi_host.h
===================================================================
--- work1.orig/include/scsi/scsi_host.h
+++ work1/include/scsi/scsi_host.h
@@ -719,6 +719,7 @@ extern struct Scsi_Host *scsi_host_alloc
 extern int __must_check scsi_add_host(struct Scsi_Host *, struct device *);
 extern void scsi_scan_host(struct Scsi_Host *);
 extern void scsi_rescan_device(struct device *);
+extern void scsi_forget_host(struct Scsi_Host *);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
 extern void scsi_host_put(struct Scsi_Host *t);
