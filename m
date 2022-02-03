Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89048C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  3 Feb 2022 19:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiBCTrM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:47:12 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:38528 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiBCTrM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2022 14:47:12 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 474732097300
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] MAINTAINERS: add myself as Renesas R-Car SATA driver
 reviewer
To:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>
Organization: Open Mobile Platform
Message-ID: <d2777768-989b-e67b-8bc0-c4776b9fbdee@omp.ru>
Date:   Thu, 3 Feb 2022 22:47:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add myself as a reviewer for the Renesas R-Car SATA driver -- I don't have
the hardware anymore (Geert Uytterhoeven does have a lot of hardware!) but
I do have the manuals still! :-)

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
repo

Changes in version 2:
- added the status entry.

 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: libata/MAINTAINERS
===================================================================
--- libata.orig/MAINTAINERS
+++ libata/MAINTAINERS
@@ -16475,6 +16475,14 @@ F:	Documentation/devicetree/bindings/i2c
 F:	drivers/i2c/busses/i2c-rcar.c
 F:	drivers/i2c/busses/i2c-sh_mobile.c
 
+RENESAS R-CAR SATA DRIVER
+R:	Sergey Shtylyov <s.shtylyov@omp.ru>
+S:	Supported
+L:	linux-ide@vger.kernel.org
+L:	linux-renesas-soc@vger.kernel.org
+F:	Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
+F:	drivers/ata/sata_rcar.c
+
 RENESAS R-CAR THERMAL DRIVERS
 M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
 L:	linux-renesas-soc@vger.kernel.org
