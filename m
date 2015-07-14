From: Arne Fitzenreiter <arne_f@ipfire.org>
Subject: [PATCH 0/2] disable trim for SuperSSpeed S238 SSD
Date: Tue, 14 Jul 2015 13:28:32 +0200
Message-ID: <1436873314-22563-1-git-send-email-arne_f@ipfire.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail01.ipfire.org ([178.63.73.247]:56156 "EHLO
	mail01.ipfire.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbGNLew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 07:34:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org


The SuperSSpeed S238 ssd lose data at trim, not only at queued trim
so this patchset introduce a new switch to disable trim and do this
for SuperSSpeed S238.

----
 drivers/ata/libata-core.c      |  3 +++
 drivers/ata/libata-scsi.c      | 14 ++++++++------
 drivers/ata/libata-transport.c |  2 ++
 include/linux/libata.h         |  2 ++
 4 files changed, 15 insertions(+), 6 deletions(-)
----

