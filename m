From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] libata: disable forced PORTS_IMPL for >= v3.0 controllers
Date: Thu, 14 Jan 2016 17:37:32 -0500
Message-ID: <20160114223732.GG3520@mtj.duckdns.org>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36753 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbcANWhe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2016 17:37:34 -0500
Content-Disposition: inline
In-Reply-To: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Some early controllers incorrectly reported zero ports in PORTS_IMPL
register and the ahci driver fabricates PORTS_IMPL from the number of
ports in those cases.  This hasn't mattered but with the new nvme
controllers there are cases where zero PORTS_IMPL is valid and should
be honored.

Disable the workaround for controllers >= v3.0.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Andy Lutomirski <luto@amacapital.net>
Link: http://lkml.kernel.org/g/CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com
---
Hello, Andy.

Can you please test whether this fixes the issue?

Thanks.

 drivers/ata/libahci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index d61740e..4931075 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -496,8 +496,8 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		}
 	}
 
-	/* fabricate port_map from cap.nr_ports */
-	if (!port_map) {
+	/* fabricate port_map from cap.nr_ports for older controllers */
+	if (!port_map && (vers >> 16) <= 2) {
 		port_map = (1 << ahci_nr_ports(cap)) - 1;
 		dev_warn(dev, "forcing PORTS_IMPL to 0x%x\n", port_map);
 
