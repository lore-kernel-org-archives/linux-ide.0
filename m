Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2156C6FD1C
	for <linux-ide@archiver.kernel.org>; Sat, 11 Mar 2023 19:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCKTZs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 11 Mar 2023 14:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCKTZs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2023 14:25:48 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3D335C9FA;
        Sat, 11 Mar 2023 11:25:46 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id DB4D37A01B9;
        Sat, 11 Mar 2023 20:25:45 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pata_parport: fix parport release without claim
Date:   Sat, 11 Mar 2023 20:25:38 +0100
Message-Id: <20230311192538.29067-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When adapter is not found, pi->disconnect() is called without previous
pi->connect(). This results in error like this:
parport0: pata_parport tried to release parport when not owner

Add missing out_disconnect label and use it correctly.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/pata_parport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index fb1f10afa722..b31cd2a845db 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -558,12 +558,13 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 
 	pi_connect(pi);
 	if (ata_host_activate(host, 0, NULL, 0, &pata_parport_sht))
-		goto out_unreg_parport;
+		goto out_disconnect;
 
 	return pi;
 
-out_unreg_parport:
+out_disconnect:
 	pi_disconnect(pi);
+out_unreg_parport:
 	parport_unregister_device(pi->pardev);
 	if (pi->proto->release_proto)
 		pi->proto->release_proto(pi);
-- 
Ondrej Zary

