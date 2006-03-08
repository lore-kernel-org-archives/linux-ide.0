From: Chisato Yamauchi <cyamauch@plamo.linet.gr.jp>
Subject: [PATCH] fix too short span of sil24_issue_SRST() loop to reset
 non-native hard drives
Date: Wed, 08 Mar 2006 14:33:06 +0900 (JST)
Message-ID: <20060308.143306.74747174.cyamauch@plamo.linet.gr.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from PPPbf446.hyogo-ip.dti.ne.jp ([210.170.214.196]:48141 "EHLO
	plamo.linet.gr.jp") by vger.kernel.org with ESMTP id S1750832AbWCHFfi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Mar 2006 00:35:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, htejun@gmail.com


  Hi,

  I use the ASI ARAID99 2000 connected with Sil3124 pci card.  
However, the Linux driver (sata_sil24.c) cannot finish phy_reset.
The dmesg is displayed as follows:

========
ata1: SRST failed, disabling port
========

and ...

========
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
sata_sil24: interrupt form disabled port 0
irq XX: nobody cared (try booting with the "irqpoll" option)
========

  This problem is fixed by this patch;  the span of loop
in sil24_issue_SRST() is too short to reset non-native hard
drive like my RAID subsystem.

*** drivers/scsi/sata_sil24.c._orig_	2006-03-02 07:37:27.000000000 +0900
--- drivers/scsi/sata_sil24.c	2006-03-05 21:22:44.000000000 +0900
***************
*** 452,458 ****
  
  	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
  
! 	for (cnt = 0; cnt < 100; cnt++) {
  		irq_stat = readl(port + PORT_IRQ_STAT);
  		writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
  
--- 493,499 ----
  
  	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
  
! 	for (cnt = 0; cnt < 1000; cnt++) {
  		irq_stat = readl(port + PORT_IRQ_STAT);
  		writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
  
***************
*** 460,466 ****
  		if (irq_stat & (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR))
  			break;
  
! 		msleep(1);
  	}
  
  	/* restore IRQs */
--- 501,507 ----
  		if (irq_stat & (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR))
  			break;
  
! 		msleep(10);
  	}
  
  	/* restore IRQs */



==  Chisato Yamauchi  =================================
