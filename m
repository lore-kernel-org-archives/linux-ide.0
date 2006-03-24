From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: check if port is disabled after internal command
Date: Fri, 24 Mar 2006 15:25:30 +0900
Message-ID: <11431815303557-git-send-email-htejun@gmail.com>
References: <11431815303216-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:12320 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423182AbWCXGZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 01:25:36 -0500
Received: by pproxy.gmail.com with SMTP id w49so645701pyg
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 22:25:35 -0800 (PST)
In-Reply-To: <11431815303216-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata core is being changed to disallow port/device disable on lower
layers.  However, some LLDDs (sata_mv) directly disable port on
command failure.  This patch makes ata_exec_internal() check whether a
port got disabled after an internal command.  If it is, AC_ERR_SYSTEM
is added to err_mask and the port gets re-enabled.

As internal command failure results in device disable for drivers
which don't implement newer reset/EH callbacks, this change results in
no behavior change for single device per port controllers.  For
slave-possible LLDDs which disable port on command failure, (1) such
drivers don't exist currently, (2) issuing command to the other device
of once-disabled port shouldn't result in catastrophe even if such
driver exists.  So, this should be enough as a temporary measure.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

e236cbb94f12a51962fc38db3e1724b17f738c09
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1063928..9cd9053 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1009,6 +1009,22 @@ ata_exec_internal(struct ata_port *ap, s
 
 	ata_qc_free(qc);
 
+	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
+	 * Until those drivers are fixed, we detect the condition
+	 * here, fail the command with AC_ERR_SYSTEM and reenable the
+	 * port.
+	 *
+	 * Note that this doesn't change any behavior as internal
+	 * command failure results in disabling the device in the
+	 * higher layer for LLDDs without new reset/EH callbacks.
+	 *
+	 * Kill the following code as soon as those drivers are fixed.
+	 */
+	if (ap->flags & ATA_FLAG_PORT_DISABLED) {
+		err_mask |= AC_ERR_SYSTEM;
+		ata_port_probe(ap);
+	}
+
 	return err_mask;
 }
 
-- 
1.2.4


