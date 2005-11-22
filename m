From: y3kniceday <y3kniceday@tin.it>
Subject: vt8251 patch= dma works
Date: Tue, 22 Nov 2005 18:26:07 +0000 (UTC)
Message-ID: <loom.20051122T191414-917@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:33510 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030347AbVKWJxv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Nov 2005 04:53:51 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EerI3-0005EE-IE
	for linux-ide@vger.kernel.org; Wed, 23 Nov 2005 10:51:50 +0100
Received: from ppp-62-11-133-31.dialup.tiscali.it ([62.11.133.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2005 10:51:46 +0100
Received: from y3kniceday by ppp-62-11-133-31.dialup.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2005 10:51:46 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

DMA works with this patch on kernel 2.6.12.4 but sata don't works!
dmesg says:
libata version 1.11 loaded.
sata_via version 1.1
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xEC0A bmdma 0xE400 irq 10
ata2: SATA max UDMA/133 cmd 0xE880 ctl 0xE88A bmdma 0xE408 irq 10
ata1: no device found (phy stat 00200008)
scsi0 : sata_via
ata2: no device found (phy stat ffffffff)
scsi1 : sata_via

and i have an hd on ata1. 

patch:
http://prcsanmarco.altervista.org/dma-sata.diff

