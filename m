From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Celleb cannot exit from ata_host_intr()
Date: Fri, 19 Jan 2007 18:48:35 +0800
Message-ID: <45B0A203.1090508@tw.ibm.com>
References: <200701180652.l0I6qKSE018982@toshiba.co.jp>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:42802 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965044AbXASKsy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jan 2007 05:48:54 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0JAlQY6031448
	for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2007 05:47:26 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0JAmq8O540270
	for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2007 03:48:52 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0JAmqUF014441
	for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2007 03:48:52 -0700
In-Reply-To: <200701180652.l0I6qKSE018982@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, kou.ishizaki@toshiba.co.jp

Akira Iguchi wrote:
> 
> I have a problem that our hardware (Celleb) cannot exit from
> ata_host_intr() when ATAPI DMA data read fails.
> 
> This PATA controller sets bit2 (ATA_DMA_INTR) of BMDMA status register
> after it finished DMA data read. If ATAPI DMA data read fails
> due to no CDROM, it doesn't transfer data and generates an interrupt.
> In this case, bit2 of BMDMA status register is not set.

This behavior is different from other adapters. For other adapters,
ATA_DMA_INTR bit of BMDMA status is set whenever the drive raises INTRQ.

> 
> libata ISR (ata_host_intr()) checks this bit by the following code:
> 
> 			/* if it's not our irq... */
> 			if (!(host_stat & ATA_DMA_INTR))
> 				goto idle_irq;
> 
> 
> Our driver always hits this check. As a result, ISR loops forever.
> I temporarily use libata by removing this check.
> 
> I wonder if this check is necessary. In drivers/ide, cdrom_decode_status()
> seems to check IDE STATUS register instead of BMDMA status register.
> If there is no problem, I hope this check will be removed.
> 

This check is needed to make sure it is "my irq". Otherwise we might
- incorrectly stop BMDMA if another PCI adapter raise the same shared irq 
- incorrectly read ALT_STATUS when DD0-DD15 being used for DMA transfer

Is the irq of Celleb IDE shared with other adapters?
If the irq is non-shared, could you check if the following code works
for Celleb:

			/* if it's not our irq... */
			if ((host_stat & ATA_DMA_ACTIVE) &&
			    !(host_stat & ATA_DMA_INTR))
				goto idle_irq;


--
albert


