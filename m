From: Farkas Levente <lfarkas@bppiac.hu>
Subject: sata kernel problems, hang for 40 sec
Date: Wed, 18 Jul 2007 17:09:17 +0200
Message-ID: <469E2D1D.6060303@bppiac.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from portal.bppiac.hu ([213.253.216.130]:39710 "EHLO
	portal.bppiac.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbXGRP3T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 11:29:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi,
we regularly (about once a day) got such messages in the log file.
during this period (about 40 sec) the whole system hangs and it seems
nothing is working on the server. we already try replace the sate cables
update the firmware but nothing helps. there are 6 sata disk in the
server and the strange thing that different disk fail (so it's not the
problem with the disk itself, we already run test on disk too).
the same system runs without problem with rhel 4, this only happened
after upgrading to rhel 5, kernel-2.6.18-8.1.8.el5,
anybody has any tip?

SCSI subsystem initialized
libata version 2.00 loaded.
sata_sil24 0000:05:00.0: version 0.3

and the error:
-------------------------------------------------
Jul 17 13:31:58 piros kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Jul 17 13:31:58 piros kernel: ata4.00: tag 0 cmd 0xea Emask 0x4 stat
0x40 err 0x0 (timeout)
Jul 17 13:31:59 piros kernel: ata4: soft resetting port
Jul 17 13:32:01 piros kernel: ata4: softreset failed (1st FIS failed)
Jul 17 13:32:01 piros kernel: ata4: softreset failed, retrying in 5 secs
Jul 17 13:32:06 piros kernel: ata4: hard resetting port
Jul 17 13:32:14 piros kernel: ata4: port is slow to respond, this delay
is known to occur on vacant SATA ports
Jul 17 13:32:37 piros kernel: ata4: port failed to respond (30 secs)
Jul 17 13:32:37 piros kernel: ata4: COMRESET failed (device not ready)
Jul 17 13:32:37 piros kernel: ata4: hardreset failed, retrying in 5 secs
Jul 17 13:32:42 piros kernel: ata4: hard resetting port
Jul 17 13:32:42 piros kernel: ata4: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Jul 17 13:32:42 piros kernel: ata4.00: configured for UDMA/133
Jul 17 13:32:42 piros kernel: ata4: EH complete
Jul 17 13:32:42 piros kernel: SCSI device sdd: 488397168 512-byte hdwr
sectors (250059 MB)
Jul 17 13:32:42 piros kernel: sdd: Write Protect is off
Jul 17 13:32:42 piros kernel: SCSI device sdd: drive cache: write back
-------------------------------------------------

-- 
  Levente                               "Si vis pacem para bellum!"

