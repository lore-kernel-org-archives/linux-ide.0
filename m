Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F52AEB64DC
	for <linux-ide@archiver.kernel.org>; Mon,  3 Jul 2023 23:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjGCXhp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 Jul 2023 19:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCXho (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jul 2023 19:37:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26BA137
        for <linux-ide@vger.kernel.org>; Mon,  3 Jul 2023 16:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 733066106C
        for <linux-ide@vger.kernel.org>; Mon,  3 Jul 2023 23:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B561C433C8;
        Mon,  3 Jul 2023 23:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688427461;
        bh=OYjs/NnqEeEmdG23Ikddj3qIi+RS1Kj2oIvFAGOhI0c=;
        h=From:To:Cc:Subject:Date:From;
        b=MO9LOQU0GwxwnSuO89EOUeNur2Lj0KYX3qVAhLQKUa9XU7sff19C7/ogWSIZvo4Wj
         RlbMTkdCmxP6Pg3QmLA6y6Q5JyNdmmc80HdIGsK1J+i9Ogd/8HANJhag+zY8Ygqftx
         IyK9Q2JICiJtsZSU+v7NXnhPVigADiNxLw+5p+J4VCqoi4mtyfDbMRMqgKbcgXg+mT
         j322TZVIOgHIZLvTErF9Uhkl0S5vdnzApSfPbLiG0CIij7JatxfkwLl25k+EYgQZVs
         taUaNnnvOrjwxEyt8UzfGAHzv6DAOTh6MgsLGIx4FaWryJp3NRjNjbcvzTjE23a6zl
         l122Luciid8nQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: pata_parport: Add mssing protocol modules description
Date:   Tue,  4 Jul 2023 08:37:40 +0900
Message-ID: <20230703233740.260401-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Most of the protocol modules for the pata_parport driver are missing a
module description, causing warnings such as:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ata/pata_parport/aten.o

when compiling with W=1. Add the missing MODULE_DESCRIPTION()
definitions to avoid these warnings. While at it, also add the missing
MODULE_AUTHOR() definitions.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/aten.c  | 2 ++
 drivers/ata/pata_parport/bpck.c  | 2 ++
 drivers/ata/pata_parport/bpck6.c | 3 ++-
 drivers/ata/pata_parport/comm.c  | 2 ++
 drivers/ata/pata_parport/dstr.c  | 2 ++
 drivers/ata/pata_parport/epat.c  | 3 +++
 drivers/ata/pata_parport/epia.c  | 3 +++
 drivers/ata/pata_parport/fit2.c  | 3 +++
 drivers/ata/pata_parport/fit3.c  | 3 +++
 drivers/ata/pata_parport/friq.c  | 2 ++
 drivers/ata/pata_parport/frpw.c  | 2 ++
 drivers/ata/pata_parport/kbic.c  | 3 +++
 drivers/ata/pata_parport/ktti.c  | 2 ++
 drivers/ata/pata_parport/on20.c  | 2 ++
 drivers/ata/pata_parport/on26.c  | 2 ++
 15 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index 8328a49a95ef..620ce6c8da5c 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -139,4 +139,6 @@ static struct pi_protocol aten = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("ATEN EH-100 parallel port IDE adapter protocol driver");
 module_pata_parport_driver(aten);
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 9f4309f9b57f..bba1eda65f36 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -502,4 +502,6 @@ static struct pi_protocol bpck = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("MicroSolutions BACKPACK parallel port IDE adapter protocol driver");
 module_pata_parport_driver(bpck);
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index c6dbd14120d1..62c2b53325e1 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -459,5 +459,6 @@ static struct pi_protocol bpck6 = {
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Micro Solutions Inc.");
-MODULE_DESCRIPTION("BACKPACK Protocol module, compatible with PARIDE");
+MODULE_DESCRIPTION("Micro Solutions BACKPACK parallel port IDE adapter "
+		   "(version 6 drives) protocol driver");
 module_pata_parport_driver(bpck6);
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index cc5485bd0a5b..4839becbbd56 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -201,4 +201,6 @@ static struct pi_protocol comm = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("DataStor Commuter parallel port IDE adapter protocol driver");
 module_pata_parport_driver(comm);
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index 368d7c7962a9..88930bb1f07e 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -230,4 +230,6 @@ static struct pi_protocol dstr = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("DataStor EP2000 parallel port IDE adapter protocol driver");
 module_pata_parport_driver(dstr);
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 016bd96bce89..3cb54fcbf0d0 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -358,5 +358,8 @@ static void __exit epat_exit(void)
 }
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("Shuttle Technologies EPAT parallel port IDE adapter "
+		   "protocol driver");
 module_init(epat_init)
 module_exit(epat_exit)
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 920e9f40d401..7aaba474c671 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -306,4 +306,7 @@ static struct pi_protocol epia = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("Shuttle Technologies EPIA parallel port IDE adapter "
+		   "protocol driver");
 module_pata_parport_driver(epia);
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index 6524f3033b1e..de79cf91ad5f 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -132,4 +132,7 @@ static struct pi_protocol fit2 = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("Fidelity International Technology parallel port IDE adapter"
+		   "(older models) protocol driver");
 module_pata_parport_driver(fit2);
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index c172a38ae67d..bad7aa920cdc 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -193,4 +193,7 @@ static struct pi_protocol fit3 = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("Fidelity International Technology parallel port IDE adapter"
+		   "(newer models) protocol driver");
 module_pata_parport_driver(fit3);
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index dc428f54fe0c..7abe2ff40685 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -259,4 +259,6 @@ static struct pi_protocol friq = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("Freecom IQ parallel port IDE adapter protocol driver");
 module_pata_parport_driver(friq);
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 28d9bb2c6baf..7fa9b9857321 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -293,4 +293,6 @@ static struct pi_protocol frpw = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("Freecom Power parallel port IDE adapter protocol driver");
 module_pata_parport_driver(frpw);
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index 6023e071516d..fca322627b82 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -301,5 +301,8 @@ static void __exit kbic_exit(void)
 }
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("KingByte Information Systems KBIC-951A and KBIC-971A "
+		   "parallel port IDE adapter protocol driver");
 module_init(kbic_init)
 module_exit(kbic_exit)
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index bca6c20ef617..c078d1934862 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -106,4 +106,6 @@ static struct pi_protocol ktti = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("KT Technology parallel port IDE adapter protocol driver");
 module_pata_parport_driver(ktti);
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index 34e69da2bec8..7c70e5b13a2a 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -142,4 +142,6 @@ static struct pi_protocol on20 = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("Onspec 90c20 parallel port IDE adapter protocol driver");
 module_pata_parport_driver(on20);
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index 5da317b394c1..c88e5d6f203e 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -310,4 +310,6 @@ static struct pi_protocol on26 = {
 };
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Grant R. Guenther <grant@torque.net>");
+MODULE_DESCRIPTION("Onspec 90c26 parallel port IDE adapter protocol driver");
 module_pata_parport_driver(on26);
-- 
2.41.0

