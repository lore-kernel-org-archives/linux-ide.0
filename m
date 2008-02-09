From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/9] libata: normalize port_info, port_operations and
 sht tables
Date: Sat, 09 Feb 2008 15:53:35 +0900
Message-ID: <47AD4DEF.2070001@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>	<12016853433225-git-send-email-htejun@gmail.com> <20080204142450.38478f70@core> <47AD442C.1030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:8159 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbYBIGxo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 01:53:44 -0500
Received: by an-out-0708.google.com with SMTP id d31so970121and.103
        for <linux-ide@vger.kernel.org>; Fri, 08 Feb 2008 22:53:43 -0800 (PST)
In-Reply-To: <47AD442C.1030706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Tejun Heo wrote:
>>> * No reason to set ata_pci_default_filter() for PIO-only drivers.
>> and your patches add the calls for the CS5520 ?
>>
>>> diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
>>> index 972ed9f..5614e76 100644
>>> --- a/drivers/ata/pata_cs5520.c
>>> +++ b/drivers/ata/pata_cs5520.c
>>> @@ -160,6 +160,7 @@ static struct scsi_host_template cs5520_sht = {
>>>  static struct ata_port_operations cs5520_port_ops = {
>>>  	.set_piomode		= cs5520_set_piomode,
>>>  	.set_dmamode		= cs5520_set_dmamode,
>>> +	.mode_filter		= ata_pci_default_filter,
>> This case is wrong. CS5520 doesn't do DMA (just VDMA which we don't
>> support) and in addition doesn't use BAR4 so its not a generic PCI
>> controller and this is asking for trouble later.

Hmm... cs5520's vdma looks like BMDMA and behaves like one.  BMDMA
methods are used and, although it doesn't use BAR4, ioaddr->bmdma_addr
is initialized, so as long as libata SFF layer is concerned, it can be
considered a BMDMA controller.

Thanks.

-- 
tejun
