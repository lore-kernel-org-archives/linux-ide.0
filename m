From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] scsi: align shost->hostdata to cacheline
Date: Thu, 14 Feb 2008 18:48:01 +0900
Message-ID: <47B40E51.3060002@gmail.com>
References: <20080212180254.GA28237@postdiluvian.org>	<20080212221257.12eeab13@core>	<20080213184702.GA13458@postdiluvian.org>	<20080213202151.34b7e5bc@core>	<20080213212549.GA14732@postdiluvian.org> <20080214002135.065dd322@core> <47B3AFDC.5040605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:42354 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbYBNJsL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 04:48:11 -0500
Received: by el-out-1112.google.com with SMTP id v27so319010ele.23
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 01:48:08 -0800 (PST)
In-Reply-To: <47B3AFDC.5040605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Mason <mason@postdiluvian.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com, Jens Axboe <jens.axboe@oracle.com>

shost->hostdata can contain arbitrary data including DMA target
buffers.  Align it to cacheline.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
James, what do you think?

 include/scsi/scsi_host.h |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 5c58d59..3876d24 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -663,12 +663,10 @@ struct Scsi_Host {
 	void *shost_data;
 
 	/*
-	 * We should ensure that this is aligned, both for better performance
-	 * and also because some compilers (m68k) don't automatically force
-	 * alignment to a long boundary.
+	 * Used for storage of host specific stuff.  As it may contain
+	 * arbitrary data, align it to cacheline.
 	 */
-	unsigned long hostdata[0]  /* Used for storage of host specific stuff */
-		__attribute__ ((aligned (sizeof(unsigned long))));
+	unsigned long hostdata[0] ____cacheline_aligned;
 };
 
 #define		class_to_shost(d)	\
