From: kenneth johansson <ken@kenjo.org>
Subject: reenable DMA
Date: Thu, 30 Oct 2008 21:54:09 +0000 (UTC)
Message-ID: <gedae1$ari$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36368 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbYJ3XpE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Oct 2008 19:45:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KvhCJ-0004zX-2G
	for linux-ide@vger.kernel.org; Thu, 30 Oct 2008 23:45:03 +0000
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 30 Oct 2008 23:45:03 +0000
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 30 Oct 2008 23:45:03 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a small problem where my DVD player got confused by a disk
and the ata driver ended up putting the driver in PIO mode. 

Now I need to get it back into DMA without rebooting the computer. 

 hdparm -d1 /dev/sr0

/dev/sr0:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Inappropriate ioctl for device
 HDIO_GET_DMA failed: Inappropriate ioctl for device
-------
 ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
 ata9.00: cmd a0/00:00:00:00:fc/00:00:00:00:00/a0 tag 0 pio 131072 in
          cdb 28 00 00 13 c6 4a 00 00  40 00 00 00 00 00 00 00
          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
 ata9.00: status: { DRDY }
 ata9: soft resetting link
 ata9.00: configured for PIO0
 ata9: EH complete

