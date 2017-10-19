From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH 0/2] libata: hotplug link speed
Date: Thu, 19 Oct 2017 13:30:34 -0500
Message-ID: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752519AbdJSSah (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 19 Oct 2017 14:30:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

During hotplug, it is possible for 6Gbps link speed to
be limited all the way down to 1.5 Gbps which may lead
to a slower link speed when drive is re-connected.

This behavior has been seen on a Intel Lewisburg SATA
controller (8086:a1d2) with HGST HUH728080ALE600 drive
where SATA link speed was limited to 1.5 Gbps and
when re-connected the link came up 3.0 Gbps. ata_dev_init
initializes link->spd to 0, but, the 0001 patch will
reset it once the link comes online. The 0002 patch will
allow the error handler to reset link->spd only if the
link is online; otherwise, it will always get set to 0.

This patch set was retested on above configuration and
showed the hotplugged link to come back online at max
speed (6Gbps). I did not see the downgrade when testing
on Intel C600/X79, but retested patched linux-4.14-rc5
kernel and didn't see any side effects from these
changes. Also, successfully retested hotplug on port
multiplier 3Gbps link. 




