From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: hot plugable?
Date: Tue, 13 Apr 2004 20:37:26 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <pan.2004.04.13.18.37.25.709554@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:41941 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263680AbUDMTAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Apr 2004 15:00:09 -0400
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BDT8i-0006ED-00
	for <linux-ide@vger.kernel.org>; Tue, 13 Apr 2004 21:00:08 +0200
Received: from port-212-202-73-229.reverse.qsc.de ([212.202.73.229])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 13 Apr 2004 21:00:08 +0200
Received: from aj by port-212-202-73-229.reverse.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 13 Apr 2004 21:00:08 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi is there any ata or sata driver that allows hotplugging with linux?

combined with software raid, could it be configured, so I can replace a
disk and repair the raid without any reboot necessary?

or will this only work with hardware raid controllers? I'm looking for 
a software raid solution, because raidtools and smartmon are both very
nice, while many tools for hardware raid controllers are not that nice
to use.

If there is such a chipset/driver, are there any benefits a hardware raid
controller has over such a software raid solution? Sure, hardware raid
controllers do the raif5 calculations for you, and the data only passes
system bus once in normal operation / not at alle for restoring data.
But with modern cpu and busses these issues might not be very important
any longer?

Thanks for your advice.

Regards, Andreas

