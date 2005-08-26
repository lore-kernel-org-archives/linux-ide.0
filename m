From: Alexander Shaposhnikov <shaposh@isp.nsc.ru>
Subject: RE :sata_sil + UDMA CRC errors
Date: Fri, 26 Aug 2005 11:41:27 +0700
Message-ID: <1125031287.2477.15.camel@m00>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.isp.nsc.ru ([194.226.178.19]:24457 "EHLO ns.isp.nsc.ru")
	by vger.kernel.org with ESMTP id S1751503AbVHZEl2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2005 00:41:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: TeJun Heo <htejun@gmail.com>, Paul Taylor <Paul.Taylor@siliconimage.com>, Yuri Kirsanov <flash@rccb.ru>, "Carlos.Pardo@siliconimage.com" <Carlos.Pardo@siliconimage.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "lbattraw@insightbb.com" <lbattraw@insightbb.com>

I can reproducibly hang the system by copying alot of files (some
several gigs) to some directory and than making "sync". It hangs with
the repeated messages :

Aug 22 04:18:11 m00 kernel: ata4: command 0x35 timeout, stat 0xd1
host_stat 0x1
Aug 22 04:18:11 m00 kernel: ata4: status=0xd1 { Busy }
Aug 22 04:18:11 m00 kernel: SCSI error : <3 0 0 0> return code =
0x8000002
Aug 22 04:18:11 m00 kernel: sdb: Current: sense key: Aborted Command
Aug 22 04:18:11 m00 kernel:     Additional sense: Scsi parity error
Aug 22 04:18:11 m00 kernel: end_request: I/O error, dev sdb, sector
22213847
Aug 22 04:18:11 m00 kernel: ATA: abnormal status 0xD1 on port
0xFFFFC200000042C7
Aug 22 04:18:11 m00 last message repeated 2 times



