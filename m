From: Marc Carino <marc.ceeeee@gmail.com>
Subject: [PATCH 0/2] libata: disable queued trim for Micron M500 SSDs
Date: Mon, 16 Dec 2013 18:15:52 -0800
Message-ID: <1387246554-7311-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:65143 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab3LQCQK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Dec 2013 21:16:10 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so5997349oag.12
        for <linux-ide@vger.kernel.org>; Mon, 16 Dec 2013 18:16:09 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: marc.ceeeee@gmail.com, mykola.dvornik@gmail.com

There was a report of silent data corruption on Fedora 20 w/ the v3.12
kernel. After some analysis of SATA traces, it appears that in certain
queued scenarios, the Micron M500 SSD will exhibit incorrect protocol
behavior. A support request was sent to the vendor, and a firmware fix
is in the works.

Until a firmware update is deployed for the Micron/Crucial M500 SSD,
the ATA driver should avoid issuing the queued TRIM commands to the
affected devices.

This patchset adds a new horkage flag to let the queued trim commands
be disabled, depending on the drive model string.

Marc Carino (2):
  libata: add horkage flag to disable issuance of queued TRIM commands
  libata: disable queued TRIMs for Micron M500 SSDs

 drivers/ata/libata-core.c | 11 +++++++++++
 include/linux/libata.h    |  2 ++
 2 files changed, 13 insertions(+)

-- 
1.8.1.3

