From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/4] libata: reorder HSM_ST_FIRST for easier decoding
Date: Sat, 31 Mar 2007 16:04:45 +0800
Message-ID: <460E161D.9020108@tw.ibm.com>
References: <460E1586.2000603@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:32921 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbXCaIEy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 04:04:54 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2V84ruO009753
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 04:04:53 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2V84rbX085402
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 02:04:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2V84qXj014202
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 02:04:53 -0600
In-Reply-To: <460E1586.2000603@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, Linux IDE <linux-ide@vger.kernel.org>

patch 1/4:
  Reorder HSM_ST_FIRST, such that the task state transition is easier decoded with human eyes.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Patch against libata-dev tree, for your review, thanks.

diff -Nrup 00_libata-dev.ori/include/linux/libata.h 01_hsm_st/include/linux/libata.h
--- 00_libata-dev.ori/include/linux/libata.h	2007-03-23 16:56:24.000000000 +0800
+++ 01_hsm_st/include/linux/libata.h	2007-03-26 12:33:28.000000000 +0800
@@ -315,11 +315,11 @@ enum {
 
 enum hsm_task_states {
 	HSM_ST_IDLE,		/* no command on going */
+	HSM_ST_FIRST,		/* (waiting the device to)
+				   write CDB or first data block */
 	HSM_ST,			/* (waiting the device to) transfer data */
 	HSM_ST_LAST,		/* (waiting the device to) complete command */
 	HSM_ST_ERR,		/* error */
-	HSM_ST_FIRST,		/* (waiting the device to)
-				   write CDB or first data block */
 };
 
 enum ata_completion_errors {


