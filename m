Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B49C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 21 Apr 2022 03:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiDUDaS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 20 Apr 2022 23:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDUDaP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 20 Apr 2022 23:30:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B8625FB
        for <linux-ide@vger.kernel.org>; Wed, 20 Apr 2022 20:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650511647; x=1682047647;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EmZhPfoQoeSqVa++9Ug8pmBGZif9DbWer+0CG045xv8=;
  b=eOoonSU0gnvxTBLemh5qCQQEZRyi7mM2tU135h5ATqlgQXsdmofSJCj/
   tEa7XOgAR4r8RMz6PnRuFEpxGowqX0PTH3d7Sodwp8iuNGLtdpDuKAI+w
   ZG/5vqVJLu0ukd79ZAxqP8IBLdHKZjFX6y9dmf+5PR/FXrrKcNcv+rGve
   6n+OsEuNa0Mt78QG65AbqydKJLBsVIztD2sD8BbUcXJ2moqxS+rsmLMPt
   GqQgHaDJJXOPzyxNxaM3gORAnj777K/HIEK5Nsdylc5CGBd4x80s05hLb
   ZHa74ftuanQGm4XxZ3kM4SEtRI2hBHO6TtZ4ZQhRrRGwxyKmqZKOHX59X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244806295"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="244806295"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 20:27:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="669723602"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 20:27:26 -0700
Subject: [PATCH] ahci: Add a generic 'controller2' RAID id
From:   Dan Williams <dan.j.williams@intel.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-ide@vger.kernel.org
Date:   Wed, 20 Apr 2022 20:27:26 -0700
Message-ID: <165051164674.3740862.4706111262486927842.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Intel server platforms that support 'RAID', i.e. have platform firmware
support for software-RAID metadata + features that the kernel also
understands, maintain the same device-ids for RAID from generation to
generation. This is in contrast to client platforms that have tended to
roll new device-ids every platform generation. However, even though
server platform keep the ids there are still unique device-ids per
controller instance. To date there have only been 2 controllers on these
platforms, but platforms code named Emmitsburg add a third controller.

Add the device-id for this third controller and collect it with the
other generic server RAID ids.

As mentioned here [1], the pain of continuing add new and different
device-ids for RAID mode to this file [2] has been heard. Ideally this
device-id would not matter and the class code would remain
PCI_CLASS_STORAGE_SATA_AHCI regardless of the RAID mode, but other
operating systems depend on the class code *not* being AHCI when the
device is in RAID mode. That said, going forward there is little reason
for new server RAID ids to be added as they can simply reuse one of the
existing ids even for a new controller. Server software RAID features
continue to be supported on Linux. Client software RAID features
continue to be not supported and the recommendation there remains to set
the device to AHCI mode in platform firmware.

Link: https://lore.kernel.org/all/8e61fb0104422e8d70701e2ddc7b1ca53f009797.camel@intel.com [1]
Link: https://lore.kernel.org/all/20201119165022.GA3582@infradead.org/ [2]
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/ahci.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 397dfd27c90d..c1eca72b4575 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -324,7 +324,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_low_power }, /* Panther M AHCI */
@@ -367,7 +366,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg/Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg/Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* *burg SATA0 'RAID' */
+	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* *burg SATA1 'RAID' */
+	{ PCI_VDEVICE(INTEL, 0x282f), board_ahci }, /* *burg SATA2 'RAID' */
 	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci }, /* Rocket Lake PCH-H RAID */

