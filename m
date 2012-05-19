From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3.3.y] libata: forbid port runtime pm by default, fixing
 regression
Date: Sat, 19 May 2012 18:58:54 -0500
Message-ID: <20120519235854.GA32208@burratino>
References: <4F8DD4DC.4050503@teksavvy.com>
 <4F8DD708.8050502@teksavvy.com>
 <4F8DD834.5070000@teksavvy.com>
 <4F8DDA53.206@teksavvy.com>
 <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com>
 <4F8EF57E.4070603@fold.natur.cuni.cz>
 <4F8EF9F7.5040202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45174 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab2ESX7G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2012 19:59:06 -0400
Content-Disposition: inline
In-Reply-To: <4F8EF9F7.5040202@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stable@vger.kernel.org
Cc: Michael Schmitt <tcwardrobe@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

From: Lin Ming <ming.m.lin@intel.com>
Date: Wed, 18 Apr 2012 09:29:47 +0800

commit 0c8d32c27f5cf6e14ca14b4758d1e994eebd50fd upstream.

Forbid port runtime pm by default because it has known hotplug issue.
User can allow it by, for example

echo auto > /sys/devices/pci0000:00/0000:00:1f.2/ata2/power/control

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Greg,

Please consider

  0c8d32c27f5c libata: forbid port runtime pm by default, fixing
               regression

for inclusion in the 3.3-stable tree.  (It should apply there cleanly.
The copy in this message is just for easy reference.)

Michael Schmitt noticed[1] using a 3.3.4-based kernel that powering
his esata enclosure on, off, and back on again would cause Linux to no
longer recognize the disk.  By contrast, a 3.2.y-based kernel worked
fine.  Examining logs reveals that on 3.3.y the second time the
enclosure turns on, no PHYRdgyChg CommWake exception shows up:

| dmesg logs directly pasted here. So first, booted with powered down 
| esata enclosure and now, poweron:
| 
| [36997.268364] ata5: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xe frozen
| [36997.268370] ata5: SError: { PHYRdyChg CommWake }
| [36997.268383] ata5: hard resetting link
[...]
| Disk works.
[...]
| mounted.... and umount again, now powerdown.
|
| [37437.877977] ata5: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
| [37437.877982] ata5: SError: { PHYRdyChg }
| [37437.877995] ata5: hard resetting link
[...]
| Drive gone... now, power-up again.
|
| adrastea:~# dmesg
| adrastea:~#
|
| Nothing. I did clear the kernel-message log in between...

With this patch, Michael found hotplug to work again.

See also [2] and [3].

Jeff seems to have acked it for stable already[4].

Hope that helps,
Jonathan

[1] http://bugs.debian.org/671689
[2] http://thread.gmane.org/gmane.linux.ide/51860/focus=51882
[3] https://bugzilla.redhat.com/show_bug.cgi?id=807632
[4] http://thread.gmane.org/gmane.linux.ide/51885/focus=51887

 drivers/ata/libata-transport.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 74aaee30e264..c34190485377 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
 	device_enable_async_suspend(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
+	pm_runtime_forbid(dev);
 
 	transport_add_device(dev);
 	transport_configure_device(dev);
-- 
1.7.10.2

