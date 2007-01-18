From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Celleb cannot exit from ata_host_intr()
Date: Thu, 18 Jan 2007 15:52:33 +0900
Message-ID: <200701180652.l0I6qKSE018982@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132]:63286 "EHLO
	imx12.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXARGwX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jan 2007 01:52:23 -0500
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0I6qLC2003591
	for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 15:52:21 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l0I6qLxR018920
	for linux-ide@vger.kernel.org; Thu, 18 Jan 2007 15:52:21 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0I6qKgk013878
	for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 15:52:20 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kou.ishizaki@toshiba.co.jp

Hi,

I have a problem that our hardware (Celleb) cannot exit from
ata_host_intr() when ATAPI DMA data read fails.

This PATA controller sets bit2 (ATA_DMA_INTR) of BMDMA status register
after it finished DMA data read. If ATAPI DMA data read fails
due to no CDROM, it doesn't transfer data and generates an interrupt.
In this case, bit2 of BMDMA status register is not set.

libata ISR (ata_host_intr()) checks this bit by the following code:

			/* if it's not our irq... */
			if (!(host_stat & ATA_DMA_INTR))
				goto idle_irq;


Our driver always hits this check. As a result, ISR loops forever.
I temporarily use libata by removing this check.

I wonder if this check is necessary. In drivers/ide, cdrom_decode_status()
seems to check IDE STATUS register instead of BMDMA status register.
If there is no problem, I hope this check will be removed.

Best regards,
Akira Iguchi
