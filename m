From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] [libata]Issue SRST to Sil3726 PMP
Date: Wed, 19 Oct 2011 17:02:41 -0700
Message-ID: <1319068962-18983-1-git-send-email-gwendal@google.com>
References: <4E959E1F.20001@teksavvy.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9092 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab1JTADH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2011 20:03:07 -0400
In-Reply-To: <4E959E1F.20001@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, kernel@teksavvy.com, mihrcke@gmail.com, derry@high-rely.com
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

By issuing SRST,
. We re enable staggered spin up
. We allow slow disks to spin up while we are still in initial error handler

However, some controller fails sending SRST while the disk is spinning up
behind the port multiplier.
To avoid slow disk to be ignored, or link to be downgraded unnecessarily, wait 10s if
SRST fails before resetting the ATA port.

With a Sil3132.
Before the patch:
[  236.184036] ata4.15: hard resetting link
[  236.184038] ata4: controller in dubious state, performing PORT_RST
[  238.338048] ata4.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  239.549102] ata4.00: hard resetting link
[  239.854315] ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  239.854344] ata4.01: hard resetting link
[  240.159316] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  240.159344] ata4.02: hard resetting link
[  240.464316] ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  240.464343] ata4.03: hard resetting link
[  240.769314] ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  240.769342] ata4.04: hard resetting link
[  241.074316] ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  241.074344] ata4.05: hard resetting link
[  241.379314] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  241.382672] ata4.00: configured for UDMA/100 
[  241.492027] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  241.492030] ata4.01: revalidation failed (errno=-5)
[  241.492033] ata4.15: hard resetting link

After the patch:
[   19.436422] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[   19.454715] ata4.00: hard resetting link
[   19.880032] ata4.00: softreset failed (SRST command error)
[   19.880048] ata4.00: failed to read SCR 0 (Emask=0x40)
[   19.880051] ata4.00: reset failed (errno=-85), retrying in 10 secs 
[   29.454092] ata4.00: reset failed, giving up
[   29.454099] ata4.15: hard resetting link
[   29.454102] ata4: controller in dubious state, performing PORT_RST 
[   31.608046] ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   31.608431] ata4.00: hard resetting link
[   31.924284] ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   31.924335] ata4.01: hard resetting link 
[   32.350029] ata4.01: softreset failed (SRST command error)
[   32.460032] ata4.01: failed to read SCR 0 (Emask=0x1)
[   32.460036] ata4.01: reset failed (errno=-85), retrying in 10 secs 
[   41.924139] ata4.01: reset failed, giving up 
[   41.924146] ata4.15: hard resetting link
[   41.924148] ata4: controller in dubious state, performing PORT_RST
[   44.078047] ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   44.078384] ata4.00: hard resetting link

Patch also tested with Marvel 7042 and Sil3726.

Gwendal Grignou (1):
  [libata]Issue SRST to Sil3726 PMP

 drivers/ata/libata-eh.c  |   12 +++++++++++-
 drivers/ata/libata-pmp.c |    7 ++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
1.7.3.1

