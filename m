From: Ming Zhang <mingz@ele.uri.edu>
Subject: hotplug works, but newly plug not
Date: Wed, 24 May 2006 11:25:16 -0400
Message-ID: <1148484316.26093.72.camel@localhost.localdomain>
Reply-To: mingz@ele.uri.edu
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orca.ele.uri.edu ([131.128.51.63]:43485 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S932642AbWEXPZX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 May 2006 11:25:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide-list <linux-ide@vger.kernel.org>

Hi All

I use the libata patch from
http://home-tj.org/wiki/index.php/Libata-tj-stable with my supermicro MB
( ICH7R chip). The AHCI works as desired in most of the time.

If I have disk(s) plugged in during boot. Then after boot, I kept unplug
and plug many times and it works fine.

but i noticed that if I have the disk(s) unplugged during boot, then
after boot, I plug the disk and nothing shows. if I try to do rescan by
run the rescan lun script, i saw these from dmesg.

Anything clue ? Thanks!

Ming

---------------------------------------
ata4: soft resetting port
ata4: SATA link down (SStatus 0 SControl 0)
ata4: EH complete
ata3: soft resetting port
ata3: SATA link down (SStatus 0 SControl 0)
ata3: EH complete
ata4: soft resetting port
ata4: SATA link down (SStatus 0 SControl 0)
ata4: EH complete
ata3: soft resetting port
ata3: SATA link down (SStatus 0 SControl 0)
ata3: EH complete
ata4: soft resetting port
ata4: SATA link down (SStatus 0 SControl 0)
ata4: EH complete


