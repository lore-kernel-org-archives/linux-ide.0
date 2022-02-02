Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C73C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 21:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiBBV0m (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:26:42 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:49968 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiBBV0m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 16:26:42 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru F321921F9C61
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH]
Organization: Open Mobile Platform
Message-ID: <257fda81-c6a1-de07-c0db-5b4a3198835b@omp.ru>
Date:   Thu, 3 Feb 2022 00:26:39 +0300
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

Add myself as a reviewer for the libata PATA drivers -- there has been some
activity in this area still... 8-)
Having been hacking on ATA from the early 90s, I think I deserved this
highly responsible position, at last! :-)

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
repo.

 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

Index: libata/MAINTAINERS
===================================================================
--- libata.orig/MAINTAINERS
+++ libata/MAINTAINERS
@@ -10880,6 +10880,12 @@ T:	git git://git.kernel.org/pub/scm/linu
 F:	drivers/ata/pata_arasan_cf.c
 F:	include/linux/pata_arasan_cf_data.h
 
+LIBATA PATA DRIVERS
+R:	Sergey Shtylyov <s.shtylyov@omp.ru>
+L:	linux-ide@vger.kernel.org
+F:	drivers/ata/ata_*.c
+F:	drivers/ata/pata_*.c
+
 LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-ide@vger.kernel.org
