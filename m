Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DE0FA3741
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 07:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiJ0Huf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiJ0Hue (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 03:50:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175BB326EE
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666857033; x=1698393033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGdiRgEzC7DlpeRUC/9CBMT5QHkeXaNz5aIoIRwRYq0=;
  b=UgAB45GTn1Ce6kllWDVDbKyTNvyb+Xqp5xMuZTGTWL+lyZdcPIWlbcs5
   rDL4V9AIsCsY0n2xqgZofkg47lT2n8WCj6PMevhcHkB6J6tk0azceBeFR
   WogWL63cwm8X923mlgACvmcbXjhtEcu8ROdfI2AG0wcD7jxALuAcZVa3k
   8jY+CgtLe5FOADxRP2JGVf4PgmJAKwX+b6I6cCdU3hu93QCRfpgYSYvve
   tp9iu8274ZIe9MLAmw0EBNu79dOvVo2HDeQ6SDRgAYUANRLErQ1J73K5f
   oph8OLlXDIFsCbl/PIRxEi65aIT4q225LtpIN86EJq+BmhUbDLFmM+JMJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214853394"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 15:50:31 +0800
IronPort-SDR: bCJzyFVNumkIRAYKcZ+YEEMA6WZx4Ce4yHkMaVxHAYq2Oq6WCcITwOPoxLpMRN8FUbax4+NAg5
 57xBbKxk/MLUANqgvfe02OLfyz9A+ye0I8euBa93MniLBJum8lMYg5RseGS0fJPSpeKFdHIvmY
 a3nIRydNl9aRlJBZuVUVVVLCVQ6n0DMRDIMaIBL/UNV4nBRmu2l04NpYeqcF3gscJCqRMVSZwq
 yuo/zuPgSV56bY2tVYCpzeSSaCDYdQQAY8S6xghlfyK46HxP1sp5esdMwHd1Wv1MSlFO0xH6Ss
 Fg9xtUGyVNo1ylTGeip3JcGe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:09:52 -0700
IronPort-SDR: aU+nYYcWrxI5NbecIMSvvNIzNUOT2A8lezycpPynEZH9GNZAmOXfmMnMa84OyQy/4F2FXNWlPe
 VQT50DLbkxS7RkvwcAihXvmFegPXo0WZD0/YVWh3p/rEqPyVrp+sLJGl6X/YKqyKpNIWU3FQsm
 Ym00EN9kvqwuXsi52sYtc85YZUX35aO98z8x9laMRUp2rSn7k1Bzs7jGsgvu8+8AIyHo+pSz3B
 94HxMl5MNzTKAdcFzapSw+8mW6JV7WYMh0xwPznqlvcP/7pB/6qZ/FHgxENITF+fzLw5GE1HCn
 oEM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:50:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MydBt5LK0z1Rwrq
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666857030; x=1669449031; bh=fGdiRgEzC7DlpeRUC/
        9CBMT5QHkeXaNz5aIoIRwRYq0=; b=kMWOiE+rzX5gy+6l4U04IWrmYMB1u3ZQ05
        8GsPjvkHgyy1ukaLCD6bkfd3BqU8UPHw+7nMkhIaw9YuGJrUyERg+AIU5Wsf2apQ
        UjYvbj7qD46KBRg4F6+mlzlUtARoTtcq05OCOWk64sjdS76wGT2tZDtEsjK00a8x
        yMZdYOl46BnCxt8m+2R7iVUsD9qj0jXpdxEt/vnhxp1aWVZmllZrqRsIoq0Hr2rl
        9FuBMz5776DMCz0wvpMHLNIMtL1yww1SIIRSQn2AoaCNFPOcXYVQiqQC4AxFMqsT
        hL1uUHEr6CNEc+GpaC/uCuKgPpoR68kCBxYNm4xjmcjSLXzN/gpQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tulwGikwlswd for <linux-ide@vger.kernel.org>;
        Thu, 27 Oct 2022 00:50:30 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MydBs5YWFz1RvLy;
        Thu, 27 Oct 2022 00:50:29 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 2/6] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Thu, 27 Oct 2022 16:50:22 +0900
Message-Id: <20221027075026.240017-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Rename ata_rwcmd_protocol() to ata_set_rwcmd_protocol() to better
reflect the fact that this function sets a task file command and
protocol. The arguments order is also reversed and the function return
type changed to a bool to indicate if the command and protocol were set
corretly (instead of returning a completely arbitrary "-1" value.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..56ddcbaa0c6f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -574,17 +574,18 @@ static const u8 ata_rw_cmds[] =3D {
 };
=20
 /**
- *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
+ *	ata_set_rwcmd_protocol - set taskfile r/w command and protocol
+ *	@dev: target device for the tf
  *	@tf: command to examine and configure
- *	@dev: device tf belongs to
  *
- *	Examine the device configuration and tf->flags to calculate
- *	the proper read/write commands and protocol to use.
+ *	Examine the device configuration and tf->flags to determine
+ *	the proper read/write command and protocol to use.
  *
  *	LOCKING:
  *	caller.
  */
-static int ata_rwcmd_protocol(struct ata_taskfile *tf, struct ata_device=
 *dev)
+static bool ata_set_rwcmd_protocol(struct ata_device *dev,
+				   struct ata_taskfile *tf)
 {
 	u8 cmd;
=20
@@ -607,11 +608,12 @@ static int ata_rwcmd_protocol(struct ata_taskfile *=
tf, struct ata_device *dev)
 	}
=20
 	cmd =3D ata_rw_cmds[index + fua + lba48 + write];
-	if (cmd) {
-		tf->command =3D cmd;
-		return 0;
-	}
-	return -1;
+	if (!cmd)
+		return false;
+
+	tf->command =3D cmd;
+
+	return true;
 }
=20
 /**
@@ -744,7 +746,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 			/* request too large even for LBA48 */
 			return -ERANGE;
=20
-		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
=20
 		tf->nsect =3D n_block & 0xff;
@@ -762,7 +764,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 		if (!lba_28_ok(block, n_block))
 			return -ERANGE;
=20
-		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
=20
 		/* Convert LBA to CHS */
--=20
2.37.3

