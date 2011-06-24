From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] libata fixes (rebased)
Date: Fri, 24 Jun 2011 02:13:59 -0400
Message-ID: <20110624061359.GA20696@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:45535 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513Ab1FXGOA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Jun 2011 02:14:00 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Same summary/description as last time, except that the pata_marvell
change was updated (via rebase) to give proper credit.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upst=
ream-linus

to receive the following updates:

 drivers/ata/libata-core.c    |    6 +++---
 drivers/ata/libata-scsi.c    |    6 ++++++
 drivers/ata/pata_marvell.c   |    3 +++
 drivers/ata/sata_dwc_460ex.c |    2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

Justin P. Mattock (1):
      drivers/ata/sata_dwc_460ex: Fix typo 'corrresponding'

Nishanth Aravamudan (1):
      libata/sas: only set FROZEN flag if new EH is supported

Pawe=C5=82 Drewniak (1):
      pata_marvell: Add support for 88SE91A0, 88SE91A4

Tejun Heo (1):
      libata: apply NOSETXFER horkage to the affected Pioneer drives

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 736bee5..000d03a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4143,9 +4143,9 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
 	 * Devices which choke on SETXFER.  Applies only if both the
 	 * device and controller are SATA.
 	 */
-	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
-	{ "PIONEER DVD-RW  DVR-212D",	"1.28", ATA_HORKAGE_NOSETXFER },
-	{ "PIONEER DVD-RW  DVR-216D",	"1.08", ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVRTD08",	NULL,	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
=20
 	/* End Marker */
 	{ }
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d51f979..927f968 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3797,6 +3797,12 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
  */
 int ata_sas_port_start(struct ata_port *ap)
 {
+	/*
+	 * the port is marked as frozen at allocation time, but if we don't
+	 * have new eh, we won't thaw it
+	 */
+	if (!ap->ops->error_handler)
+		ap->pflags &=3D ~ATA_PFLAG_FROZEN;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_start);
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 75a6a0c..5d7f58a 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -161,6 +161,9 @@ static const struct pci_device_id marvell_pci_tbl[]=
 =3D {
 	{ PCI_DEVICE(0x11AB, 0x6121), },
 	{ PCI_DEVICE(0x11AB, 0x6123), },
 	{ PCI_DEVICE(0x11AB, 0x6145), },
+	{ PCI_DEVICE(0x1B4B, 0x91A0), },
+	{ PCI_DEVICE(0x1B4B, 0x91A4), },
+
 	{ }	/* terminate list */
 };
=20
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.=
c
index 1c4b3aa..dc88a39 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -389,7 +389,7 @@ static void sata_dwc_tf_dump(struct ata_taskfile *t=
f)
 /*
  * Function: get_burst_length_encode
  * arguments: datalength: length in bytes of data
- * returns value to be programmed in register corrresponding to data l=
ength
+ * returns value to be programmed in register corresponding to data le=
ngth
  * This value is effectively the log(base 2) of the length
  */
 static  int get_burst_length_encode(int datalength)
