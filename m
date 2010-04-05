From: Tejun Heo <tj@kernel.org>
Subject: [PATCH upstream-fixes] libata: disable NCQ on Crucial C300 SSD
Date: Mon, 05 Apr 2010 10:51:26 +0900
Message-ID: <4BB9421E.9050007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36118 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab0DEBvv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Apr 2010 21:51:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lethalwp@scarlet.be, Luke Macken <lmacken@redhat.com>

Crucial said,

  Thank you for contacting us. We know that with our M225 line of SSDs
  you sometimes need to disable NCQ (native command queuing) to avoid
  just the type of errors you're seeing. Our recommendation for the
  M225 is to add libata.force=3Dnoncq to your Linux kernel boot options=
,
  under the kernel ATA library option.

  I have sent your feedback to the engineers working on the C300, and
  asked them to please pass it on to the firmware team. I have been
  notified that they are in the process of testing and finalizing a
  new firmware version, that you can expect to see released around the
  end of April. We=92ll keep you posted as to when it will be available
  for download.

So, turn off NCQ on the drive w/ the current firmware revision.

Reported in the following bug.

  https://bugzilla.kernel.org/show_bug.cgi?id=3D15573

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: lethalwp@scarlet.be
Reported-by: Luke Macken <lmacken@redhat.com>
---
 drivers/ata/libata-core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4a28420..c3076d4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4353,6 +4353,9 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
 	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },

+	/* https://bugzilla.kernel.org/show_bug.cgi?id=3D15573 */
+	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },
+
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
 	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
