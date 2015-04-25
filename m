From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2 0/2] libata: Ignore spurious PHY event on LPM policy change
Date: Sat, 25 Apr 2015 19:52:35 +0200
Message-ID: <1429984357-2223-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35856 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbbDYR6C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Apr 2015 13:58:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>

Changes since v1:
 - Added generic helper to keep the logic in one place

Gabriele Mazzotta (2):
  libata: Add helper to determine when PHY events should be ignored
  libata: Ignore spurious PHY event on LPM policy change

 drivers/ata/libahci.c     |  3 +--
 drivers/ata/libata-core.c | 32 ++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |  3 +++
 include/linux/libata.h    | 10 ++++++++++
 4 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.1.4

