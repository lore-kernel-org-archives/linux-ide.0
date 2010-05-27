From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH]: ata: fix unused variable warning in sil_host_intr()
Date: Thu, 27 May 2010 13:35:16 -0400
Message-ID: <20100527173114.23427.67952.sendpatchset@prarit.bos.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31388 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482Ab0E0RfS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 May 2010 13:35:18 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o4RHZH6S019165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Thu, 27 May 2010 13:35:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com
Cc: Prarit Bhargava <prarit@redhat.com>

Warning seen with 'make -j24 CONFIG_DEBUG_SECTION_MISMATCH=3Dy':

drivers/ata/sata_sil.c: In function =E2=80=98sil_host_intr=E2=80=99:
drivers/ata/sata_sil.c:442: error: =E2=80=98serror=E2=80=99 may be used=
 uninitialized in this function

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3cb69d5..d7c616c 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -439,7 +439,7 @@ static void sil_host_intr(struct ata_port *ap, u32 =
bmdma2)
 	u8 status;
=20
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
-		u32 serror;
+		u32 uninitialized_var(serror);
=20
 		/* SIEN doesn't mask SATA IRQs on some 3112s.  Those
 		 * controllers continue to assert IRQ as long as

