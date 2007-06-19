From: Theo Baumgartner <tbaumgartner@swissonline.ch>
Subject: sata_promise error handling
Date: Tue, 19 Jun 2007 18:59:06 +0200
Message-ID: <200706191859.07050.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:44207 "EHLO
	viefep24-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751438AbXFSQ7W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2007 12:59:22 -0400
Received: from 77-56-252-80.dclient.hispeed.ch ([77.56.252.80])
          by viefep24-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20070619165919.KWSA12976.viefep24-int.chello.at@77-56-252-80.dclient.hispeed.ch>
          for <linux-ide@vger.kernel.org>; Tue, 19 Jun 2007 18:59:19 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

I'm making a backup of some disks with dd (disk image) and sata_promise reported these errors:

----------------------------------------------------------------------------------------------------------------------
ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata8.00: cmd c8/00:08:40:83:7a/00:00:00:00:00/e4 tag 0 cdb 0x0 data 4096 in
         res 50/00:00:47:83:7a/00:00:00:00:00/e4 Emask 0x1 (device error)
ata8.00: configured for UDMA/133
ata8: EH complete
sd 7:0:0:0: [sdh] 488397168 512-byte hardware sectors (250059 MB)
sd 7:0:0:0: [sdh] Write Protect is off
sd 7:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata5.00: cmd 25/00:08:e8:af:02/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
         res 50/00:00:ef:af:02/00:00:10:00:00/e0 Emask 0x1 (device error)
ata5.00: configured for UDMA/133
ata5: EH complete
sd 4:0:0:0: [sde] 488397168 512-byte hardware sectors (250059 MB)
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
----------------------------------------------------------------------------------------------------------------------

Can I ignore them (EH handled them) or do i have to worry that the dd images are corrupted
(don't wanna make an md5sum of a 250gb disk and image)?

Theo
