From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 5/7] libata: integrate freeze/thaw with irq_on/off
Date: Mon, 16 Jul 2007 17:17:38 +0800
Message-ID: <469B37B2.5080500@tw.ibm.com>
References: <468F3949.5050800@tw.ibm.com> <468F3CE2.9080709@tw.ibm.com> <469720F1.3000907@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:60590 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbXGPJRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:17:44 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6G9HhA8011281
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 05:17:43 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6G9HhDC254012
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 03:17:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6G9HgqW014912
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 03:17:43 -0600
In-Reply-To: <469720F1.3000907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello,
> 
> 
>>+void ata_irq_on(struct ata_port *ap)
>> {
>> 	struct ata_ioports *ioaddr = &ap->ioaddr;
>>-	u8 tmp;
>> 
>> 	ap->ctl &= ~ATA_NIEN;
>> 	ap->last_ctl = ap->ctl;
>> 
>> 	iowrite8(ap->ctl, ioaddr->ctl_addr);
>>-	tmp = ata_wait_idle(ap);
>>+	ata_wait_idle(ap);
>> 
>> 	ap->ops->irq_clear(ap);
>>-
>>-	return tmp;
>> }
> 
> 
> Missing ata_chk_status() before clearing ATA_NIEN seems a bit dangerous
> to me.
> 

Will fix it in next revision. Thanks for the advice.
--
albert

