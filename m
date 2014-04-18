From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH v2 0/2] ahci: imx: software workaround for phy reset issue
Date: Fri, 18 Apr 2014 14:44:24 +0800
Message-ID: <1397803466-28411-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:22252
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750821AbaDRGou (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Apr 2014 02:44:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>

Changes since v1:
 - Do not switch to defines and stay with enums
 - Create a wrapper function imx_phy_crbit_assert() to make the code
   a little shorter and easier for eyes

Shawn Guo (2):
  ahci: imx: add namespace for register enums
  ahci: imx: software workaround for phy reset issue in resume

 drivers/ata/ahci_imx.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 7 deletions(-)

-- 
1.8.3.2


