From: Jeff Garzik <jgarzik@pobox.com>
Subject: sata_mv important note
Date: Tue, 17 Jan 2006 10:05:57 -0500
Message-ID: <43CD07D5.30302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:50091 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750915AbWAQPGA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 10:06:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>


For sata_mv users, you should be aware of three things:

1) The Marvell driver is experimental, and not yet considered ready for 
production use.  As Kconfig notes: HIGHLY EXPERIMENTAL.

2) There are PCI Message Signalled Interrupt (MSI) problems that are not 
yet diagnosed.  Workaround is to disable MSI.

3) There are still some errata that are not yet implemented.  Thus, for 
some systems, you may see either lockups or data corruption.  That's the 
price of running a HIGHLY EXPERIMENTAL driver.

Rest assured that all problem reports are read, even if you don't 
receive a reply.  After enough feedback is received, the exact problem 
becomes more clear.

	Jeff



