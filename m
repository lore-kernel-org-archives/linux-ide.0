Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD1BC4332F
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 13:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJGNYL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJGNYG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 09:24:06 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E507B1D0
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665149041; x=1696685041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D1sxSiXWFFh4J/E0ZkL4emP/C8fK9DF+Yu5fITfvU6U=;
  b=V0eXENNj+JlxiYDpZ2QQ8JNq1uwMXDyGfkXJH1fKr/zGItnhgq/ToKlg
   NRPeu7nFJgNJa2FhRiRdFshXMsCHpoekA8KpKFDDKHZdvkSsTKLJiYiED
   d9P9Qne3Uoflj+nxAhJfKb3L0mZn1ThS9oal92PCnFHvRU/BttqJCjnCT
   GDk9zTppFAYm64I+06Jevo7tqdmNOhlk3yyosMgn5YQsKvBYMTM9uNVwE
   zWI14wOoxQxbOScaTpSUVMQqYLMVa2Fq8xO/UzhCtpyP/RCmgWhNsa/LC
   /2WQFN4v+iTiYlAlQfpydw/6TQMo9CXgDRmtY/lS2byMjJ7O6Zhn097/q
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661788800"; 
   d="scan'208";a="213238177"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 21:24:01 +0800
IronPort-SDR: 1JLfdHqS6Q1PSPWKvuTfNuRtepml6ENeH1qQ/YRUyu4IgwJBVbO7qiyM1yTtuPPbPsccuosR6A
 di4uSF0IrqkcPH1kKG1PqwNz8JidpfWqgLc6NZn6CD6U0oF/S5UKJaFYgy4n9DrvvOtXlHKMo0
 5zbank0lnHyMeJ7gPoSCxaUlTDQM0GLKtCoP7a06aQfX5zXVQyP7nfDmLCtCpoctNMlrSEIoHW
 vN7RIeZ3HKlcw8mldO5bJb6vPzMO9YSM/7R3w9dqUe+qeuHd4lC4RLvXZsNthAkXP+Lfl43GO/
 wrHumr3JB/u/Fsd4mjFL9Hcu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 05:38:11 -0700
IronPort-SDR: LSL031WiD7dsjPSdrsI7p3d/p3Hjb8LGxu7QrZojuyyljsL9bQX53yVyOTnnxyzSlOHNs7x4Xb
 qqzpyuGKoL4xW3RSvKasaNOAMx4a8yAkecqlmmHkJzQKjKUNbiqoYRygE1reGsW6+e7631fldt
 oWC4lJMMNWQcS0UjHxoPZ8wKvqxljFNeaUHHq60Dkz/N66Tt/HHUITYp3bJKXshXaM49C9Q8Rz
 LC9AaXc71R1MFtFO3JE1SkElbTHmOCxkbDBGsXHT/33/IRfHdsqu3MgK5tEMGOfDkHTaLM51Ko
 T/w=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2022 06:23:59 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     john.garry@huawei.com, Niklas Cassel <niklas.cassel@wdc.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 4/4] ata: libata-core: do not retry reading the log on timeout
Date:   Fri,  7 Oct 2022 15:23:40 +0200
Message-Id: <20221007132342.1590367-5-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007132342.1590367-1-niklas.cassel@wdc.com>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_read_log_page() first tries to read the log using READ LOG DMA EXT.
If that fails it will instead try to read the log using READ LOG EXT.

ata_exec_internal_sg() is synchronous, so it will wait for the command to
finish. If we actually got an error back from the device, it is correct
to retry. However, if the command timed out, ata_exec_internal_sg() will
freeze the port.

There is no point in retrying if the port is frozen, as
ata_exec_internal_sg() will return AC_ERR_SYSTEM on a frozen port,
without ever sending the command down to the drive.

Therefore, avoid retrying if the first command froze the port, as that
will result in a misleading AC_ERR_SYSTEM error print, instead of printing
the error that actually caused the port to be frozen (AC_ERR_TIMEOUT).

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1cf326dd7c41..6ae5787103e7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2000,7 +2000,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 	if (err_mask) {
 		if (dma) {
 			dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
-			goto retry;
+			if (!ata_port_is_frozen(dev->link->ap))
+				goto retry;
 		}
 		ata_dev_err(dev,
 			    "Read log 0x%02x page 0x%02x failed, Emask 0x%x\n",
-- 
2.37.3

