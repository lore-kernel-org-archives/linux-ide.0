From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/16] libata-eh-fw: add new EH operations
Date: Tue, 11 Apr 2006 22:42:53 +0900
Message-ID: <11447629732531-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.238]:17303 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750884AbWDKNm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:42:56 -0400
Received: by wproxy.gmail.com with SMTP id i3so961063wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:42:56 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch adds three operations for new EH.  The operations are...

->freeze		freeze the port
->error_handler		new EH
->post_internal_cmd	EH/clean up for internal commands

The old and new EH's have to live together for the time being and
->error_handler will be used as a switch to select which EH mechanism
to use.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

fc162d78699201209b9ecb6250f716aa3d65959d
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d80dbb5..111bae9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -462,7 +462,14 @@ struct ata_port_operations {
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
-	void (*eng_timeout) (struct ata_port *ap);
+	/* Error handlers.  ->error_handler overrides ->eng_timeout and
+	 * indicates that new-style EH is in place.
+	 */
+	void (*eng_timeout) (struct ata_port *ap); /* obsolete */
+
+	void (*freeze) (struct ata_port *ap);
+	void (*error_handler) (struct ata_port *ap);
+	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 	void (*irq_clear) (struct ata_port *);
-- 
1.2.4


