From: Arne Fitzenreiter <arne_f@ipfire.org>
Subject: [PATCH 0/2] disable trim for SuperSSpeed S238 SSD - v2
Date: Tue, 14 Jul 2015 15:01:47 +0200
Message-ID: <1436878909-26698-1-git-send-email-arne_f@ipfire.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail01.ipfire.org ([178.63.73.247]:56220 "EHLO
	mail01.ipfire.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbGNNCE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 09:02:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org


The SuperSSpeed S238 loose data at trim, not only at queued trim
so this patchset add a switch to disable trim amd do it for this
disc.

V1: - initial patchset
V2: - signed-off commits
    - fix indenting

----
 drivers/ata/libata-core.c      |  3 +++
 drivers/ata/libata-scsi.c      | 14 ++++++++------
 drivers/ata/libata-transport.c |  2 ++
 include/linux/libata.h         |  2 ++
 4 files changed, 15 insertions(+), 6 deletions(-)

