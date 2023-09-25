Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B02CE7A81
	for <linux-ide@archiver.kernel.org>; Mon, 25 Sep 2023 08:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIYIFt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Sep 2023 04:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIYIFs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2023 04:05:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE82A2
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2023 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695629142; x=1727165142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=syiQraget6ZL8dQ7L7eUwdxzXetHoeUZ/4wW4Yej5CM=;
  b=hDi7OTfq35VtDqtNfGf/O7L03AVrHnR4HzWxG3EOcCVU90bYpmNRn9HL
   omNOhk2DuE4pcLPwnESpneu+AwmfTT/6IFo5Ys3jCr0X3GtxvisT3+dEL
   Qu88zC41It5HYufAZTgBddrl5SYlyr0heZTCYi+94HDpxxR2Z7jzpgbi/
   Y3RfDtB/d0ppfgFZwBsGKVYeOAbaBB6ug/zrbLsp8H8KC2pR7akbOs0lL
   JTQIA9EG6uCWqtH/Qkinc6i+sC8A5C/qnAnGwYMJH+h4KecqGu4Cmq78P
   ljF53th8pFo6gU7qaLcSJqtWMOd0VFg7fH2HhBL25pteOt2iHrr1/pRHa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366253684"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="366253684"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 01:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="921895137"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="921895137"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 25 Sep 2023 01:05:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 830F12E9; Mon, 25 Sep 2023 11:05:38 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ata: ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list
Date:   Mon, 25 Sep 2023 11:05:38 +0300
Message-Id: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Intel Alder Lake-P AHCI controller needs to be added to the mobile
chipsets list in order to have link power management enabled. Without
this the CPU cannot enter lower power C-states making idle power
consumption high.

Cc: Koba Ko <koba.ko@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 08745e7db820..d96f80b6ff5d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -423,6 +423,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
 	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
 	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart Lake AHCI */
+	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_low_power }, /* Alder Lake-P AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
2.40.1

