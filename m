From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: remove unused HSM_ST_UNKNOWN
Date: Fri, 17 Nov 2006 12:05:11 +0900
Message-ID: <20061117030511.GC2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:20008 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424591AbWKQDFT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Nov 2006 22:05:19 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1202397nfa
        for <linux-ide@vger.kernel.org>; Thu, 16 Nov 2006 19:05:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

HSM_ST_UNKNOWN is not used anywhere.  Its value is zero and supposed
to serve sanity check purpose but HSM_ST_IDLE is used for that
purpose.  This unused state causes confusion.  After a port is
initialized but before the first command is executed, the idle hsm
state is UNKNOWN.  However, once a command has completed, the idle hsm
state is IDLE.  This defeats sanity check in ata_pio_task() for the
first command.

This patch removes HSM_ST_UNKNOWN and consequently make HSM_ST_IDLE
the default state.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    1 -
 1 file changed, 1 deletion(-)

Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -315,7 +315,6 @@ enum {
 };
 
 enum hsm_task_states {
-	HSM_ST_UNKNOWN,		/* state unknown */
 	HSM_ST_IDLE,		/* no command on going */
 	HSM_ST,			/* (waiting the device to) transfer data */
 	HSM_ST_LAST,		/* (waiting the device to) complete command */
