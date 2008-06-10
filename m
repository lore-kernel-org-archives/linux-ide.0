From: MisterE <MisterE2002@zonnet.nl>
Subject: Promise SATA300 TX4
Date: Tue, 10 Jun 2008 23:11:40 +0200
Message-ID: <1067206692.20080610231140@zonnet.nl>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from node01.cambriumhosting.nl ([217.19.16.162]:41235 "EHLO
	node01.cambriumhosting.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757710AbYFJVbl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 17:31:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, Alexander Sabourenkov <screwdriver@lxnt.info>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

A long while ago we had contact about corruption with this
controller. Then you people found the ASIC PRD bug.

When the 2.6.24 kernel was released i made a custom version for my
debian fileserver. It's now running for a while without real problems.

But now and then i get a message in my log which concerns me. I can't
reproduce them but mass actions (copy, move, delete, etc.) does not
seem to cause it.

Example:


Mar 24 14:27:59 fileserver -- MARK --
Mar 24 14:47:59 fileserver -- MARK --
Mar 24 15:07:59 fileserver -- MARK --
Mar 24 15:22:59 fileserver kernel:          res 50/00:00:3e:3f:db/00:00:2a:00:00/e0 Emask 0x2 (HSM violation)
Mar 24 15:22:59 fileserver kernel: ata1: soft resetting link
Mar 24 15:22:59 fileserver kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 24 15:22:59 fileserver kernel: ata1.00: configured for UDMA/133
Mar 24 15:22:59 fileserver kernel: ata1: EH complete
Mar 24 15:22:59 fileserver kernel: sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
Mar 24 15:22:59 fileserver kernel: sd 0:0:0:0: [sda] Write Protect is off
Mar 24 15:22:59 fileserver kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 24 15:47:59 fileserver -- MARK --
Mar 24 16:07:59 fileserver -- MARK --
Mar 24 16:28:00 fileserver -- MARK --

May 25 17:00:19 fileserver -- MARK --
May 25 17:20:19 fileserver -- MARK --
May 25 17:23:33 fileserver kernel:          res 50/00:00:3e:73:ea/00:00:21:00:00/e0 Emask 0x2 (HSM violation)
May 25 17:23:34 fileserver kernel: ata1: soft resetting link
May 25 17:23:34 fileserver kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
May 25 17:23:34 fileserver kernel: ata1.00: configured for UDMA/133
May 25 17:23:34 fileserver kernel: ata1: EH complete
May 25 17:23:34 fileserver kernel: sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
May 25 17:23:34 fileserver kernel: sd 0:0:0:0: [sda] Write Protect is off
May 25 17:23:34 fileserver kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 25 17:40:19 fileserver -- MARK --
May 25 18:00:19 fileserver -- MARK --
May 25 18:20:19 fileserver -- MARK --
May 25 18:40:19 fileserver -- MARK --

Jun  8 21:15:46 fileserver -- MARK --
Jun  8 21:35:46 fileserver -- MARK --
Jun  8 21:55:05 fileserver kernel:          res 50/00:00:be:26:ae/00:00:19:00:00/e0 Emask 0x2 (HSM violation)
Jun  8 21:55:06 fileserver kernel: ata2: soft resetting link
Jun  8 21:55:06 fileserver kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun  8 21:55:06 fileserver kernel: ata2.00: configured for UDMA/133
Jun  8 21:55:06 fileserver kernel: ata2: EH complete
Jun  8 21:55:06 fileserver kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Jun  8 21:55:06 fileserver kernel: sd 1:0:0:0: [sdb] Write Protect is off
Jun  8 21:55:06 fileserver kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Maybe you can explain it?
Thanks in advance.
  

-- 
Best regards,
 MisterE                          mailto:MisterE2002@zonnet.nl

