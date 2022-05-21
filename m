Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457A5C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 21 May 2022 20:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbiEUUeO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 21 May 2022 16:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiEUUeO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 May 2022 16:34:14 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E1C38BE0
        for <linux-ide@vger.kernel.org>; Sat, 21 May 2022 13:34:12 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 377F120D9646
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] ata: libata-core: fix NULL pointer deref in
 ata_host_alloc_pinfo()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <a642481f-401c-8098-c6dd-64b15d41091e@omp.ru>
Date:   Sat, 21 May 2022 23:34:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In an unlikely (and probably wrong?) case that the 'ppi' parameter of
ata_host_alloc_pinfo() points to an array starting with a NULL pointer,
there's going to be a kernel oops as the 'pi' local variable won't get
reassigned from the initial value of NULL. Initialize 'pi' instead to
'&ata_dummy_port_info' to fix the possible kernel oops for good...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

Changes in version 2:
- switched from the 'pi' variable assignment in the *for* statement to the
  initializer, updating the patch description accordingly.

 drivers/ata/libata-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -5462,7 +5462,7 @@ struct ata_host *ata_host_alloc_pinfo(st
 				      const struct ata_port_info * const * ppi,
 				      int n_ports)
 {
-	const struct ata_port_info *pi;
+	const struct ata_port_info *pi = &ata_dummy_port_info;
 	struct ata_host *host;
 	int i, j;
 
@@ -5470,7 +5470,7 @@ struct ata_host *ata_host_alloc_pinfo(st
 	if (!host)
 		return NULL;
 
-	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
+	for (i = 0, j = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
 		if (ppi[j])
