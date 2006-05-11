From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/22] libata: implement new SCR handling and port on/offline functions
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <1147348791300-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:43198 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751616AbWEKMAG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:06 -0400
Received: by wr-out-0506.google.com with SMTP id i22so106725wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:05 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_scr_{valid|read|write|write_flush}() and
ata_port_{online|offline}().  These functions replace
scr_{read|write}() and sata_dev_present().

Major difference between between the new SCR functions and the old
ones is that the new ones have a way to signal error to the caller.
This makes handling SCR-available and SCR-unavailable cases in the
same path easier.  Also, it eases later PM implementation where SCR
access can fail due to various reasons.

ata_port_{online|offline}() functions return 1 only when they are
affirmitive of the condition.  e.g.  if SCR is unaccessible or
presence cannot be determined for other reasons, these functions
return 0.  So, ata_port_online() != !ata_port_offline().  This
distinction is useful in many exception handling cases.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  143 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    6 ++
 2 files changed, 149 insertions(+), 0 deletions(-)

68b43f16a1d92da94b0c28cbecce0b801cbac4a6
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3d44cff..e3c579e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4365,6 +4365,143 @@ irqreturn_t ata_interrupt (int irq, void
 	return IRQ_RETVAL(handled);
 }
 
+/**
+ *	ata_scr_valid - test whether SCRs are accessible
+ *	@ap: ATA port to test SCR accessibility for
+ *
+ *	Test whether SCRs are accessible for @ap.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if SCRs are accessible, 0 otherwise.
+ */
+int ata_scr_valid(struct ata_port *ap)
+{
+	return ap->cbl == ATA_CBL_SATA && ap->ops->scr_read;
+}
+
+/**
+ *	ata_scr_read - read SCR register of the specified port
+ *	@ap: ATA port to read SCR for
+ *	@reg: SCR to read
+ *	@val: Place to store read value
+ *
+ *	Read SCR register @reg of @ap into *@val.  This function is
+ *	guaranteed to succeed if the cable type of the port is SATA
+ *	and the port implements ->scr_read.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int ata_scr_read(struct ata_port *ap, int reg, u32 *val)
+{
+	if (ata_scr_valid(ap)) {
+		*val = ap->ops->scr_read(ap, reg);
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
+
+/**
+ *	ata_scr_write - write SCR register of the specified port
+ *	@ap: ATA port to write SCR for
+ *	@reg: SCR to write
+ *	@val: value to write
+ *
+ *	Write @val to SCR register @reg of @ap.  This function is
+ *	guaranteed to succeed if the cable type of the port is SATA
+ *	and the port implements ->scr_read.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int ata_scr_write(struct ata_port *ap, int reg, u32 val)
+{
+	if (ata_scr_valid(ap)) {
+		ap->ops->scr_write(ap, reg, val);
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
+
+/**
+ *	ata_scr_write_flush - write SCR register of the specified port and flush
+ *	@ap: ATA port to write SCR for
+ *	@reg: SCR to write
+ *	@val: value to write
+ *
+ *	This function is identical to ata_scr_write() except that this
+ *	function performs flush after writing to the register.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int ata_scr_write_flush(struct ata_port *ap, int reg, u32 val)
+{
+	if (ata_scr_valid(ap)) {
+		ap->ops->scr_write(ap, reg, val);
+		ap->ops->scr_read(ap, reg);
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
+
+/**
+ *	ata_port_online - test whether the given port is online
+ *	@ap: ATA port to test
+ *
+ *	Test whether @ap is online.  Note that this function returns 0
+ *	if online status of @ap cannot be obtained, so
+ *	ata_port_online(ap) != !ata_port_offline(ap).
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if the port online status is available and online.
+ */
+int ata_port_online(struct ata_port *ap)
+{
+	u32 sstatus;
+
+	if (!ata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) == 0x3)
+		return 1;
+	return 0;
+}
+
+/**
+ *	ata_port_offline - test whether the given port is offline
+ *	@ap: ATA port to test
+ *
+ *	Test whether @ap is offline.  Note that this function returns
+ *	0 if offline status of @ap cannot be obtained, so
+ *	ata_port_online(ap) != !ata_port_offline(ap).
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if the port offline status is available and offline.
+ */
+int ata_port_offline(struct ata_port *ap)
+{
+	u32 sstatus;
+
+	if (!ata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) != 0x3)
+		return 1;
+	return 0;
+}
 
 /*
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
@@ -5133,6 +5270,12 @@ EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
+EXPORT_SYMBOL_GPL(ata_scr_valid);
+EXPORT_SYMBOL_GPL(ata_scr_read);
+EXPORT_SYMBOL_GPL(ata_scr_write);
+EXPORT_SYMBOL_GPL(ata_scr_write_flush);
+EXPORT_SYMBOL_GPL(ata_port_online);
+EXPORT_SYMBOL_GPL(ata_port_offline);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d15c00..7b3beea 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -536,6 +536,12 @@ extern int ata_scsi_ioctl(struct scsi_de
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern int ata_scr_valid(struct ata_port *ap);
+extern int ata_scr_read(struct ata_port *ap, int reg, u32 *val);
+extern int ata_scr_write(struct ata_port *ap, int reg, u32 val);
+extern int ata_scr_write_flush(struct ata_port *ap, int reg, u32 val);
+extern int ata_port_online(struct ata_port *ap);
+extern int ata_port_offline(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
-- 
1.2.4


