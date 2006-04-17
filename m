From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: A question about right-shift in ahci_port_start()
Date: Mon, 17 Apr 2006 15:25:53 +0800
Message-ID: <1145258753.3417.5.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34206 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750816AbWDQHgY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Apr 2006 03:36:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Hi, Jeff

When reading ahci_port_start(), I found the
following code segments:

.......
if (hpriv->cap & HOST_CAP_64)
        writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio +
PORT_LST_ADDR_HI);
        writel(pp->cmd_slot_dma & 0xffffffff, port_mmio +
PORT_LST_ADDR);
        readl(port_mmio + PORT_LST_ADDR); /* flush */
......

I can't figure out why you use ">>16>>16" instead of
">>32" for right-shift 32 bits.

Would you please give me some hint?

Thanks,
Forrest
