From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/13] libata: add new EH operations
Date: Mon, 3 Apr 2006 03:31:09 +0900
Message-ID: <11440026691578-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:27419 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751044AbWDBSbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:16 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550553nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:15 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
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

9ee247ea9ddf4f1d0f5d7d2e457c8b4edd9c54f6
diff --git a/include/linux/libata.h b/include/linux/libata.h
index cc57c4d..0858788 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -463,7 +463,14 @@ struct ata_port_operations {
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


