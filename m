Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C4C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 26 Mar 2022 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiCZSKH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 26 Mar 2022 14:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiCZSKH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 26 Mar 2022 14:10:07 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D37666
        for <linux-ide@vger.kernel.org>; Sat, 26 Mar 2022 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648318110; x=1679854110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hhckl5uHWCH7Sb8Xzw3uP9VqiCG1wboxclAdlY2Hvnc=;
  b=HP2mK4pCEM6Mn2TJqBAAODlj6/iCQBD5MKmF4/Bh3uFXHA5OkZm7enMY
   g1fJed7KHgOP+MVaifojqOSlbH2/kZwqtcSSjRjwAD8tczuzdey43dqIg
   i/nZnii2lpZhRwhIAU0x6mYtlHKXijw6hLbeL1fOC38JTs/Ciyk31CxzP
   1UX8z3CwlN951U1BvFNCdFAimRh9FlaLwyYpxsQi3TCSpORSDWL/SPszp
   HUQtBcRGvsebGa1fsgAbYCWmQ6eNGN9FmsuHnG0NHWYOyHrmBtBrnILpQ
   oW8l+6drCXH9x0sN3ySckYJMjFWGEbh7zow2gNWK/DTuTid5/gmB8YMdw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="319500577"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="319500577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 11:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="562204704"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2022 11:08:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYApw-0000GP-7v; Sat, 26 Mar 2022 18:08:28 +0000
Date:   Sun, 27 Mar 2022 02:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH] libata: ata_bus_type can be static
Message-ID: <20220326180805.GA126281@a969c731af34>
References: <20220325125624.99929-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325125624.99929-2-hare@suse.de>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

drivers/ata/libata-transport.c:88:17: warning: symbol 'ata_bus_type' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 drivers/ata/libata-transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index e5ed5046b299e2..b9412d1fe3e083 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -85,7 +85,7 @@ struct ata_internal {
 static int ata_tdev_add(struct ata_device *dev);
 static void ata_tdev_delete(struct ata_device *dev);
 
-struct bus_type ata_bus_type = {
+static struct bus_type ata_bus_type = {
         .name		= "ata",
 };
 
