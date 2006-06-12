From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Maybe a corrupted BIOS?
Date: Mon, 12 Jun 2006 12:45:43 +0800
Message-ID: <1150087543.5721.49.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50834 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750808AbWFLE5s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 00:57:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Hi, Jeff

I encountered a tricky problem. Let me described it from start.

This morning I applied the "AHCI suspend/resume" patch against latest
#upstream without much modification, then after a round of suspend/
resume, then system can't boot from AHCI mode, also can't boot from
"enhanced mode with AHCI disabled". But it can boot from "compatible
mode" with ata_piix driver to drive the hardware.

So now I'm totally clueless about how to make AHCI mode come back to
life. It seems that I need to trigger a low-level re-initialization of
SATA controller. Have you ever met such weird behavior before?

Thanks,
Forrest
