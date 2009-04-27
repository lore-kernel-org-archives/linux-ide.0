From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: [PATCH] Fix Trivial Warnining in drivers/ata/libata-scsi.c
Date: Mon, 27 Apr 2009 16:01:24 +0530
Message-ID: <20090427103124.6941.55106.sendpatchset@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:36762 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbZD0Kb2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Apr 2009 06:31:28 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3RAM9OA016573
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2009 06:22:09 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n3RAVRE5056154
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2009 06:31:28 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n3RAVRNI026865
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2009 06:31:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, linux-ide@vger.kernel.org, Subrata Modak <subrata@linux.vnet.ibm.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

Hi Jeff,

I observed the following warning for drivers/ata/libata-scsi.c:

drivers/ata/libata-scsi.c: In function =E2=80=98ata_scsi_scan_host=E2=80=
=99:
drivers/ata/libata-scsi.c:3272: warning: =E2=80=98dev=E2=80=99 may be u=
sed uninitialized in this function
---

In most instances=3D>
	struct ata_device *dev
has been initialized except the above instance. My trivial patch below =
fixes this.
Please include it if you like it.

To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
Cc: Balbir Singh <balbir@linux.vnet.ibm.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>
Signed-Off-By: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- a/drivers/ata/libata-scsi.c	2009-04-27 11:39:27.000000000 +0530
+++ b/drivers/ata/libata-scsi.c	2009-04-27 15:52:17.000000000 +0530
@@ -3269,7 +3269,7 @@ void ata_scsi_scan_host(struct ata_port=20
 	int tries =3D 5;
 	struct ata_device *last_failed_dev =3D NULL;
 	struct ata_link *link;
-	struct ata_device *dev;
+	struct ata_device *dev =3D NULL;
=20
 	if (ap->flags & ATA_FLAG_DISABLED)
 		return;

---
Regards--
Subrata

