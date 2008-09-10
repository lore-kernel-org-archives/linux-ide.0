From: Tejun Heo <tj@kernel.org>
Subject: Laptop shock detection and harddisk protection
Date: Wed, 10 Sep 2008 18:59:26 +0200
Message-ID: <48C7FCEE.8060404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46887 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbYIJRBB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Sep 2008 13:01:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: multinymous@gmail.com, Elias Oltmanns <eo@nebensachen.de>, Thomas Renninger <trenn@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, all.

Elias has been sending libata/ide shock protection patches[1] and for
libata I think it's only one or two iterations from being included.
The interface is pretty simple, it only has to write timeout values to
sysfs nodes for all disks.

Thomas is now working on implementing shock detection for HP laptops
where the interface is much simpler than the HDAPS one.  Interrupts
for danger imminent and danger over plus control for warning LED.

I browsed a little bit for HDAPS one and it seems all the pieces are
there but scattered.  The latest effort seems tp_smapi which Shem
Multinymous is working on.

So, overall, all the pieces are falling into places but many pieces
are not upstream yet and there also are interface differences for
different detection drivers.  The original hdaps uses polling on sysfs
nodes, the HP thing Thomas is working on is likely to use sysfs +
sysfs_notify_event() and probably another node to control LED.  The
tp_smapi seems to use joystick input device to transfer the data along
all the axises.

So, I think it's about time to decide how to proceed on this
acceleration detection and shock protection thing.

1. How should the shock interface look like?  As we're gonna need
   userland daemon one way or the other, we can use the userland
   daemon to glue all the interfaces but it would be much better to
   have a unified interface.  Although there seem to be several
   different variants, they don't differ all that much and creating a
   new interface every time is painful.  I think we can get by with a
   sysfs interface with notification.

2. If we're gonna unify interface, how much can we unify the backend?
   Some devices are based on polling, others interrupt.  For polling,
   is it better to delegate the whole polling to userland or is it
   better to do some of it in kernel (tp_smapi seems to be doing
   this)?

3. What about the userland daemon?  It would be best to have a unified
   daemon which can handle all instead of one for hdaps and another
   for hp (and so on).  If we can unify the interface, this will be
   much easier.

Thanks.

-- 
tejun

[1] http://thread.gmane.org/gmane.linux.ide/34103
