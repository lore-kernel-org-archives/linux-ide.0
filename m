Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD7C2D0E4
	for <linux-ide@archiver.kernel.org>; Thu, 19 Nov 2020 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2806622259
	for <linux-ide@archiver.kernel.org>; Thu, 19 Nov 2020 10:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgKSKL2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:11:28 -0500
Received: from ns.weboveaplikace.net ([5.102.58.11]:46496 "EHLO
        mail.weboveaplikace.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgKSKL2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2020 05:11:28 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Nov 2020 05:11:28 EST
Received: from localhost.localdomain (ip-89-176-186-13.net.upcbroadband.cz [89.176.186.13])
        by mail-server-1.lc (Postfix) with ESMTPSA id DE2306C827;
        Thu, 19 Nov 2020 11:06:01 +0100 (CET)
From:   Lukas Herbolt <lherbolt@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Lukas Herbolt <lherbolt@redhat.com>
Subject: [PATCH] ata: libahci: use ahci_nr_ports() if port_map > ahci_nr_ports()
Date:   Thu, 19 Nov 2020 11:05:40 +0100
Message-Id: <20201119100540.3520589-1-lherbolt@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

While we report use of nr_port value, we set port_map to zero
which later leads to marking all the ports reported by ahci_nr_ports()
as DUMMY.

Signed-off-by: Lukas Herbolt <lherbolt@redhat.com>
---
 drivers/ata/libahci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ea5bf5f4cbed..fe416b6542b2 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -522,7 +522,8 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 			dev_warn(dev,
 				 "implemented port map (0x%x) contains more ports than nr_ports (%u), using nr_ports\n",
 				 port_map, ahci_nr_ports(cap));
-			port_map = 0;
+			port_map = (1 << ahci_nr_ports(cap)) - 1;
+			hpriv->saved_port_map = port_map;
 		}
 	}
 
-- 
2.26.2

