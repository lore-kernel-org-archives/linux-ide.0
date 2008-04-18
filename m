From: Jeff Garzik <jeff@garzik.org>
Subject: IDE allmodconfig: probe_4drives error
Date: Fri, 18 Apr 2008 18:49:55 -0400
Message-ID: <48092593.4040700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44903 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbYDRWt5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Apr 2008 18:49:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

allmodconfig on i386 from latest linux-2.6.git (the one w/ the kgdb 
build error):

WARNING: modpost: Found 15 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
   UPD     include/linux/compile.h
   Building modules, stage 2.
Root device is (9, 0)
Setup is 12536 bytes (padded to 12800 bytes).
System is 1896 kB
CRC 116c83e7
Kernel: arch/x86/boot/bzImage is ready  (#1)
ERROR: "probe_4drives" [drivers/ide/ide-core.ko] undefined!
[...]

