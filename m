From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Tue, 14 Mar 2006 12:52:53 +0800
Message-ID: <44164C25.10106@tw.ibm.com>
References: <441525DB.40905@tw.ibm.com> <441528BD.8070708@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:57772 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750717AbWCNExL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 23:53:11 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2E4r5if003507
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 23:53:05 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2E4oFIS224400
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 21:50:15 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2E4r4Ot011432
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 21:53:04 -0700
In-Reply-To: <441528BD.8070708@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:

> 
> Applied, though I think its an open question what happens with
> CDB-interrupt ATAPI devices want to do DMA.  Perhaps we just get an
> interrupt event that we clear, then life proceeds as normal.

Not sure. I have no such device at hand for test; currently relying
on the SFF-8020i spec (http://www.bswd.com/sff8020i.pdf) as reference.
According to p.31, we have to send out the CDB after receiving
the CDB interrupt. So, just clearing the irq looks not enough.

> 
> Does anybody actually have such a device anywhere?  :)
> 

Maybe Alan or Mark knows? 

We really need tester for such device.
How about the attached patch?

---
Albert

--- 07_followup/drivers/scsi/libata-core.c	2006-03-13 16:25:52.000000000 +0800
+++ 08_need_tester/drivers/scsi/libata-core.c	2006-03-14 12:45:09.000000000 +0800
@@ -1294,8 +1294,12 @@ static int ata_dev_configure(struct ata_
 		}
 		dev->cdb_len = (unsigned int) rc;
 
-		if (ata_id_cdb_intr(dev->id))
+		if (ata_id_cdb_intr(dev->id)) {
 			dev->flags |= ATA_DFLAG_CDB_INTR;
+			printk(KERN_INFO "This ATAPI device generates CDB intr.\n"
+			       "Please send an email to linux-ide@vger.kernel.org\n"
+			       "if you are interested to help testing such device.\n");
+		}
 
 		/* print device info to dmesg */
 		if (print_info)


