From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream-fixes] libata: fix a bunch of PMP related problems
Date: Mon, 19 May 2008 01:15:04 +0900
Message-ID: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:52674 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYERQPX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1010109wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:23 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca

Hello,

This patchset is started from investigating sil24 - mv4140 PMP
detection / NCQ problems.  It soon turned out there are quite a number
of issues lurking in the current PMP implementation.

* We still have a hole during reset where hotplug can go unnoticed.

* PMP r/w timeout is too short.  It's currently 250ms.  This is from
  SIMG PMPs and was mainly to avoid longish sequential multiple
  timeouts when access PMP regs via polled commands which is not the
  case anymore and mv 4140 and SIMG4726 needs more time occasionally.

* SDB Notify is not masked during fan-out port resets if PMP hasn't
  been reset in that pass.  This causes PMP register access failure
  because SDB Notify is received while PMP register write is in
  progress for fan-out reset.  I missed this because most of my
  testing was before PMP register access was converted to IRQ driven.

* ata_lpm_schedule() is called during probe right after SCSI scan is
  complete which schedules EH immediately, reliably triggering above
  two on certain hardware combinations.  This by itself should be okay
  but makes other problems more painful.

* sil3124/32 and mv4140 combination for some reason can't do NCQ
  reliably.  I don't know why.  I'll blacklist it for the time being
  and contact both companies about this.

* recovered errors shouldn't trigger resets.

* SIMG4726 config device still is a real pain in the ass.

This patchset contains ten patches addressing all the above issues.
Although this patchset is rather large, it's basically bug fixes.

The patchset fixes all hotplug problems I can reproduce including the
hotplug problems on inic162x and JMB ahcis.  The only remaining issue
is that sometimes device detection gets delayed by 30sec IDENTIFY
timeout.  I'll prep a patchset to make EH command timeouts more
intelligent (for #upstream).

The sad part is that with PMP in the mix and the current host
controller designs, we have inherent race condition during reset (no
reliable way to wait for the initial D2H FIS after hardresetting
fan-out port, so SRST races with D2H FIS) and this seems to lead to
problems during or after reset sometimes.  We have to resort to
intelligently timed retries to make it work bearably.

Thanks.

 drivers/ata/libata-core.c |   40 ++++----
 drivers/ata/libata-eh.c   |  207 +++++++++++++++++++++++++---------------------
 drivers/ata/libata-pmp.c  |   44 ++++-----
 drivers/ata/libata-scsi.c |    6 -
 drivers/ata/sata_sil24.c  |   11 ++
 include/linux/libata.h    |    4
 6 files changed, 170 insertions(+), 142 deletions(-)

--
tejun
