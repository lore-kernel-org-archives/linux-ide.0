From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata-dev:  update timer for PIO polling - revised
Date: Fri, 20 Jan 2006 22:19:33 +0800
Message-ID: <43D0F175.7010206@tw.ibm.com>
References: <43BA8AEE.8010608@bj-ig.de> <43BB3CBA.5010908@tw.ibm.com> <43BB9568.6010000@bj-ig.de> <43BDE6EB.9090106@tw.ibm.com> <43CD9130.4000600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:46721 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751005AbWATOTm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jan 2006 09:19:42 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0KEJY9O028113
	for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2006 09:19:34 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0KELjKQ176636
	for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2006 07:21:45 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0KEJXPG010522
	for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2006 07:19:34 -0700
In-Reply-To: <43CD9130.4000600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Jeff,

Revised per your advice to use the eh_timed_out() handler.

Description:
  In the bug reported by Ralf M=FCller:
(http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D113629906809278&w=3D2)

When the scsi command times out, the qc is completed by the time
out handler. This might cause null pointer dereference if
the qc is running in the PIO polling thread.

Changes:
  Add ata_scsi_timed_out() to libata-scsi.
  If the qc times out when running in PIO mode, EH_RESET_TIMER is retur=
ned.
  Otherwise, EH_NOT_HANDLED is returned and the eh_strategy_handler()
  is triggered as before.

(Will add ata_scsi_timed_out() to LLDs later if this is ok.)

Patch against the libata-dev irq-pio branch=20
(000080c3499cd5037e60c08a8053efb9e48aa9c0).

=46or your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

=3D=3D=3D=3D=3D

--- irq-pio/include/linux/libata.h	2006-01-20 10:35:11.000000000 +0800
+++ eh_timed_out/include/linux/libata.h	2006-01-20 10:48:29.000000000 +=
0800
@@ -449,6 +449,7 @@ extern void ata_host_set_remove(struct a
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __use=
r *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struc=
t scsi_cmnd *));
+extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *=
);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queu=
ed_cmd *qc);
--- irq-pio/drivers/scsi/libata-scsi.c	2006-01-20 10:35:05.000000000 +0=
800
+++ eh_timed_out/drivers/scsi/libata-scsi.c	2006-01-20 22:13:14.0000000=
00 +0800
@@ -717,6 +717,59 @@ int ata_scsi_slave_config(struct scsi_de
 }
=20
 /**
+ *	ata_scsi_timed_out - SCSI layer time out handler callback
+ *	@cmd: SCSI cmd on which time out occurred
+ *
+ *	Handles SCSI-layer-thrown time out events.
+ *
+ *	RETURNS:
+ *	EH_HANDLED if qc was completed
+ *	EH_RESET_TIMER for polling case
+ *	EH_NOT_HANDLED otherwise.
+ */
+enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
+{
+	struct scsi_device *scsidev =3D cmd->device;
+	struct ata_port *ap =3D (struct ata_port *) &scsidev->host->hostdata[=
0];
+	struct ata_host_set *host_set =3D ap->host_set;
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	int rc =3D EH_NOT_HANDLED;
+
+	DPRINTK("ENTER\n");
+	spin_lock_irqsave(&host_set->lock, flags);
+
+	qc =3D ata_qc_from_tag(ap, ap->active_tag);
+	if (!qc) {
+		/* ata_poll_qc_complete() or ata_interrupt() win the race.
+		 */
+		printk(KERN_ERR "ata%u: timeout without qc\n", ap->id);
+		rc =3D EH_HANDLED;
+		goto out;
+	}
+
+	/* check if we are handling the right qc */
+	assert(qc->scsicmd =3D=3D cmd);
+	assert(qc->flags & ATA_QCFLAG_ACTIVE);
+
+	if (qc->tf.flags & ATA_TFLAG_POLLING) {
+		/* The PIO polling thread has its own timeout handling.
+		 * It won't loop forever, even if it takes a long time.
+		 * We can wait the PIO polling thread to finish its work.
+		 * No need to stop the polling thread from the timeout handler.
+		 * Just reset the timer here.
+		 */
+		printk(KERN_WARNING "ata%u: reset scsi timer for PIO polling\n", ap-=
>id);
+		cmd->retries =3D 0;
+		rc =3D EH_RESET_TIMER;
+	}
+out:
+	spin_unlock_irqrestore(&host_set->lock, flags);
+	DPRINTK("EXIT rc %d\n", rc);
+	return rc;
+}
+
+/**
  *	ata_scsi_error - SCSI layer error handler callback
  *	@host: SCSI host on which error occurred
  *
--- irq-pio/drivers/scsi/libata-core.c	2006-01-20 10:35:05.000000000 +0=
800
+++ eh_timed_out/drivers/scsi/libata-core.c	2006-01-20 10:48:44.0000000=
00 +0800
@@ -5434,6 +5434,7 @@ EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
+EXPORT_SYMBOL_GPL(ata_scsi_timed_out);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);



