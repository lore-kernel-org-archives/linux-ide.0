From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata machine check on Alpha
Date: Thu, 06 Apr 2006 17:17:37 +0800
Message-ID: <4434DCB1.7010909@tw.ibm.com>
References: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com> <4431CF4D.6000806@gmail.com> <4431D5F5.4010905@tw.ibm.com> <r4p732p2j7rlui8umeqrq9hothsl79n3bo@4ax.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:64177 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932158AbWDFJRy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Apr 2006 05:17:54 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k369HmXA023432
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 05:17:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k369EROS185794
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 03:14:27 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k369Hl0b004444
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 03:17:48 -0600
In-Reply-To: <r4p732p2j7rlui8umeqrq9hothsl79n3bo@4ax.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Blake Benson <airbatica@verizon.net>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Doug Maxey <dwm@maxeymade.com>

Jonathan Blake Benson wrote:
 
> 
> Albert, enabling the ATAPI_ENABLE_DMADIR workaround did the trick.
> The DVD-ROM drive now works as it should.  Thanks again!
> 

Hi Jonathan,

Could you please give a try to the attached patch and post the content of word 62?
If word 62 + SiI 3611 looks good, we can turn on the DMADIR automatically. Thanks!

--
albert

--- upstream0/drivers/scsi/libata-core.c	2006-04-06 16:07:32.000000000 +0800
+++ upstream0-show/drivers/scsi/libata-core.c	2006-04-06 17:08:10.000000000 +0800
@@ -1322,6 +1322,9 @@ static int ata_dev_configure(struct ata_
 		}
 		dev->cdb_len = (unsigned int) rc;
 
+		printk(KERN_ERR "ata%u: dev %u word 62 [%x]\n",
+		       ap->id, dev->devno, id[62]);
+
 		/* print device info to dmesg */
 		if (print_info)
 			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",

