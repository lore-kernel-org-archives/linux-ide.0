From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: PATCH/RFC libata-2.6 5/5] Odd request buffer length handling
 in __atapi_pio_bytes()
Date: Tue, 29 Mar 2005 20:57:29 +0800
Message-ID: <424950B9.4030800@tw.ibm.com>
References: <423A905F.1030400@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080704090603020103010400"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:53229 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262282AbVC2M57 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Mar 2005 07:57:59 -0500
In-Reply-To: <423A905F.1030400@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080704090603020103010400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Resubmit since the offset changed by patch 4/5.
Also changed printk() in previous patch to DPRINTK().

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------
--- libata-2.6-extrabytes/drivers/scsi/libata-core.c	2005-03-29 20:23:24.000000000 +0800
+++ libata-2.6-odd/drivers/scsi/libata-core.c	2005-03-29 20:51:52.000000000 +0800
@@ -2370,6 +2370,13 @@
  	/* don't cross page boundaries */
  	count = min(count, (unsigned int)PAGE_SIZE - offset);

+	/* handle the odd condition */
+	if (unlikely(count & 0x01)) {
+		DPRINTK("ata%u: odd count %u rounded: qc->nbytes %u, bytes %u\n",
+			ap->id, count, qc->nbytes, bytes);
+		count++;
+	}
+
  	buf = kmap(page) + offset;

  	qc->curbytes += count;


--------------080704090603020103010400
Content-Type: text/plain;
 name="oddbuffer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oddbuffer.diff"

--- libata-2.6-extrabytes/drivers/scsi/libata-core.c	2005-03-29 20:23:24.000000000 +0800
+++ libata-2.6-odd/drivers/scsi/libata-core.c	2005-03-29 20:51:52.000000000 +0800
@@ -2370,6 +2370,13 @@
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
+	/* handle the odd condition */
+	if (unlikely(count & 0x01)) {
+		DPRINTK("ata%u: odd count %u rounded: qc->nbytes %u, bytes %u\n", 
+			ap->id, count, qc->nbytes, bytes);
+		count++;
+	}
+
 	buf = kmap(page) + offset;
 
 	qc->curbytes += count;

--------------080704090603020103010400--


