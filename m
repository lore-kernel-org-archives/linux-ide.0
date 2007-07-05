From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc7] libata: quirk IOMEGA ZIP 250 ATAPI FLOPPY
Date: Thu, 5 Jul 2007 12:31:31 +0900
Message-ID: <20070705033131.GW29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:54173 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074AbXGEDbg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 23:31:36 -0400
Received: by py-out-1112.google.com with SMTP id u77so4173699pyb
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 20:31:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, bruinjm@xs4all.nl, alan@lxorguk.ukuu.org.uk

The Zip 250 which chokes on MWDMA SET_XFERMODE sometimes have "Floppy"
appeneded to its model number.  Quirk it too.

  http://bugzilla.kernel.org/show_bug.cgi?id=8563

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Hans de Bruin <bruinjm@xs4all.nl>
---
It seems the Zip 250 mwdma failure on libata doesn't seem to be
libata's fault after all.  IDE also fails SET_XFERMODE on this drive
but IDE simply ignores the error and continues to operate in MWDMA
mode, so I guess we can remove the 'temporary fix' comment or add
another quirk type - ATA_HORKAGE_SETXFER_MAY_FAIL - and use it.

Anyways, for the time being, this should do.

 drivers/ata/libata-core.c |    2 ++
 1 file changed, 2 insertions(+)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3774,6 +3774,8 @@ static const struct ata_blacklist_entry 
 	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
 	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
 	{ "IOMEGA  ZIP 250       ATAPI", NULL,	ATA_HORKAGE_NODMA }, /* temporary fix */
+	{ "IOMEGA  ZIP 250       ATAPI       Floppy",
+				NULL,		ATA_HORKAGE_NODMA },
 
 	/* Weird ATAPI devices */
 	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
