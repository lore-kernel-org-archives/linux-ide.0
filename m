From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/3] libata: remove unneeded ata_altstatus() from ata_hsm_qc_complete()
Date: Tue, 05 Jun 2007 11:46:57 +0800
Message-ID: <4664DCB1.9040908@tw.ibm.com>
References: <4664DB99.8010202@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:35211 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbXFEDrA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2007 23:47:00 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l553kxJ5020608
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 23:46:59 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l553kxPA188300
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 21:46:59 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l553kwrp008443
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 21:46:59 -0600
In-Reply-To: <4664DB99.8010202@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Patch 1/3:
In ata_hsm_qc_complete():
Calling ata_altstatus() after the qc completed looks wrong.
Remove it.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
After checking, it is leftover of ata_pio_block( ) in 2.6.17-rc5 of the following merge:
http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commitdiff;h=bb31a8faa270beafcc51a65880c5564c6b718bd6
We can safely remove it.

diff -Nrup 00_libata-dev/drivers/ata/libata-core.c 01_remove_bad_flush/drivers/ata/libata-core.c
--- 00_libata-dev/drivers/ata/libata-core.c	2007-06-01 12:08:21.000000000 +0800
+++ 01_remove_bad_flush/drivers/ata/libata-core.c	2007-06-04 18:10:43.000000000 +0800
@@ -4782,8 +4782,6 @@ static void ata_hsm_qc_complete(struct a
 		} else
 			ata_qc_complete(qc);
 	}
-
-	ata_altstatus(ap); /* flush */
 }
 
 /**


