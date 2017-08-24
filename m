From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/3] constify ata_port_info
Date: Thu, 24 Aug 2017 15:19:58 +0530
Message-ID: <1503568201-9991-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34392 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdHXJuV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2017 05:50:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, b.zolnierkie@samsung.com, linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

ata_port_info are not supposed to change at runtime. All functions
working with ata_port_info provided by <linux/libata.h> work with
const ata_port_info. So mark the non-const structs as const.

Arvind Yadav (3):
  [PATCH 1/3] ata: ftide010: constify ata_port_info
  [PATCH 2/3] ata: pdc2027x: constify ata_port_info
  [PATCH 3/3] ata: constify ata_port_info

 drivers/ata/pata_ftide010.c | 2 +-
 drivers/ata/pata_pdc2027x.c | 2 +-
 drivers/ata/pdc_adma.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

