From: Ian Pilcher <arequipeno@gmail.com>
Subject: Monkey-patching libahci
Date: Mon, 14 Jul 2014 13:30:57 -0500
Message-ID: <lq17mj$40p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56459 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbaGNScG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jul 2014 14:32:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1X6l2g-0007Pq-SW
	for linux-ide@vger.kernel.org; Mon, 14 Jul 2014 20:32:02 +0200
Received: from pool-173-57-185-5.dllstx.fios.verizon.net ([173.57.185.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2014 20:32:02 +0200
Received: from arequipeno by pool-173-57-185-5.dllstx.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2014 20:32:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a Thecus N5550 NAS with an ICH10R AHCI controller.  5 of the AHCI
ports are used for "data" drives, and each of these has an activity LED
which is driven by one of the ICH GPIOs.  (The other AHCI port is used
by the internal SATA DOM.)

In order to make the LEDs actually blink, I am wrapping libahci's
qc_issue function to blink the LED that corresponds to a given command's
port (if any):


https://github.com/ipilcher/n5550/blob/master/modules/n5550_ahci_leds.c#L177

I "hook in" the wrapper function by ensuring that my module is loaded
immediately after libahci (via modprobe configuration) and directly
modifying ahci_ops.qc_issue.  I do everything I can think of to make
sure that no other libahci users are loaded while I'm making the
changes.


https://github.com/ipilcher/n5550/blob/master/modules/n5550_ahci_leds.c#L207

I also prevent my module from being unloaded when any other libahci
users are loaded.  The module keeps an additional reference to itself,
which is released when the hook is successfully disabled via sysfs.


https://github.com/ipilcher/n5550/blob/master/modules/n5550_ahci_leds.c#L79

This definitely works, and it allows me to use pre-packaged kernels on
this system (ELRepo kernel-lt on CentOS 6 and hopefully the CentOSPlus
kernel on CentOS 7), but it sure does feel ugly and hackish.

Short of patching and rebuilding the libahci or ahci modules, is there a
better way to do this?  (Keeping in mind that I'm not worried about
supporting any other hardware configuration.)

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================

