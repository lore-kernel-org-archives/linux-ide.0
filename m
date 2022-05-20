Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03096C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 20 May 2022 20:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiETUxm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 May 2022 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiETUxk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2022 16:53:40 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D319619320C
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2022 13:53:36 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru B242420BFEC3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-core: fix NULL pointer deref in
 ata_host_alloc_pinfo()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <3727e0b4-3958-283f-c0cf-6b8b898ab018@omp.ru>
Date:   Fri, 20 May 2022 23:53:33 +0300
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
reassigned from the initial value of NULL.  Assign &ata_dummy_port_info
to 'pi' at the start of the *for* loop instead to fix this kernel oops
for good...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -5470,7 +5470,7 @@ struct ata_host *ata_host_alloc_pinfo(st
 	if (!host)
 		return NULL;
 
-	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
+	for (i = 0, j = 0, pi = &ata_dummy_port_info; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
 		if (ppi[j])
