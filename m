From: perazim@portugalmail.pt
Subject: trouble with dvd writers on centos 5.2
Date: Tue,  9 Sep 2008 14:45:13 +0100
Message-ID: <1220967913.48c67de92647c@gold6.portugalmail.pt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gandalf.portugalmail.pt ([195.245.179.74]:42391 "EHLO
	gandalf.portugalmail.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYIIOEJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 10:04:09 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Fresh install of centos 5.1. Installed updates so if I read docs correctly, I really have 5.2 now. Kernel is 2.6.18-92.1.10.el5. Hardware is P4 with 7 sony 170C pata dvd writers. (Before you ask, I am not copying movies) Hard drive is hda. First writer is hdc on mainboard. There are three Kouwell 571-B dual pata pci controllers each connected to two of the remaining six writers with 80 conductor cables. These controllers are flashed with the most recent firmware. Writers are at hdc, hde, hdg, hdi, hdk, hdm, hdo. This is known good hardware and ran fine under fedora7. System appears to lockup for five to ten seconds every minute or so. Mouse and keyboard become inoperative. Looked in the system log and found this:
.........
Sep 2 16:57:01 server kernel: hdk: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.
Sep 2 16:57:21 server kernel: hde: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.
Sep 2 16:57:26 server kernel: hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Sep 2 16:57:26 server kernel: ide: failed opcode was: unknown
Sep 2 16:57:26 server kernel: hde: drive not ready for command
Sep 2 16:57:26 server kernel: hde: status timeout: status=0xd8 { Busy }
Sep 2 16:57:26 server kernel: ide: failed opcode was: unknown
Sep 2 16:57:26 server kernel: hde: drive not ready for command
Sep 2 16:57:27 server kernel: hde: ATAPI reset complete
Sep 2 16:57:30 server kernel: hdi: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.
Sep 2 16:57:34 server kernel: hdi: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.
Sep 2 16:57:48 server kernel: hdk: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.
Sep 2 16:57:48 server kernel: hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Sep 2 16:57:48 server kernel: ide: failed opcode was: unknown
Sep 2 16:57:48 server kernel: hdk: drive not ready for command
Sep 2 16:57:48 server kernel: hdk: status timeout: status=0xd8 { Busy }
Sep 2 16:57:48 server kernel: ide: failed opcode was: unknown
Sep 2 16:57:48 server kernel: hdk: drive not ready for command
Sep 2 16:57:48 server kernel: hdk: ATAPI reset complete
Sep 2 16:59:10 server kernel: hdg: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.
Sep 2 16:59:28 server kernel: hdg: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.
Sep 2 17:00:26 server kernel: hde: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.

Have posted this to the centos list a week ago but no reply's.

I know this is now an old kernel but I am trying to get something stable that doesn't require an upgrade every year.

Thanks,

Yossi

-- 
