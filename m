From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/5] ahci: st: Apply Bartlomiej's suggestions
Date: Wed, 12 Mar 2014 12:39:37 +0000
Message-ID: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63999 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbaCLMkF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2014 08:40:05 -0400
Received: by mail-wg0-f41.google.com with SMTP id n12so11368206wgh.0
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2014 05:40:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tj@kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org

Hi Tejun,

Sorry for the delay, I was in Asia for 9 days last week.

Here are the suggestions from Bartlomiej's review.

 drivers/ata/Kconfig   |  8 ++++----
 drivers/ata/ahci_st.c | 54 ++++++++++++++++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 26 deletions(-)

