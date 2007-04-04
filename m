From: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>
Subject: CDROM errors fill logs (probably followup to earlier thread). Device reads and writes correctly.
Date: Wed, 4 Apr 2007 20:56:40 +0200
Message-ID: <200704042056.40918.Marcin.Kasperski@softax.com.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bozon2.softax.com.pl ([83.238.10.48]:34777 "EHLO
	bozon2.softax.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934069AbXDDTYS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2007 15:24:18 -0400
Received: from bozon2.softax.pl (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id E4FD9DC00D
	for <linux-ide@vger.kernel.org>; Wed,  4 Apr 2007 20:56:44 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id CEFAADC005
	for <linux-ide@vger.kernel.org>; Wed,  4 Apr 2007 20:56:44 +0200 (CEST)
Received: from bozon2.softax.com.pl ([127.0.0.1])
 by localhost (bozon2.softax.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08179-05 for <linux-ide@vger.kernel.org>;
 Wed,  4 Apr 2007 20:56:41 +0200 (CEST)
Received: from cauchy.softax.local (unknown [16.193.144.107])
	by bozon2.softax.com.pl (Postfix) with ESMTP id C8D5DDC00D
	for <linux-ide@vger.kernel.org>; Wed,  4 Apr 2007 20:56:41 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is probably followup to 
http://www.spinics.net/lists/linux-ide/msg09412.html
I post it first to confirm the problem, then because I am not sure whether the patch
handles everything I quote here.

Kernel 2.6.21-rc5 (2.6.18 behaved similarly).
Hardware: modern intel (dual core on gigabyte 965, HP DVD 940,
   dvd is the only IDE device, SATA hard drive is used in AHCI mode)

I observe plenty of CDROM-related errors in my logs, in spite of the fact that my 
CD/DVD device works correctly (at least, reads and writes correctly). 

Example errors:

Apr  3 11:22:34 cauchy kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest
}
Apr  3 11:22:34 cauchy kernel: ide: failed opcode was: unknown
Apr  3 11:22:34 cauchy kernel: hdb: drive not ready for command

   (those filled my logs until I disabled HAL cd monitoring and show from time to time)

Apr  4 13:12:00 cauchy kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Erro
r }
Apr  4 13:12:00 cauchy kernel: hdb: packet command error: error=0x54 { AbortedCommand LastFailedSens
e=0x05 }
Apr  4 13:12:00 cauchy kernel: ide: failed opcode was: unknown
Apr  4 13:12:00 cauchy kernel: ATAPI device hdb:
Apr  4 13:12:00 cauchy kernel:   Error: Illegal request -- (Sense key=0x05)
Apr  4 13:12:00 cauchy kernel:   Cannot read medium - incompatible format -- (asc=0x30, ascq=0x02)
Apr  4 13:12:00 cauchy kernel:   The failed "Read Subchannel" packet command was:
Apr  4 13:12:00 cauchy kernel:   "42 02 40 01 00 00 00 00 10 00 00 00 00 00 00 00 "

   (those are repeated about once per second when DVD movie is in the drive,
    both when it is played, and when left unused)

