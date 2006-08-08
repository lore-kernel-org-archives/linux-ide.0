From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Tue, 08 Aug 2006 14:18:55 +0800
Message-ID: <44D82CCF.8020705@tw.ibm.com>
References: <44D336EE.5000907@gmail.com> <44D36823.7020406@pobox.com> <44D37129.9030100@rtr.ca> <44D37519.1020908@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:11188 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751244AbWHHGTa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Aug 2006 02:19:30 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k786JBAT030619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Tue, 8 Aug 2006 02:19:11 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k786JBsN117484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 8 Aug 2006 00:19:11 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k786JALU010363
	for <linux-ide@vger.kernel.org>; Tue, 8 Aug 2006 00:19:11 -0600
In-Reply-To: <44D37519.1020908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
> 
>>
>> Is this "IDENTIFY using IRQs rather than polling" a newish feature?
>> Because I just don't see how it could work with the the existing
>> adma_intr_mmio routine --> that code is only correct for non-data
>> commands, and IDENTIFY definitely has data.
> 
> 
> IDENTIFY w/ IRQs came with Albert Lee's irq-pio which was merged into
> mainline together with new EH.
> 

Oops, pdc_adma.c was overlooked by the irq-pio patch.
Only HSM_ST_LAST interrupts should be delivered to this LLDD.
Could you please check if the attached patch helps?

--
albert

(Patch against mainline 2.6.18-rc4.)

--- linux-2.6.18-rc4/drivers/scsi/pdc_adma.c	2006-08-08 14:03:21.000000000 +0800
+++ linux-2.6.18-rc4-adma-poll/drivers/scsi/pdc_adma.c	2006-08-08 14:05:13.000000000 +0800
@@ -183,7 +183,8 @@ static struct ata_port_info adma_port_in
 	{
 		.sht		= &adma_ata_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO,
+				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x1f, /* udma0-4 */
 		.port_ops	= &adma_ata_ops,



