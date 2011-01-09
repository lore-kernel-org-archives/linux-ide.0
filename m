From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] pata_mpc52xx: inherit from
 ata_bmdma_port_ops
Date: Sun, 9 Jan 2011 17:48:20 -0500
Message-ID: <20110109224820.GB26607@mtj.dyndns.org>
References: <201101031445.47922.roman.fietze@telemotive.de>
 <20110103135929.GO18831@htj.dyndns.org>
 <4D21DD55.2000000@ru.mvista.com>
 <AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
 <4D21EAF1.2010504@ru.mvista.com>
 <4D21FA4D.3030506@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53324 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1AIWsY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Jan 2011 17:48:24 -0500
Received: by vws16 with SMTP id 16so7931554vws.19
        for <linux-ide@vger.kernel.org>; Sun, 09 Jan 2011 14:48:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D21FA4D.3030506@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Roman Fietze <roman.fietze@telemotive.de>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

pata_mpc52xx supports BMDMA but inherits ata_sff_port_ops which
triggers BUG_ON() when a DMA command is issued.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Roman Fietze <roman.fietze@telemotive.de>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: stable@kernel.org
---
 drivers/ata/pata_mpc52xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 8cc536e..d7d8026 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -610,7 +610,7 @@ static struct scsi_host_template mpc52xx_ata_sht = {
 };
 
 static struct ata_port_operations mpc52xx_ata_port_ops = {
-	.inherits		= &ata_sff_port_ops,
+	.inherits		= &ata_bmdma_port_ops,
 	.sff_dev_select		= mpc52xx_ata_dev_select,
 	.set_piomode		= mpc52xx_ata_set_piomode,
 	.set_dmamode		= mpc52xx_ata_set_dmamode,
