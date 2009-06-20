From: Christian Engelmayer <christian.engelmayer@frequentis.com>
Subject: [PATCH 1/1] ide: memory overrun in ide_get_identity_ioctl() on big
 endian machines using ioctl HDIO_OBSOLETE_IDENTITY
Date: Sun, 21 Jun 2009 00:04:23 +0200
Message-ID: <20090621000423.30c462d9@frequentis.com>
References: <20090619084105.4cdf78be@frequentis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.frequentis.com ([213.47.210.151]:30586 "EHLO
	webmail.frequentis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbZFTWEc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jun 2009 18:04:32 -0400
In-Reply-To: <20090619084105.4cdf78be@frequentis.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, hancockrwd@gmail.com
Cc: christian.engelmayer@frequentis.com, linux-ide@vger.kernel.org

From: Christian Engelmayer <christian.engelmayer@frequentis.com>

This patch fixes a memory overrun in function ide_get_identity_ioctl() which
chooses the size of a memory buffer depending on the ioctl command that led
to the function call, however, passes that buffer to a function which needs the
buffer size to be always chosen unconditionally.

Due to conditional compilation the memory overrun can only happen on big endian
machines. The error can be triggered using ioctl HDIO_OBSOLETE_IDENTITY. Usage
of ioctl HDIO_GET_IDENTITY is safe.

Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
--
Proposed patch after comment by Robert Hancock who shares the view that buffer
'id' should be allocated unconditionally.

--- drivers/ide/ide-ioctls.c.orig	2009-06-20 23:22:45.000000000 +0200
+++ drivers/ide/ide-ioctls.c	2009-06-20 23:30:21.000000000 +0200
@@ -64,7 +64,8 @@ static int ide_get_identity_ioctl(ide_dr
 		goto out;
 	}
 
-	id = kmalloc(size, GFP_KERNEL);
+	/* ata_id_to_hd_driveid() relies on 'id' to be fully allocated. */
+	id = kmalloc(ATA_ID_WORDS * 2, GFP_KERNEL);
 	if (id == NULL) {
 		rc = -ENOMEM;
 		goto out;
