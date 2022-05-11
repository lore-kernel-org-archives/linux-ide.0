Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3604DC4167B
	for <linux-ide@archiver.kernel.org>; Wed, 11 May 2022 23:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbiEKXTN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 May 2022 19:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349089AbiEKXTD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2022 19:19:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB01D1A15E0;
        Wed, 11 May 2022 16:18:41 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0813EBB4;
        Thu, 12 May 2022 02:19:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 0813EBB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311168;
        bh=4TSIdkgFfAKZWEyJBfOCbPqmpHzKYfwYa1OonXBwMv4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=MuchufuM7mjfaMJgTKIQtDeIulhY+Q5mNAmFHZXiDqFCbfvspSsymFXD4EB3zLXxj
         WI4bNQvRCQP1zCtVx2L8n4jEgnxVjwPg9hifnrOYgd/Zlq841RbC55ColZ24TCN2UL
         mNTN6MGl/aNmm8yo4ArBfWFSewXl1fTBcx+U5Qd4=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 23/23] MAINTAINERS: Add maintainers for DWC AHCI SATA driver
Date:   Thu, 12 May 2022 02:18:10 +0300
Message-ID: <20220511231810.4928-24-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add myself as a maintainer of the new DWC AHCI SATA driver and
its DT-bindings schema.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Use dlemoal/libata.git git tree for the LIBATA SATA AHCI SYNOPSYS
  DWC driver (@Damien).
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa1955ca3f..04f470519708 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11135,6 +11135,15 @@ F:	drivers/ata/ahci_platform.c
 F:	drivers/ata/libahci_platform.c
 F:	include/linux/ahci_platform.h
 
+LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-ide@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
+F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
+F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
+F:	drivers/ata/ahci_dwc.c
+
 LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
 M:	Mikael Pettersson <mikpelinux@gmail.com>
 L:	linux-ide@vger.kernel.org
-- 
2.35.1

