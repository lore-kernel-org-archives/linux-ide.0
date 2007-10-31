From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] libata: suppress two warnings
Date: Wed, 31 Oct 2007 14:53:32 +1100
Message-ID: <20071031145332.01529b7d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:48708 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbXJaDxb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 23:53:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

drivers/ata/libata-core.c:768: warning: 'ata_lpm_enable' defined but not used
drivers/ata/libata-core.c:784: warning: 'ata_lpm_disable' defined but not used

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/ata/libata-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 63035d7..7162645 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -735,6 +735,7 @@ enable_pm_out:
 	return /* rc */;	/* hopefully we can use 'rc' eventually */
 }
 
+#ifdef CONFIG_PM
 /**
  *	ata_dev_disable_pm - disable SATA interface power management
  *	@device - device to enable ipm for
@@ -755,6 +756,7 @@ static void ata_dev_disable_pm(struct ata_device *dev)
 	if (ap->ops->disable_pm)
 		ap->ops->disable_pm(ap);
 }
+#endif	/* CONFIG_PM */
 
 void ata_lpm_schedule(struct ata_port *ap, enum link_pm policy)
 {
@@ -764,6 +766,7 @@ void ata_lpm_schedule(struct ata_port *ap, enum link_pm policy)
 	ata_port_schedule_eh(ap);
 }
 
+#ifdef CONFIG_PM
 static void ata_lpm_enable(struct ata_host *host)
 {
 	struct ata_link *link;
@@ -789,6 +792,7 @@ static void ata_lpm_disable(struct ata_host *host)
 		ata_lpm_schedule(ap, ap->pm_policy);
 	}
 }
+#endif	/* CONFIG_PM */
 
 
 /**
-- 
1.5.3.4

