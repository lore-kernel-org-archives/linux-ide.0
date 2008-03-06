From: walt <w41ter@gmail.com>
Subject: Commit 9f10d9ee breaks CD mounting/burning
Date: Wed, 05 Mar 2008 17:16:51 -0800
Message-ID: <fqngjf$cjf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36401 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759124AbYCFBPh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Mar 2008 20:15:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JX4hp-000219-RD
	for linux-ide@vger.kernel.org; Thu, 06 Mar 2008 01:15:33 +0000
Received: from adsl-69-234-213-79.dsl.irvnca.pacbell.net ([69.234.213.79])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 01:15:33 +0000
Received: from w41ter by adsl-69-234-213-79.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 01:15:33 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Bartolmiej,

For me, this commit causes the problem it's intended to fix:

commit 9f10d9ee0ac6d79d7bc8b9a158bf4a29322d84d3
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Tue Feb 26 21:50:35 2008 +0100

     ide-cd: fix 'ireason' handling for REQ_TYPE_ATA_PC requests

     This fixes some hangs caused by not finishing the transfer before ending
     the request and also makes use of 'ireason == 1' quirk for spurious IRQs.

When I mount a CD there is a long delay, and I see this error message:

hdc: ide_cd_check_ireason: wrong transfer direction!
cdrom: failed setting lba address space
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hdc: drive not ready for command
<repeated many times>

When I revert this commit everything works properly again, including
CD burning.

Here is the drive info:

hdc: TSSTcorpCD/DVDW SH-S182M, ATAPI CD/DVD-ROM drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/33 mode selected
hdc: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hdc: UDMA/33 mode selected

I'm happy to try patches or supply more info, just let me know
what you need.

Thanks.

