Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A29BC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 13 Jan 2022 15:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiAMPqx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:46:53 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:57255 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236269AbiAMPqu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 13 Jan 2022 10:46:50 -0500
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 7692761EA191E;
        Thu, 13 Jan 2022 16:46:47 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 0/2][RFC] Make delay before debouncing configurable
Date:   Thu, 13 Jan 2022 16:46:33 +0100
Message-Id: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The 200 ms delay before debouncing the PHY was introduced for some buggy
old controllers. To decrease the boot time to come closer do instant
boot, add a parameter so users can override that delay.

The current implementation has several drawbacks, and is just a proof of
concept, which some experienced Linux kernel developer can probably
implement in a better way.

One problem is, that the warning is shown for each link and not just per
controller.

Paul Menzel (2):
  ata: Add module parameter `debounce_delay_ms`
  ata: Warn about removal of debounce delay in Linux 5.19

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/ata/libata-core.c                       |  4 ++++
 drivers/ata/libata-sata.c                       | 12 +++++++++---
 drivers/ata/libata.h                            |  1 +
 4 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.30.2

