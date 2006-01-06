From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata-dev: update timeout for PIO polling
Date: Fri, 06 Jan 2006 11:41:31 +0800
Message-ID: <43BDE6EB.9090106@tw.ibm.com>
References: <43BA8AEE.8010608@bj-ig.de> <43BB3CBA.5010908@tw.ibm.com> <43BB9568.6010000@bj-ig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:17544 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932246AbWAFDlm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jan 2006 22:41:42 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k063fXEW010817
	for <linux-ide@vger.kernel.org>; Thu, 5 Jan 2006 22:41:33 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k063eDxC111320
	for <linux-ide@vger.kernel.org>; Thu, 5 Jan 2006 20:40:13 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k063fWJo021953
	for <linux-ide@vger.kernel.org>; Thu, 5 Jan 2006 20:41:33 -0700
In-Reply-To: <43BB9568.6010000@bj-ig.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Jeff,

In the bug reported by Ralf M=FCller:
  (http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D113629906809278&w=3D=
2)

  When the command times out, the qc is completed by the time
out handler. This might cause null pointer dereference if
the command is running in the PIO polling thread.

Changes:
- Update the timeout for PIO polling to 5 minutes.
  This should be long enough to prevent the timeout handler from
  interfering with the PIO polling thread. =20

Patch against the libata-dev irq-pio branch=20
(61420e147a706ee7c7a902008045547fb2a2a330).

=46or your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- irq-pio/include/linux/libata.h	2006-01-05 15:16:32.000000000 +0800
+++ update_tmout/include/linux/libata.h	2006-01-06 10:17:34.000000000 +=
0800
@@ -141,6 +141,7 @@ enum {
 	ATA_TMOUT_CDB_QUICK	=3D 5 * HZ,
 	ATA_TMOUT_INTERNAL	=3D 30 * HZ,
 	ATA_TMOUT_INTERNAL_QUICK =3D 5 * HZ,
+	ATA_TMOUT_LONG		=3D 300 * HZ,	/* looks long enough */
=20
 	/* ATA bus states */
 	BUS_UNKNOWN		=3D 0,
--- irq-pio/drivers/scsi/libata-core.c	2006-01-05 15:16:29.000000000 +0=
800
+++ update_tmout/drivers/scsi/libata-core.c	2006-01-06 10:41:23.0000000=
00 +0800
@@ -3866,6 +3866,21 @@ int ata_qc_issue_prot(struct ata_queued_
 		}
 	}
=20
+	/* The PIO polling thread has its own timeout handling.
+	 * It won't loop forever. Even if it takes a long time,
+	 * we can wait the PIO polling thread to finish its work.
+	 * No need to stop the polling thread from the timeout handler.
+	 * So the timeout is updated to a long time here. This can prevent
+	 * the timeout handler from interfering with the PIO polling thread.
+	 */
+	if (qc->tf.flags & ATA_TFLAG_POLLING &&
+	    qc->scsicmd &&
+	    qc->scsicmd->eh_timeout.function) {
+		DPRINTK("ata%u: timer updated for PIO polling\n", ap->id);
+		mod_timer(&qc->scsicmd->eh_timeout,
+			  jiffies + ATA_TMOUT_LONG);
+	}
+
 	/* select the device */
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
=20


