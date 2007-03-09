From: Martin Mailand <martin@tuxadero.com>
Subject: freeze issue with the H8SSLi AM2 HT1000
Date: Fri, 09 Mar 2007 11:04:03 +0100
Message-ID: <45F13113.2070703@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-12-249.dedicated.hosteurope.de ([87.230.12.249]:36674
	"EHLO lvps87-230-12-249.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993093AbXCIKaq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 05:30:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, benh@kernel.crashing.org

To whom it my concern,

We use the H8SSL-I2 AM2 Board from Supermicro with 4GB RAM, 2 SATA-HDs 
on the onboard HT1000-Controller in a software RAID-1 configuration and 
the 1218 HE AMD CPU, the firmware version is "ServerWorks Serial ATA 
Controller  MMIO BIOS V 3.0.0015.3h 09-14-2006". The OS is Suse 10.2 
with the 2.6.18.2-34-bigsmp Kernel.

Every time we start our initial hardware burnin-test, the system hangs 
after a few hours; our main test tool is stress 
(http://weather.ou.edu/%7Eapw/projects/stress/).

The following symptoms are shown:


After a system hang the system is still pingable, networksockets are 
open, but no userspace process is responding.

At one instance we had a "top" open and almost all of the userspace 
processes were in the state of iowait.

The console for the login is still responding (the typed characters are 
echoed back) but no login process is spawned.

The Magic sys request is still working.

If we use a 3ware RAID-controller card instead of the onboard 
controller, the system runs stable.

If we use 2GB instead of the 4GB the system hangs are less frequent.

If we use the the 2.6.20 kernel form kernel.org the system runs stable.

 
I think all of the above points indicate that it is not a hardware 
issue, but a software issue, in particular a timing- / locking-issue of 
the SATA driver (ata_svw).


Our main problem is that we can not switch to the 2.6.20 kernel, we must 
use the standart Suse kernel 2.6.18.2-34-bigsmp.
Is there any workaround / fix or new fimrware known to fix this freeze 
issue?

Any help would be appreciated.

Could you please include me in your reply, I am not subscribe to the 
linux-ide list.

Thanks in advanced.

Martin

