From: mikep <mikpolniak@adelphia.net>
Subject: DMA timeout with kernel-2.6.6-rc3 + SCSI_SATA_SIL
Date: Mon, 03 May 2004 11:44:50 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <c75pdj$1ge$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:23734 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263763AbUECQAy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 May 2004 12:00:54 -0400
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BKfsD-00063Y-00
	for <linux-ide@vger.kernel.org>; Mon, 03 May 2004 18:00:53 +0200
Received: from 69-161-69-17.bflony.adelphia.net ([69.161.69.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 03 May 2004 18:00:53 +0200
Received: from mikpolniak by 69-161-69-17.bflony.adelphia.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 03 May 2004 18:00:53 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Using ASUS A7n8X m/b with SIL3112 and Raptor hard drive. This works with 
the BLK_DEV_SIIMAGE driver but with SCSI_SATA_SIL driver it hangs at 
boot message:

.......
SCSI device sda: drive cache : write through
/dev/scsi/host0/bus0/target0/lun0:<3>ata1: DMA timeout, stat 0x4
p1 p2 p3 p4<

As this is my first try with the SCSI driver, what am i missing?

