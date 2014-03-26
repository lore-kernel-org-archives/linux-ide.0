From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: sata_highbank: remove superfluous cast
Date: Wed, 26 Mar 2014 16:41 +0100
Message-ID: <11638294.fp3ZK6zVlg@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15807 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaCZPlW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2014 11:41:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, Rob Herring <robh@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

hpriv->plat_data is 'void *' so there is no need to cast it to
'struct ecx_plat_data *'.

Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_highbank.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/sata_highbank.c
===================================================================
--- a/drivers/ata/sata_highbank.c	2014-03-14 16:45:04.384724376 +0100
+++ b/drivers/ata/sata_highbank.c	2014-03-26 16:28:40.927062349 +0100
@@ -141,7 +141,7 @@ static ssize_t ecx_transmit_led_message(
 					ssize_t size)
 {
 	struct ahci_host_priv *hpriv =  ap->host->private_data;
-	struct ecx_plat_data *pdata = (struct ecx_plat_data *) hpriv->plat_data;
+	struct ecx_plat_data *pdata = hpriv->plat_data;
 	struct ahci_port_priv *pp = ap->private_data;
 	unsigned long flags;
 	int pmp, i;

