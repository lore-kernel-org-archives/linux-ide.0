From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: Celleb cannot exit from ata_host_intr()
Date: Mon, 22 Jan 2007 11:48:31 +0900
Message-ID: <200701220248.l0M2m9eH007098@toshiba.co.jp>
References: <200701180652.l0I6qKSE018982@toshiba.co.jp>
 <45B0A203.1090508@tw.ibm.com>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:49635 "EHLO
	inet-tsb5.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbXAVCsQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Jan 2007 21:48:16 -0500
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0M2mE52010940
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 11:48:14 +0900 (JST)
Received: (from root@localhost)
	by tsb-wall.toshiba.co.jp  id l0M2mE6H013003
	for linux-ide@vger.kernel.org; Mon, 22 Jan 2007 11:48:14 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0M2mCRB006356
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 11:48:12 +0900 (JST)
In-Reply-To: (Your message of "Fri, 19 Jan 2007 18:48:35 +0800")
  <45B0A203.1090508@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org, kou.ishizaki@toshiba.co.jp

Hi, Albert-san,

Thank you for your comment.

>Albert Lee wrote:
>This check is needed to make sure it is "my irq". Otherwise we might
>- incorrectly stop BMDMA if another PCI adapter raise the same shared irq 
>- incorrectly read ALT_STATUS when DD0-DD15 being used for DMA transfer

I understood the meaning of this check.

>Is the irq of Celleb IDE shared with other adapters?
>If the irq is non-shared, could you check if the following code works
>for Celleb:
>
>			/* if it's not our irq... */
>			if ((host_stat & ATA_DMA_ACTIVE) &&
>			    !(host_stat & ATA_DMA_INTR))
>				goto idle_irq;

My irq is non-shared, but above code doesn't work.
I got the following register values at this point:
- DMA_STATUS = 0x01 (ATA_DMA_ACTIVE is 1)
- ALT_STATUS = 0x51 (ERR is 1)

Now I think I should handle this problem in my bmdma_status() hook
because it is a device specific problem.
I intend to emulate ATA_DMA_INTR if the following conditions are true:
- In ISR
- ALT_STATUS[ERR] = 1
- DMA_STATUS[DMA_ACTIVE] = 1


Best regards,
Akira iguchi
