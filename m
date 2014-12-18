From: worley@alum.mit.edu (Dale R. Worley)
Subject: Driver for Initio inic162x
Date: Thu, 18 Dec 2014 18:12:14 -0500
Message-ID: <87k31omu29.fsf@hobgoblin.ariadne.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:34960 "EHLO
	resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751660AbaLRXU2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2014 18:20:28 -0500
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id sBINCEpB028347
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2014 18:12:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am running kernel 3.14.23, specifically

# uname -a
Linux freeze.ariadne.com 3.14.23-100.fc19.i686.PAE #1 SMP Thu Oct 30 18:49:10 UTC 2014 i686 i686 i386 GNU/Linux

I've installed a SATA controller which seems to use the Initio inic162x
chip.  When it is booted, the kernel reports

Nov 23 23:31:25 localhost kernel: [    2.055310] sata_inic162x 0000:02:09.0: inic162x support is broken with common data corruption issues and will be disabled by default, contact linux-ide@vger.kernel.org if in production use

For the time being, I've attached the SATA disk using a "Diablo"
USB-to-SATA dongle, but I'd really like to use the controller card that
I've installed.

The discussions I've been able to find online are very thin, but it
appears that the problem is with the driver, not the controller chip.
Has anyone looked into fixing whatever the problem is?

http://www.spinics.net/lists/linux-ide/msg06499.html
http://www.spinics.net/lists/linux-ide/msg22920.html
http://www.spinics.net/lists/linux-ide/msg49293.html

Thanks,

Dale
