From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Celleb cannot exit from ata_host_intr()
Date: Mon, 22 Jan 2007 15:58:44 +0800
Message-ID: <45B46EB4.8080004@tw.ibm.com>
References: <200701180652.l0I6qKSE018982@toshiba.co.jp> <45B0A203.1090508@tw.ibm.com> <200701220248.l0M2m9r4016903@toshiba.co.jp>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:51339 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbXAVH6t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 02:58:49 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0M7wnp8014966
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 02:58:49 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0M7wnm0406202
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 00:58:49 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0M7wmfB012159
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 00:58:48 -0700
In-Reply-To: <200701220248.l0M2m9r4016903@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: albertl@mail.com, linux-ide@vger.kernel.org, kou.ishizaki@toshiba.co.jp

Hi Iguchi-san,

> 
> 
>>Is the irq of Celleb IDE shared with other adapters?
>>If the irq is non-shared, could you check if the following code works
>>for Celleb:
>>
>>			/* if it's not our irq... */
>>			if ((host_stat & ATA_DMA_ACTIVE) &&
>>			    !(host_stat & ATA_DMA_INTR))
>>				goto idle_irq;
> 
> 
> My irq is non-shared, but above code doesn't work.
> I got the following register values at this point:
> - DMA_STATUS = 0x01 (ATA_DMA_ACTIVE is 1)
> - ALT_STATUS = 0x51 (ERR is 1)

Ah, I see, so the adapter thinks BMDMA is still active. :(
Wonder whether this behavior would be related to CD-ROM drive...
i.e. Does it possibly work ok with other CD-ROM models?

> 
> Now I think I should handle this problem in my bmdma_status() hook
> because it is a device specific problem.
> I intend to emulate ATA_DMA_INTR if the following conditions are true:
> - In ISR
> - ALT_STATUS[ERR] = 1
> - DMA_STATUS[DMA_ACTIVE] = 1
> 
> 

Some controller like Promise 2027x has an extra register/bit for INTRQ.
Don't know whether Celleb has such hardware bit or not. If do, maybe
such bit can be also used as substitute for bmdma:INTR.

--
albert


