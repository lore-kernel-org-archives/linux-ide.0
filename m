From: Tejun Heo <tj@kernel.org>
Subject: [PATCH v3] libata: disable forced PORTS_IMPL for >= AHCI 1.3
Date: Mon, 25 Jan 2016 15:46:59 -0500
Message-ID: <20160125204659.GN3628@mtj.duckdns.org>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
 <20160114223732.GG3520@mtj.duckdns.org>
 <20160115201305.GN3520@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35266 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933957AbcAYUrC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jan 2016 15:47:02 -0500
Content-Disposition: inline
In-Reply-To: <20160115201305.GN3520@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

Applied the following to libata/for-4.5-fixes.

Thanks.

------ 8< ------
>From 566d1827df2ef0cbe921d3d6946ac3007b1a6938 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 15 Jan 2016 15:13:05 -0500
Subject: [PATCH] libata: disable forced PORTS_IMPL for >= AHCI 1.3

Some early controllers incorrectly reported zero ports in PORTS_IMPL
register and the ahci driver fabricates PORTS_IMPL from the number of
ports in those cases.  This hasn't mattered but with the new nvme
controllers there are cases where zero PORTS_IMPL is valid and should
be honored.

Disable the workaround for >= AHCI 1.3.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Andy Lutomirski <luto@amacapital.net>
Link: http://lkml.kernel.org/g/CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libahci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 284a176..4029679 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -496,8 +496,8 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		}
 	}
 
-	/* fabricate port_map from cap.nr_ports */
-	if (!port_map) {
+	/* fabricate port_map from cap.nr_ports for < AHCI 1.3 */
+	if (!port_map && vers < 0x10300) {
 		port_map = (1 << ahci_nr_ports(cap)) - 1;
 		dev_warn(dev, "forcing PORTS_IMPL to 0x%x\n", port_map);
 
-- 
2.5.0

